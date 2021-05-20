#include <jni.h>
#include <android/log.h>
#include <sys/mman.h>
#include <errno.h>
#include <EGL/egl.h>
#include <GLES2/gl2.h>
#include <vector>
#include <pthread.h>
#include <stdlib.h>

struct Renderer {
    EGLDisplay display = EGL_NO_DISPLAY;
    EGLContext context = EGL_NO_CONTEXT;
    EGLSurface surface = EGL_NO_SURFACE;
    size_t first_shader = 0;
    size_t last_shader = 0;
};

void init_egl(Renderer* renderer, int width, int height) {
    renderer->display = eglGetDisplay(EGL_DEFAULT_DISPLAY);

    EGLBoolean success = eglInitialize(renderer->display, nullptr, nullptr);
    if (!success) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "eglInitialize returned error: 0x%x",
                            eglGetError());
        abort();
    }

    const EGLint attribs[] = {
        EGL_SURFACE_TYPE, EGL_PBUFFER_BIT,
        EGL_BLUE_SIZE, 8,
        EGL_GREEN_SIZE, 8,
        EGL_RED_SIZE, 8,
        EGL_NONE
    };
    EGLConfig config;
    EGLint num_configs;
    success = eglChooseConfig(renderer->display, attribs, &config, 1, &num_configs);
    if (!success) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "eglChooseConfig returned error: 0x%x",
                            eglGetError());
        abort();
    }
    if (num_configs == 0) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "eglChooseConfig returned 0 configs");
        abort();
    }

    const EGLint context_attribs[] = {
        EGL_CONTEXT_MAJOR_VERSION, 2,
        EGL_CONTEXT_MINOR_VERSION, 0,
        EGL_NONE,
    };
    renderer->context = eglCreateContext(renderer->display, config, EGL_NO_CONTEXT, context_attribs);
    if (renderer->context == EGL_NO_CONTEXT) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE",
                            "eglCreateContext returned error: 0x%x", eglGetError());
        abort();
    }

    EGLint surface_attribs[] = {
        EGL_WIDTH, width,
        EGL_HEIGHT, height,
        EGL_NONE
    };
    renderer->surface = eglCreatePbufferSurface(renderer->display, config, surface_attribs);
    if (renderer->surface == EGL_NO_SURFACE) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE",
                            "eglCreatePbufferSurface returned error: 0x%x", eglGetError());
        abort();
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Successfully initialized EGL");
}

void make_current(Renderer* renderer) {
    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "make_current()");
    bool success = eglMakeCurrent(renderer->display, renderer->surface, renderer->surface, renderer->context);
    if (!success) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE",
                            "eglMakeCurrent returned error: 0x%x", eglGetError());
        abort();
    }
}

void compile_shader(size_t index, const char* name, const char* vert_src, const char* frag_src) {
  __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Compiling shader %zu %s", index, name);

    GLuint prog = glCreateProgram();

    GLuint vert = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vert, 1, &vert_src, nullptr);
    glCompileShader(vert);

    GLuint frag = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(frag, 1, &frag_src, nullptr);
    glCompileShader(frag);

    glAttachShader(prog, vert);
    glAttachShader(prog, frag);

    __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Linking shader %zu %s", index, name);

    glLinkProgram(prog);
}

struct Shader {
    const char* name;
    const char* vert_src;
    const char* frag_src;
};
std::vector<Shader> shaders;

static void* render_thread(void* arg) {
    __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Running Render thread. frame address: %p", __builtin_frame_address(0));

    Renderer* renderer = (Renderer*)arg;

    make_current(renderer);

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Compiling shaders");
    for (size_t i = renderer->first_shader; i < renderer->last_shader; i++) {
        compile_shader(i, shaders[i].name, shaders[i].vert_src, shaders[i].frag_src);
    }
    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Finished compiling shaders");

    return nullptr;
}

void create_thread(pthread_t* thread, void* stack_addr, size_t stack_size, void* (fun)(void*), void* arg) {
    pthread_attr_t attr;
    int err = pthread_attr_init(&attr);
    if (err) {
      __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_attr_init: 0x%x", err);
    }

    __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                        "Mapping %zu bytes at %p for render thread stack", stack_size, stack_addr);
    void* stack = mmap(stack_addr, stack_size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
    if (stack == MAP_FAILED) {
      __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "mmap failed: %d\n", errno);
      abort();
    } else if (stack != stack_addr) {
      __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "mmap %p not at specified address (requested %p)\n",
                          stack, stack_addr);
      abort();
    } else {
      __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                          "mmap succeeded: 0x%zx - 0x%zx\n", (size_t)stack,
                          (size_t)stack + stack_size);
    }

    err = pthread_attr_setstack(&attr, stack, stack_size);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_attr_setstack: 0x%x", err);
        abort();
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Creating Render thread");
    err = pthread_create(thread, &attr, fun, arg);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_create: 0x%x", err);
        abort();
    }

    err = pthread_attr_destroy(&attr);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_attr_destroy: 0x%x", err);
    }
}

extern "C"
JNIEXPORT void JNICALL
Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_run_1native(JNIEnv *env, jobject thiz, jobjectArray shaderNames, jobjectArray vertSources, jobjectArray fragSources) {

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Copying objects from JNI");

    jsize num_shaders = env->GetArrayLength(shaderNames);

    shaders.reserve(num_shaders);
    for (int i = 0; i < num_shaders; i++) {
        shaders.push_back(Shader {
            env->GetStringUTFChars((jstring)env->GetObjectArrayElement(shaderNames, i), 0),
            env->GetStringUTFChars((jstring)env->GetObjectArrayElement(vertSources, i), 0),
            env->GetStringUTFChars((jstring)env->GetObjectArrayElement(fragSources, i), 0),
        });
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Initializing EGL Contexts");
    Renderer renderer1, renderer2;

    renderer1.first_shader = 0;
    renderer1.last_shader = shaders.size() / 2;
    renderer2.first_shader = shaders.size() / 2;
    renderer2.last_shader = shaders.size();

    init_egl(&renderer1, 1080, 1776);
    init_egl(&renderer2, 1080, 1776);

    // Both threads stack being >= 0x80000000 avoids the crash. Either or both of them < 0x80000000 crashes.
    pthread_t thread1, thread2;
    create_thread(&thread1, (void *)0x80000000, 1024 * 1024, render_thread, &renderer1);
    create_thread(&thread2, (void *)0x70000000, 1024 * 1024, render_thread, &renderer2);

    int err = pthread_join(thread1, nullptr);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_join 1: 0x%x", err);
    }
    err = pthread_join(thread2, nullptr);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_join 2: 0x%x", err);
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Cleaning up JNI objects");
    for (int i = 0; i < num_shaders; i++) {
        env->ReleaseStringUTFChars((jstring)env->GetObjectArrayElement(shaderNames, i), shaders[i].name);
        env->ReleaseStringUTFChars((jstring)env->GetObjectArrayElement(vertSources, i), shaders[i].vert_src);
        env->ReleaseStringUTFChars((jstring)env->GetObjectArrayElement(fragSources, i), shaders[i].frag_src);
    }
}

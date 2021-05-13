#include <jni.h>
#include <android/log.h>
#include <sys/mman.h>
#include <errno.h>
#include <EGL/egl.h>
#include <GLES2/gl2.h>
#include <vector>
#include <pthread.h>

static EGLDisplay display = EGL_NO_DISPLAY;
static EGLContext context = EGL_NO_CONTEXT;
static EGLSurface surface = EGL_NO_SURFACE;

void init_egl(int width, int height) {
    display = eglGetDisplay(EGL_DEFAULT_DISPLAY);

    EGLBoolean success = eglInitialize(display, nullptr, nullptr);
    if (!success) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "eglInitialize returned error: 0x%x",
                            eglGetError());
        return;
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
    success = eglChooseConfig(display, attribs, &config, 1, &num_configs);
    if (!success) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "eglChooseConfig returned error: 0x%x",
                            eglGetError());
        return;
    }
    if (num_configs == 0) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "eglChooseConfig returned 0 configs");
        return;
    }

    const EGLint context_attribs[] = {
        EGL_CONTEXT_MAJOR_VERSION, 2,
        EGL_CONTEXT_MINOR_VERSION, 0,
        EGL_NONE,
    };
    context = eglCreateContext(display, config, EGL_NO_CONTEXT, context_attribs);
    if (context == EGL_NO_CONTEXT) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE",
                            "eglCreateContext returned error: 0x%x", eglGetError());
        return;
    }

    EGLint surface_attribs[] = {
        EGL_WIDTH, width,
        EGL_HEIGHT, height,
        EGL_NONE
    };
    surface = eglCreatePbufferSurface(display, config, surface_attribs);
    if (surface == EGL_NO_SURFACE) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE",
                            "eglCreatePbufferSurface returned error: 0x%x", eglGetError());
        return;
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Successfully initialized EGL");
}

void make_current() {
    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "make_current()");
    bool success = eglMakeCurrent(display, surface, surface, context);
    if (!success) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE",
                            "eglMakeCurrent returned error: 0x%x", eglGetError());
        return;
    }
}

void compile_shader(const char* name, const char* vert_src, const char* frag_src) {
    __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Compiling shader %s", name);

    GLuint prog = glCreateProgram();

    GLuint vert = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vert, 1, &vert_src, nullptr);
    glCompileShader(vert);

    GLuint frag = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(frag, 1, &frag_src, nullptr);
    glCompileShader(frag);

    glAttachShader(prog, vert);
    glAttachShader(prog, frag);

    __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Linking shader %s", name);

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

    make_current();

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Compiling shaders");
    for (const auto& shader: shaders) {
        compile_shader(shader.name, shader.vert_src, shader.frag_src);
    }
    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Finished compiling shaders");

    return nullptr;
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

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Initializing EGL Context");
    init_egl(1080, 1776);

    pthread_attr_t attr;
    int err = pthread_attr_init(&attr);
    if (err) {
      __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_attr_init: 0x%x", err);
    }

    // Map 1MB for render thread stack at a specific address.
    // 0x70000000 - 0x70100000 crashes.
    // 0x80000000 - 0x80100000 does not crash
    // 0x7ff00000 - 0x80000000 crashes
    // 0x7ff80000 - 0x80080000 does not crash
    // 0x7ff10000 - 0x80010000 does not crash
    // 0x7ff01000 - 0x80001000 crashes
    void* stack_addr = (void*)0x7ff01000;
    size_t stack_size = 1024 * 1024;
    __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                        "Mapping %zu bytes at %p for render thread stack", stack_size, stack_addr);
    void* stack = mmap(stack_addr, stack_size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
    if (stack == MAP_FAILED) {
      __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "mmap failed: %d\n", errno);
      return;
    } else if (stack != stack_addr) {
      __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "mmap %p not at specified address (requested %p)\n",
                          stack, stack_addr);
      return;
    } else {
      __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                          "mmap succeeded: 0x%zx - 0x%zx\n", (size_t)stack,
                          (size_t)stack + stack_size);
    }

    err = pthread_attr_setstack(&attr, stack, stack_size);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_attr_setstack: 0x%x", err);
        return;
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Creating Render thread");
    pthread_t thread;
    err = pthread_create(&thread, &attr, render_thread, &shaders);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_create: 0x%x", err);
        return;
    }

    err = pthread_join(thread, nullptr);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_join: 0x%x", err);
    }

    err = pthread_attr_destroy(&attr);
    if (err) {
        __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "Error in pthread_attr_destroy: 0x%x", err);
    }

    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Cleaning up JNI objects");
    for (int i = 0; i < num_shaders; i++) {
        env->ReleaseStringUTFChars((jstring)env->GetObjectArrayElement(shaderNames, i), shaders[i].name);
        env->ReleaseStringUTFChars((jstring)env->GetObjectArrayElement(vertSources, i), shaders[i].vert_src);
        env->ReleaseStringUTFChars((jstring)env->GetObjectArrayElement(fragSources, i), shaders[i].frag_src);
    }
}

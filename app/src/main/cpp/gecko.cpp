#include <jni.h>
#include <android/log.h>
#include <sys/mman.h>
#include <errno.h>
#include <EGL/egl.h>
#include <GLES2/gl2.h>
#include <vector>

const size_t num_maps = 1000;
const size_t map_len = 1024 * 1024;
static std::vector<void*> maps;

static EGLDisplay display = EGL_NO_DISPLAY;
static EGLContext context = EGL_NO_CONTEXT;
static EGLSurface surface = EGL_NO_SURFACE;

void map_omnijar() {
    maps.reserve(num_maps);
    for (int i = 0; i < num_maps; i++) {
        size_t map_len = 1024 * 1024;
        __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                            "%d mmapping %zu bytes", i, map_len);
        void *map = mmap(0, map_len, PROT_READ, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
        if (map == MAP_FAILED) {
            __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "mmap failed: %d\n",
                                errno);
            break;
        } else {
            __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                                "mmap succeeded: 0x%zx - 0x%zx\n", (size_t) map,
                                (size_t) map + map_len);
            maps.push_back(map);
        }
    }
}

void unmap_omnijar() {
    for (int i = 0; i < maps.size(); i++) {
        __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                            "%d munmapping %zu bytes", i, map_len);
        munmap(maps[i], map_len);
    }
}

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

extern "C"
JNIEXPORT void JNICALL
Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_map_1omnijar(JNIEnv *env, jobject thiz) {
    map_omnijar();
}

extern "C"
JNIEXPORT void JNICALL
Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_unmap_1omnijar(JNIEnv *env, jobject thiz) {
    unmap_omnijar();
}

extern "C"
JNIEXPORT void JNICALL
Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_init_1egl(JNIEnv *env, jobject thiz, jint width, jint height) {
    init_egl(width, height);
}

extern "C"
JNIEXPORT void JNICALL
Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_make_1current(JNIEnv *env, jobject thiz) {
    make_current();
}

extern "C"
JNIEXPORT void JNICALL
Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_compile_1shader(JNIEnv *env, jobject thiz,
                                                                  jstring name,
                                                                  jstring vert_src,
                                                                  jstring frag_src) {
    const char *name_cstr = env->GetStringUTFChars(name, 0);
    const char *vert_src_cstr = env->GetStringUTFChars(vert_src, 0);
    const char *frag_src_cstr = env->GetStringUTFChars(frag_src, 0);

    compile_shader(name_cstr, vert_src_cstr, frag_src_cstr);

    env->ReleaseStringUTFChars(name, name_cstr);
    env->ReleaseStringUTFChars(vert_src, vert_src_cstr);
    env->ReleaseStringUTFChars(frag_src, frag_src_cstr);
}

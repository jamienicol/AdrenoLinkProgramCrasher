#include <jni.h>
#include <android/log.h>
#include <sys/mman.h>
#include <errno.h>
#include <GLES2/gl2.h>

extern "C" void Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_init(JNIEnv *env, jobject thiz) {
    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Gecko init()");

    for (int i = 0; i < 1000; i++) {
        size_t map_len = 1024 * 1024;
        __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                            "mmapping %zu bytes", map_len);
        void *map = mmap(0, map_len, PROT_READ, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
        if (map == MAP_FAILED) {
            __android_log_print(ANDROID_LOG_ERROR, "JAMIE", "mmap failed: %d\n",
                                errno);
            break;
        } else {
            __android_log_print(ANDROID_LOG_INFO, "JAMIE",
                                "mmap succeeded: 0x%zx - 0x%zx\n", (size_t) map,
                                (size_t) map + map_len);
        }
    }
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

    __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Compiling shader %s", name_cstr);

    GLuint prog = glCreateProgram();

    GLuint vert = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vert, 1, &vert_src_cstr, nullptr);
    glCompileShader(vert);

    GLuint frag = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(frag, 1, &frag_src_cstr, nullptr);
    glCompileShader(frag);

    glAttachShader(prog, vert);
    glAttachShader(prog, frag);

    __android_log_print(ANDROID_LOG_INFO, "JAMIE", "Linking shader %s", name_cstr);

    glLinkProgram(prog);

    env->ReleaseStringUTFChars(name, name_cstr);
    env->ReleaseStringUTFChars(vert_src, vert_src_cstr);
    env->ReleaseStringUTFChars(frag_src, frag_src_cstr);
}

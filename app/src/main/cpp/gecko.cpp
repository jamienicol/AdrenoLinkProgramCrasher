#include <jni.h>
#include <android/log.h>
#include <sys/mman.h>
#include <errno.h>

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

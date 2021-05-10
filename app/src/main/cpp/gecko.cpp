#include <jni.h>
#include <android/log.h>

extern "C" void Java_me_jamienicol_adrenolinkprogramcrasher_Gecko_init(JNIEnv *env, jobject thiz) {
    __android_log_write(ANDROID_LOG_INFO, "JAMIE", "Gecko init()");
}

package me.jamienicol.adrenolinkprogramcrasher

class Gecko {
    init {
        System.loadLibrary("geckojni")
    }

    external fun map_omnijar()

    external fun unmap_omnijar()

    external fun init_egl(width: Int, height: Int)

    external fun make_current()

    external fun compile_shader(name: String, vertSrc: String, fragSrc: String)
}

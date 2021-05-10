package me.jamienicol.adrenolinkprogramcrasher

class Gecko {
    init {
        System.loadLibrary("geckojni")
    }

    external fun init()

    external fun compile_shader(name: String, vertSrc: String, fragSrc: String)
}

package me.jamienicol.adrenolinkprogramcrasher

class Gecko {
    init {
        System.loadLibrary("geckojni")
    }

    external fun init()
}

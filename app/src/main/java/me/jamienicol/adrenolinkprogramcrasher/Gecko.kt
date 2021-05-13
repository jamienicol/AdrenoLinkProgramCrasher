package me.jamienicol.adrenolinkprogramcrasher

class Gecko {
    init {
        System.loadLibrary("geckojni")
    }

    external fun run_native(shaderNames: Array<String>, vertSources: Array<String>, fragSources: Array<String>)
}

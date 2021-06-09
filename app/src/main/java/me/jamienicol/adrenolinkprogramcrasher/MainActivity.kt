package me.jamienicol.adrenolinkprogramcrasher

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.util.Pair
import java.io.BufferedReader
import java.io.InputStreamReader
import java.util.UUID;

class MainActivity : AppCompatActivity() {
    private var shaders = HashMap<String, Pair<String, String>>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Log.i("JAMIE", "Loading shaders from resources")
        loadShaders()

        val vertSources = shaderList.map { shaders[it]!!.first!! }.toTypedArray()
        val fragSources = shaderList.map { shaders[it]!!.second!! }.toTypedArray()

        Gecko().run_native(shaderList, vertSources, fragSources)
    }

    private fun loadShaders() {
        for (asset in assets?.list("shaders")!!) {
            if (asset.endsWith(".vert")) {
                val vertInput = assets?.open("shaders/$asset")
                val vertReader = BufferedReader(InputStreamReader(vertInput))
                val vertBuilder = StringBuilder()
                var line: String?
                while (vertReader.readLine().also { line = it } != null) {
                    vertBuilder.append(line)
                    vertBuilder.append('\n')
                }
                vertReader.close()
                val fragAsset = asset.replace(".vert", ".frag")
                val fragInput = assets?.open("shaders/$fragAsset")
                val fragReader = BufferedReader(InputStreamReader(fragInput))
                val fragBuilder = StringBuilder()
                while (fragReader.readLine().also { line = it } != null) {
                    fragBuilder.append(line)
                    fragBuilder.append('\n')
                }
                fragReader.close()

//                vertBuilder.append("// ${UUID.randomUUID().toString()}\n")
//                fragBuilder.append("// ${UUID.randomUUID().toString()}\n")

                shaders[asset.replace(".vert", "")] = Pair.create(
                    vertBuilder.toString(),
                    fragBuilder.toString()
                )
            }
        }
    }

    val shaderList = arrayOf(
        "brush_image_DEBUG_OVERDRAW_TEXTURE_2D_Gles",
        "brush_solid_DEBUG_OVERDRAW_Gles",
    )
}

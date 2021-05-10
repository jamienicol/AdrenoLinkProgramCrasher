package me.jamienicol.adrenolinkprogramcrasher

import android.content.Context
import android.opengl.GLES20
import android.opengl.GLSurfaceView
import android.util.AttributeSet
import android.util.Log
import androidx.core.util.Pair
import java.io.BufferedReader
import java.io.InputStreamReader
import java.util.*
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10

internal class MyGLSurfaceView(context: Context?) : GLSurfaceView(context) {
    private inner class MyGLRenderer(context: Context?) : Renderer {

        private val shaders = HashMap<String?, Pair<String, String>>()

        override fun onSurfaceCreated(unused: GL10, config: EGLConfig) {
            Log.w("JAMIE", "MyGLSurfaceView.onSurfaceCreated()")

            for (name in shaders.keys) {
                Log.w("JAMIE", "Compiling shader $name")
                val shader = shaders[name]!!
                val prog = GLES20.glCreateProgram()

                val vert = GLES20.glCreateShader(GLES20.GL_VERTEX_SHADER)
                GLES20.glShaderSource(vert, shader.first)
                GLES20.glCompileShader(vert)

                val frag = GLES20.glCreateShader(GLES20.GL_FRAGMENT_SHADER)
                GLES20.glShaderSource(frag, shader.second)
                GLES20.glCompileShader(frag)

                GLES20.glAttachShader(prog, vert)
                GLES20.glAttachShader(prog, frag)

                Log.w("JAMIE", "Linking shader $name")
                GLES20.glLinkProgram(prog)
            }
        }

        override fun onDrawFrame(unused: GL10) {
        }

        override fun onSurfaceChanged(unused: GL10, width: Int, height: Int) {
        }

        init {
            for (asset in context?.assets?.list("shaders")!!) {
                if (asset.endsWith(".vert")) {
                    // Log.w("JAMIE", asset)
                    val vertInput = context.assets?.open("shaders/$asset")
                    val vertReader = BufferedReader(InputStreamReader(vertInput))
                    val vertBuilder = StringBuilder()
                    var line: String?
                    while (vertReader.readLine().also { line = it } != null) {
                        vertBuilder.append(line)
                        vertBuilder.append('\n')
                    }
                    vertReader.close()
                    val fragAsset = asset.replace(".vert", ".frag")
                    val fragInput = context.assets?.open("shaders/$fragAsset")
                    val fragReader = BufferedReader(InputStreamReader(fragInput))
                    val fragBuilder = StringBuilder()
                    while (fragReader.readLine().also { line = it } != null) {
                        fragBuilder.append(line)
                        fragBuilder.append('\n')
                    }
                    fragReader.close()
                    shaders[asset.replace(".vert", "")] = Pair.create(
                        vertBuilder.toString(),
                        fragBuilder.toString()
                    )
                }
            }
        }
    }

    private val renderer: MyGLRenderer

    constructor(context: Context?, attrs: AttributeSet?) : this(context)

    init {
        setEGLContextClientVersion(3)
        renderer = MyGLRenderer(context)
        setRenderer(renderer)
    }
}
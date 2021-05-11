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

            val shaderList = listOf(
                "debug_font_Gles",
                "brush_mix_blend_ALPHA_PASS_Gles",
                "composite_TEXTURE_EXTERNAL_Gles",
                "cs_blur_COLOR_TARGET_Gles",
                "cs_radial_gradient_DITHERING_Gles",
                "brush_image_TEXTURE_2D_Gles",
                "brush_image_DEBUG_OVERDRAW_TEXTURE_EXTERNAL_Gles",
                "brush_mix_blend_Gles",
                "brush_opacity_ALPHA_PASS_ANTIALIASING_Gles",
                "cs_scale_TEXTURE_2D_Gles",
                "composite_TEXTURE_2D_YUV_Gles",
                "cs_clip_rectangle_Gles",
                "brush_image_ALPHA_PASS_DUAL_SOURCE_BLENDING_TEXTURE_2D_Gles",
                "cs_linear_gradient_DITHERING_Gles",
                "brush_image_ADVANCED_BLEND_ALPHA_PASS_ANTIALIASING_REPETITION_TEXTURE_2D_Gles",
                "brush_image_ALPHA_PASS_ANTIALIASING_REPETITION_TEXTURE_EXTERNAL_Gles",
                "brush_yuv_image_ALPHA_PASS_TEXTURE_2D_YUV_Gles",
                "cs_linear_gradient_Gles",
                "brush_solid_DEBUG_OVERDRAW_Gles",
                "composite_TEXTURE_EXTERNAL_ESSL1_Gles",
                "brush_linear_gradient_ALPHA_PASS_DITHERING_Gles",
                "cs_clip_rectangle_FAST_PATH_Gles",
                "cs_conic_gradient_DITHERING_Gles",
                "cs_conic_gradient_Gles",
                "cs_svg_filter_Gles",
                "brush_opacity_ALPHA_PASS_Gles",
                "ps_text_run_ALPHA_PASS_DUAL_SOURCE_BLENDING_TEXTURE_2D_Gles",
                "cs_line_decoration_Gles",
                "brush_opacity_ANTIALIASING_DEBUG_OVERDRAW_Gles",
                "brush_image_ANTIALIASING_DEBUG_OVERDRAW_REPETITION_TEXTURE_EXTERNAL_Gles",
                "ps_text_run_ALPHA_PASS_TEXTURE_2D_Gles",
                "brush_image_ADVANCED_BLEND_ALPHA_PASS_TEXTURE_2D_Gles",
                "composite_FAST_PATH_TEXTURE_2D_Gles",
                "composite_TEXTURE_EXTERNAL_YUV_Gles",
                "cs_clip_image_TEXTURE_2D_Gles",
                "brush_solid_ALPHA_PASS_Gles",
                "cs_fast_linear_gradient_Gles",
                "cs_radial_gradient_Gles",
                "brush_image_ALPHA_PASS_ANTIALIASING_DUAL_SOURCE_BLENDING_REPETITION_TEXTURE_2D_Gles",
                "brush_blend_DEBUG_OVERDRAW_Gles",
                "cs_border_segment_Gles",
                "brush_image_ADVANCED_BLEND_ALPHA_PASS_TEXTURE_EXTERNAL_Gles",
                "brush_opacity_DEBUG_OVERDRAW_Gles",
                "cs_clip_box_shadow_TEXTURE_2D_Gles",
                "brush_image_TEXTURE_EXTERNAL_Gles",
                "brush_yuv_image_DEBUG_OVERDRAW_TEXTURE_EXTERNAL_YUV_Gles",
                "brush_yuv_image_ALPHA_PASS_TEXTURE_EXTERNAL_YUV_Gles",
                "brush_image_ALPHA_PASS_TEXTURE_EXTERNAL_Gles",
                "brush_image_ALPHA_PASS_ANTIALIASING_REPETITION_TEXTURE_2D_Gles",
                "brush_yuv_image_TEXTURE_2D_YUV_Gles",
                "brush_yuv_image_TEXTURE_EXTERNAL_YUV_Gles",
                "brush_image_ANTIALIASING_REPETITION_TEXTURE_2D_Gles",
                "brush_solid_Gles",
                "debug_color_Gles",
                "brush_image_ANTIALIASING_REPETITION_TEXTURE_EXTERNAL_Gles",
                "composite_FAST_PATH_TEXTURE_EXTERNAL_Gles",
                "cs_border_solid_Gles",
                "brush_image_DEBUG_OVERDRAW_TEXTURE_2D_Gles",
                "brush_blend_Gles",
                "composite_TEXTURE_2D_Gles",
                "brush_yuv_image_DEBUG_OVERDRAW_TEXTURE_2D_YUV_Gles",
                "brush_opacity_Gles",
                "brush_linear_gradient_DEBUG_OVERDRAW_DITHERING_Gles",
                "ps_clear_Gles",
                "ps_text_run_DEBUG_OVERDRAW_TEXTURE_2D_Gles",
                "composite_FAST_PATH_TEXTURE_EXTERNAL_ESSL1_Gles",
                "ps_text_run_ALPHA_PASS_DUAL_SOURCE_BLENDING_GLYPH_TRANSFORM_TEXTURE_2D_Gles",
                "brush_image_ALPHA_PASS_DUAL_SOURCE_BLENDING_TEXTURE_EXTERNAL_Gles",
                "brush_mix_blend_DEBUG_OVERDRAW_Gles",
                "brush_linear_gradient_DITHERING_Gles",
                "cs_scale_TEXTURE_EXTERNAL_ESSL1_Gles",
                "ps_split_composite_Gles",
                "brush_image_ANTIALIASING_DEBUG_OVERDRAW_REPETITION_TEXTURE_2D_Gles",
                "cs_blur_ALPHA_TARGET_Gles",
                "brush_image_ADVANCED_BLEND_ALPHA_PASS_ANTIALIASING_REPETITION_TEXTURE_EXTERNAL_Gles",
                "ps_text_run_ALPHA_PASS_GLYPH_TRANSFORM_TEXTURE_2D_Gles",
                "brush_image_ALPHA_PASS_TEXTURE_2D_Gles",
                "cs_scale_TEXTURE_EXTERNAL_Gles",
                "brush_opacity_ANTIALIASING_Gles",
                "ps_text_run_DEBUG_OVERDRAW_DUAL_SOURCE_BLENDING_TEXTURE_2D_Gles",
                "brush_image_ALPHA_PASS_ANTIALIASING_DUAL_SOURCE_BLENDING_REPETITION_TEXTURE_EXTERNAL_Gles",
                "brush_blend_ALPHA_PASS_Gles",
            )
            for (name in shaderList) {
                Gecko().compile_shader(name!!, shaders[name]?.first!!, shaders[name]?.second!!)
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

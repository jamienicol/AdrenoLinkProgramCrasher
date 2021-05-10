#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
out highp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
in highp vec2 v_uv;
flat in highp vec4 v_uv_bounds;
flat in highp vec4 v_uv_sample_bounds;
flat in highp float v_perspective;
void main ()
{
  oFragColor = texture (sColor0, min (max ((
    (v_uv * mix (gl_FragCoord.w, 1.0, v_perspective))
   + v_uv_bounds.xy), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
}


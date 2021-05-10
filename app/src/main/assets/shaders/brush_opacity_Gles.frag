#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
in highp vec2 v_uv;
flat in highp vec4 v_uv_sample_bounds;
flat in highp float v_perspective;
flat in highp float v_opacity;
void main ()
{
  oFragColor = (v_opacity * texture (sColor0, min (max (
    (v_uv * mix (gl_FragCoord.w, 1.0, v_perspective))
  , v_uv_sample_bounds.xy), v_uv_sample_bounds.zw)));
}


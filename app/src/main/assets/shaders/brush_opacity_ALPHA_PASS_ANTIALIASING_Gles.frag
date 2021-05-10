#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
flat in highp vec4 vTransformBounds;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_local_pos;
in highp vec2 v_uv;
flat in highp vec4 v_uv_sample_bounds;
flat in highp float v_perspective;
flat in highp float v_opacity;
void main ()
{
  vec4 frag_color_1;
  vec2 tmpvar_2;
  tmpvar_2 = max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw));
  vec2 tmpvar_3;
  tmpvar_3 = (abs(dFdx(v_local_pos)) + abs(dFdy(v_local_pos)));
  frag_color_1 = ((v_opacity * min (
    max ((0.5 - (max (tmpvar_2.x, tmpvar_2.y) * inversesqrt(
      (0.5 * dot (tmpvar_3, tmpvar_3))
    ))), 0.0)
  , 1.0)) * texture (sColor0, min (max (
    (v_uv * mix (gl_FragCoord.w, 1.0, v_perspective))
  , v_uv_sample_bounds.xy), v_uv_sample_bounds.zw)));
  float tmpvar_4;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_4 = 1.0;
  } else {
    vec2 tmpvar_5;
    tmpvar_5 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_6;
    tmpvar_6.xy = greaterThanEqual (tmpvar_5, vClipMaskUvBounds.xy);
    tmpvar_6.zw = lessThan (tmpvar_5, vClipMaskUvBounds.zw);
    bool tmpvar_7;
    tmpvar_7 = (tmpvar_6 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_7)) {
      tmpvar_4 = 0.0;
    } else {
      tmpvar_4 = texelFetch (sClipMask, ivec2(tmpvar_5), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_4);
  oFragColor = frag_color_1;
}


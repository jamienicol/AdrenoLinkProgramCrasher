#version 300 es
#extension GL_EXT_blend_func_extended : enable
precision highp float;
layout(location=0, index=0) out highp vec4 oFragColor;
layout(location=0, index=1) out highp vec4 oFragBlend;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_uv;
flat in highp vec4 v_color;
flat in highp vec2 v_mask_swizzle;
flat in highp vec4 v_uv_bounds;
flat in highp vec4 v_uv_sample_bounds;
flat in highp float v_perspective;
void main ()
{
  vec4 frag_color_1;
  vec4 frag_blend_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture (sColor0, min (max ((
    (v_uv * mix (gl_FragCoord.w, 1.0, v_perspective))
   + v_uv_bounds.xy), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
  frag_color_1 = (v_color * tmpvar_3);
  frag_blend_2 = ((tmpvar_3 * v_mask_swizzle.x) + (tmpvar_3.wwww * v_mask_swizzle.y));
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
  oFragBlend = (frag_blend_2 * tmpvar_4);
  oFragColor = frag_color_1;
}


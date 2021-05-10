#version 300 es
#extension GL_EXT_blend_func_extended : enable
precision highp float;
layout(location=0, index=0) out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
flat in highp vec4 v_color;
flat in highp vec3 v_mask_swizzle;
flat in highp vec4 v_uv_bounds;
in highp vec2 v_uv;
void main ()
{
  vec4 frag_color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture (sColor0, min (max (v_uv, v_uv_bounds.xy), v_uv_bounds.zw));
  frag_color_1 = (v_color * mix(tmpvar_2, tmpvar_2.xxxx, bvec4((v_mask_swizzle.z != 0.0))));
  float tmpvar_3;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_3 = 1.0;
  } else {
    vec2 tmpvar_4;
    tmpvar_4 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_5;
    tmpvar_5.xy = greaterThanEqual (tmpvar_4, vClipMaskUvBounds.xy);
    tmpvar_5.zw = lessThan (tmpvar_4, vClipMaskUvBounds.zw);
    bool tmpvar_6;
    tmpvar_6 = (tmpvar_5 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_6)) {
      tmpvar_3 = 0.0;
    } else {
      tmpvar_3 = texelFetch (sClipMask, ivec2(tmpvar_4), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_3);
  oFragColor = vec4(0.11, 0.077, 0.027, 0.125);
}


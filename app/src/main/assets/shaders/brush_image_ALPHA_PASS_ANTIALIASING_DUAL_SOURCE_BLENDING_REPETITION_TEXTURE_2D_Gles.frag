#version 300 es
#extension GL_EXT_blend_func_extended : enable
precision highp float;
layout(location=0, index=0) out highp vec4 oFragColor;
layout(location=0, index=1) out highp vec4 oFragBlend;
uniform lowp sampler2D sColor0;
flat in highp vec4 vTransformBounds;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_local_pos;
in highp vec2 v_uv;
flat in highp vec4 v_color;
flat in highp vec2 v_mask_swizzle;
flat in highp vec2 v_tile_repeat;
flat in highp vec4 v_uv_bounds;
flat in highp vec4 v_uv_sample_bounds;
flat in highp float v_perspective;
void main ()
{
  vec4 frag_color_1;
  vec4 frag_blend_2;
  highp vec2 repeated_uv_3;
  vec2 tmpvar_4;
  tmpvar_4 = max ((v_uv * mix (gl_FragCoord.w, 1.0, v_perspective)), vec2(0.0, 0.0));
  repeated_uv_3 = ((fract(tmpvar_4) * (v_uv_bounds.zw - v_uv_bounds.xy)) + v_uv_bounds.xy);
  if ((tmpvar_4.x >= v_tile_repeat.x)) {
    repeated_uv_3.x = v_uv_bounds.z;
  };
  if ((tmpvar_4.y >= v_tile_repeat.y)) {
    repeated_uv_3.y = v_uv_bounds.w;
  };
  vec2 tmpvar_5;
  tmpvar_5 = max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw));
  vec2 tmpvar_6;
  tmpvar_6 = (abs(dFdx(v_local_pos)) + abs(dFdy(v_local_pos)));
  vec4 tmpvar_7;
  tmpvar_7 = (texture (sColor0, min (max (repeated_uv_3, v_uv_sample_bounds.xy), v_uv_sample_bounds.zw)) * min (max (
    (0.5 - (max (tmpvar_5.x, tmpvar_5.y) * inversesqrt((0.5 * 
      dot (tmpvar_6, tmpvar_6)
    ))))
  , 0.0), 1.0));
  frag_color_1 = (v_color * tmpvar_7);
  frag_blend_2 = ((tmpvar_7 * v_mask_swizzle.x) + (tmpvar_7.wwww * v_mask_swizzle.y));
  float tmpvar_8;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_8 = 1.0;
  } else {
    vec2 tmpvar_9;
    tmpvar_9 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_10;
    tmpvar_10.xy = greaterThanEqual (tmpvar_9, vClipMaskUvBounds.xy);
    tmpvar_10.zw = lessThan (tmpvar_9, vClipMaskUvBounds.zw);
    bool tmpvar_11;
    tmpvar_11 = (tmpvar_10 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_11)) {
      tmpvar_8 = 0.0;
    } else {
      tmpvar_8 = texelFetch (sClipMask, ivec2(tmpvar_9), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_8);
  oFragBlend = (frag_blend_2 * tmpvar_8);
  oFragColor = frag_color_1;
}


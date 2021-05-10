#version 300 es
precision highp float;
out highp vec4 oFragColor;
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
  highp vec4 mask_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture (sColor0, min (max (v_uv, v_uv_bounds.xy), v_uv_bounds.zw));
  vec4 tmpvar_4;
  tmpvar_4 = mix(tmpvar_3, tmpvar_3.xxxx, bvec4((v_mask_swizzle.z != 0.0)));
  mask_2.w = tmpvar_4.w;
  mask_2.xyz = ((tmpvar_4.xyz * v_mask_swizzle.x) + (tmpvar_4.www * v_mask_swizzle.y));
  frag_color_1 = (v_color * mask_2);
  float tmpvar_5;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_5 = 1.0;
  } else {
    vec2 tmpvar_6;
    tmpvar_6 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_7;
    tmpvar_7.xy = greaterThanEqual (tmpvar_6, vClipMaskUvBounds.xy);
    tmpvar_7.zw = lessThan (tmpvar_6, vClipMaskUvBounds.zw);
    bool tmpvar_8;
    tmpvar_8 = (tmpvar_7 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_8)) {
      tmpvar_5 = 0.0;
    } else {
      tmpvar_5 = texelFetch (sClipMask, ivec2(tmpvar_6), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_5);
  oFragColor = frag_color_1;
}


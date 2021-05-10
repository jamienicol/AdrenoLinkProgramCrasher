#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sDither;
uniform highp sampler2D sGpuCache;
flat in highp vec4 vTransformBounds;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_local_pos;
flat in highp int v_gradient_address;
flat in highp float v_gradient_repeat;
in highp vec2 v_pos;
flat in highp vec2 v_tile_repeat;
flat in highp float v_start_offset;
flat in highp vec2 v_scale_dir;
void main ()
{
  vec4 frag_color_1;
  highp vec2 pos_2;
  vec2 tmpvar_3;
  tmpvar_3 = max (v_pos, vec2(0.0, 0.0));
  pos_2 = fract(tmpvar_3);
  if ((tmpvar_3.x >= v_tile_repeat.x)) {
    pos_2.x = 1.0;
  };
  if ((tmpvar_3.y >= v_tile_repeat.y)) {
    pos_2.y = 1.0;
  };
  float tmpvar_4;
  tmpvar_4 = (dot (pos_2, v_scale_dir) - v_start_offset);
  float tmpvar_5;
  tmpvar_5 = min (max ((1.0 + 
    ((tmpvar_4 - (floor(tmpvar_4) * v_gradient_repeat)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_6;
  tmpvar_6 = floor(tmpvar_5);
  highp int tmpvar_7;
  tmpvar_7 = (v_gradient_address + (2 * int(tmpvar_6)));
  ivec2 tmpvar_8;
  tmpvar_8.x = int((uint(tmpvar_7) % 1024u));
  tmpvar_8.y = int((uint(tmpvar_7) / 1024u));
  float tmpvar_9;
  tmpvar_9 = (((
    ((texelFetch (sDither, (ivec2(gl_FragCoord.xy) & ivec2(7, 7)), 0).x * 255.0) + 0.5)
   / 64.0) - 0.5) / 256.0);
  vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.x = tmpvar_9;
  tmpvar_10.y = tmpvar_9;
  tmpvar_10.z = tmpvar_9;
  vec2 tmpvar_11;
  tmpvar_11 = max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw));
  vec2 tmpvar_12;
  tmpvar_12 = (abs(dFdx(v_local_pos)) + abs(dFdy(v_local_pos)));
  frag_color_1 = (((texelFetch (sGpuCache, tmpvar_8, 0) + 
    (texelFetch (sGpuCache, (tmpvar_8 + ivec2(1, 0)), 0) * (tmpvar_5 - tmpvar_6))
  ) + tmpvar_10) * min (max (
    (0.5 - (max (tmpvar_11.x, tmpvar_11.y) * inversesqrt((0.5 * 
      dot (tmpvar_12, tmpvar_12)
    ))))
  , 0.0), 1.0));
  float tmpvar_13;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_13 = 1.0;
  } else {
    vec2 tmpvar_14;
    tmpvar_14 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_15;
    tmpvar_15.xy = greaterThanEqual (tmpvar_14, vClipMaskUvBounds.xy);
    tmpvar_15.zw = lessThan (tmpvar_14, vClipMaskUvBounds.zw);
    bool tmpvar_16;
    tmpvar_16 = (tmpvar_15 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_16)) {
      tmpvar_13 = 0.0;
    } else {
      tmpvar_13 = texelFetch (sClipMask, ivec2(tmpvar_14), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_13);
  oFragColor = frag_color_1;
}


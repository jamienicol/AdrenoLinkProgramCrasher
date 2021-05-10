#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sDither;
uniform highp sampler2D sGpuCache;
flat in highp int v_gradient_address;
flat in highp float v_gradient_repeat;
in highp vec2 v_pos;
flat in highp vec2 v_center;
flat in highp float v_start_offset;
flat in highp float v_offset_scale;
flat in highp float v_angle;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (v_pos - v_center);
  float tmpvar_2;
  tmpvar_2 = ((fract(
    ((atan (tmpvar_1.y, tmpvar_1.x) + v_angle) / 6.283185)
  ) * v_offset_scale) - v_start_offset);
  float tmpvar_3;
  tmpvar_3 = min (max ((1.0 + 
    ((tmpvar_2 - (floor(tmpvar_2) * v_gradient_repeat)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_4;
  tmpvar_4 = floor(tmpvar_3);
  highp int tmpvar_5;
  tmpvar_5 = (v_gradient_address + (2 * int(tmpvar_4)));
  ivec2 tmpvar_6;
  tmpvar_6.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_6.y = int((uint(tmpvar_5) / 1024u));
  float tmpvar_7;
  tmpvar_7 = (((
    ((texelFetch (sDither, (ivec2(gl_FragCoord.xy) & ivec2(7, 7)), 0).x * 255.0) + 0.5)
   / 64.0) - 0.5) / 256.0);
  vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.y = tmpvar_7;
  tmpvar_8.z = tmpvar_7;
  oFragColor = ((texelFetch (sGpuCache, tmpvar_6, 0) + (texelFetch (sGpuCache, 
    (tmpvar_6 + ivec2(1, 0))
  , 0) * 
    (tmpvar_3 - tmpvar_4)
  )) + tmpvar_8);
}


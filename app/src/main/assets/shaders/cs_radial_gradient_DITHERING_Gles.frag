#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sDither;
uniform highp sampler2D sGpuCache;
flat in highp int v_gradient_address;
flat in highp float v_gradient_repeat;
in highp vec2 v_pos;
flat in highp float v_start_radius;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (sqrt(dot (v_pos, v_pos)) - v_start_radius);
  float tmpvar_2;
  tmpvar_2 = min (max ((1.0 + 
    ((tmpvar_1 - (floor(tmpvar_1) * v_gradient_repeat)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_3;
  tmpvar_3 = floor(tmpvar_2);
  highp int tmpvar_4;
  tmpvar_4 = (v_gradient_address + (2 * int(tmpvar_3)));
  ivec2 tmpvar_5;
  tmpvar_5.x = int((uint(tmpvar_4) % 1024u));
  tmpvar_5.y = int((uint(tmpvar_4) / 1024u));
  float tmpvar_6;
  tmpvar_6 = (((
    ((texelFetch (sDither, (ivec2(gl_FragCoord.xy) & ivec2(7, 7)), 0).x * 255.0) + 0.5)
   / 64.0) - 0.5) / 256.0);
  vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_6;
  tmpvar_7.z = tmpvar_6;
  oFragColor = ((texelFetch (sGpuCache, tmpvar_5, 0) + (texelFetch (sGpuCache, 
    (tmpvar_5 + ivec2(1, 0))
  , 0) * 
    (tmpvar_2 - tmpvar_3)
  )) + tmpvar_7);
}


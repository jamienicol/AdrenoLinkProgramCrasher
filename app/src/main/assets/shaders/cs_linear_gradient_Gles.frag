#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform highp sampler2D sGpuCache;
flat in highp int v_gradient_address;
flat in highp float v_gradient_repeat;
in highp vec2 v_pos;
flat in highp vec2 v_scale_dir;
flat in highp float v_start_offset;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (dot (v_pos, v_scale_dir) - v_start_offset);
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
  oFragColor = (texelFetch (sGpuCache, tmpvar_5, 0) + (texelFetch (sGpuCache, (tmpvar_5 + ivec2(1, 0)), 0) * (tmpvar_2 - tmpvar_3)));
}


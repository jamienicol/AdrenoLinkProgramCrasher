#version 300 es
precision highp float;
out highp vec4 oFragColor;
flat in highp vec4 v_color;
void main ()
{
  oFragColor = v_color;
}


#version 300 es
precision highp float;
out highp vec4 oFragColor;
in highp vec4 vColor;
void main ()
{
  oFragColor = vColor;
}


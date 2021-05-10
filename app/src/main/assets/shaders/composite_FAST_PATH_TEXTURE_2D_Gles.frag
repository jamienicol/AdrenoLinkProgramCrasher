#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
in highp vec2 vUv;
void main ()
{
  oFragColor = texture (sColor0, vUv);
}


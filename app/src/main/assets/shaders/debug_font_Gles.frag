#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
in highp vec2 vColorTexCoord;
in highp vec4 vColor;
void main ()
{
  oFragColor = (vColor * texture (sColor0, vColorTexCoord).x);
}


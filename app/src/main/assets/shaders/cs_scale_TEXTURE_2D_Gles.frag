#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
in highp vec2 vUv;
flat in highp vec4 vUvRect;
void main ()
{
  oFragColor = texture (sColor0, min (max (vUv, vUvRect.xy), vUvRect.zw));
}


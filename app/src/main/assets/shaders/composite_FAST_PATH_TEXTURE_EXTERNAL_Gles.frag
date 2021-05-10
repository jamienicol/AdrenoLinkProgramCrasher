#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
out highp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
in highp vec2 vUv;
void main ()
{
  oFragColor = texture (sColor0, vUv);
}


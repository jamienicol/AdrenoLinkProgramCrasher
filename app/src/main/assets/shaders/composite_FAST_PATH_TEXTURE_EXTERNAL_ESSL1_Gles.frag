#version 100
#extension GL_OES_EGL_image_external : enable
precision highp float;
uniform lowp samplerExternalOES sColor0;
varying highp vec2 vUv;
void main ()
{
  gl_FragColor = texture2D (sColor0, vUv);
}


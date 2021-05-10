#version 100
#extension GL_OES_EGL_image_external : enable
precision highp float;
uniform lowp samplerExternalOES sColor0;
varying highp vec2 vUv;
varying highp vec4 vColor;
varying highp vec4 vUVBounds;
void main ()
{
  gl_FragColor = (vColor * texture2D (sColor0, min (max (vUv, vUVBounds.xy), vUVBounds.zw)));
}


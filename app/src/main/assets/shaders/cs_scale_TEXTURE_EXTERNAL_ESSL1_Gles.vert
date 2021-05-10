#version 100
#extension GL_OES_EGL_image_external : enable
uniform highp mat4 uTransform;
attribute highp vec2 aPosition;
varying highp vec2 vUv;
varying highp vec4 vUvRect;
uniform highp vec2 uTextureSize;
attribute highp vec4 aScaleTargetRect;
attribute highp vec4 aScaleSourceRect;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = (aScaleSourceRect.xy + vec2(0.5, 0.5));
  tmpvar_1.zw = ((aScaleSourceRect.xy + aScaleSourceRect.zw) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_1 / uTextureSize.xyxy);
  vUv = ((aScaleSourceRect.xy + (aScaleSourceRect.zw * aPosition)) / uTextureSize);
  vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  tmpvar_2.xy = (aScaleTargetRect.xy + (aScaleTargetRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_2);
}


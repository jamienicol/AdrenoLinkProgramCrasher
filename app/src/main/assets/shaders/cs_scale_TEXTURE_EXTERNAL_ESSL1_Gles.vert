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
  vec2 tmpvar_1;
  tmpvar_1 = (aScaleSourceRect.zw - aScaleSourceRect.xy);
  vec4 tmpvar_2;
  tmpvar_2.xy = (aScaleSourceRect.xy + vec2(0.5, 0.5));
  tmpvar_2.zw = ((aScaleSourceRect.xy + tmpvar_1) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_2 / uTextureSize.xyxy);
  vUv = ((aScaleSourceRect.xy + (tmpvar_1 * aPosition)) / uTextureSize);
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = mix (aScaleTargetRect.xy, aScaleTargetRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_3);
}


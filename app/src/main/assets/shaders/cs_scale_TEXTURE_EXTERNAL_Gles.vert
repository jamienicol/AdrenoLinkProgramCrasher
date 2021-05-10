#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp samplerExternalOES sColor0;
out highp vec2 vUv;
flat out highp vec4 vUvRect;
in highp vec4 aScaleTargetRect;
in highp vec4 aScaleSourceRect;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = vec2(textureSize (sColor0, 0));
  vec4 tmpvar_2;
  tmpvar_2.xy = (aScaleSourceRect.xy + vec2(0.5, 0.5));
  tmpvar_2.zw = ((aScaleSourceRect.xy + aScaleSourceRect.zw) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_2 / tmpvar_1.xyxy);
  vUv = ((aScaleSourceRect.xy + (aScaleSourceRect.zw * aPosition)) / tmpvar_1);
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = (aScaleTargetRect.xy + (aScaleTargetRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_3);
}


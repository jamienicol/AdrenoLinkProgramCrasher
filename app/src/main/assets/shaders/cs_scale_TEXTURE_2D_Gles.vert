#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
out highp vec2 vUv;
flat out highp vec4 vUvRect;
in highp vec4 aScaleTargetRect;
in highp vec4 aScaleSourceRect;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (aScaleSourceRect.zw - aScaleSourceRect.xy);
  vec2 tmpvar_2;
  tmpvar_2 = vec2(textureSize (sColor0, 0));
  vec4 tmpvar_3;
  tmpvar_3.xy = (aScaleSourceRect.xy + vec2(0.5, 0.5));
  tmpvar_3.zw = ((aScaleSourceRect.xy + tmpvar_1) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_3 / tmpvar_2.xyxy);
  vUv = ((aScaleSourceRect.xy + (tmpvar_1 * aPosition)) / tmpvar_2);
  vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = mix (aScaleTargetRect.xy, aScaleTargetRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_4);
}


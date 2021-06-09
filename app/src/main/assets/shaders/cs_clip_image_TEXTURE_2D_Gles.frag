#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
flat in highp vec4 vTransformBounds;
in highp vec2 vLocalPos;
in highp vec2 vClipMaskImageUv;
flat in highp vec4 vClipMaskUvInnerRect;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = float((vLocalPos.x >= vTransformBounds.z));
  tmpvar_1.y = float((vLocalPos.y >= vTransformBounds.w));
  vec2 tmpvar_2;
  tmpvar_2 = (vec2(greaterThanEqual (vLocalPos, vTransformBounds.xy)) - tmpvar_1);
  vec4 tmpvar_3;
  tmpvar_3.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_3.x = mix (1.0, texture (sColor0, min (max (vClipMaskImageUv, vClipMaskUvInnerRect.xy), vClipMaskUvInnerRect.zw)).x, (tmpvar_2.x * tmpvar_2.y));
  oFragColor = tmpvar_3;
}


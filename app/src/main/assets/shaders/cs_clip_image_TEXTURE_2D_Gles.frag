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
  tmpvar_1 = max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw));
  vec2 tmpvar_2;
  tmpvar_2 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  vec4 tmpvar_3;
  tmpvar_3.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_3.x = mix (1.0, texture (sColor0, min (max (vClipMaskImageUv, vClipMaskUvInnerRect.xy), vClipMaskUvInnerRect.zw)).x, min (max (
    (0.5 - (max (tmpvar_1.x, tmpvar_1.y) * inversesqrt((0.5 * 
      dot (tmpvar_2, tmpvar_2)
    ))))
  , 0.0), 1.0));
  oFragColor = tmpvar_3;
}


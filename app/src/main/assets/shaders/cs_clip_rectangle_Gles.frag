#version 300 es
precision highp float;
out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
in highp vec4 vLocalPos;
flat in highp vec4 vClipCenter_Radius_TL;
flat in highp vec4 vClipCenter_Radius_TR;
flat in highp vec4 vClipCenter_Radius_BL;
flat in highp vec4 vClipCenter_Radius_BR;
flat in highp float vClipMode;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (vLocalPos.xy / vLocalPos.w);
  vec2 tmpvar_2;
  tmpvar_2 = (abs(dFdx(tmpvar_1)) + abs(dFdy(tmpvar_1)));
  float tmpvar_3;
  tmpvar_3 = inversesqrt((0.5 * dot (tmpvar_2, tmpvar_2)));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vClipCenter_Radius_TL.zw;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vClipCenter_Radius_TR.zw;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vClipCenter_Radius_BR.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vClipCenter_Radius_BL.zw;
  highp vec4 corner_8;
  corner_8 = vec4(1e-06, 1e-06, 1.0, 1.0);
  tmpvar_4.xy = (vClipCenter_Radius_TL.xy - tmpvar_1);
  tmpvar_5.xy = ((vClipCenter_Radius_TR.xy - tmpvar_1) * vec2(-1.0, 1.0));
  tmpvar_6.xy = (tmpvar_1 - vClipCenter_Radius_BR.xy);
  tmpvar_7.xy = ((vClipCenter_Radius_BL.xy - tmpvar_1) * vec2(1.0, -1.0));
  float tmpvar_9;
  tmpvar_9 = min (tmpvar_4.x, tmpvar_4.y);
  if ((1e-06 < tmpvar_9)) {
    corner_8 = tmpvar_4;
  };
  float tmpvar_10;
  tmpvar_10 = min (tmpvar_5.x, tmpvar_5.y);
  float tmpvar_11;
  tmpvar_11 = min (corner_8.x, corner_8.y);
  if ((tmpvar_11 < tmpvar_10)) {
    corner_8 = tmpvar_5;
  };
  float tmpvar_12;
  tmpvar_12 = min (tmpvar_6.x, tmpvar_6.y);
  float tmpvar_13;
  tmpvar_13 = min (corner_8.x, corner_8.y);
  if ((tmpvar_13 < tmpvar_12)) {
    corner_8 = tmpvar_6;
  };
  float tmpvar_14;
  tmpvar_14 = min (tmpvar_7.x, tmpvar_7.y);
  float tmpvar_15;
  tmpvar_15 = min (corner_8.x, corner_8.y);
  if ((tmpvar_15 < tmpvar_14)) {
    corner_8 = tmpvar_7;
  };
  vec2 tmpvar_16;
  tmpvar_16 = (corner_8.xy * corner_8.zw);
  vec2 tmpvar_17;
  tmpvar_17 = (2.0 * tmpvar_16);
  vec2 tmpvar_18;
  tmpvar_18 = max ((vTransformBounds.xy - tmpvar_1), (tmpvar_1 - vTransformBounds.zw));
  float tmpvar_19;
  tmpvar_19 = min (max ((0.5 - 
    (max (((
      dot (corner_8.xy, tmpvar_16)
     - 1.0) * inversesqrt(
      dot (tmpvar_17, tmpvar_17)
    )), max (tmpvar_18.x, tmpvar_18.y)) * tmpvar_3)
  ), 0.0), 1.0);
  float tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, (1.0 - tmpvar_19), vClipMode);
  float tmpvar_21;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_21 = tmpvar_20;
  } else {
    tmpvar_21 = 0.0;
  };
  vec4 tmpvar_22;
  tmpvar_22.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_22.x = tmpvar_21;
  oFragColor = tmpvar_22;
}


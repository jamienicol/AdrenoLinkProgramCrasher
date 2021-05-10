#version 300 es
precision highp float;
out highp vec4 oFragColor;
in highp vec2 vLocalPos;
flat in mediump int vStyle;
flat in highp vec4 vParams;
void main ()
{
  highp float alpha_1;
  highp vec2 pos_2;
  pos_2 = vLocalPos;
  vec2 tmpvar_3;
  tmpvar_3 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  float tmpvar_4;
  tmpvar_4 = inversesqrt((0.5 * dot (tmpvar_3, tmpvar_3)));
  alpha_1 = 1.0;
  bool tmpvar_5;
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  tmpvar_5 = (0 == vStyle);
  if (tmpvar_5) {
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (2 == vStyle));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    alpha_1 = float((vParams.y >= floor(
      (vLocalPos.x + 0.5)
    )));
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (1 == vStyle));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    vec2 tmpvar_7;
    tmpvar_7 = (vLocalPos - vParams.yz);
    alpha_1 = min (max ((0.5 - 
      ((sqrt(dot (tmpvar_7, tmpvar_7)) - vParams.y) * tmpvar_4)
    ), 0.0), 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (3 == vStyle));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    float tmpvar_8;
    tmpvar_8 = (vParams.y + vParams.z);
    float tmpvar_9;
    tmpvar_9 = (vParams.w / 2.0);
    float tmpvar_10;
    tmpvar_10 = (-2.0 * (float(
      (tmpvar_8 >= (float(mod (vLocalPos.x, (2.0 * tmpvar_8)))))
    ) - 0.5));
    float tmpvar_11;
    tmpvar_11 = (tmpvar_9 + ((tmpvar_9 - vParams.x) * tmpvar_10));
    pos_2.x = (float(mod (vLocalPos.x, tmpvar_8)));
    vec2 tmpvar_12;
    tmpvar_12.x = 0.0;
    tmpvar_12.y = tmpvar_11;
    vec2 tmpvar_13;
    tmpvar_13.x = 1.0;
    tmpvar_13.y = -(tmpvar_10);
    vec2 tmpvar_14;
    tmpvar_14.x = 0.0;
    tmpvar_14.y = tmpvar_11;
    vec2 tmpvar_15;
    tmpvar_15.x = 0.0;
    tmpvar_15.y = -(tmpvar_10);
    vec2 tmpvar_16;
    tmpvar_16.x = vParams.z;
    tmpvar_16.y = tmpvar_11;
    vec2 tmpvar_17;
    tmpvar_17.x = -1.0;
    tmpvar_17.y = -(tmpvar_10);
    float tmpvar_18;
    tmpvar_18 = min (max ((0.5 - 
      ((abs(max (
        max (dot ((tmpvar_13 * inversesqrt(
          dot (tmpvar_13, tmpvar_13)
        )), (tmpvar_12 - pos_2)), dot ((tmpvar_15 * inversesqrt(
          dot (tmpvar_15, tmpvar_15)
        )), (tmpvar_14 - pos_2)))
      , 
        dot ((tmpvar_17 * inversesqrt(dot (tmpvar_17, tmpvar_17))), (tmpvar_16 - pos_2))
      )) - vParams.x) * tmpvar_4)
    ), 0.0), 1.0);
    alpha_1 = tmpvar_18;
    if ((1.0 >= vParams.x)) {
      alpha_1 = (1.0 - float((0.5 >= tmpvar_18)));
    };
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = !(tmpvar_6);
  if (tmpvar_5) {
    tmpvar_6 = bool(1);
  };
  oFragColor = vec4(alpha_1);
}


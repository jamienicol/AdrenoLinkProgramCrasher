#version 300 es
precision highp float;
out highp vec4 oFragColor;
flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
flat in highp vec4 vColorLine;
flat in mediump int vMixColors;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipRadii;
flat in highp vec4 vHorizontalClipCenter_Sign;
flat in highp vec2 vHorizontalClipRadii;
flat in highp vec4 vVerticalClipCenter_Sign;
flat in highp vec2 vVerticalClipRadii;
in highp vec2 vPos;
void main ()
{
  highp float d_1;
  highp vec2 clip_relative_pos_2;
  highp float mix_factor_3;
  vec2 tmpvar_4;
  tmpvar_4 = (abs(dFdx(vPos)) + abs(dFdy(vPos)));
  float tmpvar_5;
  tmpvar_5 = inversesqrt((0.5 * dot (tmpvar_4, tmpvar_4)));
  bool tmpvar_6;
  tmpvar_6 = (vMixColors != 2);
  mix_factor_3 = 0.0;
  if ((vMixColors != 0)) {
    float tmpvar_7;
    tmpvar_7 = dot ((vColorLine.zw * inversesqrt(
      dot (vColorLine.zw, vColorLine.zw)
    )), (vColorLine.xy - vPos));
    if (tmpvar_6) {
      mix_factor_3 = min (max ((0.5 - 
        (-(tmpvar_7) * tmpvar_5)
      ), 0.0), 1.0);
    } else {
      float tmpvar_8;
      if ((tmpvar_7 >= -0.0001)) {
        tmpvar_8 = 1.0;
      } else {
        tmpvar_8 = 0.0;
      };
      mix_factor_3 = tmpvar_8;
    };
  };
  vec2 tmpvar_9;
  tmpvar_9 = (vPos - vClipCenter_Sign.xy);
  clip_relative_pos_2 = tmpvar_9;
  d_1 = -1.0;
  if ((lessThan ((vClipCenter_Sign.zw * tmpvar_9), vec2(0.0, 0.0)) == bvec2(1, 1))) {
    highp float tmpvar_10;
    tmpvar_10 = float((lessThan (vec2(0.0, 0.0), vClipRadii.xy) == bvec2(1, 1)));
    vec2 tmpvar_11;
    tmpvar_11 = (tmpvar_9 * (1.0/(max (
      (vClipRadii.xy * vClipRadii.xy)
    , 1e-06))));
    vec2 tmpvar_12;
    tmpvar_12 = ((1.0 + tmpvar_10) * tmpvar_11);
    highp float tmpvar_13;
    tmpvar_13 = float((lessThan (vec2(0.0, 0.0), vClipRadii.zw) == bvec2(1, 1)));
    vec2 tmpvar_14;
    tmpvar_14 = (tmpvar_9 * (1.0/(max (
      (vClipRadii.zw * vClipRadii.zw)
    , 1e-06))));
    vec2 tmpvar_15;
    tmpvar_15 = ((1.0 + tmpvar_13) * tmpvar_14);
    d_1 = max (((
      dot (tmpvar_9, tmpvar_11)
     - tmpvar_10) * inversesqrt(
      dot (tmpvar_12, tmpvar_12)
    )), -((
      (dot (tmpvar_9, tmpvar_14) - tmpvar_13)
     * 
      inversesqrt(dot (tmpvar_15, tmpvar_15))
    )));
  };
  clip_relative_pos_2 = (vPos - vHorizontalClipCenter_Sign.xy);
  if ((lessThan ((vHorizontalClipCenter_Sign.zw * clip_relative_pos_2), vec2(0.0, 0.0)) == bvec2(1, 1))) {
    highp float tmpvar_16;
    tmpvar_16 = float((lessThan (vec2(0.0, 0.0), vHorizontalClipRadii) == bvec2(1, 1)));
    vec2 tmpvar_17;
    tmpvar_17 = (clip_relative_pos_2 * (1.0/(max (
      (vHorizontalClipRadii * vHorizontalClipRadii)
    , 1e-06))));
    vec2 tmpvar_18;
    tmpvar_18 = ((1.0 + tmpvar_16) * tmpvar_17);
    d_1 = max (((
      dot (clip_relative_pos_2, tmpvar_17)
     - tmpvar_16) * inversesqrt(
      dot (tmpvar_18, tmpvar_18)
    )), d_1);
  };
  clip_relative_pos_2 = (vPos - vVerticalClipCenter_Sign.xy);
  if ((lessThan ((vVerticalClipCenter_Sign.zw * clip_relative_pos_2), vec2(0.0, 0.0)) == bvec2(1, 1))) {
    highp float tmpvar_19;
    tmpvar_19 = float((lessThan (vec2(0.0, 0.0), vVerticalClipRadii) == bvec2(1, 1)));
    vec2 tmpvar_20;
    tmpvar_20 = (clip_relative_pos_2 * (1.0/(max (
      (vVerticalClipRadii * vVerticalClipRadii)
    , 1e-06))));
    vec2 tmpvar_21;
    tmpvar_21 = ((1.0 + tmpvar_19) * tmpvar_20);
    d_1 = max (((
      dot (clip_relative_pos_2, tmpvar_20)
     - tmpvar_19) * inversesqrt(
      dot (tmpvar_21, tmpvar_21)
    )), d_1);
  };
  float tmpvar_22;
  if (tmpvar_6) {
    tmpvar_22 = min (max ((0.5 - 
      (d_1 * tmpvar_5)
    ), 0.0), 1.0);
  } else {
    tmpvar_22 = 1.0;
  };
  oFragColor = (mix (vColor0, vColor1, mix_factor_3) * tmpvar_22);
}


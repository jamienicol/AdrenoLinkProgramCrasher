#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp vec4 vColor0;
flat out highp vec4 vColor1;
flat out highp vec4 vColorLine;
flat out highp int vMixColors;
flat out highp vec4 vClipCenter_Sign;
flat out highp vec4 vClipRadii;
flat out highp vec4 vHorizontalClipCenter_Sign;
flat out highp vec2 vHorizontalClipRadii;
flat out highp vec4 vVerticalClipCenter_Sign;
flat out highp vec2 vVerticalClipRadii;
out highp vec2 vPos;
in highp vec2 aTaskOrigin;
in highp vec4 aRect;
in highp vec4 aColor0;
in highp vec4 aColor1;
in highp int aFlags;
in highp vec2 aWidths;
in highp vec2 aRadii;
in highp vec4 aClipParams1;
in highp vec4 aClipParams2;
void main ()
{
  highp int mix_colors_1;
  int tmpvar_2;
  tmpvar_2 = (aFlags & 255);
  bool tmpvar_3;
  tmpvar_3 = (((aFlags >> 24) & 240) != 0);
  highp vec2 p_4;
  bool tmpvar_5;
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  tmpvar_5 = (0 == tmpvar_2);
  if (tmpvar_5) {
    p_4 = vec2(0.0, 0.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (1 == tmpvar_2));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    p_4 = vec2(1.0, 0.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (2 == tmpvar_2));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    p_4 = vec2(1.0, 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (3 == tmpvar_2));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    p_4 = vec2(0.0, 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = !(tmpvar_6);
  if (tmpvar_5) {
    p_4 = vec2(0.0, 0.0);
    tmpvar_6 = bool(1);
  };
  vec2 tmpvar_7;
  tmpvar_7 = (aRect.zw - aRect.xy);
  vec2 tmpvar_8;
  tmpvar_8 = (p_4 * tmpvar_7);
  vec2 tmpvar_9;
  tmpvar_9 = (1.0 - (2.0 * p_4));
  bool tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = bool(0);
  tmpvar_10 = (0 == tmpvar_2);
  tmpvar_10 = (tmpvar_10 || (1 == tmpvar_2));
  tmpvar_10 = (tmpvar_10 || (2 == tmpvar_2));
  tmpvar_10 = (tmpvar_10 || (3 == tmpvar_2));
  if (tmpvar_10) {
    int tmpvar_12;
    if (tmpvar_3) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    mix_colors_1 = tmpvar_12;
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = !(tmpvar_11);
  if (tmpvar_10) {
    mix_colors_1 = 0;
    tmpvar_11 = bool(1);
  };
  vMixColors = mix_colors_1;
  vPos = (tmpvar_7 * aPosition);
  vColor0 = aColor0;
  vColor1 = aColor1;
  vec4 tmpvar_13;
  tmpvar_13.xy = (tmpvar_8 + (tmpvar_9 * aRadii));
  tmpvar_13.zw = tmpvar_9;
  vClipCenter_Sign = tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xy = aRadii;
  tmpvar_14.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_15.xy = tmpvar_8;
  tmpvar_15.z = (aWidths.y * -(tmpvar_9.y));
  tmpvar_15.w = (aWidths.x * tmpvar_9.x);
  vColorLine = tmpvar_15;
  vec2 tmpvar_16;
  tmpvar_16.x = -(tmpvar_9.x);
  tmpvar_16.y = tmpvar_9.y;
  vec4 tmpvar_17;
  tmpvar_17.xy = (aClipParams1.xy + (tmpvar_16 * aClipParams1.zw));
  tmpvar_17.zw = tmpvar_16;
  vHorizontalClipCenter_Sign = tmpvar_17;
  vHorizontalClipRadii = aClipParams1.zw;
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_9.x;
  tmpvar_18.y = -(tmpvar_9.y);
  vec4 tmpvar_19;
  tmpvar_19.xy = (aClipParams2.xy + (tmpvar_18 * aClipParams2.zw));
  tmpvar_19.zw = tmpvar_18;
  vVerticalClipCenter_Sign = tmpvar_19;
  vVerticalClipRadii = aClipParams2.zw;
  vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 1.0);
  tmpvar_20.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_20);
}


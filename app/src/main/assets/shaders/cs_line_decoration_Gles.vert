#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
out highp vec2 vLocalPos;
flat out highp int vStyle;
flat out highp vec4 vParams;
in highp vec4 aTaskRect;
in highp vec2 aLocalSize;
in highp int aStyle;
in highp float aAxisSelect;
in highp float aWavyLineThickness;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = mix (aLocalSize, aLocalSize.yx, aAxisSelect);
  vStyle = aStyle;
  bool tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  tmpvar_2 = (0 == aStyle);
  if (tmpvar_2) {
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (2 == aStyle));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    vec4 tmpvar_4;
    tmpvar_4.zw = vec2(0.0, 0.0);
    tmpvar_4.x = tmpvar_1.x;
    tmpvar_4.y = (0.5 * tmpvar_1.x);
    vParams = tmpvar_4;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (1 == aStyle));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    vec4 tmpvar_5;
    tmpvar_5.w = 0.0;
    tmpvar_5.x = (tmpvar_1.y * 2.0);
    tmpvar_5.y = (tmpvar_1.y / 2.0);
    tmpvar_5.z = (0.5 * tmpvar_1.y);
    vParams = tmpvar_5;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (3 == aStyle));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    float tmpvar_6;
    tmpvar_6 = max (aWavyLineThickness, 1.0);
    vec4 tmpvar_7;
    tmpvar_7.x = (tmpvar_6 / 2.0);
    tmpvar_7.y = (tmpvar_1.y - tmpvar_6);
    tmpvar_7.z = max (((tmpvar_6 - 1.0) * 2.0), 1.0);
    tmpvar_7.w = tmpvar_1.y;
    vParams = tmpvar_7;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = !(tmpvar_3);
  if (tmpvar_2) {
    vParams = vec4(0.0, 0.0, 0.0, 0.0);
  };
  vLocalPos = (mix (aPosition, aPosition.yx, aAxisSelect) * tmpvar_1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 1.0);
  tmpvar_8.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_8);
}


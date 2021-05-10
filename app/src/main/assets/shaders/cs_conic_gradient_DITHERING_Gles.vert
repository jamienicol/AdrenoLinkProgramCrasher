#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp int v_gradient_address;
flat out highp float v_gradient_repeat;
out highp vec2 v_pos;
flat out highp vec2 v_center;
flat out highp float v_start_offset;
flat out highp float v_offset_scale;
flat out highp float v_angle;
in highp vec4 aTaskRect;
in highp vec2 aCenter;
in highp vec2 aScale;
in highp float aStartOffset;
in highp float aEndOffset;
in highp float aAngle;
in highp int aExtendMode;
in highp int aGradientStopsAddress;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (aEndOffset - aStartOffset);
  float tmpvar_2;
  if ((tmpvar_1 != 0.0)) {
    tmpvar_2 = (1.0/(tmpvar_1));
  } else {
    tmpvar_2 = 0.0;
  };
  v_offset_scale = tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_3);
  v_angle = (1.570796 - aAngle);
  v_start_offset = (aStartOffset * tmpvar_2);
  v_center = (aCenter * tmpvar_2);
  v_pos = (((aTaskRect.zw * aPosition) * tmpvar_2) * aScale);
  v_gradient_repeat = float((aExtendMode == 1));
  v_gradient_address = aGradientStopsAddress;
}


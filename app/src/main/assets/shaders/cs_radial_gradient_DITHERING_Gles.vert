#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp int v_gradient_address;
flat out highp float v_gradient_repeat;
out highp vec2 v_pos;
flat out highp float v_start_radius;
in highp vec4 aTaskRect;
in highp vec2 aCenter;
in highp float aStartRadius;
in highp float aEndRadius;
in highp float aXYRatio;
in highp int aExtendMode;
in highp int aGradientStopsAddress;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (aEndRadius - aStartRadius);
  float tmpvar_2;
  if ((tmpvar_1 != 0.0)) {
    tmpvar_2 = (1.0/(tmpvar_1));
  } else {
    tmpvar_2 = 0.0;
  };
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_3);
  v_start_radius = (aStartRadius * tmpvar_2);
  v_pos = (((aTaskRect.zw * aPosition) - aCenter) * tmpvar_2);
  v_pos.y = (v_pos.y * aXYRatio);
  v_gradient_repeat = float((aExtendMode == 1));
  v_gradient_address = aGradientStopsAddress;
}


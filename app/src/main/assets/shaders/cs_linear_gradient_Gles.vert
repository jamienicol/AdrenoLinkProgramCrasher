#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp int v_gradient_address;
flat out highp float v_gradient_repeat;
out highp vec2 v_pos;
flat out highp vec2 v_scale_dir;
flat out highp float v_start_offset;
in highp vec4 aTaskRect;
in highp vec2 aStartPoint;
in highp vec2 aEndPoint;
in highp vec2 aScale;
in highp int aExtendMode;
in highp int aGradientStopsAddress;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_1);
  v_pos = (aPosition * aScale);
  vec2 tmpvar_2;
  tmpvar_2 = (aEndPoint - aStartPoint);
  v_scale_dir = (tmpvar_2 / dot (tmpvar_2, tmpvar_2));
  v_start_offset = dot (aStartPoint, v_scale_dir);
  v_scale_dir = (v_scale_dir * aTaskRect.zw);
  v_gradient_repeat = float((aExtendMode == 1));
  v_gradient_address = aGradientStopsAddress;
}


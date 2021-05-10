#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
out highp vec4 vColor;
in highp vec4 aRect;
in highp vec4 aColor;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (aRect.xy + (aPosition * aRect.zw));
  gl_Position = (uTransform * tmpvar_1);
  gl_Position.z = gl_Position.w;
  vColor = aColor;
}


#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
out highp vec4 vColor;
in highp vec4 aColor;
void main ()
{
  highp vec4 pos_1;
  vec4 tmpvar_2;
  tmpvar_2.xyz = (aColor.xyz * aColor.w);
  tmpvar_2.w = aColor.w;
  vColor = tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = aPosition;
  pos_1.zw = tmpvar_3.zw;
  pos_1.xy = floor((aPosition + 0.5));
  gl_Position = (uTransform * pos_1);
}


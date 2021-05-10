#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
out highp vec2 vColorTexCoord;
out highp vec4 vColor;
in highp vec4 aColor;
in highp vec2 aColorTexCoord;
void main ()
{
  highp vec4 pos_1;
  vColor = aColor;
  vColorTexCoord = aColorTexCoord;
  vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  tmpvar_2.xy = aPosition;
  pos_1.zw = tmpvar_2.zw;
  pos_1.xy = floor((aPosition + 0.5));
  gl_Position = (uTransform * pos_1);
}


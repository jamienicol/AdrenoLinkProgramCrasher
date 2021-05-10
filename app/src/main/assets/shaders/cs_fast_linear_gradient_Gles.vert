#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
out highp float vPos;
flat out highp vec4 vColor0;
flat out highp vec4 vColor1;
in highp vec4 aTaskRect;
in highp vec4 aColor0;
in highp vec4 aColor1;
in highp float aAxisSelect;
void main ()
{
  vPos = mix (aPosition.x, aPosition.y, aAxisSelect);
  vColor0 = aColor0;
  vColor1 = aColor1;
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_1);
}


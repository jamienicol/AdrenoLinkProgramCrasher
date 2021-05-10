#version 300 es
precision highp float;
out highp vec4 oFragColor;
in highp float vPos;
flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
void main ()
{
  oFragColor = mix (vColor0, vColor1, vPos);
}


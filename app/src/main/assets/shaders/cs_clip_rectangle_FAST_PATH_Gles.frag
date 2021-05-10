#version 300 es
precision highp float;
out highp vec4 oFragColor;
in highp vec4 vLocalPos;
flat in highp vec3 vClipParams;
flat in highp float vClipMode;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (vLocalPos.xy / vLocalPos.w);
  vec2 tmpvar_2;
  tmpvar_2 = (abs(dFdx(tmpvar_1)) + abs(dFdy(tmpvar_1)));
  vec2 tmpvar_3;
  tmpvar_3 = (abs(tmpvar_1) - vClipParams.xy);
  vec2 tmpvar_4;
  tmpvar_4 = max (tmpvar_3, vec2(0.0, 0.0));
  float tmpvar_5;
  tmpvar_5 = min (max ((0.5 - 
    (((sqrt(
      dot (tmpvar_4, tmpvar_4)
    ) + min (
      max (tmpvar_3.x, tmpvar_3.y)
    , 0.0)) - vClipParams.z) * inversesqrt((0.5 * dot (tmpvar_2, tmpvar_2))))
  ), 0.0), 1.0);
  float tmpvar_6;
  tmpvar_6 = mix (tmpvar_5, (1.0 - tmpvar_5), vClipMode);
  float tmpvar_7;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_7 = tmpvar_6;
  } else {
    tmpvar_7 = 0.0;
  };
  vec4 tmpvar_8;
  tmpvar_8.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_8.x = tmpvar_7;
  oFragColor = tmpvar_8;
}


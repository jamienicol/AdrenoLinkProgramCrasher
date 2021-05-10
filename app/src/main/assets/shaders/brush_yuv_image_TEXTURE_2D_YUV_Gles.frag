#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sColor1;
uniform lowp sampler2D sColor2;
in highp vec2 vUv_Y;
flat in highp vec4 vUvBounds_Y;
in highp vec2 vUv_U;
flat in highp vec4 vUvBounds_U;
in highp vec2 vUv_V;
flat in highp vec4 vUvBounds_V;
flat in highp mat3 vYuvColorMatrix;
flat in highp vec4 vYuvOffsetVector_Coefficient;
flat in mediump int vFormat;
void main ()
{
  highp vec3 yuv_value_1;
  bool tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  tmpvar_2 = (1 == vFormat);
  if (tmpvar_2) {
    yuv_value_1.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    yuv_value_1.y = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).x;
    yuv_value_1.z = texture (sColor2, min (max (vUv_V, vUvBounds_V.xy), vUvBounds_V.zw)).x;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (0 == vFormat));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    yuv_value_1.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    yuv_value_1.yz = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).xy;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (2 == vFormat));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    yuv_value_1 = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).yzx;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = !(tmpvar_3);
  if (tmpvar_2) {
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    tmpvar_3 = bool(1);
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (vYuvColorMatrix * ((yuv_value_1 * vYuvOffsetVector_Coefficient.w) - vYuvOffsetVector_Coefficient.xyz));
  oFragColor = tmpvar_4;
}


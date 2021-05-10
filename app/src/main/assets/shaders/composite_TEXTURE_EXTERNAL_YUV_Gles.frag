#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
out highp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
uniform lowp samplerExternalOES sColor1;
uniform lowp samplerExternalOES sColor2;
flat in highp mat3 vYuvColorMatrix;
flat in highp vec3 vYuvOffsetVector;
flat in highp float vYuvCoefficient;
flat in mediump int vYuvFormat;
in highp vec2 vUV_y;
in highp vec2 vUV_u;
in highp vec2 vUV_v;
flat in highp vec4 vUVBounds_y;
flat in highp vec4 vUVBounds_u;
flat in highp vec4 vUVBounds_v;
void main ()
{
  highp vec3 yuv_value_1;
  bool tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  tmpvar_2 = (1 == vYuvFormat);
  if (tmpvar_2) {
    yuv_value_1.x = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).x;
    yuv_value_1.y = texture (sColor1, min (max (vUV_u, vUVBounds_u.xy), vUVBounds_u.zw)).x;
    yuv_value_1.z = texture (sColor2, min (max (vUV_v, vUVBounds_v.xy), vUVBounds_v.zw)).x;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (0 == vYuvFormat));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    yuv_value_1.x = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).x;
    yuv_value_1.yz = texture (sColor1, min (max (vUV_u, vUVBounds_u.xy), vUVBounds_u.zw)).xy;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (2 == vYuvFormat));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    yuv_value_1 = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).yzx;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = !(tmpvar_3);
  if (tmpvar_2) {
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    tmpvar_3 = bool(1);
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (vYuvColorMatrix * ((yuv_value_1 * vYuvCoefficient) - vYuvOffsetVector));
  oFragColor = tmpvar_4;
}


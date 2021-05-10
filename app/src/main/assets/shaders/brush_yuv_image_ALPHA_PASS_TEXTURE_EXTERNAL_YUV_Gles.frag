#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
out highp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
uniform lowp samplerExternalOES sColor1;
uniform lowp samplerExternalOES sColor2;
flat in highp vec4 vTransformBounds;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_local_pos;
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
  vec4 frag_color_1;
  highp vec3 yuv_value_2;
  bool tmpvar_3;
  bool tmpvar_4;
  tmpvar_4 = bool(0);
  tmpvar_3 = (1 == vFormat);
  if (tmpvar_3) {
    yuv_value_2.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    yuv_value_2.y = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).x;
    yuv_value_2.z = texture (sColor2, min (max (vUv_V, vUvBounds_V.xy), vUvBounds_V.zw)).x;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = (tmpvar_3 || (0 == vFormat));
  tmpvar_3 = (tmpvar_3 && !(tmpvar_4));
  if (tmpvar_3) {
    yuv_value_2.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    yuv_value_2.yz = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).xy;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = (tmpvar_3 || (2 == vFormat));
  tmpvar_3 = (tmpvar_3 && !(tmpvar_4));
  if (tmpvar_3) {
    yuv_value_2 = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).yzx;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = !(tmpvar_4);
  if (tmpvar_3) {
    yuv_value_2 = vec3(0.0, 0.0, 0.0);
    tmpvar_4 = bool(1);
  };
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (vYuvColorMatrix * ((yuv_value_2 * vYuvOffsetVector_Coefficient.w) - vYuvOffsetVector_Coefficient.xyz));
  vec2 tmpvar_6;
  tmpvar_6 = max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw));
  vec2 tmpvar_7;
  tmpvar_7 = (abs(dFdx(v_local_pos)) + abs(dFdy(v_local_pos)));
  frag_color_1 = (tmpvar_5 * min (max (
    (0.5 - (max (tmpvar_6.x, tmpvar_6.y) * inversesqrt((0.5 * 
      dot (tmpvar_7, tmpvar_7)
    ))))
  , 0.0), 1.0));
  float tmpvar_8;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_8 = 1.0;
  } else {
    vec2 tmpvar_9;
    tmpvar_9 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_10;
    tmpvar_10.xy = greaterThanEqual (tmpvar_9, vClipMaskUvBounds.xy);
    tmpvar_10.zw = lessThan (tmpvar_9, vClipMaskUvBounds.zw);
    bool tmpvar_11;
    tmpvar_11 = (tmpvar_10 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_11)) {
      tmpvar_8 = 0.0;
    } else {
      tmpvar_8 = texelFetch (sClipMask, ivec2(tmpvar_9), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_8);
  oFragColor = frag_color_1;
}


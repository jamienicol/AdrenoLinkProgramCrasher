#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sColor1;
uniform lowp sampler2D sColor2;
flat out highp mat3 vYuvColorMatrix;
flat out highp vec3 vYuvOffsetVector;
flat out highp float vYuvCoefficient;
flat out highp int vYuvFormat;
out highp vec2 vUV_y;
out highp vec2 vUV_u;
out highp vec2 vUV_v;
flat out highp vec4 vUVBounds_y;
flat out highp vec4 vUVBounds_u;
flat out highp vec4 vUVBounds_v;
in highp vec4 aDeviceRect;
in highp vec4 aDeviceClipRect;
in highp vec4 aParams;
in highp vec4 aUvRect0;
in highp vec4 aUvRect1;
in highp vec4 aUvRect2;
void main ()
{
  highp float yuv_coefficient_1;
  highp int yuv_format_2;
  highp vec2 uv_3;
  vec2 tmpvar_4;
  tmpvar_4 = min (max ((aDeviceRect.xy + 
    (aPosition * aDeviceRect.zw)
  ), aDeviceClipRect.xy), (aDeviceClipRect.xy + aDeviceClipRect.zw));
  uv_3 = ((tmpvar_4 - aDeviceRect.xy) / aDeviceRect.zw);
  int tmpvar_5;
  tmpvar_5 = int(aParams.y);
  yuv_format_2 = int(aParams.z);
  yuv_coefficient_1 = aParams.w;
  mat3 tmpvar_6;
  if ((tmpvar_5 == 0)) {
    tmpvar_6 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((tmpvar_5 == 1)) {
      tmpvar_6 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      if ((tmpvar_5 == 3)) {
        tmpvar_6 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
      } else {
        tmpvar_6 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
      };
    };
  };
  vYuvColorMatrix = tmpvar_6;
  vec3 tmpvar_7;
  if ((tmpvar_5 == 3)) {
    tmpvar_7 = vec3(0.0, 0.0, 0.0);
  } else {
    tmpvar_7 = vec3(0.06275, 0.50196, 0.50196);
  };
  vYuvOffsetVector = tmpvar_7;
  vYuvCoefficient = yuv_coefficient_1;
  vYuvFormat = yuv_format_2;
  vec2 tmpvar_8;
  tmpvar_8 = vec2(textureSize (sColor0, 0));
  vec4 tmpvar_9;
  tmpvar_9.xy = (aUvRect0.xy + vec2(0.5, 0.5));
  tmpvar_9.zw = (aUvRect0.zw - vec2(0.5, 0.5));
  vUV_y = (mix (aUvRect0.xy, aUvRect0.zw, uv_3) / tmpvar_8);
  vUVBounds_y = (tmpvar_9 / tmpvar_8.xyxy);
  vec2 tmpvar_10;
  tmpvar_10 = vec2(textureSize (sColor1, 0));
  vec4 tmpvar_11;
  tmpvar_11.xy = (aUvRect1.xy + vec2(0.5, 0.5));
  tmpvar_11.zw = (aUvRect1.zw - vec2(0.5, 0.5));
  vUV_u = (mix (aUvRect1.xy, aUvRect1.zw, uv_3) / tmpvar_10);
  vUVBounds_u = (tmpvar_11 / tmpvar_10.xyxy);
  vec2 tmpvar_12;
  tmpvar_12 = vec2(textureSize (sColor2, 0));
  vec4 tmpvar_13;
  tmpvar_13.xy = (aUvRect2.xy + vec2(0.5, 0.5));
  tmpvar_13.zw = (aUvRect2.zw - vec2(0.5, 0.5));
  vUV_v = (mix (aUvRect2.xy, aUvRect2.zw, uv_3) / tmpvar_12);
  vUVBounds_v = (tmpvar_13 / tmpvar_12.xyxy);
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xy = tmpvar_4;
  tmpvar_14.z = aParams.x;
  gl_Position = (uTransform * tmpvar_14);
}


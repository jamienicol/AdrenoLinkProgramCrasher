#version 100
#extension GL_OES_EGL_image_external : enable
uniform highp mat4 uTransform;
attribute highp vec2 aPosition;
varying highp vec2 vUv;
uniform highp vec2 uTextureSize;
attribute highp vec4 aDeviceRect;
attribute highp vec4 aDeviceClipRect;
attribute highp vec4 aParams;
attribute highp vec4 aUvRect0;
void main ()
{
  highp vec4 uvBounds_1;
  highp vec2 uv_2;
  vec2 tmpvar_3;
  tmpvar_3 = min (max ((aDeviceRect.xy + 
    (aPosition * aDeviceRect.zw)
  ), aDeviceClipRect.xy), (aDeviceClipRect.xy + aDeviceClipRect.zw));
  vec2 tmpvar_4;
  tmpvar_4 = mix (aUvRect0.xy, aUvRect0.zw, ((tmpvar_3 - aDeviceRect.xy) / aDeviceRect.zw));
  uv_2 = tmpvar_4;
  vec4 tmpvar_5;
  tmpvar_5.x = aUvRect0.x;
  tmpvar_5.y = min (aUvRect0.y, aUvRect0.w);
  tmpvar_5.z = aUvRect0.z;
  tmpvar_5.w = max (aUvRect0.y, aUvRect0.w);
  uvBounds_1 = tmpvar_5;
  int tmpvar_6;
  tmpvar_6 = int(aParams.y);
  if ((tmpvar_6 == 1)) {
    uvBounds_1 = (tmpvar_5 + vec4(0.5, 0.5, -0.5, -0.5));
    uv_2 = (tmpvar_4 / uTextureSize);
    uvBounds_1 = (uvBounds_1 / uTextureSize.xyxy);
  };
  vUv = uv_2;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xy = tmpvar_3;
  tmpvar_7.z = aParams.x;
  gl_Position = (uTransform * tmpvar_7);
}


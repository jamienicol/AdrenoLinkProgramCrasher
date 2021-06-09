#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp samplerExternalOES sColor0;
out highp vec2 vUv;
flat out highp vec4 vColor;
flat out highp vec4 vUVBounds;
in highp vec4 aDeviceRect;
in highp vec4 aDeviceClipRect;
in highp vec4 aColor;
in highp vec4 aParams;
in highp vec4 aUvRect0;
void main ()
{
  highp vec4 uvBounds_1;
  highp vec2 uv_2;
  vec2 tmpvar_3;
  tmpvar_3 = min (max (mix (aDeviceRect.xy, aDeviceRect.zw, aPosition), aDeviceClipRect.xy), aDeviceClipRect.zw);
  vec2 tmpvar_4;
  tmpvar_4 = mix (aUvRect0.xy, aUvRect0.zw, ((tmpvar_3 - aDeviceRect.xy) / (aDeviceRect.zw - aDeviceRect.xy)));
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
    vec2 tmpvar_7;
    tmpvar_7 = vec2(textureSize (sColor0, 0));
    uvBounds_1 = (tmpvar_5 + vec4(0.5, 0.5, -0.5, -0.5));
    uv_2 = (tmpvar_4 / tmpvar_7);
    uvBounds_1 = (uvBounds_1 / tmpvar_7.xyxy);
  };
  vUv = uv_2;
  vUVBounds = uvBounds_1;
  vColor = aColor;
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xy = tmpvar_3;
  tmpvar_8.z = aParams.x;
  gl_Position = (uTransform * tmpvar_8);
}


#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
in highp vec4 aClipOrigins;
in highp float aDevicePixelScale;
in highp ivec2 aTransformIds;
out highp vec2 vLocalPos;
out highp vec2 vClipMaskImageUv;
flat out highp vec4 vClipMaskUvInnerRect;
in highp vec4 aClipTileRect;
in highp ivec2 aClipDataResourceAddress;
in highp vec4 aClipLocalRect;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = aClipLocalRect.xy;
  mat4 transform_m_2;
  int tmpvar_3;
  tmpvar_3 = (aTransformIds.y & 16777215);
  ivec2 tmpvar_4;
  tmpvar_4.x = int((8u * (
    uint(tmpvar_3)
   % 128u)));
  tmpvar_4.y = int((uint(tmpvar_3) / 128u));
  transform_m_2[0] = texelFetch (sTransformPalette, tmpvar_4, 0);
  transform_m_2[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(1, 0)), 0);
  transform_m_2[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(2, 0)), 0);
  transform_m_2[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(3, 0)), 0);
  vec2 uv_rect_p0_5;
  vec2 uv_rect_p1_6;
  vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sGpuCache, aClipDataResourceAddress, 0);
  uv_rect_p0_5 = tmpvar_7.xy;
  uv_rect_p1_6 = tmpvar_7.zw;
  vec2 tmpvar_8;
  tmpvar_8 = min (max ((aClipTileRect.xy + 
    (aPosition * aClipTileRect.zw)
  ), aClipLocalRect.xy), (aClipLocalRect.xy + aClipLocalRect.zw));
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 1.0);
  tmpvar_9.xy = tmpvar_8;
  vec4 tmpvar_10;
  tmpvar_10 = (transform_m_2 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.z = 0.0;
  tmpvar_11.xy = ((tmpvar_10.xy * aDevicePixelScale) + ((aClipOrigins.xy - aClipOrigins.zw) * tmpvar_10.w));
  tmpvar_11.w = tmpvar_10.w;
  gl_Position = (uTransform * tmpvar_11);
  vec4 tmpvar_12;
  if (((aTransformIds.x >> 24) == 0)) {
    tmpvar_12 = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_13;
    tmpvar_13.xy = tmpvar_1;
    tmpvar_13.zw = (aClipLocalRect.xy + aClipLocalRect.zw);
    tmpvar_12 = tmpvar_13;
  };
  vTransformBounds = tmpvar_12;
  vLocalPos = tmpvar_8;
  vec2 tmpvar_14;
  tmpvar_14 = vec2(textureSize (sColor0, 0));
  vec4 tmpvar_15;
  tmpvar_15.xy = uv_rect_p0_5;
  tmpvar_15.zw = uv_rect_p1_6;
  vClipMaskImageUv = (mix (tmpvar_7.xy, tmpvar_7.zw, (
    (tmpvar_8 - aClipTileRect.xy)
   / aClipTileRect.zw)) / tmpvar_14);
  vClipMaskUvInnerRect = ((tmpvar_15 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_14.xyxy);
}


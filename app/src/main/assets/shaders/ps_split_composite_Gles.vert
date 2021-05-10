#version 300 es
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
flat out highp vec4 vClipMaskUvBounds;
out highp vec2 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
out highp vec2 vUv;
flat out highp float vPerspective;
flat out highp vec4 vUvSampleBounds;
void main ()
{
  float ci_z_1;
  ci_z_1 = float(aData.z);
  ivec2 tmpvar_2;
  tmpvar_2.x = int((uint(aData.y) % 1024u));
  tmpvar_2.y = int((uint(aData.y) / 1024u));
  vec4 tmpvar_3;
  tmpvar_3 = texelFetch (sGpuCache, tmpvar_2, 0);
  vec4 tmpvar_4;
  tmpvar_4 = texelFetch (sGpuCache, (tmpvar_2 + ivec2(1, 0)), 0);
  ivec2 tmpvar_5;
  tmpvar_5.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_5.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetch (sPrimitiveHeadersF, tmpvar_5, 0);
  ivec2 tmpvar_7;
  tmpvar_7.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_7.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersI, (tmpvar_7 + ivec2(1, 0)), 0);
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (
    uint(aData.w)
   % 512u)));
  tmpvar_9.y = int((uint(aData.w) / 512u));
  vec4 tmpvar_10;
  tmpvar_10 = texelFetch (sRenderTasks, tmpvar_9, 0);
  vec4 tmpvar_11;
  tmpvar_11 = texelFetch (sRenderTasks, (tmpvar_9 + ivec2(1, 0)), 0);
  mat4 transform_m_12;
  int tmpvar_13;
  tmpvar_13 = (texelFetch (sPrimitiveHeadersI, tmpvar_7, 0).z & 16777215);
  ivec2 tmpvar_14;
  tmpvar_14.x = int((8u * (
    uint(tmpvar_13)
   % 128u)));
  tmpvar_14.y = int((uint(tmpvar_13) / 128u));
  transform_m_12[0] = texelFetch (sTransformPalette, tmpvar_14, 0);
  transform_m_12[1] = texelFetch (sTransformPalette, (tmpvar_14 + ivec2(1, 0)), 0);
  transform_m_12[2] = texelFetch (sTransformPalette, (tmpvar_14 + ivec2(2, 0)), 0);
  transform_m_12[3] = texelFetch (sTransformPalette, (tmpvar_14 + ivec2(3, 0)), 0);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((uint(tmpvar_8.x) % 1024u));
  tmpvar_15.y = int((uint(tmpvar_8.x) / 1024u));
  vec4 tmpvar_16;
  tmpvar_16 = texelFetch (sGpuCache, tmpvar_15, 0);
  RectWithSize area_task_rect_17;
  float area_device_pixel_scale_18;
  vec2 area_screen_origin_19;
  if ((tmpvar_8.w >= 32767)) {
    area_task_rect_17 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_device_pixel_scale_18 = 0.0;
    area_screen_origin_19 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_20;
    tmpvar_20.x = int((2u * (
      uint(tmpvar_8.w)
     % 512u)));
    tmpvar_20.y = int((uint(tmpvar_8.w) / 512u));
    vec4 tmpvar_21;
    tmpvar_21 = texelFetch (sRenderTasks, tmpvar_20, 0);
    vec4 tmpvar_22;
    tmpvar_22 = texelFetch (sRenderTasks, (tmpvar_20 + ivec2(1, 0)), 0);
    area_task_rect_17.p0 = tmpvar_21.xy;
    area_task_rect_17.size = tmpvar_21.zw;
    area_device_pixel_scale_18 = tmpvar_22.x;
    area_screen_origin_19 = tmpvar_22.yz;
  };
  vec2 tmpvar_23;
  tmpvar_23 = mix (mix (tmpvar_3.xy, tmpvar_3.zw, aPosition.x), mix (tmpvar_4.zw, tmpvar_4.xy, aPosition.x), aPosition.y);
  vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 1.0);
  tmpvar_24.xy = tmpvar_23;
  vec4 tmpvar_25;
  tmpvar_25 = (transform_m_12 * tmpvar_24);
  vec4 tmpvar_26;
  tmpvar_26.xy = (((tmpvar_10.xy - tmpvar_11.yz) * tmpvar_25.w) + (tmpvar_25.xy * tmpvar_11.x));
  tmpvar_26.z = (tmpvar_25.w * ci_z_1);
  tmpvar_26.w = tmpvar_25.w;
  vec4 tmpvar_27;
  tmpvar_27.xy = area_task_rect_17.p0;
  tmpvar_27.zw = (area_task_rect_17.p0 + area_task_rect_17.size);
  vClipMaskUvBounds = tmpvar_27;
  vClipMaskUv = ((tmpvar_25.xy * area_device_pixel_scale_18) + (tmpvar_25.w * (area_task_rect_17.p0 - area_screen_origin_19)));
  gl_Position = (uTransform * tmpvar_26);
  vec2 tmpvar_28;
  tmpvar_28 = vec2(textureSize (sColor0, 0));
  vec4 tmpvar_29;
  tmpvar_29.xy = (min (tmpvar_16.xy, tmpvar_16.zw) + vec2(0.5, 0.5));
  tmpvar_29.zw = (max (tmpvar_16.xy, tmpvar_16.zw) - vec2(0.5, 0.5));
  vUvSampleBounds = (tmpvar_29 / tmpvar_28.xyxy);
  vec2 tmpvar_30;
  tmpvar_30 = ((tmpvar_23 - tmpvar_6.xy) / tmpvar_6.zw);
  highp int tmpvar_31;
  tmpvar_31 = (tmpvar_8.x + 2);
  ivec2 tmpvar_32;
  tmpvar_32.x = int((uint(tmpvar_31) % 1024u));
  tmpvar_32.y = int((uint(tmpvar_31) / 1024u));
  vec4 tmpvar_33;
  tmpvar_33 = mix (mix (texelFetch (sGpuCache, tmpvar_32, 0), texelFetch (sGpuCache, (tmpvar_32 + ivec2(1, 0)), 0), tmpvar_30.x), mix (texelFetch (sGpuCache, (tmpvar_32 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_32 + ivec2(3, 0)), 0), tmpvar_30.x), tmpvar_30.y);
  float tmpvar_34;
  tmpvar_34 = float(tmpvar_8.y);
  vUv = ((mix (tmpvar_16.xy, tmpvar_16.zw, 
    (tmpvar_33.xy / tmpvar_33.w)
  ) / tmpvar_28) * mix (gl_Position.w, 1.0, tmpvar_34));
  vPerspective = tmpvar_34;
}


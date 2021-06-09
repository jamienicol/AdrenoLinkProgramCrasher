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
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
flat out highp vec4 vClipMaskUvBounds;
out highp vec2 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
out highp vec2 v_local_pos;
out highp vec2 v_uv;
flat out highp vec4 v_uv_sample_bounds;
flat out highp float v_perspective;
flat out highp float v_opacity;
void main ()
{
  int instance_picture_task_address_1;
  int instance_clip_address_2;
  int instance_segment_index_3;
  int instance_flags_4;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_clip_address_2 = (aData.y & 65535);
  instance_segment_index_3 = (aData.z & 65535);
  instance_flags_4 = (aData.z >> 16);
  float ph_z_5;
  ivec2 tmpvar_6;
  tmpvar_6.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_6.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sPrimitiveHeadersF, tmpvar_6, 0);
  vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, (tmpvar_6 + ivec2(1, 0)), 0);
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  tmpvar_9 = tmpvar_7.xy;
  tmpvar_10 = tmpvar_7.zw;
  ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_11.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, tmpvar_11, 0);
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, (tmpvar_11 + ivec2(1, 0)), 0);
  ph_z_5 = float(tmpvar_12.x);
  mat4 transform_m_14;
  bool transform_is_axis_aligned_15;
  transform_is_axis_aligned_15 = ((tmpvar_12.z >> 24) == 0);
  int tmpvar_16;
  tmpvar_16 = (tmpvar_12.z & 16777215);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  transform_m_14[0] = texelFetch (sTransformPalette, tmpvar_17, 0);
  transform_m_14[1] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(1, 0)), 0);
  transform_m_14[2] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(2, 0)), 0);
  transform_m_14[3] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(3, 0)), 0);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_18.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, tmpvar_18, 0);
  vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, (tmpvar_18 + ivec2(1, 0)), 0);
  RectWithSize area_task_rect_21;
  float area_device_pixel_scale_22;
  vec2 area_screen_origin_23;
  if ((instance_clip_address_2 >= 32767)) {
    area_task_rect_21 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_device_pixel_scale_22 = 0.0;
    area_screen_origin_23 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_24;
    tmpvar_24.x = int((2u * (
      uint(instance_clip_address_2)
     % 512u)));
    tmpvar_24.y = int((uint(instance_clip_address_2) / 512u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sRenderTasks, tmpvar_24, 0);
    vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sRenderTasks, (tmpvar_24 + ivec2(1, 0)), 0);
    area_task_rect_21.p0 = tmpvar_25.xy;
    area_task_rect_21.size = tmpvar_25.zw;
    area_device_pixel_scale_22 = tmpvar_26.x;
    area_screen_origin_23 = tmpvar_26.yz;
  };
  vec2 vi_local_pos_27;
  vec4 vi_world_pos_28;
  vec2 segment_rect_p0_29;
  vec2 segment_rect_size_30;
  int tmpvar_31;
  tmpvar_31 = (instance_flags_4 & 255);
  int tmpvar_32;
  tmpvar_32 = ((instance_flags_4 >> 8) & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_29 = tmpvar_9;
    segment_rect_size_30 = tmpvar_10;
  } else {
    int tmpvar_33;
    tmpvar_33 = ((tmpvar_12.y + 3) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_34;
    tmpvar_34.x = int((uint(tmpvar_33) % 1024u));
    tmpvar_34.y = int((uint(tmpvar_33) / 1024u));
    vec4 tmpvar_35;
    tmpvar_35 = texelFetch (sGpuCache, tmpvar_34, 0);
    segment_rect_size_30 = tmpvar_35.zw;
    segment_rect_p0_29 = (tmpvar_35.xy + tmpvar_7.xy);
  };
  if (transform_is_axis_aligned_15) {
    vec2 tmpvar_36;
    tmpvar_36 = min (max ((segment_rect_p0_29 + 
      (segment_rect_size_30 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 1.0);
    tmpvar_37.xy = tmpvar_36;
    vec4 tmpvar_38;
    tmpvar_38 = (transform_m_14 * tmpvar_37);
    vec4 tmpvar_39;
    tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_20.x) + ((
      -(tmpvar_20.yz)
     + tmpvar_19.xy) * tmpvar_38.w));
    tmpvar_39.z = (ph_z_5 * tmpvar_38.w);
    tmpvar_39.w = tmpvar_38.w;
    gl_Position = (uTransform * tmpvar_39);
    vi_local_pos_27 = tmpvar_36;
    vi_world_pos_28 = tmpvar_38;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec2 result_p1_40;
    result_p1_40 = (tmpvar_8.xy + tmpvar_8.zw);
    bvec4 tmpvar_41;
    tmpvar_41 = bvec4(false);
    vec4 tmpvar_42;
    tmpvar_42.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_40);
    tmpvar_42.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_40);
    vec4 tmpvar_43;
    tmpvar_43.xy = min (max (segment_rect_p0_29, tmpvar_8.xy), result_p1_40);
    tmpvar_43.zw = min (max ((segment_rect_p0_29 + segment_rect_size_30), tmpvar_8.xy), result_p1_40);
    vTransformBounds = mix(tmpvar_42, tmpvar_43, bvec4(tmpvar_41));
    vec4 tmpvar_44;
    tmpvar_44 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_41));
    vec2 tmpvar_45;
    tmpvar_45 = ((segment_rect_p0_29 - tmpvar_44.xy) + ((segment_rect_size_30 + 
      (tmpvar_44.xy + tmpvar_44.zw)
    ) * aPosition));
    vec4 tmpvar_46;
    tmpvar_46.zw = vec2(0.0, 1.0);
    tmpvar_46.xy = tmpvar_45;
    vec4 tmpvar_47;
    tmpvar_47 = (transform_m_14 * tmpvar_46);
    vec4 tmpvar_48;
    tmpvar_48.xy = ((tmpvar_47.xy * tmpvar_20.x) + ((tmpvar_19.xy - tmpvar_20.yz) * tmpvar_47.w));
    tmpvar_48.z = (ph_z_5 * tmpvar_47.w);
    tmpvar_48.w = tmpvar_47.w;
    gl_Position = (uTransform * tmpvar_48);
    vi_local_pos_27 = tmpvar_45;
    vi_world_pos_28 = tmpvar_47;
  };
  vec4 tmpvar_49;
  tmpvar_49.xy = area_task_rect_21.p0;
  tmpvar_49.zw = (area_task_rect_21.p0 + area_task_rect_21.size);
  vClipMaskUvBounds = tmpvar_49;
  vClipMaskUv = ((vi_world_pos_28.xy * area_device_pixel_scale_22) + (vi_world_pos_28.w * (area_task_rect_21.p0 - area_screen_origin_23)));
  ivec2 tmpvar_50;
  tmpvar_50.x = int((uint(tmpvar_13.x) % 1024u));
  tmpvar_50.y = int((uint(tmpvar_13.x) / 1024u));
  vec4 tmpvar_51;
  tmpvar_51 = texelFetch (sGpuCache, tmpvar_50, 0);
  vec2 tmpvar_52;
  tmpvar_52 = vec2(textureSize (sColor0, 0));
  vec2 tmpvar_53;
  tmpvar_53 = ((vi_local_pos_27 - tmpvar_7.xy) / tmpvar_7.zw);
  highp int tmpvar_54;
  tmpvar_54 = (tmpvar_13.x + 2);
  ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(tmpvar_54) % 1024u));
  tmpvar_55.y = int((uint(tmpvar_54) / 1024u));
  vec4 tmpvar_56;
  tmpvar_56 = mix (mix (texelFetch (sGpuCache, tmpvar_55, 0), texelFetch (sGpuCache, (tmpvar_55 + ivec2(1, 0)), 0), tmpvar_53.x), mix (texelFetch (sGpuCache, (tmpvar_55 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_55 + ivec2(3, 0)), 0), tmpvar_53.x), tmpvar_53.y);
  vec2 tmpvar_57;
  tmpvar_57 = mix (tmpvar_51.xy, tmpvar_51.zw, (tmpvar_56.xy / tmpvar_56.w));
  float tmpvar_58;
  if (((tmpvar_32 & 1) != 0)) {
    tmpvar_58 = 1.0;
  } else {
    tmpvar_58 = 0.0;
  };
  v_uv = ((tmpvar_57 / tmpvar_52) * mix (vi_world_pos_28.w, 1.0, tmpvar_58));
  v_perspective = tmpvar_58;
  vec4 tmpvar_59;
  tmpvar_59.xy = (tmpvar_51.xy + vec2(0.5, 0.5));
  tmpvar_59.zw = (tmpvar_51.zw - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_59 / tmpvar_52.xyxy);
  v_opacity = min (max ((
    float(tmpvar_13.y)
   / 65536.0), 0.0), 1.0);
  v_local_pos = vi_local_pos_27;
}


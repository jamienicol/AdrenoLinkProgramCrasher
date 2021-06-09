#version 300 es
#extension GL_EXT_blend_func_extended : enable
#extension GL_OES_EGL_image_external_essl3 : enable
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp int uMode;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp samplerExternalOES sColor0;
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
flat out highp vec4 v_color;
flat out highp vec2 v_mask_swizzle;
flat out highp vec2 v_tile_repeat;
flat out highp vec4 v_uv_bounds;
flat out highp vec4 v_uv_sample_bounds;
flat out highp float v_perspective;
void main ()
{
  int instance_picture_task_address_1;
  int instance_clip_address_2;
  int instance_segment_index_3;
  int instance_flags_4;
  int instance_resource_address_5;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_clip_address_2 = (aData.y & 65535);
  instance_segment_index_3 = (aData.z & 65535);
  instance_flags_4 = (aData.z >> 16);
  instance_resource_address_5 = (aData.w & 16777215);
  float ph_z_6;
  ivec2 tmpvar_7;
  tmpvar_7.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_7.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, tmpvar_7, 0);
  vec4 tmpvar_9;
  tmpvar_9 = texelFetch (sPrimitiveHeadersF, (tmpvar_7 + ivec2(1, 0)), 0);
  vec2 tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_10 = tmpvar_8.xy;
  tmpvar_11 = tmpvar_8.zw;
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_12.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, tmpvar_12, 0);
  ivec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersI, (tmpvar_12 + ivec2(1, 0)), 0);
  ph_z_6 = float(tmpvar_13.x);
  mat4 transform_m_15;
  bool transform_is_axis_aligned_16;
  transform_is_axis_aligned_16 = ((tmpvar_13.z >> 24) == 0);
  int tmpvar_17;
  tmpvar_17 = (tmpvar_13.z & 16777215);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((8u * (
    uint(tmpvar_17)
   % 128u)));
  tmpvar_18.y = int((uint(tmpvar_17) / 128u));
  transform_m_15[0] = texelFetch (sTransformPalette, tmpvar_18, 0);
  transform_m_15[1] = texelFetch (sTransformPalette, (tmpvar_18 + ivec2(1, 0)), 0);
  transform_m_15[2] = texelFetch (sTransformPalette, (tmpvar_18 + ivec2(2, 0)), 0);
  transform_m_15[3] = texelFetch (sTransformPalette, (tmpvar_18 + ivec2(3, 0)), 0);
  ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_19.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, tmpvar_19, 0);
  vec4 tmpvar_21;
  tmpvar_21 = texelFetch (sRenderTasks, (tmpvar_19 + ivec2(1, 0)), 0);
  RectWithSize area_task_rect_22;
  float area_device_pixel_scale_23;
  vec2 area_screen_origin_24;
  if ((instance_clip_address_2 >= 32767)) {
    area_task_rect_22 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_device_pixel_scale_23 = 0.0;
    area_screen_origin_24 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_25;
    tmpvar_25.x = int((2u * (
      uint(instance_clip_address_2)
     % 512u)));
    tmpvar_25.y = int((uint(instance_clip_address_2) / 512u));
    vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sRenderTasks, tmpvar_25, 0);
    vec4 tmpvar_27;
    tmpvar_27 = texelFetch (sRenderTasks, (tmpvar_25 + ivec2(1, 0)), 0);
    area_task_rect_22.p0 = tmpvar_26.xy;
    area_task_rect_22.size = tmpvar_26.zw;
    area_device_pixel_scale_23 = tmpvar_27.x;
    area_screen_origin_24 = tmpvar_27.yz;
  };
  vec2 vi_local_pos_28;
  vec4 vi_world_pos_29;
  vec2 segment_rect_p0_30;
  vec2 segment_rect_size_31;
  highp vec4 segment_data_32;
  int tmpvar_33;
  tmpvar_33 = (instance_flags_4 & 255);
  int tmpvar_34;
  tmpvar_34 = ((instance_flags_4 >> 8) & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_30 = tmpvar_10;
    segment_rect_size_31 = tmpvar_11;
    segment_data_32 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_35;
    tmpvar_35 = ((tmpvar_13.y + 3) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_36;
    tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
    tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
    vec4 tmpvar_37;
    tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
    segment_rect_size_31 = tmpvar_37.zw;
    segment_rect_p0_30 = (tmpvar_37.xy + tmpvar_8.xy);
    segment_data_32 = texelFetch (sGpuCache, (tmpvar_36 + ivec2(1, 0)), 0);
  };
  if (transform_is_axis_aligned_16) {
    vec2 tmpvar_38;
    tmpvar_38 = min (max ((segment_rect_p0_30 + 
      (segment_rect_size_31 * aPosition)
    ), tmpvar_9.xy), (tmpvar_9.xy + tmpvar_9.zw));
    vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    vec4 tmpvar_40;
    tmpvar_40 = (transform_m_15 * tmpvar_39);
    vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_21.x) + ((
      -(tmpvar_21.yz)
     + tmpvar_20.xy) * tmpvar_40.w));
    tmpvar_41.z = (ph_z_6 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    vi_local_pos_28 = tmpvar_38;
    vi_world_pos_29 = tmpvar_40;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec2 result_p1_42;
    result_p1_42 = (tmpvar_9.xy + tmpvar_9.zw);
    bvec4 tmpvar_43;
    tmpvar_43 = bvec4(false);
    vec4 tmpvar_44;
    tmpvar_44.xy = min (max (tmpvar_8.xy, tmpvar_9.xy), result_p1_42);
    tmpvar_44.zw = min (max ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy), result_p1_42);
    vec4 tmpvar_45;
    tmpvar_45.xy = min (max (segment_rect_p0_30, tmpvar_9.xy), result_p1_42);
    tmpvar_45.zw = min (max ((segment_rect_p0_30 + segment_rect_size_31), tmpvar_9.xy), result_p1_42);
    vTransformBounds = mix(tmpvar_44, tmpvar_45, bvec4(tmpvar_43));
    vec4 tmpvar_46;
    tmpvar_46 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_43));
    vec2 tmpvar_47;
    tmpvar_47 = ((segment_rect_p0_30 - tmpvar_46.xy) + ((segment_rect_size_31 + 
      (tmpvar_46.xy + tmpvar_46.zw)
    ) * aPosition));
    vec4 tmpvar_48;
    tmpvar_48.zw = vec2(0.0, 1.0);
    tmpvar_48.xy = tmpvar_47;
    vec4 tmpvar_49;
    tmpvar_49 = (transform_m_15 * tmpvar_48);
    vec4 tmpvar_50;
    tmpvar_50.xy = ((tmpvar_49.xy * tmpvar_21.x) + ((tmpvar_20.xy - tmpvar_21.yz) * tmpvar_49.w));
    tmpvar_50.z = (ph_z_6 * tmpvar_49.w);
    tmpvar_50.w = tmpvar_49.w;
    gl_Position = (uTransform * tmpvar_50);
    vi_local_pos_28 = tmpvar_47;
    vi_world_pos_29 = tmpvar_49;
  };
  vec4 tmpvar_51;
  tmpvar_51.xy = area_task_rect_22.p0;
  tmpvar_51.zw = (area_task_rect_22.p0 + area_task_rect_22.size);
  vClipMaskUvBounds = tmpvar_51;
  vClipMaskUv = ((vi_world_pos_29.xy * area_device_pixel_scale_23) + (vi_world_pos_29.w * (area_task_rect_22.p0 - area_screen_origin_24)));
  highp int color_mode_52;
  highp vec2 f_53;
  highp vec2 stretch_size_54;
  vec2 local_rect_p0_55;
  vec2 local_rect_size_56;
  highp vec2 uv1_57;
  highp vec2 uv0_58;
  vec4 image_data_color_59;
  ivec2 tmpvar_60;
  tmpvar_60.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_60.y = int((uint(tmpvar_13.y) / 1024u));
  vec4 tmpvar_61;
  vec4 tmpvar_62;
  vec4 tmpvar_63;
  tmpvar_61 = texelFetch (sGpuCache, tmpvar_60, 0);
  tmpvar_62 = texelFetch (sGpuCache, (tmpvar_60 + ivec2(1, 0)), 0);
  tmpvar_63 = texelFetch (sGpuCache, (tmpvar_60 + ivec2(2, 0)), 0);
  image_data_color_59 = tmpvar_61;
  vec2 tmpvar_64;
  tmpvar_64 = vec2(textureSize (sColor0, 0));
  ivec2 tmpvar_65;
  tmpvar_65.x = int((uint(instance_resource_address_5) % 1024u));
  tmpvar_65.y = int((uint(instance_resource_address_5) / 1024u));
  vec4 tmpvar_66;
  tmpvar_66 = texelFetch (sGpuCache, tmpvar_65, 0);
  uv0_58 = tmpvar_66.xy;
  uv1_57 = tmpvar_66.zw;
  local_rect_p0_55 = tmpvar_10;
  local_rect_size_56 = tmpvar_11;
  stretch_size_54 = tmpvar_63.xy;
  if ((tmpvar_63.x < 0.0)) {
    stretch_size_54 = tmpvar_11;
  };
  if (((tmpvar_34 & 2) != 0)) {
    local_rect_p0_55 = segment_rect_p0_30;
    local_rect_size_56 = segment_rect_size_31;
    stretch_size_54 = segment_rect_size_31;
    if (((tmpvar_34 & 128) != 0)) {
      vec2 tmpvar_67;
      tmpvar_67 = (tmpvar_66.zw - tmpvar_66.xy);
      uv0_58 = (tmpvar_66.xy + (segment_data_32.xy * tmpvar_67));
      uv1_57 = (tmpvar_66.xy + (segment_data_32.zw * tmpvar_67));
    };
    if (((tmpvar_34 & 128) != 0)) {
      highp vec2 vertical_uv_size_68;
      highp vec2 horizontal_uv_size_69;
      highp vec2 repeated_stretch_size_70;
      repeated_stretch_size_70 = segment_rect_size_31;
      vec2 tmpvar_71;
      tmpvar_71 = (uv1_57 - uv0_58);
      horizontal_uv_size_69 = tmpvar_71;
      vec2 tmpvar_72;
      tmpvar_72 = (uv1_57 - uv0_58);
      vertical_uv_size_68 = tmpvar_72;
      if (((tmpvar_34 & 64) != 0)) {
        repeated_stretch_size_70 = (segment_rect_p0_30 - tmpvar_8.xy);
        vertical_uv_size_68.x = (uv0_58.x - tmpvar_66.x);
        if (((vertical_uv_size_68.x < 0.001) || (repeated_stretch_size_70.x < 0.001))) {
          vertical_uv_size_68.x = (tmpvar_66.z - uv1_57.x);
          repeated_stretch_size_70.x = (((tmpvar_8.x + tmpvar_8.z) - segment_rect_p0_30.x) - segment_rect_size_31.x);
        };
        horizontal_uv_size_69.y = (uv0_58.y - tmpvar_66.y);
        if (((horizontal_uv_size_69.y < 0.001) || (repeated_stretch_size_70.y < 0.001))) {
          horizontal_uv_size_69.y = (tmpvar_66.w - uv1_57.y);
          repeated_stretch_size_70.y = (((tmpvar_8.y + tmpvar_8.w) - segment_rect_p0_30.y) - segment_rect_size_31.y);
        };
      };
      if (((tmpvar_34 & 4) != 0)) {
        stretch_size_54.x = (repeated_stretch_size_70.y * (tmpvar_71.x / horizontal_uv_size_69.y));
      };
      if (((tmpvar_34 & 8) != 0)) {
        stretch_size_54.y = (repeated_stretch_size_70.x * (tmpvar_72.y / vertical_uv_size_68.x));
      };
    } else {
      if (((tmpvar_34 & 4) != 0)) {
        stretch_size_54.x = (segment_data_32.z - segment_data_32.x);
      };
      if (((tmpvar_34 & 8) != 0)) {
        stretch_size_54.y = (segment_data_32.w - segment_data_32.y);
      };
    };
    if (((tmpvar_34 & 16) != 0)) {
      stretch_size_54.x = (segment_rect_size_31.x / max (1.0, roundEven(
        (segment_rect_size_31.x / stretch_size_54.x)
      )));
    };
    if (((tmpvar_34 & 32) != 0)) {
      stretch_size_54.y = (segment_rect_size_31.y / max (1.0, roundEven(
        (segment_rect_size_31.y / stretch_size_54.y)
      )));
    };
  };
  float tmpvar_73;
  if (((tmpvar_34 & 1) != 0)) {
    tmpvar_73 = 1.0;
  } else {
    tmpvar_73 = 0.0;
  };
  v_perspective = tmpvar_73;
  vec2 tmpvar_74;
  tmpvar_74 = min (uv0_58, uv1_57);
  vec2 tmpvar_75;
  tmpvar_75 = max (uv0_58, uv1_57);
  vec4 tmpvar_76;
  tmpvar_76.xy = (tmpvar_74 + vec2(0.5, 0.5));
  tmpvar_76.zw = (tmpvar_75 - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_76 / tmpvar_64.xyxy);
  vec2 tmpvar_77;
  tmpvar_77 = ((vi_local_pos_28 - local_rect_p0_55) / local_rect_size_56);
  f_53 = tmpvar_77;
  int tmpvar_78;
  tmpvar_78 = (tmpvar_14.x & 65535);
  color_mode_52 = tmpvar_78;
  int tmpvar_79;
  tmpvar_79 = (tmpvar_14.x >> 16);
  if ((tmpvar_78 == 0)) {
    color_mode_52 = uMode;
  };
  if ((tmpvar_14.y == 1)) {
    highp int tmpvar_80;
    tmpvar_80 = (instance_resource_address_5 + 2);
    ivec2 tmpvar_81;
    tmpvar_81.x = int((uint(tmpvar_80) % 1024u));
    tmpvar_81.y = int((uint(tmpvar_80) / 1024u));
    vec4 tmpvar_82;
    tmpvar_82 = mix (mix (texelFetch (sGpuCache, tmpvar_81, 0), texelFetch (sGpuCache, (tmpvar_81 + ivec2(1, 0)), 0), tmpvar_77.x), mix (texelFetch (sGpuCache, (tmpvar_81 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_81 + ivec2(3, 0)), 0), tmpvar_77.x), tmpvar_77.y);
    f_53 = (tmpvar_82.xy / tmpvar_82.w);
  };
  vec2 tmpvar_83;
  tmpvar_83 = (local_rect_size_56 / stretch_size_54);
  v_uv = (mix (uv0_58, uv1_57, f_53) - tmpvar_74);
  v_uv = (v_uv / tmpvar_64);
  v_uv = (v_uv * tmpvar_83);
  if ((tmpvar_73 == 0.0)) {
    v_uv = (v_uv * vi_world_pos_29.w);
  };
  vec4 tmpvar_84;
  tmpvar_84.xy = tmpvar_74;
  tmpvar_84.zw = tmpvar_75;
  v_uv_bounds = (tmpvar_84 / tmpvar_64.xyxy);
  v_uv = (v_uv / (v_uv_bounds.zw - v_uv_bounds.xy));
  v_tile_repeat = tmpvar_83;
  float tmpvar_85;
  tmpvar_85 = (float(tmpvar_14.z) / 65535.0);
  bool tmpvar_86;
  bool tmpvar_87;
  tmpvar_87 = bool(0);
  tmpvar_86 = (0 == tmpvar_79);
  if (tmpvar_86) {
    image_data_color_59.w = (tmpvar_61.w * tmpvar_85);
    tmpvar_87 = bool(1);
  };
  tmpvar_86 = !(tmpvar_87);
  if (tmpvar_86) {
    image_data_color_59 = (image_data_color_59 * tmpvar_85);
    tmpvar_87 = bool(1);
  };
  bool tmpvar_88;
  bool tmpvar_89;
  tmpvar_89 = bool(0);
  tmpvar_88 = (1 == color_mode_52);
  tmpvar_88 = (tmpvar_88 || (7 == color_mode_52));
  if (tmpvar_88) {
    v_mask_swizzle = vec2(0.0, 1.0);
    v_color = image_data_color_59;
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = (tmpvar_88 || (5 == color_mode_52));
  tmpvar_88 = (tmpvar_88 || (9 == color_mode_52));
  tmpvar_88 = (tmpvar_88 && !(tmpvar_89));
  if (tmpvar_88) {
    v_mask_swizzle = vec2(1.0, 0.0);
    v_color = image_data_color_59;
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = (tmpvar_88 || (2 == color_mode_52));
  tmpvar_88 = (tmpvar_88 || (3 == color_mode_52));
  tmpvar_88 = (tmpvar_88 || (8 == color_mode_52));
  tmpvar_88 = (tmpvar_88 && !(tmpvar_89));
  if (tmpvar_88) {
    v_mask_swizzle = vec2(1.0, 0.0);
    v_color = image_data_color_59.wwww;
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = (tmpvar_88 || (4 == color_mode_52));
  tmpvar_88 = (tmpvar_88 && !(tmpvar_89));
  if (tmpvar_88) {
    v_mask_swizzle = vec2(-1.0, 1.0);
    v_color = (image_data_color_59.wwww * tmpvar_62);
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = (tmpvar_88 || (6 == color_mode_52));
  tmpvar_88 = (tmpvar_88 && !(tmpvar_89));
  if (tmpvar_88) {
    vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = image_data_color_59.w;
    v_mask_swizzle = tmpvar_90;
    v_color = image_data_color_59;
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = (tmpvar_88 || (10 == color_mode_52));
  tmpvar_88 = (tmpvar_88 && !(tmpvar_89));
  if (tmpvar_88) {
    vec2 tmpvar_91;
    tmpvar_91.x = -(image_data_color_59.w);
    tmpvar_91.y = image_data_color_59.w;
    v_mask_swizzle = tmpvar_91;
    v_color = image_data_color_59;
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = !(tmpvar_89);
  if (tmpvar_88) {
    v_mask_swizzle = vec2(0.0, 0.0);
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
  };
  v_local_pos = vi_local_pos_28;
}


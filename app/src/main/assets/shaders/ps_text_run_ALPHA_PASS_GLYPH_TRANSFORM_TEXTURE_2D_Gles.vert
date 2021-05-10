#version 300 es
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp int uMode;
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
flat out highp vec4 v_color;
flat out highp vec3 v_mask_swizzle;
flat out highp vec4 v_uv_bounds;
out highp vec2 v_uv;
out highp vec4 v_uv_clip;
void main ()
{
  highp vec2 local_pos_1;
  vec2 glyph_offset_2;
  highp int color_mode_3;
  vec2 clip_area_task_rect_p0_4;
  vec2 clip_area_task_rect_size_5;
  float ph_z_6;
  int instance_picture_task_address_7;
  int instance_clip_address_8;
  int instance_segment_index_9;
  int instance_flags_10;
  int instance_resource_address_11;
  instance_picture_task_address_7 = (aData.y >> 16);
  instance_clip_address_8 = (aData.y & 65535);
  instance_segment_index_9 = (aData.z & 65535);
  instance_flags_10 = (aData.z >> 16);
  instance_resource_address_11 = (aData.w & 16777215);
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_12.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersF, tmpvar_12, 0);
  vec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersF, (tmpvar_12 + ivec2(1, 0)), 0);
  vec2 tmpvar_15;
  tmpvar_15 = tmpvar_14.xy;
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_16.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_17;
  tmpvar_17 = texelFetch (sPrimitiveHeadersI, tmpvar_16, 0);
  ph_z_6 = float(tmpvar_17.x);
  mat4 transform_m_18;
  int tmpvar_19;
  tmpvar_19 = (tmpvar_17.z & 16777215);
  ivec2 tmpvar_20;
  tmpvar_20.x = int((8u * (
    uint(tmpvar_19)
   % 128u)));
  tmpvar_20.y = int((uint(tmpvar_19) / 128u));
  transform_m_18[0] = texelFetch (sTransformPalette, tmpvar_20, 0);
  transform_m_18[1] = texelFetch (sTransformPalette, (tmpvar_20 + ivec2(1, 0)), 0);
  transform_m_18[2] = texelFetch (sTransformPalette, (tmpvar_20 + ivec2(2, 0)), 0);
  transform_m_18[3] = texelFetch (sTransformPalette, (tmpvar_20 + ivec2(3, 0)), 0);
  RectWithSize area_task_rect_21;
  float area_device_pixel_scale_22;
  vec2 area_screen_origin_23;
  if ((instance_clip_address_8 >= 32767)) {
    area_task_rect_21 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_device_pixel_scale_22 = 0.0;
    area_screen_origin_23 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_24;
    tmpvar_24.x = int((2u * (
      uint(instance_clip_address_8)
     % 512u)));
    tmpvar_24.y = int((uint(instance_clip_address_8) / 512u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sRenderTasks, tmpvar_24, 0);
    vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sRenderTasks, (tmpvar_24 + ivec2(1, 0)), 0);
    area_task_rect_21.p0 = tmpvar_25.xy;
    area_task_rect_21.size = tmpvar_25.zw;
    area_device_pixel_scale_22 = tmpvar_26.x;
    area_screen_origin_23 = tmpvar_26.yz;
  };
  clip_area_task_rect_p0_4 = area_task_rect_21.p0;
  clip_area_task_rect_size_5 = area_task_rect_21.size;
  ivec2 tmpvar_27;
  tmpvar_27.x = int((2u * (
    uint(instance_picture_task_address_7)
   % 512u)));
  tmpvar_27.y = int((uint(instance_picture_task_address_7) / 512u));
  vec4 tmpvar_28;
  tmpvar_28 = texelFetch (sRenderTasks, tmpvar_27, 0);
  vec4 tmpvar_29;
  tmpvar_29 = texelFetch (sRenderTasks, (tmpvar_27 + ivec2(1, 0)), 0);
  int tmpvar_30;
  tmpvar_30 = ((instance_flags_10 >> 8) & 255);
  int tmpvar_31;
  tmpvar_31 = (instance_flags_10 & 255);
  color_mode_3 = tmpvar_31;
  ivec2 tmpvar_32;
  tmpvar_32.x = int((uint(tmpvar_17.y) % 1024u));
  tmpvar_32.y = int((uint(tmpvar_17.y) / 1024u));
  vec4 tmpvar_33;
  vec4 tmpvar_34;
  tmpvar_33 = texelFetch (sGpuCache, tmpvar_32, 0);
  tmpvar_34 = texelFetch (sGpuCache, (tmpvar_32 + ivec2(1, 0)), 0);
  if ((tmpvar_31 == 0)) {
    color_mode_3 = uMode;
  };
  int tmpvar_35;
  tmpvar_35 = ((tmpvar_17.y + 2) + int((
    uint(instance_segment_index_9)
   / 2u)));
  ivec2 tmpvar_36;
  tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
  tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
  vec4 tmpvar_37;
  tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
  glyph_offset_2 = (mix(tmpvar_37.xy, tmpvar_37.zw, bvec2((
    (uint(instance_segment_index_9) % 2u)
   == 1u))) + tmpvar_13.xy);
  ivec2 tmpvar_38;
  tmpvar_38.x = int((uint(instance_resource_address_11) % 1024u));
  tmpvar_38.y = int((uint(instance_resource_address_11) / 1024u));
  vec4 tmpvar_39;
  vec4 tmpvar_40;
  tmpvar_39 = texelFetch (sGpuCache, tmpvar_38, 0);
  tmpvar_40 = texelFetch (sGpuCache, (tmpvar_38 + ivec2(1, 0)), 0);
  vec2 tmpvar_41;
  bool tmpvar_42;
  tmpvar_42 = (0 == tmpvar_30);
  tmpvar_42 = (tmpvar_42 || !((
    ((1 == tmpvar_30) || (2 == tmpvar_30))
   || 
    (3 == tmpvar_30)
  )));
  if (tmpvar_42) {
    tmpvar_41 = vec2(0.5, 0.5);
  } else {
    tmpvar_42 = (tmpvar_42 || (1 == tmpvar_30));
    if (tmpvar_42) {
      tmpvar_41 = vec2(0.125, 0.5);
    } else {
      tmpvar_42 = (tmpvar_42 || (2 == tmpvar_30));
      if (tmpvar_42) {
        tmpvar_41 = vec2(0.5, 0.125);
      } else {
        tmpvar_42 = (tmpvar_42 || (3 == tmpvar_30));
        if (tmpvar_42) {
          tmpvar_41 = vec2(0.125, 0.125);
        };
      };
    };
  };
  mat2 tmpvar_43;
  tmpvar_43[uint(0)] = transform_m_18[uint(0)].xy;
  tmpvar_43[1u] = transform_m_18[1u].xy;
  mat2 tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_29.x);
  vec2 tmpvar_45;
  tmpvar_45 = (transform_m_18[3].xy * tmpvar_29.x);
  mat2 tmpvar_46;
  mat2 tmpvar_47;
  tmpvar_47[0].x = tmpvar_44[1].y;
  tmpvar_47[0].y = -(tmpvar_44[0].y);
  tmpvar_47[1].x = -(tmpvar_44[1].x);
  tmpvar_47[1].y = tmpvar_44[0].x;
  tmpvar_46 = (tmpvar_47 / ((tmpvar_44[0].x * tmpvar_44[1].y) - (tmpvar_44[1].x * tmpvar_44[0].y)));
  vec2 tmpvar_48;
  vec2 tmpvar_49;
  tmpvar_48 = ((tmpvar_40.xy + floor(
    ((tmpvar_44 * glyph_offset_2) + tmpvar_41)
  )) + (floor(
    (((tmpvar_44 * tmpvar_13.zw) + tmpvar_45) + 0.5)
  ) - tmpvar_45));
  tmpvar_49 = (tmpvar_39.zw - tmpvar_39.xy);
  mat2 tmpvar_50;
  tmpvar_50[uint(0)] = abs(tmpvar_46[0]);
  tmpvar_50[1u] = abs(tmpvar_46[1]);
  vec2 tmpvar_51;
  tmpvar_51 = (tmpvar_50 * (tmpvar_49 * 0.5));
  vec2 tmpvar_52;
  vec2 tmpvar_53;
  tmpvar_52 = ((tmpvar_46 * (tmpvar_48 + 
    (tmpvar_49 * 0.5)
  )) - tmpvar_51);
  tmpvar_53 = (tmpvar_51 * 2.0);
  local_pos_1 = (tmpvar_52 + (tmpvar_53 * aPosition));
  vec4 tmpvar_54;
  tmpvar_54.xy = tmpvar_15;
  tmpvar_54.zw = (tmpvar_52 + tmpvar_53);
  vec4 tmpvar_55;
  tmpvar_55.xy = tmpvar_52;
  tmpvar_55.zw = (tmpvar_14.xy + tmpvar_14.zw);
  if ((greaterThanEqual (tmpvar_55, tmpvar_54) == bvec4(1, 1, 1, 1))) {
    local_pos_1 = (tmpvar_46 * (tmpvar_48 + (tmpvar_49 * aPosition)));
  };
  vec2 tmpvar_56;
  tmpvar_56 = min (max (local_pos_1, tmpvar_14.xy), (tmpvar_14.xy + tmpvar_14.zw));
  vec4 tmpvar_57;
  tmpvar_57.zw = vec2(0.0, 1.0);
  tmpvar_57.xy = tmpvar_56;
  vec4 tmpvar_58;
  tmpvar_58 = (transform_m_18 * tmpvar_57);
  vec4 tmpvar_59;
  tmpvar_59.xy = ((tmpvar_58.xy * tmpvar_29.x) + ((
    -(tmpvar_29.yz)
   + tmpvar_28.xy) * tmpvar_58.w));
  tmpvar_59.z = (ph_z_6 * tmpvar_58.w);
  tmpvar_59.w = tmpvar_58.w;
  gl_Position = (uTransform * tmpvar_59);
  vec2 tmpvar_60;
  tmpvar_60 = (((tmpvar_44 * tmpvar_56) - tmpvar_48) / tmpvar_49);
  vec4 tmpvar_61;
  tmpvar_61.xy = tmpvar_60;
  tmpvar_61.zw = (1.0 - tmpvar_60);
  v_uv_clip = tmpvar_61;
  vec4 tmpvar_62;
  tmpvar_62.xy = clip_area_task_rect_p0_4;
  tmpvar_62.zw = (clip_area_task_rect_p0_4 + clip_area_task_rect_size_5);
  vClipMaskUvBounds = tmpvar_62;
  vClipMaskUv = ((tmpvar_58.xy * area_device_pixel_scale_22) + (tmpvar_58.w * (clip_area_task_rect_p0_4 - area_screen_origin_23)));
  bool tmpvar_63;
  bool tmpvar_64;
  tmpvar_64 = bool(0);
  tmpvar_63 = (1 == color_mode_3);
  if (tmpvar_63) {
    v_mask_swizzle = vec3(0.0, 1.0, 1.0);
    v_color = tmpvar_33;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (7 == color_mode_3));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    v_mask_swizzle = vec3(0.0, 1.0, 0.0);
    v_color = tmpvar_33;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (5 == color_mode_3));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    v_mask_swizzle = vec3(1.0, 0.0, 0.0);
    v_color = tmpvar_33;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (2 == color_mode_3));
  tmpvar_63 = (tmpvar_63 || (3 == color_mode_3));
  tmpvar_63 = (tmpvar_63 || (8 == color_mode_3));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    v_mask_swizzle = vec3(1.0, 0.0, 0.0);
    v_color = tmpvar_33.wwww;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (4 == color_mode_3));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    v_mask_swizzle = vec3(-1.0, 1.0, 0.0);
    v_color = (tmpvar_33.wwww * tmpvar_34);
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (6 == color_mode_3));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    vec3 tmpvar_65;
    tmpvar_65.yz = vec2(0.0, 0.0);
    tmpvar_65.x = tmpvar_33.w;
    v_mask_swizzle = tmpvar_65;
    v_color = tmpvar_33;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = !(tmpvar_64);
  if (tmpvar_63) {
    v_mask_swizzle = vec3(0.0, 0.0, 0.0);
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
  };
  vec2 tmpvar_66;
  tmpvar_66 = vec2(textureSize (sColor0, 0));
  v_uv = mix ((tmpvar_39.xy / tmpvar_66), (tmpvar_39.zw / tmpvar_66), tmpvar_60);
  v_uv_bounds = ((tmpvar_39 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_66.xyxy);
}


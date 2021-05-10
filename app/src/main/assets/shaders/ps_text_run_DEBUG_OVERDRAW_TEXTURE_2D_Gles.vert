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
void main ()
{
  vec2 glyph_offset_1;
  highp int color_mode_2;
  vec2 clip_area_task_rect_p0_3;
  vec2 clip_area_task_rect_size_4;
  float ph_z_5;
  ivec4 ph_user_data_6;
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
  ivec2 tmpvar_15;
  tmpvar_15.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_15.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersI, tmpvar_15, 0);
  ph_z_5 = float(tmpvar_16.x);
  ph_user_data_6 = texelFetch (sPrimitiveHeadersI, (tmpvar_15 + ivec2(1, 0)), 0);
  mat4 transform_m_17;
  int tmpvar_18;
  tmpvar_18 = (tmpvar_16.z & 16777215);
  ivec2 tmpvar_19;
  tmpvar_19.x = int((8u * (
    uint(tmpvar_18)
   % 128u)));
  tmpvar_19.y = int((uint(tmpvar_18) / 128u));
  transform_m_17[0] = texelFetch (sTransformPalette, tmpvar_19, 0);
  transform_m_17[1] = texelFetch (sTransformPalette, (tmpvar_19 + ivec2(1, 0)), 0);
  transform_m_17[2] = texelFetch (sTransformPalette, (tmpvar_19 + ivec2(2, 0)), 0);
  transform_m_17[3] = texelFetch (sTransformPalette, (tmpvar_19 + ivec2(3, 0)), 0);
  RectWithSize area_task_rect_20;
  float area_device_pixel_scale_21;
  vec2 area_screen_origin_22;
  if ((instance_clip_address_8 >= 32767)) {
    area_task_rect_20 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_device_pixel_scale_21 = 0.0;
    area_screen_origin_22 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_23;
    tmpvar_23.x = int((2u * (
      uint(instance_clip_address_8)
     % 512u)));
    tmpvar_23.y = int((uint(instance_clip_address_8) / 512u));
    vec4 tmpvar_24;
    tmpvar_24 = texelFetch (sRenderTasks, tmpvar_23, 0);
    vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sRenderTasks, (tmpvar_23 + ivec2(1, 0)), 0);
    area_task_rect_20.p0 = tmpvar_24.xy;
    area_task_rect_20.size = tmpvar_24.zw;
    area_device_pixel_scale_21 = tmpvar_25.x;
    area_screen_origin_22 = tmpvar_25.yz;
  };
  clip_area_task_rect_p0_3 = area_task_rect_20.p0;
  clip_area_task_rect_size_4 = area_task_rect_20.size;
  ivec2 tmpvar_26;
  tmpvar_26.x = int((2u * (
    uint(instance_picture_task_address_7)
   % 512u)));
  tmpvar_26.y = int((uint(instance_picture_task_address_7) / 512u));
  vec4 tmpvar_27;
  tmpvar_27 = texelFetch (sRenderTasks, tmpvar_26, 0);
  vec4 tmpvar_28;
  tmpvar_28 = texelFetch (sRenderTasks, (tmpvar_26 + ivec2(1, 0)), 0);
  int tmpvar_29;
  tmpvar_29 = ((instance_flags_10 >> 8) & 255);
  int tmpvar_30;
  tmpvar_30 = (instance_flags_10 & 255);
  color_mode_2 = tmpvar_30;
  ivec2 tmpvar_31;
  tmpvar_31.x = int((uint(tmpvar_16.y) % 1024u));
  tmpvar_31.y = int((uint(tmpvar_16.y) / 1024u));
  vec4 tmpvar_32;
  vec4 tmpvar_33;
  tmpvar_32 = texelFetch (sGpuCache, tmpvar_31, 0);
  tmpvar_33 = texelFetch (sGpuCache, (tmpvar_31 + ivec2(1, 0)), 0);
  if ((tmpvar_30 == 0)) {
    color_mode_2 = uMode;
  };
  int tmpvar_34;
  tmpvar_34 = ((tmpvar_16.y + 2) + int((
    uint(instance_segment_index_9)
   / 2u)));
  ivec2 tmpvar_35;
  tmpvar_35.x = int((uint(tmpvar_34) % 1024u));
  tmpvar_35.y = int((uint(tmpvar_34) / 1024u));
  vec4 tmpvar_36;
  tmpvar_36 = texelFetch (sGpuCache, tmpvar_35, 0);
  glyph_offset_1 = (mix(tmpvar_36.xy, tmpvar_36.zw, bvec2((
    (uint(instance_segment_index_9) % 2u)
   == 1u))) + tmpvar_13.xy);
  ivec2 tmpvar_37;
  tmpvar_37.x = int((uint(instance_resource_address_11) % 1024u));
  tmpvar_37.y = int((uint(instance_resource_address_11) / 1024u));
  vec4 tmpvar_38;
  vec4 tmpvar_39;
  tmpvar_38 = texelFetch (sGpuCache, tmpvar_37, 0);
  tmpvar_39 = texelFetch (sGpuCache, (tmpvar_37 + ivec2(1, 0)), 0);
  vec2 tmpvar_40;
  bool tmpvar_41;
  tmpvar_41 = (0 == tmpvar_29);
  tmpvar_41 = (tmpvar_41 || !((
    ((1 == tmpvar_29) || (2 == tmpvar_29))
   || 
    (3 == tmpvar_29)
  )));
  if (tmpvar_41) {
    tmpvar_40 = vec2(0.5, 0.5);
  } else {
    tmpvar_41 = (tmpvar_41 || (1 == tmpvar_29));
    if (tmpvar_41) {
      tmpvar_40 = vec2(0.125, 0.5);
    } else {
      tmpvar_41 = (tmpvar_41 || (2 == tmpvar_29));
      if (tmpvar_41) {
        tmpvar_40 = vec2(0.5, 0.125);
      } else {
        tmpvar_41 = (tmpvar_41 || (3 == tmpvar_29));
        if (tmpvar_41) {
          tmpvar_40 = vec2(0.125, 0.125);
        };
      };
    };
  };
  float tmpvar_42;
  tmpvar_42 = ((float(ph_user_data_6.x) / 65535.0) * tmpvar_28.x);
  float tmpvar_43;
  tmpvar_43 = (tmpvar_39.z / tmpvar_42);
  vec2 tmpvar_44;
  vec2 tmpvar_45;
  tmpvar_44 = ((tmpvar_43 * (tmpvar_39.xy + 
    (floor(((glyph_offset_1 * tmpvar_42) + tmpvar_40)) / tmpvar_39.z)
  )) + tmpvar_13.zw);
  tmpvar_45 = (tmpvar_43 * (tmpvar_38.zw - tmpvar_38.xy));
  vec2 tmpvar_46;
  tmpvar_46 = min (max ((tmpvar_44 + 
    (tmpvar_45 * aPosition)
  ), tmpvar_14.xy), (tmpvar_14.xy + tmpvar_14.zw));
  vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 1.0);
  tmpvar_47.xy = tmpvar_46;
  vec4 tmpvar_48;
  tmpvar_48 = (transform_m_17 * tmpvar_47);
  vec4 tmpvar_49;
  tmpvar_49.xy = ((tmpvar_48.xy * tmpvar_28.x) + ((
    -(tmpvar_28.yz)
   + tmpvar_27.xy) * tmpvar_48.w));
  tmpvar_49.z = (ph_z_5 * tmpvar_48.w);
  tmpvar_49.w = tmpvar_48.w;
  gl_Position = (uTransform * tmpvar_49);
  vec2 tmpvar_50;
  tmpvar_50 = ((tmpvar_46 - tmpvar_44) / tmpvar_45);
  vec4 tmpvar_51;
  tmpvar_51.xy = clip_area_task_rect_p0_3;
  tmpvar_51.zw = (clip_area_task_rect_p0_3 + clip_area_task_rect_size_4);
  vClipMaskUvBounds = tmpvar_51;
  vClipMaskUv = ((tmpvar_48.xy * area_device_pixel_scale_21) + (tmpvar_48.w * (clip_area_task_rect_p0_3 - area_screen_origin_22)));
  bool tmpvar_52;
  bool tmpvar_53;
  tmpvar_53 = bool(0);
  tmpvar_52 = (1 == color_mode_2);
  if (tmpvar_52) {
    v_mask_swizzle = vec3(0.0, 1.0, 1.0);
    v_color = tmpvar_32;
    tmpvar_53 = bool(1);
  };
  tmpvar_52 = (tmpvar_52 || (7 == color_mode_2));
  tmpvar_52 = (tmpvar_52 && !(tmpvar_53));
  if (tmpvar_52) {
    v_mask_swizzle = vec3(0.0, 1.0, 0.0);
    v_color = tmpvar_32;
    tmpvar_53 = bool(1);
  };
  tmpvar_52 = (tmpvar_52 || (5 == color_mode_2));
  tmpvar_52 = (tmpvar_52 && !(tmpvar_53));
  if (tmpvar_52) {
    v_mask_swizzle = vec3(1.0, 0.0, 0.0);
    v_color = tmpvar_32;
    tmpvar_53 = bool(1);
  };
  tmpvar_52 = (tmpvar_52 || (2 == color_mode_2));
  tmpvar_52 = (tmpvar_52 || (3 == color_mode_2));
  tmpvar_52 = (tmpvar_52 || (8 == color_mode_2));
  tmpvar_52 = (tmpvar_52 && !(tmpvar_53));
  if (tmpvar_52) {
    v_mask_swizzle = vec3(1.0, 0.0, 0.0);
    v_color = tmpvar_32.wwww;
    tmpvar_53 = bool(1);
  };
  tmpvar_52 = (tmpvar_52 || (4 == color_mode_2));
  tmpvar_52 = (tmpvar_52 && !(tmpvar_53));
  if (tmpvar_52) {
    v_mask_swizzle = vec3(-1.0, 1.0, 0.0);
    v_color = (tmpvar_32.wwww * tmpvar_33);
    tmpvar_53 = bool(1);
  };
  tmpvar_52 = (tmpvar_52 || (6 == color_mode_2));
  tmpvar_52 = (tmpvar_52 && !(tmpvar_53));
  if (tmpvar_52) {
    vec3 tmpvar_54;
    tmpvar_54.yz = vec2(0.0, 0.0);
    tmpvar_54.x = tmpvar_32.w;
    v_mask_swizzle = tmpvar_54;
    v_color = tmpvar_32;
    tmpvar_53 = bool(1);
  };
  tmpvar_52 = !(tmpvar_53);
  if (tmpvar_52) {
    v_mask_swizzle = vec3(0.0, 0.0, 0.0);
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
  };
  vec2 tmpvar_55;
  tmpvar_55 = vec2(textureSize (sColor0, 0));
  v_uv = mix ((tmpvar_38.xy / tmpvar_55), (tmpvar_38.zw / tmpvar_55), tmpvar_50);
  v_uv_bounds = ((tmpvar_38 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_55.xyxy);
}


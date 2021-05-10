#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp samplerExternalOES sColor0;
uniform lowp samplerExternalOES sColor1;
uniform lowp samplerExternalOES sColor2;
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
out highp vec2 vUv_Y;
flat out highp vec4 vUvBounds_Y;
out highp vec2 vUv_U;
flat out highp vec4 vUvBounds_U;
out highp vec2 vUv_V;
flat out highp vec4 vUvBounds_V;
flat out highp mat3 vYuvColorMatrix;
flat out highp vec4 vYuvOffsetVector_Coefficient;
flat out highp int vFormat;
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
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_29 = tmpvar_9;
    segment_rect_size_30 = tmpvar_10;
  } else {
    int tmpvar_32;
    tmpvar_32 = ((tmpvar_12.y + 1) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_33;
    tmpvar_33.x = int((uint(tmpvar_32) % 1024u));
    tmpvar_33.y = int((uint(tmpvar_32) / 1024u));
    vec4 tmpvar_34;
    tmpvar_34 = texelFetch (sGpuCache, tmpvar_33, 0);
    segment_rect_size_30 = tmpvar_34.zw;
    segment_rect_p0_29 = (tmpvar_34.xy + tmpvar_7.xy);
  };
  if (transform_is_axis_aligned_15) {
    vec2 tmpvar_35;
    tmpvar_35 = min (max ((segment_rect_p0_29 + 
      (segment_rect_size_30 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_36;
    tmpvar_36.zw = vec2(0.0, 1.0);
    tmpvar_36.xy = tmpvar_35;
    vec4 tmpvar_37;
    tmpvar_37 = (transform_m_14 * tmpvar_36);
    vec4 tmpvar_38;
    tmpvar_38.xy = ((tmpvar_37.xy * tmpvar_20.x) + ((
      -(tmpvar_20.yz)
     + tmpvar_19.xy) * tmpvar_37.w));
    tmpvar_38.z = (ph_z_5 * tmpvar_37.w);
    tmpvar_38.w = tmpvar_37.w;
    gl_Position = (uTransform * tmpvar_38);
    vi_local_pos_27 = tmpvar_35;
    vi_world_pos_28 = tmpvar_37;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec2 result_p1_39;
    result_p1_39 = (tmpvar_8.xy + tmpvar_8.zw);
    bvec4 tmpvar_40;
    tmpvar_40 = notEqual ((tmpvar_31 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0));
    vec4 tmpvar_41;
    tmpvar_41.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_39);
    tmpvar_41.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_39);
    vec4 tmpvar_42;
    tmpvar_42.xy = min (max (segment_rect_p0_29, tmpvar_8.xy), result_p1_39);
    tmpvar_42.zw = min (max ((segment_rect_p0_29 + segment_rect_size_30), tmpvar_8.xy), result_p1_39);
    vTransformBounds = mix(tmpvar_41, tmpvar_42, bvec4(tmpvar_40));
    vec4 tmpvar_43;
    tmpvar_43 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_40));
    vec2 tmpvar_44;
    tmpvar_44 = ((segment_rect_p0_29 - tmpvar_43.xy) + ((segment_rect_size_30 + 
      (tmpvar_43.xy + tmpvar_43.zw)
    ) * aPosition));
    vec4 tmpvar_45;
    tmpvar_45.zw = vec2(0.0, 1.0);
    tmpvar_45.xy = tmpvar_44;
    vec4 tmpvar_46;
    tmpvar_46 = (transform_m_14 * tmpvar_45);
    vec4 tmpvar_47;
    tmpvar_47.xy = ((tmpvar_46.xy * tmpvar_20.x) + ((tmpvar_19.xy - tmpvar_20.yz) * tmpvar_46.w));
    tmpvar_47.z = (ph_z_5 * tmpvar_46.w);
    tmpvar_47.w = tmpvar_46.w;
    gl_Position = (uTransform * tmpvar_47);
    vi_local_pos_27 = tmpvar_44;
    vi_world_pos_28 = tmpvar_46;
  };
  vec4 tmpvar_48;
  tmpvar_48.xy = area_task_rect_21.p0;
  tmpvar_48.zw = (area_task_rect_21.p0 + area_task_rect_21.size);
  vClipMaskUvBounds = tmpvar_48;
  vClipMaskUv = ((vi_world_pos_28.xy * area_device_pixel_scale_22) + (vi_world_pos_28.w * (area_task_rect_21.p0 - area_screen_origin_23)));
  int prim_yuv_format_49;
  highp vec2 f_50;
  f_50 = ((vi_local_pos_27 - tmpvar_7.xy) / tmpvar_7.zw);
  ivec2 tmpvar_51;
  tmpvar_51.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_51.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_52;
  tmpvar_52 = texelFetch (sGpuCache, tmpvar_51, 0);
  int tmpvar_53;
  tmpvar_53 = int(tmpvar_52.y);
  prim_yuv_format_49 = int(tmpvar_52.z);
  vYuvOffsetVector_Coefficient.w = tmpvar_52.x;
  mat3 tmpvar_54;
  if ((tmpvar_53 == 0)) {
    tmpvar_54 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((tmpvar_53 == 1)) {
      tmpvar_54 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      if ((tmpvar_53 == 3)) {
        tmpvar_54 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
      } else {
        tmpvar_54 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
      };
    };
  };
  vYuvColorMatrix = tmpvar_54;
  vec3 tmpvar_55;
  if ((tmpvar_53 == 3)) {
    tmpvar_55 = vec3(0.0, 0.0, 0.0);
  } else {
    tmpvar_55 = vec3(0.06275, 0.50196, 0.50196);
  };
  vYuvOffsetVector_Coefficient.xyz = tmpvar_55;
  vFormat = prim_yuv_format_49;
  if ((prim_yuv_format_49 == 1)) {
    ivec2 tmpvar_56;
    tmpvar_56.x = int((uint(tmpvar_13.x) % 1024u));
    tmpvar_56.y = int((uint(tmpvar_13.x) / 1024u));
    vec4 tmpvar_57;
    tmpvar_57 = texelFetch (sGpuCache, tmpvar_56, 0);
    ivec2 tmpvar_58;
    tmpvar_58.x = int((uint(tmpvar_13.y) % 1024u));
    tmpvar_58.y = int((uint(tmpvar_13.y) / 1024u));
    vec4 tmpvar_59;
    tmpvar_59 = texelFetch (sGpuCache, tmpvar_58, 0);
    ivec2 tmpvar_60;
    tmpvar_60.x = int((uint(tmpvar_13.z) % 1024u));
    tmpvar_60.y = int((uint(tmpvar_13.z) / 1024u));
    vec4 tmpvar_61;
    tmpvar_61 = texelFetch (sGpuCache, tmpvar_60, 0);
    vec2 tmpvar_62;
    tmpvar_62 = vec2(textureSize (sColor0, 0));
    vec4 tmpvar_63;
    tmpvar_63.xy = (tmpvar_57.xy + vec2(0.5, 0.5));
    tmpvar_63.zw = (tmpvar_57.zw - vec2(0.5, 0.5));
    vUv_Y = (mix (tmpvar_57.xy, tmpvar_57.zw, f_50) / tmpvar_62);
    vUvBounds_Y = (tmpvar_63 / tmpvar_62.xyxy);
    vec2 tmpvar_64;
    tmpvar_64 = vec2(textureSize (sColor1, 0));
    vec4 tmpvar_65;
    tmpvar_65.xy = (tmpvar_59.xy + vec2(0.5, 0.5));
    tmpvar_65.zw = (tmpvar_59.zw - vec2(0.5, 0.5));
    vUv_U = (mix (tmpvar_59.xy, tmpvar_59.zw, f_50) / tmpvar_64);
    vUvBounds_U = (tmpvar_65 / tmpvar_64.xyxy);
    vec2 tmpvar_66;
    tmpvar_66 = vec2(textureSize (sColor2, 0));
    vec4 tmpvar_67;
    tmpvar_67.xy = (tmpvar_61.xy + vec2(0.5, 0.5));
    tmpvar_67.zw = (tmpvar_61.zw - vec2(0.5, 0.5));
    vUv_V = (mix (tmpvar_61.xy, tmpvar_61.zw, f_50) / tmpvar_66);
    vUvBounds_V = (tmpvar_67 / tmpvar_66.xyxy);
  } else {
    if ((prim_yuv_format_49 == 0)) {
      ivec2 tmpvar_68;
      tmpvar_68.x = int((uint(tmpvar_13.x) % 1024u));
      tmpvar_68.y = int((uint(tmpvar_13.x) / 1024u));
      vec4 tmpvar_69;
      tmpvar_69 = texelFetch (sGpuCache, tmpvar_68, 0);
      ivec2 tmpvar_70;
      tmpvar_70.x = int((uint(tmpvar_13.y) % 1024u));
      tmpvar_70.y = int((uint(tmpvar_13.y) / 1024u));
      vec4 tmpvar_71;
      tmpvar_71 = texelFetch (sGpuCache, tmpvar_70, 0);
      vec2 tmpvar_72;
      tmpvar_72 = vec2(textureSize (sColor0, 0));
      vec4 tmpvar_73;
      tmpvar_73.xy = (tmpvar_69.xy + vec2(0.5, 0.5));
      tmpvar_73.zw = (tmpvar_69.zw - vec2(0.5, 0.5));
      vUv_Y = (mix (tmpvar_69.xy, tmpvar_69.zw, f_50) / tmpvar_72);
      vUvBounds_Y = (tmpvar_73 / tmpvar_72.xyxy);
      vec2 tmpvar_74;
      tmpvar_74 = vec2(textureSize (sColor1, 0));
      vec4 tmpvar_75;
      tmpvar_75.xy = (tmpvar_71.xy + vec2(0.5, 0.5));
      tmpvar_75.zw = (tmpvar_71.zw - vec2(0.5, 0.5));
      vUv_U = (mix (tmpvar_71.xy, tmpvar_71.zw, f_50) / tmpvar_74);
      vUvBounds_U = (tmpvar_75 / tmpvar_74.xyxy);
    } else {
      if ((prim_yuv_format_49 == 2)) {
        ivec2 tmpvar_76;
        tmpvar_76.x = int((uint(tmpvar_13.x) % 1024u));
        tmpvar_76.y = int((uint(tmpvar_13.x) / 1024u));
        vec4 tmpvar_77;
        tmpvar_77 = texelFetch (sGpuCache, tmpvar_76, 0);
        vec2 tmpvar_78;
        tmpvar_78 = vec2(textureSize (sColor0, 0));
        vec4 tmpvar_79;
        tmpvar_79.xy = (tmpvar_77.xy + vec2(0.5, 0.5));
        tmpvar_79.zw = (tmpvar_77.zw - vec2(0.5, 0.5));
        vUv_Y = (mix (tmpvar_77.xy, tmpvar_77.zw, f_50) / tmpvar_78);
        vUvBounds_Y = (tmpvar_79 / tmpvar_78.xyxy);
      };
    };
  };
  v_local_pos = vi_local_pos_27;
}


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
flat out highp vec2 v_perspective_amount;
flat out highp int v_op;
flat out highp int v_table_address;
flat out highp mat4 v_color_mat;
flat out highp ivec4 v_funcs;
flat out highp vec4 v_color_offset;
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
    tmpvar_41.x = bool((tmpvar_31 & 1));
    tmpvar_41.y = bool((tmpvar_31 & 2));
    tmpvar_41.z = bool((tmpvar_31 & 4));
    tmpvar_41.w = bool((tmpvar_31 & 8));
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
  tmpvar_52 = (1.0/(vec2(textureSize (sColor0, 0))));
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
  v_uv = ((tmpvar_57 * tmpvar_52) * mix (vi_world_pos_28.w, 1.0, tmpvar_58));
  v_perspective_amount.x = tmpvar_58;
  vec4 tmpvar_59;
  tmpvar_59.xy = (tmpvar_51.xy + vec2(0.5, 0.5));
  tmpvar_59.zw = (tmpvar_51.zw - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_59 * tmpvar_52.xyxy);
  float tmpvar_60;
  tmpvar_60 = (float(tmpvar_13.z) / 65536.0);
  v_op = (tmpvar_13.y & 65535);
  v_perspective_amount.y = tmpvar_60;
  v_funcs.x = ((tmpvar_13.y >> 28) & 15);
  v_funcs.y = ((tmpvar_13.y >> 24) & 15);
  v_funcs.z = ((tmpvar_13.y >> 20) & 15);
  v_funcs.w = ((tmpvar_13.y >> 16) & 15);
  highp int tmpvar_61;
  tmpvar_61 = tmpvar_13.z;
  highp vec4 tmpvar_62;
  highp mat4 tmpvar_63;
  highp int tmpvar_64;
  float tmpvar_65;
  tmpvar_65 = (1.0 - tmpvar_60);
  if ((v_op == 1)) {
    vec4 tmpvar_66;
    tmpvar_66.w = 0.0;
    tmpvar_66.x = (0.2126 + (0.7874 * tmpvar_65));
    tmpvar_66.y = (0.2126 - (0.2126 * tmpvar_65));
    tmpvar_66.z = (0.2126 - (0.2126 * tmpvar_65));
    vec4 tmpvar_67;
    tmpvar_67.w = 0.0;
    tmpvar_67.x = (0.7152 - (0.7152 * tmpvar_65));
    tmpvar_67.y = (0.7152 + (0.2848 * tmpvar_65));
    tmpvar_67.z = (0.7152 - (0.7152 * tmpvar_65));
    vec4 tmpvar_68;
    tmpvar_68.w = 0.0;
    tmpvar_68.x = (0.0722 - (0.0722 * tmpvar_65));
    tmpvar_68.y = (0.0722 - (0.0722 * tmpvar_65));
    tmpvar_68.z = (0.0722 + (0.9278 * tmpvar_65));
    mat4 tmpvar_69;
    tmpvar_69[uint(0)] = tmpvar_66;
    tmpvar_69[1u] = tmpvar_67;
    tmpvar_69[2u] = tmpvar_68;
    tmpvar_69[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    tmpvar_63 = tmpvar_69;
    tmpvar_62 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    if ((v_op == 2)) {
      float tmpvar_70;
      tmpvar_70 = cos(tmpvar_60);
      float tmpvar_71;
      tmpvar_71 = sin(tmpvar_60);
      vec4 tmpvar_72;
      tmpvar_72.w = 0.0;
      tmpvar_72.x = ((0.2126 + (0.7874 * tmpvar_70)) - (0.2126 * tmpvar_71));
      tmpvar_72.y = ((0.2126 - (0.2126 * tmpvar_70)) + (0.143 * tmpvar_71));
      tmpvar_72.z = ((0.2126 - (0.2126 * tmpvar_70)) - (0.7874 * tmpvar_71));
      vec4 tmpvar_73;
      tmpvar_73.w = 0.0;
      tmpvar_73.x = ((0.7152 - (0.7152 * tmpvar_70)) - (0.7152 * tmpvar_71));
      tmpvar_73.y = ((0.7152 + (0.2848 * tmpvar_70)) + (0.14 * tmpvar_71));
      tmpvar_73.z = ((0.7152 - (0.7152 * tmpvar_70)) + (0.7152 * tmpvar_71));
      vec4 tmpvar_74;
      tmpvar_74.w = 0.0;
      tmpvar_74.x = ((0.0722 - (0.0722 * tmpvar_70)) + (0.9278 * tmpvar_71));
      tmpvar_74.y = ((0.0722 - (0.0722 * tmpvar_70)) - (0.283 * tmpvar_71));
      tmpvar_74.z = ((0.0722 + (0.9278 * tmpvar_70)) + (0.0722 * tmpvar_71));
      mat4 tmpvar_75;
      tmpvar_75[uint(0)] = tmpvar_72;
      tmpvar_75[1u] = tmpvar_73;
      tmpvar_75[2u] = tmpvar_74;
      tmpvar_75[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      tmpvar_63 = tmpvar_75;
      tmpvar_62 = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
      if ((v_op == 4)) {
        vec4 tmpvar_76;
        tmpvar_76.w = 0.0;
        tmpvar_76.x = ((tmpvar_65 * 0.2126) + tmpvar_60);
        tmpvar_76.y = (tmpvar_65 * 0.2126);
        tmpvar_76.z = (tmpvar_65 * 0.2126);
        vec4 tmpvar_77;
        tmpvar_77.w = 0.0;
        tmpvar_77.x = (tmpvar_65 * 0.7152);
        tmpvar_77.y = ((tmpvar_65 * 0.7152) + tmpvar_60);
        tmpvar_77.z = (tmpvar_65 * 0.7152);
        vec4 tmpvar_78;
        tmpvar_78.w = 0.0;
        tmpvar_78.x = (tmpvar_65 * 0.0722);
        tmpvar_78.y = (tmpvar_65 * 0.0722);
        tmpvar_78.z = ((tmpvar_65 * 0.0722) + tmpvar_60);
        mat4 tmpvar_79;
        tmpvar_79[uint(0)] = tmpvar_76;
        tmpvar_79[1u] = tmpvar_77;
        tmpvar_79[2u] = tmpvar_78;
        tmpvar_79[3u] = vec4(0.0, 0.0, 0.0, 1.0);
        tmpvar_63 = tmpvar_79;
        tmpvar_62 = vec4(0.0, 0.0, 0.0, 0.0);
      } else {
        if ((v_op == 5)) {
          vec4 tmpvar_80;
          tmpvar_80.w = 0.0;
          tmpvar_80.x = (0.393 + (0.607 * tmpvar_65));
          tmpvar_80.y = (0.349 - (0.349 * tmpvar_65));
          tmpvar_80.z = (0.272 - (0.272 * tmpvar_65));
          vec4 tmpvar_81;
          tmpvar_81.w = 0.0;
          tmpvar_81.x = (0.769 - (0.769 * tmpvar_65));
          tmpvar_81.y = (0.686 + (0.314 * tmpvar_65));
          tmpvar_81.z = (0.534 - (0.534 * tmpvar_65));
          vec4 tmpvar_82;
          tmpvar_82.w = 0.0;
          tmpvar_82.x = (0.189 - (0.189 * tmpvar_65));
          tmpvar_82.y = (0.168 - (0.168 * tmpvar_65));
          tmpvar_82.z = (0.131 + (0.869 * tmpvar_65));
          mat4 tmpvar_83;
          tmpvar_83[uint(0)] = tmpvar_80;
          tmpvar_83[1u] = tmpvar_81;
          tmpvar_83[2u] = tmpvar_82;
          tmpvar_83[3u] = vec4(0.0, 0.0, 0.0, 1.0);
          tmpvar_63 = tmpvar_83;
          tmpvar_62 = vec4(0.0, 0.0, 0.0, 0.0);
        } else {
          if ((v_op == 7)) {
            ivec2 tmpvar_84;
            tmpvar_84.x = int((uint(tmpvar_13.z) % 1024u));
            tmpvar_84.y = int((uint(tmpvar_13.z) / 1024u));
            highp int tmpvar_85;
            tmpvar_85 = (tmpvar_13.z + 4);
            ivec2 tmpvar_86;
            tmpvar_86.x = int((uint(tmpvar_85) % 1024u));
            tmpvar_86.y = int((uint(tmpvar_85) / 1024u));
            mat4 tmpvar_87;
            tmpvar_87[uint(0)] = texelFetch (sGpuCache, tmpvar_84, 0);
            tmpvar_87[1u] = texelFetch (sGpuCache, (tmpvar_84 + ivec2(1, 0)), 0);
            tmpvar_87[2u] = texelFetch (sGpuCache, (tmpvar_84 + ivec2(2, 0)), 0);
            tmpvar_87[3u] = texelFetch (sGpuCache, (tmpvar_84 + ivec2(3, 0)), 0);
            tmpvar_63 = tmpvar_87;
            tmpvar_62 = texelFetch (sGpuCache, tmpvar_86, 0);
          } else {
            if ((v_op == 11)) {
              tmpvar_64 = tmpvar_61;
            } else {
              if ((v_op == 10)) {
                ivec2 tmpvar_88;
                tmpvar_88.x = int((uint(tmpvar_13.z) % 1024u));
                tmpvar_88.y = int((uint(tmpvar_13.z) / 1024u));
                tmpvar_62 = texelFetch (sGpuCache, tmpvar_88, 0);
              };
            };
          };
        };
      };
    };
  };
  v_color_offset = tmpvar_62;
  v_color_mat = tmpvar_63;
  v_table_address = tmpvar_64;
  v_local_pos = vi_local_pos_27;
}


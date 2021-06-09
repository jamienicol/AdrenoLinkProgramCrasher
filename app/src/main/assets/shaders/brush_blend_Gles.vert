#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
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
  int instance_segment_index_2;
  int instance_flags_3;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_segment_index_2 = (aData.z & 65535);
  instance_flags_3 = (aData.z >> 16);
  float ph_z_4;
  ivec2 tmpvar_5;
  tmpvar_5.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_5.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetch (sPrimitiveHeadersF, tmpvar_5, 0);
  vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sPrimitiveHeadersF, (tmpvar_5 + ivec2(1, 0)), 0);
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  tmpvar_8 = tmpvar_6.xy;
  tmpvar_9 = tmpvar_6.zw;
  ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_10.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetch (sPrimitiveHeadersI, tmpvar_10, 0);
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, (tmpvar_10 + ivec2(1, 0)), 0);
  ph_z_4 = float(tmpvar_11.x);
  mat4 transform_m_13;
  bool transform_is_axis_aligned_14;
  transform_is_axis_aligned_14 = ((tmpvar_11.z >> 24) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_11.z & 16777215);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  transform_m_13[0] = texelFetch (sTransformPalette, tmpvar_16, 0);
  transform_m_13[1] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(1, 0)), 0);
  transform_m_13[2] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(2, 0)), 0);
  transform_m_13[3] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(3, 0)), 0);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_17.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sRenderTasks, tmpvar_17, 0);
  vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, (tmpvar_17 + ivec2(1, 0)), 0);
  vec2 vi_local_pos_20;
  vec4 vi_world_pos_21;
  vec2 segment_rect_p0_22;
  vec2 segment_rect_size_23;
  int tmpvar_24;
  tmpvar_24 = (instance_flags_3 & 255);
  int tmpvar_25;
  tmpvar_25 = ((instance_flags_3 >> 8) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_22 = tmpvar_8;
    segment_rect_size_23 = tmpvar_9;
  } else {
    int tmpvar_26;
    tmpvar_26 = ((tmpvar_11.y + 3) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_27;
    tmpvar_27.x = int((uint(tmpvar_26) % 1024u));
    tmpvar_27.y = int((uint(tmpvar_26) / 1024u));
    vec4 tmpvar_28;
    tmpvar_28 = texelFetch (sGpuCache, tmpvar_27, 0);
    segment_rect_size_23 = tmpvar_28.zw;
    segment_rect_p0_22 = (tmpvar_28.xy + tmpvar_6.xy);
  };
  if (transform_is_axis_aligned_14) {
    vec2 tmpvar_29;
    tmpvar_29 = min (max ((segment_rect_p0_22 + 
      (segment_rect_size_23 * aPosition)
    ), tmpvar_7.xy), (tmpvar_7.xy + tmpvar_7.zw));
    vec4 tmpvar_30;
    tmpvar_30.zw = vec2(0.0, 1.0);
    tmpvar_30.xy = tmpvar_29;
    vec4 tmpvar_31;
    tmpvar_31 = (transform_m_13 * tmpvar_30);
    vec4 tmpvar_32;
    tmpvar_32.xy = ((tmpvar_31.xy * tmpvar_19.x) + ((
      -(tmpvar_19.yz)
     + tmpvar_18.xy) * tmpvar_31.w));
    tmpvar_32.z = (ph_z_4 * tmpvar_31.w);
    tmpvar_32.w = tmpvar_31.w;
    gl_Position = (uTransform * tmpvar_32);
    vi_local_pos_20 = tmpvar_29;
    vi_world_pos_21 = tmpvar_31;
  } else {
    vec2 result_p1_33;
    result_p1_33 = (tmpvar_7.xy + tmpvar_7.zw);
    bvec4 tmpvar_34;
    tmpvar_34.x = bool((tmpvar_24 & 1));
    tmpvar_34.y = bool((tmpvar_24 & 2));
    tmpvar_34.z = bool((tmpvar_24 & 4));
    tmpvar_34.w = bool((tmpvar_24 & 8));
    vec4 tmpvar_35;
    tmpvar_35.xy = min (max (tmpvar_6.xy, tmpvar_7.xy), result_p1_33);
    tmpvar_35.zw = min (max ((tmpvar_6.xy + tmpvar_6.zw), tmpvar_7.xy), result_p1_33);
    vec4 tmpvar_36;
    tmpvar_36.xy = min (max (segment_rect_p0_22, tmpvar_7.xy), result_p1_33);
    tmpvar_36.zw = min (max ((segment_rect_p0_22 + segment_rect_size_23), tmpvar_7.xy), result_p1_33);
    vTransformBounds = mix(tmpvar_35, tmpvar_36, bvec4(tmpvar_34));
    vec4 tmpvar_37;
    tmpvar_37 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_34));
    vec2 tmpvar_38;
    tmpvar_38 = ((segment_rect_p0_22 - tmpvar_37.xy) + ((segment_rect_size_23 + 
      (tmpvar_37.xy + tmpvar_37.zw)
    ) * aPosition));
    vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    vec4 tmpvar_40;
    tmpvar_40 = (transform_m_13 * tmpvar_39);
    vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_19.x) + ((tmpvar_18.xy - tmpvar_19.yz) * tmpvar_40.w));
    tmpvar_41.z = (ph_z_4 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    vi_local_pos_20 = tmpvar_38;
    vi_world_pos_21 = tmpvar_40;
  };
  ivec2 tmpvar_42;
  tmpvar_42.x = int((uint(tmpvar_12.x) % 1024u));
  tmpvar_42.y = int((uint(tmpvar_12.x) / 1024u));
  vec4 tmpvar_43;
  tmpvar_43 = texelFetch (sGpuCache, tmpvar_42, 0);
  vec2 tmpvar_44;
  tmpvar_44 = (1.0/(vec2(textureSize (sColor0, 0))));
  vec2 tmpvar_45;
  tmpvar_45 = ((vi_local_pos_20 - tmpvar_6.xy) / tmpvar_6.zw);
  highp int tmpvar_46;
  tmpvar_46 = (tmpvar_12.x + 2);
  ivec2 tmpvar_47;
  tmpvar_47.x = int((uint(tmpvar_46) % 1024u));
  tmpvar_47.y = int((uint(tmpvar_46) / 1024u));
  vec4 tmpvar_48;
  tmpvar_48 = mix (mix (texelFetch (sGpuCache, tmpvar_47, 0), texelFetch (sGpuCache, (tmpvar_47 + ivec2(1, 0)), 0), tmpvar_45.x), mix (texelFetch (sGpuCache, (tmpvar_47 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_47 + ivec2(3, 0)), 0), tmpvar_45.x), tmpvar_45.y);
  vec2 tmpvar_49;
  tmpvar_49 = mix (tmpvar_43.xy, tmpvar_43.zw, (tmpvar_48.xy / tmpvar_48.w));
  float tmpvar_50;
  if (((tmpvar_25 & 1) != 0)) {
    tmpvar_50 = 1.0;
  } else {
    tmpvar_50 = 0.0;
  };
  v_uv = ((tmpvar_49 * tmpvar_44) * mix (vi_world_pos_21.w, 1.0, tmpvar_50));
  v_perspective_amount.x = tmpvar_50;
  vec4 tmpvar_51;
  tmpvar_51.xy = (tmpvar_43.xy + vec2(0.5, 0.5));
  tmpvar_51.zw = (tmpvar_43.zw - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_51 * tmpvar_44.xyxy);
  float tmpvar_52;
  tmpvar_52 = (float(tmpvar_12.z) / 65536.0);
  v_op = (tmpvar_12.y & 65535);
  v_perspective_amount.y = tmpvar_52;
  v_funcs.x = ((tmpvar_12.y >> 28) & 15);
  v_funcs.y = ((tmpvar_12.y >> 24) & 15);
  v_funcs.z = ((tmpvar_12.y >> 20) & 15);
  v_funcs.w = ((tmpvar_12.y >> 16) & 15);
  highp int tmpvar_53;
  tmpvar_53 = tmpvar_12.z;
  highp vec4 tmpvar_54;
  highp mat4 tmpvar_55;
  highp int tmpvar_56;
  float tmpvar_57;
  tmpvar_57 = (1.0 - tmpvar_52);
  if ((v_op == 1)) {
    vec4 tmpvar_58;
    tmpvar_58.w = 0.0;
    tmpvar_58.x = (0.2126 + (0.7874 * tmpvar_57));
    tmpvar_58.y = (0.2126 - (0.2126 * tmpvar_57));
    tmpvar_58.z = (0.2126 - (0.2126 * tmpvar_57));
    vec4 tmpvar_59;
    tmpvar_59.w = 0.0;
    tmpvar_59.x = (0.7152 - (0.7152 * tmpvar_57));
    tmpvar_59.y = (0.7152 + (0.2848 * tmpvar_57));
    tmpvar_59.z = (0.7152 - (0.7152 * tmpvar_57));
    vec4 tmpvar_60;
    tmpvar_60.w = 0.0;
    tmpvar_60.x = (0.0722 - (0.0722 * tmpvar_57));
    tmpvar_60.y = (0.0722 - (0.0722 * tmpvar_57));
    tmpvar_60.z = (0.0722 + (0.9278 * tmpvar_57));
    mat4 tmpvar_61;
    tmpvar_61[uint(0)] = tmpvar_58;
    tmpvar_61[1u] = tmpvar_59;
    tmpvar_61[2u] = tmpvar_60;
    tmpvar_61[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    tmpvar_55 = tmpvar_61;
    tmpvar_54 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    if ((v_op == 2)) {
      float tmpvar_62;
      tmpvar_62 = cos(tmpvar_52);
      float tmpvar_63;
      tmpvar_63 = sin(tmpvar_52);
      vec4 tmpvar_64;
      tmpvar_64.w = 0.0;
      tmpvar_64.x = ((0.2126 + (0.7874 * tmpvar_62)) - (0.2126 * tmpvar_63));
      tmpvar_64.y = ((0.2126 - (0.2126 * tmpvar_62)) + (0.143 * tmpvar_63));
      tmpvar_64.z = ((0.2126 - (0.2126 * tmpvar_62)) - (0.7874 * tmpvar_63));
      vec4 tmpvar_65;
      tmpvar_65.w = 0.0;
      tmpvar_65.x = ((0.7152 - (0.7152 * tmpvar_62)) - (0.7152 * tmpvar_63));
      tmpvar_65.y = ((0.7152 + (0.2848 * tmpvar_62)) + (0.14 * tmpvar_63));
      tmpvar_65.z = ((0.7152 - (0.7152 * tmpvar_62)) + (0.7152 * tmpvar_63));
      vec4 tmpvar_66;
      tmpvar_66.w = 0.0;
      tmpvar_66.x = ((0.0722 - (0.0722 * tmpvar_62)) + (0.9278 * tmpvar_63));
      tmpvar_66.y = ((0.0722 - (0.0722 * tmpvar_62)) - (0.283 * tmpvar_63));
      tmpvar_66.z = ((0.0722 + (0.9278 * tmpvar_62)) + (0.0722 * tmpvar_63));
      mat4 tmpvar_67;
      tmpvar_67[uint(0)] = tmpvar_64;
      tmpvar_67[1u] = tmpvar_65;
      tmpvar_67[2u] = tmpvar_66;
      tmpvar_67[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      tmpvar_55 = tmpvar_67;
      tmpvar_54 = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
      if ((v_op == 4)) {
        vec4 tmpvar_68;
        tmpvar_68.w = 0.0;
        tmpvar_68.x = ((tmpvar_57 * 0.2126) + tmpvar_52);
        tmpvar_68.y = (tmpvar_57 * 0.2126);
        tmpvar_68.z = (tmpvar_57 * 0.2126);
        vec4 tmpvar_69;
        tmpvar_69.w = 0.0;
        tmpvar_69.x = (tmpvar_57 * 0.7152);
        tmpvar_69.y = ((tmpvar_57 * 0.7152) + tmpvar_52);
        tmpvar_69.z = (tmpvar_57 * 0.7152);
        vec4 tmpvar_70;
        tmpvar_70.w = 0.0;
        tmpvar_70.x = (tmpvar_57 * 0.0722);
        tmpvar_70.y = (tmpvar_57 * 0.0722);
        tmpvar_70.z = ((tmpvar_57 * 0.0722) + tmpvar_52);
        mat4 tmpvar_71;
        tmpvar_71[uint(0)] = tmpvar_68;
        tmpvar_71[1u] = tmpvar_69;
        tmpvar_71[2u] = tmpvar_70;
        tmpvar_71[3u] = vec4(0.0, 0.0, 0.0, 1.0);
        tmpvar_55 = tmpvar_71;
        tmpvar_54 = vec4(0.0, 0.0, 0.0, 0.0);
      } else {
        if ((v_op == 5)) {
          vec4 tmpvar_72;
          tmpvar_72.w = 0.0;
          tmpvar_72.x = (0.393 + (0.607 * tmpvar_57));
          tmpvar_72.y = (0.349 - (0.349 * tmpvar_57));
          tmpvar_72.z = (0.272 - (0.272 * tmpvar_57));
          vec4 tmpvar_73;
          tmpvar_73.w = 0.0;
          tmpvar_73.x = (0.769 - (0.769 * tmpvar_57));
          tmpvar_73.y = (0.686 + (0.314 * tmpvar_57));
          tmpvar_73.z = (0.534 - (0.534 * tmpvar_57));
          vec4 tmpvar_74;
          tmpvar_74.w = 0.0;
          tmpvar_74.x = (0.189 - (0.189 * tmpvar_57));
          tmpvar_74.y = (0.168 - (0.168 * tmpvar_57));
          tmpvar_74.z = (0.131 + (0.869 * tmpvar_57));
          mat4 tmpvar_75;
          tmpvar_75[uint(0)] = tmpvar_72;
          tmpvar_75[1u] = tmpvar_73;
          tmpvar_75[2u] = tmpvar_74;
          tmpvar_75[3u] = vec4(0.0, 0.0, 0.0, 1.0);
          tmpvar_55 = tmpvar_75;
          tmpvar_54 = vec4(0.0, 0.0, 0.0, 0.0);
        } else {
          if ((v_op == 7)) {
            ivec2 tmpvar_76;
            tmpvar_76.x = int((uint(tmpvar_12.z) % 1024u));
            tmpvar_76.y = int((uint(tmpvar_12.z) / 1024u));
            highp int tmpvar_77;
            tmpvar_77 = (tmpvar_12.z + 4);
            ivec2 tmpvar_78;
            tmpvar_78.x = int((uint(tmpvar_77) % 1024u));
            tmpvar_78.y = int((uint(tmpvar_77) / 1024u));
            mat4 tmpvar_79;
            tmpvar_79[uint(0)] = texelFetch (sGpuCache, tmpvar_76, 0);
            tmpvar_79[1u] = texelFetch (sGpuCache, (tmpvar_76 + ivec2(1, 0)), 0);
            tmpvar_79[2u] = texelFetch (sGpuCache, (tmpvar_76 + ivec2(2, 0)), 0);
            tmpvar_79[3u] = texelFetch (sGpuCache, (tmpvar_76 + ivec2(3, 0)), 0);
            tmpvar_55 = tmpvar_79;
            tmpvar_54 = texelFetch (sGpuCache, tmpvar_78, 0);
          } else {
            if ((v_op == 11)) {
              tmpvar_56 = tmpvar_53;
            } else {
              if ((v_op == 10)) {
                ivec2 tmpvar_80;
                tmpvar_80.x = int((uint(tmpvar_12.z) % 1024u));
                tmpvar_80.y = int((uint(tmpvar_12.z) / 1024u));
                tmpvar_54 = texelFetch (sGpuCache, tmpvar_80, 0);
              };
            };
          };
        };
      };
    };
  };
  v_color_offset = tmpvar_54;
  v_color_mat = tmpvar_55;
  v_table_address = tmpvar_56;
}


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
out highp vec2 v_local_pos;
out highp vec2 v_uv;
flat out highp vec4 v_uv_bounds;
flat out highp vec4 v_uv_sample_bounds;
flat out highp float v_perspective;
void main ()
{
  int instance_picture_task_address_1;
  int instance_segment_index_2;
  int instance_flags_3;
  int instance_resource_address_4;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_segment_index_2 = (aData.z & 65535);
  instance_flags_3 = (aData.z >> 16);
  instance_resource_address_4 = (aData.w & 16777215);
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
  ph_z_5 = float(tmpvar_12.x);
  mat4 transform_m_13;
  bool transform_is_axis_aligned_14;
  transform_is_axis_aligned_14 = ((tmpvar_12.z >> 24) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_12.z & 16777215);
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
  highp vec4 segment_data_24;
  int tmpvar_25;
  tmpvar_25 = (instance_flags_3 & 255);
  int tmpvar_26;
  tmpvar_26 = ((instance_flags_3 >> 8) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_22 = tmpvar_9;
    segment_rect_size_23 = tmpvar_10;
    segment_data_24 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_27;
    tmpvar_27 = ((tmpvar_12.y + 3) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_28;
    tmpvar_28.x = int((uint(tmpvar_27) % 1024u));
    tmpvar_28.y = int((uint(tmpvar_27) / 1024u));
    vec4 tmpvar_29;
    tmpvar_29 = texelFetch (sGpuCache, tmpvar_28, 0);
    segment_rect_size_23 = tmpvar_29.zw;
    segment_rect_p0_22 = (tmpvar_29.xy + tmpvar_7.xy);
    segment_data_24 = texelFetch (sGpuCache, (tmpvar_28 + ivec2(1, 0)), 0);
  };
  if (transform_is_axis_aligned_14) {
    vec2 tmpvar_30;
    tmpvar_30 = min (max ((segment_rect_p0_22 + 
      (segment_rect_size_23 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 1.0);
    tmpvar_31.xy = tmpvar_30;
    vec4 tmpvar_32;
    tmpvar_32 = (transform_m_13 * tmpvar_31);
    vec4 tmpvar_33;
    tmpvar_33.xy = ((tmpvar_32.xy * tmpvar_19.x) + ((
      -(tmpvar_19.yz)
     + tmpvar_18.xy) * tmpvar_32.w));
    tmpvar_33.z = (ph_z_5 * tmpvar_32.w);
    tmpvar_33.w = tmpvar_32.w;
    gl_Position = (uTransform * tmpvar_33);
    vi_local_pos_20 = tmpvar_30;
    vi_world_pos_21 = tmpvar_32;
  } else {
    vec2 result_p1_34;
    result_p1_34 = (tmpvar_8.xy + tmpvar_8.zw);
    bvec4 tmpvar_35;
    tmpvar_35.x = bool((tmpvar_25 & 1));
    tmpvar_35.y = bool((tmpvar_25 & 2));
    tmpvar_35.z = bool((tmpvar_25 & 4));
    tmpvar_35.w = bool((tmpvar_25 & 8));
    vec4 tmpvar_36;
    tmpvar_36.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_34);
    tmpvar_36.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_34);
    vec4 tmpvar_37;
    tmpvar_37.xy = min (max (segment_rect_p0_22, tmpvar_8.xy), result_p1_34);
    tmpvar_37.zw = min (max ((segment_rect_p0_22 + segment_rect_size_23), tmpvar_8.xy), result_p1_34);
    vTransformBounds = mix(tmpvar_36, tmpvar_37, bvec4(tmpvar_35));
    vec4 tmpvar_38;
    tmpvar_38 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_35));
    vec2 tmpvar_39;
    tmpvar_39 = ((segment_rect_p0_22 - tmpvar_38.xy) + ((segment_rect_size_23 + 
      (tmpvar_38.xy + tmpvar_38.zw)
    ) * aPosition));
    vec4 tmpvar_40;
    tmpvar_40.zw = vec2(0.0, 1.0);
    tmpvar_40.xy = tmpvar_39;
    vec4 tmpvar_41;
    tmpvar_41 = (transform_m_13 * tmpvar_40);
    vec4 tmpvar_42;
    tmpvar_42.xy = ((tmpvar_41.xy * tmpvar_19.x) + ((tmpvar_18.xy - tmpvar_19.yz) * tmpvar_41.w));
    tmpvar_42.z = (ph_z_5 * tmpvar_41.w);
    tmpvar_42.w = tmpvar_41.w;
    gl_Position = (uTransform * tmpvar_42);
    vi_local_pos_20 = tmpvar_39;
    vi_world_pos_21 = tmpvar_41;
  };
  highp vec2 stretch_size_43;
  vec2 local_rect_p0_44;
  vec2 local_rect_size_45;
  highp vec2 uv1_46;
  highp vec2 uv0_47;
  ivec2 tmpvar_48;
  tmpvar_48.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_48.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_49;
  tmpvar_49 = texelFetch (sGpuCache, (tmpvar_48 + ivec2(2, 0)), 0);
  vec2 tmpvar_50;
  tmpvar_50 = vec2(textureSize (sColor0, 0));
  ivec2 tmpvar_51;
  tmpvar_51.x = int((uint(instance_resource_address_4) % 1024u));
  tmpvar_51.y = int((uint(instance_resource_address_4) / 1024u));
  vec4 tmpvar_52;
  tmpvar_52 = texelFetch (sGpuCache, tmpvar_51, 0);
  uv0_47 = tmpvar_52.xy;
  uv1_46 = tmpvar_52.zw;
  local_rect_p0_44 = tmpvar_9;
  local_rect_size_45 = tmpvar_10;
  stretch_size_43 = tmpvar_49.xy;
  if ((tmpvar_49.x < 0.0)) {
    stretch_size_43 = tmpvar_10;
  };
  if (((tmpvar_26 & 2) != 0)) {
    local_rect_p0_44 = segment_rect_p0_22;
    local_rect_size_45 = segment_rect_size_23;
    stretch_size_43 = segment_rect_size_23;
    if (((tmpvar_26 & 128) != 0)) {
      vec2 tmpvar_53;
      tmpvar_53 = (tmpvar_52.zw - tmpvar_52.xy);
      uv0_47 = (tmpvar_52.xy + (segment_data_24.xy * tmpvar_53));
      uv1_46 = (tmpvar_52.xy + (segment_data_24.zw * tmpvar_53));
    };
    if (((tmpvar_26 & 128) != 0)) {
      highp vec2 vertical_uv_size_54;
      highp vec2 horizontal_uv_size_55;
      highp vec2 repeated_stretch_size_56;
      repeated_stretch_size_56 = segment_rect_size_23;
      vec2 tmpvar_57;
      tmpvar_57 = (uv1_46 - uv0_47);
      horizontal_uv_size_55 = tmpvar_57;
      vec2 tmpvar_58;
      tmpvar_58 = (uv1_46 - uv0_47);
      vertical_uv_size_54 = tmpvar_58;
      if (((tmpvar_26 & 64) != 0)) {
        repeated_stretch_size_56 = (segment_rect_p0_22 - tmpvar_7.xy);
        vertical_uv_size_54.x = (uv0_47.x - tmpvar_52.x);
        if (((vertical_uv_size_54.x < 0.001) || (repeated_stretch_size_56.x < 0.001))) {
          vertical_uv_size_54.x = (tmpvar_52.z - uv1_46.x);
          repeated_stretch_size_56.x = (((tmpvar_7.x + tmpvar_7.z) - segment_rect_p0_22.x) - segment_rect_size_23.x);
        };
        horizontal_uv_size_55.y = (uv0_47.y - tmpvar_52.y);
        if (((horizontal_uv_size_55.y < 0.001) || (repeated_stretch_size_56.y < 0.001))) {
          horizontal_uv_size_55.y = (tmpvar_52.w - uv1_46.y);
          repeated_stretch_size_56.y = (((tmpvar_7.y + tmpvar_7.w) - segment_rect_p0_22.y) - segment_rect_size_23.y);
        };
      };
      if (((tmpvar_26 & 4) != 0)) {
        stretch_size_43.x = (repeated_stretch_size_56.y * (tmpvar_57.x / horizontal_uv_size_55.y));
      };
      if (((tmpvar_26 & 8) != 0)) {
        stretch_size_43.y = (repeated_stretch_size_56.x * (tmpvar_58.y / vertical_uv_size_54.x));
      };
    } else {
      if (((tmpvar_26 & 4) != 0)) {
        stretch_size_43.x = (segment_data_24.z - segment_data_24.x);
      };
      if (((tmpvar_26 & 8) != 0)) {
        stretch_size_43.y = (segment_data_24.w - segment_data_24.y);
      };
    };
    if (((tmpvar_26 & 16) != 0)) {
      stretch_size_43.x = (segment_rect_size_23.x / max (1.0, roundEven(
        (segment_rect_size_23.x / stretch_size_43.x)
      )));
    };
    if (((tmpvar_26 & 32) != 0)) {
      stretch_size_43.y = (segment_rect_size_23.y / max (1.0, roundEven(
        (segment_rect_size_23.y / stretch_size_43.y)
      )));
    };
  };
  float tmpvar_59;
  if (((tmpvar_26 & 1) != 0)) {
    tmpvar_59 = 1.0;
  } else {
    tmpvar_59 = 0.0;
  };
  v_perspective = tmpvar_59;
  vec2 tmpvar_60;
  tmpvar_60 = min (uv0_47, uv1_46);
  vec2 tmpvar_61;
  tmpvar_61 = max (uv0_47, uv1_46);
  vec4 tmpvar_62;
  tmpvar_62.xy = (tmpvar_60 + vec2(0.5, 0.5));
  tmpvar_62.zw = (tmpvar_61 - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_62 / tmpvar_50.xyxy);
  v_uv = (mix (uv0_47, uv1_46, (
    (vi_local_pos_20 - local_rect_p0_44)
   / local_rect_size_45)) - tmpvar_60);
  v_uv = (v_uv / tmpvar_50);
  v_uv = (v_uv * (local_rect_size_45 / stretch_size_43));
  if ((tmpvar_59 == 0.0)) {
    v_uv = (v_uv * vi_world_pos_21.w);
  };
  vec4 tmpvar_63;
  tmpvar_63.xy = tmpvar_60;
  tmpvar_63.zw = tmpvar_61;
  v_uv_bounds = (tmpvar_63 / tmpvar_50.xyxy);
  v_uv = (v_uv / (v_uv_bounds.zw - v_uv_bounds.xy));
  v_local_pos = vi_local_pos_20;
}


#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sColor1;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
out highp vec2 v_src_uv;
flat out highp vec4 v_src_uv_sample_bounds;
out highp vec2 v_backdrop_uv;
flat out highp vec4 v_backdrop_uv_sample_bounds;
flat out highp float v_perspective;
flat out highp int v_op;
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
  vec2 tmpvar_42;
  tmpvar_42 = ((vi_local_pos_20 - tmpvar_6.xy) / tmpvar_6.zw);
  float tmpvar_43;
  if (((tmpvar_25 & 1) != 0)) {
    tmpvar_43 = 1.0;
  } else {
    tmpvar_43 = 0.0;
  };
  v_perspective = tmpvar_43;
  v_op = tmpvar_12.x;
  highp vec2 inv_texture_size_44;
  ivec2 tmpvar_45;
  tmpvar_45.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_45.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_46;
  tmpvar_46 = texelFetch (sGpuCache, tmpvar_45, 0);
  inv_texture_size_44 = (1.0/(vec2(textureSize (sColor0, 0))));
  highp int tmpvar_47;
  tmpvar_47 = (tmpvar_12.y + 2);
  ivec2 tmpvar_48;
  tmpvar_48.x = int((uint(tmpvar_47) % 1024u));
  tmpvar_48.y = int((uint(tmpvar_47) / 1024u));
  vec4 tmpvar_49;
  tmpvar_49 = mix (mix (texelFetch (sGpuCache, tmpvar_48, 0), texelFetch (sGpuCache, (tmpvar_48 + ivec2(1, 0)), 0), tmpvar_42.x), mix (texelFetch (sGpuCache, (tmpvar_48 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_48 + ivec2(3, 0)), 0), tmpvar_42.x), tmpvar_42.y);
  vec4 tmpvar_50;
  tmpvar_50.xy = (tmpvar_46.xy + vec2(0.5, 0.5));
  tmpvar_50.zw = (tmpvar_46.zw - vec2(0.5, 0.5));
  v_backdrop_uv = (mix (tmpvar_46.xy, tmpvar_46.zw, (tmpvar_49.xy / tmpvar_49.w)) * inv_texture_size_44);
  v_backdrop_uv_sample_bounds = (tmpvar_50 * inv_texture_size_44.xyxy);
  highp vec2 inv_texture_size_51;
  ivec2 tmpvar_52;
  tmpvar_52.x = int((uint(tmpvar_12.z) % 1024u));
  tmpvar_52.y = int((uint(tmpvar_12.z) / 1024u));
  vec4 tmpvar_53;
  tmpvar_53 = texelFetch (sGpuCache, tmpvar_52, 0);
  inv_texture_size_51 = (1.0/(vec2(textureSize (sColor1, 0))));
  highp int tmpvar_54;
  tmpvar_54 = (tmpvar_12.z + 2);
  ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(tmpvar_54) % 1024u));
  tmpvar_55.y = int((uint(tmpvar_54) / 1024u));
  vec4 tmpvar_56;
  tmpvar_56 = mix (mix (texelFetch (sGpuCache, tmpvar_55, 0), texelFetch (sGpuCache, (tmpvar_55 + ivec2(1, 0)), 0), tmpvar_42.x), mix (texelFetch (sGpuCache, (tmpvar_55 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_55 + ivec2(3, 0)), 0), tmpvar_42.x), tmpvar_42.y);
  vec4 tmpvar_57;
  tmpvar_57.xy = (tmpvar_53.xy + vec2(0.5, 0.5));
  tmpvar_57.zw = (tmpvar_53.zw - vec2(0.5, 0.5));
  v_src_uv = ((mix (tmpvar_53.xy, tmpvar_53.zw, 
    (tmpvar_56.xy / tmpvar_56.w)
  ) * inv_texture_size_51) * mix (vi_world_pos_21.w, 1.0, tmpvar_43));
  v_src_uv_sample_bounds = (tmpvar_57 * inv_texture_size_51.xyxy);
}


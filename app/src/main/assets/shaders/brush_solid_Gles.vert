#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 v_color;
void main ()
{
  int instance_picture_task_address_1;
  int instance_segment_index_2;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_segment_index_2 = (aData.z & 65535);
  float ph_z_3;
  ivec2 tmpvar_4;
  tmpvar_4.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_4.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetch (sPrimitiveHeadersF, tmpvar_4, 0);
  vec4 tmpvar_6;
  tmpvar_6 = texelFetch (sPrimitiveHeadersF, (tmpvar_4 + ivec2(1, 0)), 0);
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_7 = tmpvar_5.xy;
  tmpvar_8 = tmpvar_5.zw;
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_9.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_10;
  tmpvar_10 = texelFetch (sPrimitiveHeadersI, tmpvar_9, 0);
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetch (sPrimitiveHeadersI, (tmpvar_9 + ivec2(1, 0)), 0);
  ph_z_3 = float(tmpvar_10.x);
  mat4 transform_m_12;
  bool transform_is_axis_aligned_13;
  transform_is_axis_aligned_13 = ((tmpvar_10.z >> 24) == 0);
  int tmpvar_14;
  tmpvar_14 = (tmpvar_10.z & 16777215);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((8u * (
    uint(tmpvar_14)
   % 128u)));
  tmpvar_15.y = int((uint(tmpvar_14) / 128u));
  transform_m_12[0] = texelFetch (sTransformPalette, tmpvar_15, 0);
  transform_m_12[1] = texelFetch (sTransformPalette, (tmpvar_15 + ivec2(1, 0)), 0);
  transform_m_12[2] = texelFetch (sTransformPalette, (tmpvar_15 + ivec2(2, 0)), 0);
  transform_m_12[3] = texelFetch (sTransformPalette, (tmpvar_15 + ivec2(3, 0)), 0);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_16.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_17;
  tmpvar_17 = texelFetch (sRenderTasks, tmpvar_16, 0);
  vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sRenderTasks, (tmpvar_16 + ivec2(1, 0)), 0);
  vec2 segment_rect_p0_19;
  vec2 segment_rect_size_20;
  int tmpvar_21;
  tmpvar_21 = ((aData.z >> 16) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_19 = tmpvar_7;
    segment_rect_size_20 = tmpvar_8;
  } else {
    int tmpvar_22;
    tmpvar_22 = ((tmpvar_10.y + 1) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_23;
    tmpvar_23.x = int((uint(tmpvar_22) % 1024u));
    tmpvar_23.y = int((uint(tmpvar_22) / 1024u));
    vec4 tmpvar_24;
    tmpvar_24 = texelFetch (sGpuCache, tmpvar_23, 0);
    segment_rect_size_20 = tmpvar_24.zw;
    segment_rect_p0_19 = (tmpvar_24.xy + tmpvar_5.xy);
  };
  if (transform_is_axis_aligned_13) {
    vec4 tmpvar_25;
    tmpvar_25.zw = vec2(0.0, 1.0);
    tmpvar_25.xy = min (max ((segment_rect_p0_19 + 
      (segment_rect_size_20 * aPosition)
    ), tmpvar_6.xy), (tmpvar_6.xy + tmpvar_6.zw));
    vec4 tmpvar_26;
    tmpvar_26 = (transform_m_12 * tmpvar_25);
    vec4 tmpvar_27;
    tmpvar_27.xy = ((tmpvar_26.xy * tmpvar_18.x) + ((
      -(tmpvar_18.yz)
     + tmpvar_17.xy) * tmpvar_26.w));
    tmpvar_27.z = (ph_z_3 * tmpvar_26.w);
    tmpvar_27.w = tmpvar_26.w;
    gl_Position = (uTransform * tmpvar_27);
  } else {
    vec2 result_p1_28;
    result_p1_28 = (tmpvar_6.xy + tmpvar_6.zw);
    bvec4 tmpvar_29;
    tmpvar_29 = notEqual ((tmpvar_21 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0));
    vec4 tmpvar_30;
    tmpvar_30.xy = min (max (tmpvar_5.xy, tmpvar_6.xy), result_p1_28);
    tmpvar_30.zw = min (max ((tmpvar_5.xy + tmpvar_5.zw), tmpvar_6.xy), result_p1_28);
    vec4 tmpvar_31;
    tmpvar_31.xy = min (max (segment_rect_p0_19, tmpvar_6.xy), result_p1_28);
    tmpvar_31.zw = min (max ((segment_rect_p0_19 + segment_rect_size_20), tmpvar_6.xy), result_p1_28);
    vTransformBounds = mix(tmpvar_30, tmpvar_31, bvec4(tmpvar_29));
    vec4 tmpvar_32;
    tmpvar_32 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_29));
    vec4 tmpvar_33;
    tmpvar_33.zw = vec2(0.0, 1.0);
    tmpvar_33.xy = ((segment_rect_p0_19 - tmpvar_32.xy) + ((segment_rect_size_20 + 
      (tmpvar_32.xy + tmpvar_32.zw)
    ) * aPosition));
    vec4 tmpvar_34;
    tmpvar_34 = (transform_m_12 * tmpvar_33);
    vec4 tmpvar_35;
    tmpvar_35.xy = ((tmpvar_34.xy * tmpvar_18.x) + ((tmpvar_17.xy - tmpvar_18.yz) * tmpvar_34.w));
    tmpvar_35.z = (ph_z_3 * tmpvar_34.w);
    tmpvar_35.w = tmpvar_34.w;
    gl_Position = (uTransform * tmpvar_35);
  };
  ivec2 tmpvar_36;
  tmpvar_36.x = int((uint(tmpvar_10.y) % 1024u));
  tmpvar_36.y = int((uint(tmpvar_10.y) / 1024u));
  v_color = (texelFetch (sGpuCache, tmpvar_36, 0) * (float(tmpvar_11.x) / 65535.0));
}


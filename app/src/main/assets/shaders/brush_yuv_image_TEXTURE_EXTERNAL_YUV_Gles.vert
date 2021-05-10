#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp samplerExternalOES sColor0;
uniform lowp samplerExternalOES sColor1;
uniform lowp samplerExternalOES sColor2;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
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
  vec2 vi_local_pos_19;
  vec2 segment_rect_p0_20;
  vec2 segment_rect_size_21;
  int tmpvar_22;
  tmpvar_22 = ((aData.z >> 16) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_20 = tmpvar_7;
    segment_rect_size_21 = tmpvar_8;
  } else {
    int tmpvar_23;
    tmpvar_23 = ((tmpvar_10.y + 1) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_24;
    tmpvar_24.x = int((uint(tmpvar_23) % 1024u));
    tmpvar_24.y = int((uint(tmpvar_23) / 1024u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sGpuCache, tmpvar_24, 0);
    segment_rect_size_21 = tmpvar_25.zw;
    segment_rect_p0_20 = (tmpvar_25.xy + tmpvar_5.xy);
  };
  if (transform_is_axis_aligned_13) {
    vec2 tmpvar_26;
    tmpvar_26 = min (max ((segment_rect_p0_20 + 
      (segment_rect_size_21 * aPosition)
    ), tmpvar_6.xy), (tmpvar_6.xy + tmpvar_6.zw));
    vec4 tmpvar_27;
    tmpvar_27.zw = vec2(0.0, 1.0);
    tmpvar_27.xy = tmpvar_26;
    vec4 tmpvar_28;
    tmpvar_28 = (transform_m_12 * tmpvar_27);
    vec4 tmpvar_29;
    tmpvar_29.xy = ((tmpvar_28.xy * tmpvar_18.x) + ((
      -(tmpvar_18.yz)
     + tmpvar_17.xy) * tmpvar_28.w));
    tmpvar_29.z = (ph_z_3 * tmpvar_28.w);
    tmpvar_29.w = tmpvar_28.w;
    gl_Position = (uTransform * tmpvar_29);
    vi_local_pos_19 = tmpvar_26;
  } else {
    vec2 result_p1_30;
    result_p1_30 = (tmpvar_6.xy + tmpvar_6.zw);
    bvec4 tmpvar_31;
    tmpvar_31 = notEqual ((tmpvar_22 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0));
    vec4 tmpvar_32;
    tmpvar_32.xy = min (max (tmpvar_5.xy, tmpvar_6.xy), result_p1_30);
    tmpvar_32.zw = min (max ((tmpvar_5.xy + tmpvar_5.zw), tmpvar_6.xy), result_p1_30);
    vec4 tmpvar_33;
    tmpvar_33.xy = min (max (segment_rect_p0_20, tmpvar_6.xy), result_p1_30);
    tmpvar_33.zw = min (max ((segment_rect_p0_20 + segment_rect_size_21), tmpvar_6.xy), result_p1_30);
    vTransformBounds = mix(tmpvar_32, tmpvar_33, bvec4(tmpvar_31));
    vec4 tmpvar_34;
    tmpvar_34 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_31));
    vec2 tmpvar_35;
    tmpvar_35 = ((segment_rect_p0_20 - tmpvar_34.xy) + ((segment_rect_size_21 + 
      (tmpvar_34.xy + tmpvar_34.zw)
    ) * aPosition));
    vec4 tmpvar_36;
    tmpvar_36.zw = vec2(0.0, 1.0);
    tmpvar_36.xy = tmpvar_35;
    vec4 tmpvar_37;
    tmpvar_37 = (transform_m_12 * tmpvar_36);
    vec4 tmpvar_38;
    tmpvar_38.xy = ((tmpvar_37.xy * tmpvar_18.x) + ((tmpvar_17.xy - tmpvar_18.yz) * tmpvar_37.w));
    tmpvar_38.z = (ph_z_3 * tmpvar_37.w);
    tmpvar_38.w = tmpvar_37.w;
    gl_Position = (uTransform * tmpvar_38);
    vi_local_pos_19 = tmpvar_35;
  };
  int prim_yuv_format_39;
  highp vec2 f_40;
  f_40 = ((vi_local_pos_19 - tmpvar_5.xy) / tmpvar_5.zw);
  ivec2 tmpvar_41;
  tmpvar_41.x = int((uint(tmpvar_10.y) % 1024u));
  tmpvar_41.y = int((uint(tmpvar_10.y) / 1024u));
  vec4 tmpvar_42;
  tmpvar_42 = texelFetch (sGpuCache, tmpvar_41, 0);
  int tmpvar_43;
  tmpvar_43 = int(tmpvar_42.y);
  prim_yuv_format_39 = int(tmpvar_42.z);
  vYuvOffsetVector_Coefficient.w = tmpvar_42.x;
  mat3 tmpvar_44;
  if ((tmpvar_43 == 0)) {
    tmpvar_44 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((tmpvar_43 == 1)) {
      tmpvar_44 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      if ((tmpvar_43 == 3)) {
        tmpvar_44 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
      } else {
        tmpvar_44 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
      };
    };
  };
  vYuvColorMatrix = tmpvar_44;
  vec3 tmpvar_45;
  if ((tmpvar_43 == 3)) {
    tmpvar_45 = vec3(0.0, 0.0, 0.0);
  } else {
    tmpvar_45 = vec3(0.06275, 0.50196, 0.50196);
  };
  vYuvOffsetVector_Coefficient.xyz = tmpvar_45;
  vFormat = prim_yuv_format_39;
  if ((prim_yuv_format_39 == 1)) {
    ivec2 tmpvar_46;
    tmpvar_46.x = int((uint(tmpvar_11.x) % 1024u));
    tmpvar_46.y = int((uint(tmpvar_11.x) / 1024u));
    vec4 tmpvar_47;
    tmpvar_47 = texelFetch (sGpuCache, tmpvar_46, 0);
    ivec2 tmpvar_48;
    tmpvar_48.x = int((uint(tmpvar_11.y) % 1024u));
    tmpvar_48.y = int((uint(tmpvar_11.y) / 1024u));
    vec4 tmpvar_49;
    tmpvar_49 = texelFetch (sGpuCache, tmpvar_48, 0);
    ivec2 tmpvar_50;
    tmpvar_50.x = int((uint(tmpvar_11.z) % 1024u));
    tmpvar_50.y = int((uint(tmpvar_11.z) / 1024u));
    vec4 tmpvar_51;
    tmpvar_51 = texelFetch (sGpuCache, tmpvar_50, 0);
    vec2 tmpvar_52;
    tmpvar_52 = vec2(textureSize (sColor0, 0));
    vec4 tmpvar_53;
    tmpvar_53.xy = (tmpvar_47.xy + vec2(0.5, 0.5));
    tmpvar_53.zw = (tmpvar_47.zw - vec2(0.5, 0.5));
    vUv_Y = (mix (tmpvar_47.xy, tmpvar_47.zw, f_40) / tmpvar_52);
    vUvBounds_Y = (tmpvar_53 / tmpvar_52.xyxy);
    vec2 tmpvar_54;
    tmpvar_54 = vec2(textureSize (sColor1, 0));
    vec4 tmpvar_55;
    tmpvar_55.xy = (tmpvar_49.xy + vec2(0.5, 0.5));
    tmpvar_55.zw = (tmpvar_49.zw - vec2(0.5, 0.5));
    vUv_U = (mix (tmpvar_49.xy, tmpvar_49.zw, f_40) / tmpvar_54);
    vUvBounds_U = (tmpvar_55 / tmpvar_54.xyxy);
    vec2 tmpvar_56;
    tmpvar_56 = vec2(textureSize (sColor2, 0));
    vec4 tmpvar_57;
    tmpvar_57.xy = (tmpvar_51.xy + vec2(0.5, 0.5));
    tmpvar_57.zw = (tmpvar_51.zw - vec2(0.5, 0.5));
    vUv_V = (mix (tmpvar_51.xy, tmpvar_51.zw, f_40) / tmpvar_56);
    vUvBounds_V = (tmpvar_57 / tmpvar_56.xyxy);
  } else {
    if ((prim_yuv_format_39 == 0)) {
      ivec2 tmpvar_58;
      tmpvar_58.x = int((uint(tmpvar_11.x) % 1024u));
      tmpvar_58.y = int((uint(tmpvar_11.x) / 1024u));
      vec4 tmpvar_59;
      tmpvar_59 = texelFetch (sGpuCache, tmpvar_58, 0);
      ivec2 tmpvar_60;
      tmpvar_60.x = int((uint(tmpvar_11.y) % 1024u));
      tmpvar_60.y = int((uint(tmpvar_11.y) / 1024u));
      vec4 tmpvar_61;
      tmpvar_61 = texelFetch (sGpuCache, tmpvar_60, 0);
      vec2 tmpvar_62;
      tmpvar_62 = vec2(textureSize (sColor0, 0));
      vec4 tmpvar_63;
      tmpvar_63.xy = (tmpvar_59.xy + vec2(0.5, 0.5));
      tmpvar_63.zw = (tmpvar_59.zw - vec2(0.5, 0.5));
      vUv_Y = (mix (tmpvar_59.xy, tmpvar_59.zw, f_40) / tmpvar_62);
      vUvBounds_Y = (tmpvar_63 / tmpvar_62.xyxy);
      vec2 tmpvar_64;
      tmpvar_64 = vec2(textureSize (sColor1, 0));
      vec4 tmpvar_65;
      tmpvar_65.xy = (tmpvar_61.xy + vec2(0.5, 0.5));
      tmpvar_65.zw = (tmpvar_61.zw - vec2(0.5, 0.5));
      vUv_U = (mix (tmpvar_61.xy, tmpvar_61.zw, f_40) / tmpvar_64);
      vUvBounds_U = (tmpvar_65 / tmpvar_64.xyxy);
    } else {
      if ((prim_yuv_format_39 == 2)) {
        ivec2 tmpvar_66;
        tmpvar_66.x = int((uint(tmpvar_11.x) % 1024u));
        tmpvar_66.y = int((uint(tmpvar_11.x) / 1024u));
        vec4 tmpvar_67;
        tmpvar_67 = texelFetch (sGpuCache, tmpvar_66, 0);
        vec2 tmpvar_68;
        tmpvar_68 = vec2(textureSize (sColor0, 0));
        vec4 tmpvar_69;
        tmpvar_69.xy = (tmpvar_67.xy + vec2(0.5, 0.5));
        tmpvar_69.zw = (tmpvar_67.zw - vec2(0.5, 0.5));
        vUv_Y = (mix (tmpvar_67.xy, tmpvar_67.zw, f_40) / tmpvar_68);
        vUvBounds_Y = (tmpvar_69 / tmpvar_68.xyxy);
      };
    };
  };
}


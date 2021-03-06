#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
in highp vec4 aClipDeviceArea;
in highp vec4 aClipOrigins;
in highp float aDevicePixelScale;
in highp ivec2 aTransformIds;
out highp vec4 vLocalPos;
flat out highp vec3 vClipParams;
flat out highp float vClipMode;
in highp vec2 aClipLocalPos;
in highp vec4 aClipLocalRect;
in highp float aClipMode;
in highp vec4 aClipRadii_TL;
void main ()
{
  mat4 transform_m_1;
  mat4 transform_inv_m_2;
  int tmpvar_3;
  tmpvar_3 = (aTransformIds.x & 16777215);
  ivec2 tmpvar_4;
  tmpvar_4.x = int((8u * (
    uint(tmpvar_3)
   % 128u)));
  tmpvar_4.y = int((uint(tmpvar_3) / 128u));
  transform_m_1[0] = texelFetch (sTransformPalette, tmpvar_4, 0);
  transform_m_1[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(1, 0)), 0);
  transform_m_1[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(2, 0)), 0);
  transform_m_1[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(3, 0)), 0);
  transform_inv_m_2[0] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(4, 0)), 0);
  transform_inv_m_2[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(5, 0)), 0);
  transform_inv_m_2[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(6, 0)), 0);
  transform_inv_m_2[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(7, 0)), 0);
  mat4 transform_m_5;
  int tmpvar_6;
  tmpvar_6 = (aTransformIds.y & 16777215);
  ivec2 tmpvar_7;
  tmpvar_7.x = int((8u * (
    uint(tmpvar_6)
   % 128u)));
  tmpvar_7.y = int((uint(tmpvar_6) / 128u));
  transform_m_5[0] = texelFetch (sTransformPalette, tmpvar_7, 0);
  transform_m_5[1] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(1, 0)), 0);
  transform_m_5[2] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(2, 0)), 0);
  transform_m_5[3] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(3, 0)), 0);
  highp vec4 pos_8;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 1.0);
  tmpvar_9.xy = ((aClipOrigins.zw + mix (aClipDeviceArea.xy, aClipDeviceArea.zw, aPosition)) / aDevicePixelScale);
  vec4 tmpvar_10;
  tmpvar_10 = (transform_m_5 * tmpvar_9);
  pos_8.w = tmpvar_10.w;
  pos_8.xyz = (tmpvar_10.xyz / tmpvar_10.w);
  highp vec2 tmpvar_11;
  tmpvar_11 = pos_8.xy;
  vec4 tmpvar_12;
  tmpvar_12 = (transform_m_1 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_13;
  vec3 tmpvar_14;
  vec3 tmpvar_15;
  tmpvar_13 = transform_inv_m_2[uint(0)].xyz;
  tmpvar_14 = transform_inv_m_2[1u].xyz;
  tmpvar_15 = transform_inv_m_2[2u].xyz;
  mat3 tmpvar_16;
  tmpvar_16[0].x = tmpvar_13.x;
  tmpvar_16[1].x = tmpvar_13.y;
  tmpvar_16[2].x = tmpvar_13.z;
  tmpvar_16[0].y = tmpvar_14.x;
  tmpvar_16[1].y = tmpvar_14.y;
  tmpvar_16[2].y = tmpvar_14.z;
  tmpvar_16[0].z = tmpvar_15.x;
  tmpvar_16[1].z = tmpvar_15.y;
  tmpvar_16[2].z = tmpvar_15.z;
  vec3 tmpvar_17;
  tmpvar_17.z = -10000.0;
  tmpvar_17.xy = tmpvar_11;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * vec3(0.0, 0.0, 1.0));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_12.xyz / tmpvar_12.w);
  highp float tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = dot (tmpvar_18, vec3(0.0, 0.0, 1.0));
  float tmpvar_22;
  tmpvar_22 = abs(tmpvar_21);
  if ((1e-06 < tmpvar_22)) {
    tmpvar_20 = (dot ((tmpvar_19 - tmpvar_17), tmpvar_18) / tmpvar_21);
  };
  vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xy = tmpvar_11;
  tmpvar_23.z = (-10000.0 + tmpvar_20);
  vec4 tmpvar_24;
  tmpvar_24 = ((transform_inv_m_2 * tmpvar_23) * tmpvar_10.w);
  vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 1.0);
  tmpvar_25.xy = (aClipOrigins.xy + mix (aClipDeviceArea.xy, aClipDeviceArea.zw, aPosition));
  gl_Position = (uTransform * tmpvar_25);
  vec4 tmpvar_26;
  tmpvar_26.xy = aClipLocalPos;
  tmpvar_26.zw = (aClipLocalPos + aClipLocalRect.zw);
  vTransformBounds = tmpvar_26;
  vClipMode = aClipMode;
  vLocalPos.zw = tmpvar_24.zw;
  vec2 tmpvar_27;
  tmpvar_27 = (0.5 * aClipLocalRect.zw);
  vLocalPos.xy = (tmpvar_24.xy - ((tmpvar_27 + aClipLocalPos) * tmpvar_24.w));
  vec3 tmpvar_28;
  tmpvar_28.xy = (tmpvar_27 - aClipRadii_TL.xx);
  tmpvar_28.z = aClipRadii_TL.x;
  vClipParams = tmpvar_28;
}


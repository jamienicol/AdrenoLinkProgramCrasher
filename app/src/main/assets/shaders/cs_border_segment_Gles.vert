#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp vec4 vColor00;
flat out highp vec4 vColor01;
flat out highp vec4 vColor10;
flat out highp vec4 vColor11;
flat out highp vec4 vColorLine;
flat out mediump ivec4 vConfig;
flat out highp vec4 vClipCenter_Sign;
flat out highp vec4 vClipRadii;
flat out highp vec4 vEdgeReference;
flat out highp vec4 vPartialWidths;
flat out highp vec4 vClipParams1;
flat out highp vec4 vClipParams2;
out highp vec2 vPos;
in highp vec2 aTaskOrigin;
in highp vec4 aRect;
in highp vec4 aColor0;
in highp vec4 aColor1;
in highp int aFlags;
in highp vec2 aWidths;
in highp vec2 aRadii;
in highp vec4 aClipParams1;
in highp vec4 aClipParams2;
void main ()
{
  highp vec2 edge_reference_1;
  highp ivec2 edge_axis_2;
  highp vec2 clip_sign_3;
  int tmpvar_4;
  tmpvar_4 = (aFlags & 255);
  int tmpvar_5;
  tmpvar_5 = ((aFlags >> 8) & 255);
  int tmpvar_6;
  tmpvar_6 = ((aFlags >> 16) & 255);
  int tmpvar_7;
  tmpvar_7 = ((aFlags >> 24) & 15);
  vec2 tmpvar_8;
  tmpvar_8 = (aRect.zw - aRect.xy);
  highp vec2 p_9;
  bool tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = bool(0);
  tmpvar_10 = (0 == tmpvar_4);
  if (tmpvar_10) {
    p_9 = vec2(0.0, 0.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (1 == tmpvar_4));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    p_9 = vec2(1.0, 0.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (2 == tmpvar_4));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    p_9 = vec2(1.0, 1.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (3 == tmpvar_4));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    p_9 = vec2(0.0, 1.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = !(tmpvar_11);
  if (tmpvar_10) {
    p_9 = vec2(0.0, 0.0);
    tmpvar_11 = bool(1);
  };
  vec2 tmpvar_12;
  tmpvar_12 = (p_9 * tmpvar_8);
  clip_sign_3 = (1.0 - (2.0 * p_9));
  edge_axis_2 = ivec2(0, 0);
  edge_reference_1 = vec2(0.0, 0.0);
  bool tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = bool(0);
  tmpvar_13 = (0 == tmpvar_4);
  if (tmpvar_13) {
    edge_axis_2 = ivec2(0, 1);
    edge_reference_1 = tmpvar_12;
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (1 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(1, 0);
    vec2 tmpvar_15;
    tmpvar_15.x = (tmpvar_12.x - aWidths.x);
    tmpvar_15.y = tmpvar_12.y;
    edge_reference_1 = tmpvar_15;
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (2 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(0, 1);
    edge_reference_1 = (tmpvar_12 - aWidths);
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (3 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(1, 0);
    vec2 tmpvar_16;
    tmpvar_16.x = tmpvar_12.x;
    tmpvar_16.y = (tmpvar_12.y - aWidths.y);
    edge_reference_1 = tmpvar_16;
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (5 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 || (7 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(1, 1);
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = !(tmpvar_14);
  if (tmpvar_13) {
    tmpvar_14 = bool(1);
  };
  ivec4 tmpvar_17;
  tmpvar_17.x = tmpvar_4;
  tmpvar_17.y = (tmpvar_5 | (tmpvar_6 << 8));
  tmpvar_17.z = (edge_axis_2.x | (edge_axis_2.y << 8));
  tmpvar_17.w = tmpvar_7;
  vConfig = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18.xy = (aWidths / 3.0);
  tmpvar_18.zw = (aWidths / 2.0);
  vPartialWidths = tmpvar_18;
  vPos = (tmpvar_8 * aPosition);
  vec4 tmpvar_19;
  vec4 tmpvar_20;
  bool tmpvar_21;
  tmpvar_21 = (aColor0.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_22;
  bool tmpvar_23;
  tmpvar_23 = bool(0);
  tmpvar_22 = (6 == tmpvar_5);
  if (tmpvar_22) {
    vec4 tmpvar_24;
    if (tmpvar_21) {
      vec4 tmpvar_25;
      tmpvar_25.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_25.w = aColor0.w;
      tmpvar_24 = tmpvar_25;
    } else {
      vec4 tmpvar_26;
      tmpvar_26.xyz = aColor0.xyz;
      tmpvar_26.w = aColor0.w;
      tmpvar_24 = tmpvar_26;
    };
    tmpvar_19 = tmpvar_24;
    vec4 tmpvar_27;
    if (tmpvar_21) {
      vec4 tmpvar_28;
      tmpvar_28.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_28.w = aColor0.w;
      tmpvar_27 = tmpvar_28;
    } else {
      vec4 tmpvar_29;
      tmpvar_29.xyz = (aColor0.xyz * 0.6666667);
      tmpvar_29.w = aColor0.w;
      tmpvar_27 = tmpvar_29;
    };
    tmpvar_20 = tmpvar_27;
    tmpvar_23 = bool(1);
  };
  tmpvar_22 = (tmpvar_22 || (7 == tmpvar_5));
  tmpvar_22 = (tmpvar_22 && !(tmpvar_23));
  if (tmpvar_22) {
    vec4 tmpvar_30;
    if (tmpvar_21) {
      vec4 tmpvar_31;
      tmpvar_31.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_31.w = aColor0.w;
      tmpvar_30 = tmpvar_31;
    } else {
      vec4 tmpvar_32;
      tmpvar_32.xyz = (aColor0.xyz * 0.6666667);
      tmpvar_32.w = aColor0.w;
      tmpvar_30 = tmpvar_32;
    };
    tmpvar_19 = tmpvar_30;
    vec4 tmpvar_33;
    if (tmpvar_21) {
      vec4 tmpvar_34;
      tmpvar_34.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_34.w = aColor0.w;
      tmpvar_33 = tmpvar_34;
    } else {
      vec4 tmpvar_35;
      tmpvar_35.xyz = aColor0.xyz;
      tmpvar_35.w = aColor0.w;
      tmpvar_33 = tmpvar_35;
    };
    tmpvar_20 = tmpvar_33;
    tmpvar_23 = bool(1);
  };
  tmpvar_22 = !(tmpvar_23);
  if (tmpvar_22) {
    tmpvar_19 = aColor0;
    tmpvar_20 = aColor0;
    tmpvar_23 = bool(1);
  };
  vColor00 = tmpvar_19;
  vColor01 = tmpvar_20;
  vec4 tmpvar_36;
  vec4 tmpvar_37;
  bool tmpvar_38;
  tmpvar_38 = (aColor1.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_39;
  bool tmpvar_40;
  tmpvar_40 = bool(0);
  tmpvar_39 = (6 == tmpvar_6);
  if (tmpvar_39) {
    vec4 tmpvar_41;
    if (tmpvar_38) {
      vec4 tmpvar_42;
      tmpvar_42.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_42.w = aColor1.w;
      tmpvar_41 = tmpvar_42;
    } else {
      vec4 tmpvar_43;
      tmpvar_43.xyz = aColor1.xyz;
      tmpvar_43.w = aColor1.w;
      tmpvar_41 = tmpvar_43;
    };
    tmpvar_36 = tmpvar_41;
    vec4 tmpvar_44;
    if (tmpvar_38) {
      vec4 tmpvar_45;
      tmpvar_45.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_45.w = aColor1.w;
      tmpvar_44 = tmpvar_45;
    } else {
      vec4 tmpvar_46;
      tmpvar_46.xyz = (aColor1.xyz * 0.6666667);
      tmpvar_46.w = aColor1.w;
      tmpvar_44 = tmpvar_46;
    };
    tmpvar_37 = tmpvar_44;
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = (tmpvar_39 || (7 == tmpvar_6));
  tmpvar_39 = (tmpvar_39 && !(tmpvar_40));
  if (tmpvar_39) {
    vec4 tmpvar_47;
    if (tmpvar_38) {
      vec4 tmpvar_48;
      tmpvar_48.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_48.w = aColor1.w;
      tmpvar_47 = tmpvar_48;
    } else {
      vec4 tmpvar_49;
      tmpvar_49.xyz = (aColor1.xyz * 0.6666667);
      tmpvar_49.w = aColor1.w;
      tmpvar_47 = tmpvar_49;
    };
    tmpvar_36 = tmpvar_47;
    vec4 tmpvar_50;
    if (tmpvar_38) {
      vec4 tmpvar_51;
      tmpvar_51.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_51.w = aColor1.w;
      tmpvar_50 = tmpvar_51;
    } else {
      vec4 tmpvar_52;
      tmpvar_52.xyz = aColor1.xyz;
      tmpvar_52.w = aColor1.w;
      tmpvar_50 = tmpvar_52;
    };
    tmpvar_37 = tmpvar_50;
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = !(tmpvar_40);
  if (tmpvar_39) {
    tmpvar_36 = aColor1;
    tmpvar_37 = aColor1;
    tmpvar_40 = bool(1);
  };
  vColor10 = tmpvar_36;
  vColor11 = tmpvar_37;
  vec4 tmpvar_53;
  tmpvar_53.xy = (tmpvar_12 + (clip_sign_3 * aRadii));
  tmpvar_53.zw = clip_sign_3;
  vClipCenter_Sign = tmpvar_53;
  vec4 tmpvar_54;
  tmpvar_54.xy = aRadii;
  tmpvar_54.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_54;
  vec4 tmpvar_55;
  tmpvar_55.xy = tmpvar_12;
  tmpvar_55.z = (aWidths.y * -(clip_sign_3.y));
  tmpvar_55.w = (aWidths.x * clip_sign_3.x);
  vColorLine = tmpvar_55;
  vec4 tmpvar_56;
  tmpvar_56.xy = edge_reference_1;
  tmpvar_56.zw = (edge_reference_1 + aWidths);
  vEdgeReference = tmpvar_56;
  vClipParams1 = aClipParams1;
  vClipParams2 = aClipParams2;
  if ((tmpvar_7 == 3)) {
    highp float radius_57;
    radius_57 = aClipParams1.z;
    if ((0.5 < aClipParams1.z)) {
      radius_57 = (aClipParams1.z + 2.0);
    };
    vPos = (aClipParams1.xy + (radius_57 * (
      (2.0 * aPosition)
     - 1.0)));
    vPos = min (max (vPos, vec2(0.0, 0.0)), tmpvar_8);
  } else {
    if ((tmpvar_7 == 1)) {
      vec2 tmpvar_58;
      tmpvar_58 = ((aClipParams1.xy + aClipParams2.xy) * 0.5);
      vec2 tmpvar_59;
      tmpvar_59 = (aClipParams1.xy - aClipParams2.xy);
      vec2 tmpvar_60;
      tmpvar_60 = (vec2(max (sqrt(
        dot (tmpvar_59, tmpvar_59)
      ), max (aWidths.x, aWidths.y))) + 2.0);
      vPos = min (max (vPos, (tmpvar_58 - tmpvar_60)), (tmpvar_58 + tmpvar_60));
    };
  };
  vec4 tmpvar_61;
  tmpvar_61.zw = vec2(0.0, 1.0);
  tmpvar_61.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_61);
}


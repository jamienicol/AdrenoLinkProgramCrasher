#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform highp sampler2D sGpuCache;
flat in highp vec4 vTransformBounds;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_local_pos;
in highp vec2 v_uv;
flat in highp vec4 v_uv_sample_bounds;
flat in highp vec2 v_perspective_amount;
flat in mediump int v_op;
flat in mediump int v_table_address;
flat in highp mat4 v_color_mat;
flat in mediump ivec4 v_funcs;
flat in highp vec4 v_color_offset;
void main ()
{
  vec4 frag_color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture (sColor0, min (max ((v_uv * 
    mix (gl_FragCoord.w, 1.0, v_perspective_amount.x)
  ), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
  highp vec3 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  vec3 tmpvar_5;
  if ((tmpvar_2.w != 0.0)) {
    tmpvar_5 = (tmpvar_2.xyz / tmpvar_2.w);
  } else {
    tmpvar_5 = tmpvar_2.xyz;
  };
  tmpvar_3 = tmpvar_5;
  bool tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  tmpvar_6 = (0 == v_op);
  if (tmpvar_6) {
    tmpvar_3 = min (max ((
      ((tmpvar_5 * v_perspective_amount.y) - (0.5 * v_perspective_amount.y))
     + 0.5), 0.0), 1.0);
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (3 == v_op));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = mix (tmpvar_3, (vec3(1.0, 1.0, 1.0) - tmpvar_3), v_perspective_amount.y);
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (6 == v_op));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = min (max ((tmpvar_3 * v_perspective_amount.y), 0.0), 1.0);
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (8 == v_op));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = mix(pow ((
      (tmpvar_3 / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (tmpvar_3 / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), tmpvar_3)));
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (9 == v_op));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (tmpvar_3, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (tmpvar_3 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), tmpvar_3)));
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (11 == v_op));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    vec4 tmpvar_8;
    tmpvar_8.xyz = tmpvar_3;
    tmpvar_8.w = tmpvar_4;
    highp vec4 tmpvar_9;
    tmpvar_9 = tmpvar_8;
    mediump int k_10;
    mediump int offset_11;
    offset_11 = 0;
    bool tmpvar_12;
    bool tmpvar_13;
    tmpvar_13 = bool(0);
    tmpvar_12 = (0 == v_funcs.x);
    if (tmpvar_12) {
      tmpvar_13 = bool(1);
    };
    tmpvar_12 = (tmpvar_12 || (1 == v_funcs.x));
    tmpvar_12 = (tmpvar_12 || (2 == v_funcs.x));
    tmpvar_12 = (tmpvar_12 && !(tmpvar_13));
    if (tmpvar_12) {
      k_10 = int(floor((tmpvar_8[0] * 255.0)));
      highp int tmpvar_14;
      tmpvar_14 = (v_table_address + (k_10 / 4));
      ivec2 tmpvar_15;
      tmpvar_15.x = int((uint(tmpvar_14) % 1024u));
      tmpvar_15.y = int((uint(tmpvar_14) / 1024u));
      vec4 tmpvar_16;
      tmpvar_16 = texelFetch (sGpuCache, tmpvar_15, 0);
      tmpvar_9[0] = min (max (tmpvar_16[(k_10 % 4)], 0.0), 1.0);
      offset_11 = 64;
      tmpvar_13 = bool(1);
    };
    tmpvar_12 = (tmpvar_12 || (3 == v_funcs.x));
    tmpvar_12 = (tmpvar_12 && !(tmpvar_13));
    if (tmpvar_12) {
      highp int tmpvar_17;
      tmpvar_17 = (v_table_address + offset_11);
      ivec2 tmpvar_18;
      tmpvar_18.x = int((uint(tmpvar_17) % 1024u));
      tmpvar_18.y = int((uint(tmpvar_17) / 1024u));
      vec4 tmpvar_19;
      tmpvar_19 = texelFetch (sGpuCache, tmpvar_18, 0);
      tmpvar_9[0] = min (max ((
        (tmpvar_19[0] * tmpvar_9[0])
       + tmpvar_19[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_13 = bool(1);
    };
    tmpvar_12 = (tmpvar_12 || (4 == v_funcs.x));
    tmpvar_12 = (tmpvar_12 && !(tmpvar_13));
    if (tmpvar_12) {
      highp int tmpvar_20;
      tmpvar_20 = (v_table_address + offset_11);
      ivec2 tmpvar_21;
      tmpvar_21.x = int((uint(tmpvar_20) % 1024u));
      tmpvar_21.y = int((uint(tmpvar_20) / 1024u));
      vec4 tmpvar_22;
      tmpvar_22 = texelFetch (sGpuCache, tmpvar_21, 0);
      tmpvar_9[0] = min (max ((
        (tmpvar_22[0] * pow (tmpvar_9[0], tmpvar_22[1]))
       + tmpvar_22[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_13 = bool(1);
    };
    tmpvar_12 = !(tmpvar_13);
    if (tmpvar_12) {
      tmpvar_13 = bool(1);
    };
    bool tmpvar_23;
    bool tmpvar_24;
    tmpvar_24 = bool(0);
    tmpvar_23 = (0 == v_funcs.y);
    if (tmpvar_23) {
      tmpvar_24 = bool(1);
    };
    tmpvar_23 = (tmpvar_23 || (1 == v_funcs.y));
    tmpvar_23 = (tmpvar_23 || (2 == v_funcs.y));
    tmpvar_23 = (tmpvar_23 && !(tmpvar_24));
    if (tmpvar_23) {
      k_10 = int(floor((tmpvar_9[1] * 255.0)));
      highp int tmpvar_25;
      tmpvar_25 = ((v_table_address + offset_11) + (k_10 / 4));
      ivec2 tmpvar_26;
      tmpvar_26.x = int((uint(tmpvar_25) % 1024u));
      tmpvar_26.y = int((uint(tmpvar_25) / 1024u));
      vec4 tmpvar_27;
      tmpvar_27 = texelFetch (sGpuCache, tmpvar_26, 0);
      tmpvar_9[1] = min (max (tmpvar_27[(k_10 % 4)], 0.0), 1.0);
      offset_11 += 64;
      tmpvar_24 = bool(1);
    };
    tmpvar_23 = (tmpvar_23 || (3 == v_funcs.y));
    tmpvar_23 = (tmpvar_23 && !(tmpvar_24));
    if (tmpvar_23) {
      highp int tmpvar_28;
      tmpvar_28 = (v_table_address + offset_11);
      ivec2 tmpvar_29;
      tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
      tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
      vec4 tmpvar_30;
      tmpvar_30 = texelFetch (sGpuCache, tmpvar_29, 0);
      tmpvar_9[1] = min (max ((
        (tmpvar_30[0] * tmpvar_9[1])
       + tmpvar_30[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_24 = bool(1);
    };
    tmpvar_23 = (tmpvar_23 || (4 == v_funcs.y));
    tmpvar_23 = (tmpvar_23 && !(tmpvar_24));
    if (tmpvar_23) {
      highp int tmpvar_31;
      tmpvar_31 = (v_table_address + offset_11);
      ivec2 tmpvar_32;
      tmpvar_32.x = int((uint(tmpvar_31) % 1024u));
      tmpvar_32.y = int((uint(tmpvar_31) / 1024u));
      vec4 tmpvar_33;
      tmpvar_33 = texelFetch (sGpuCache, tmpvar_32, 0);
      tmpvar_9[1] = min (max ((
        (tmpvar_33[0] * pow (tmpvar_9[1], tmpvar_33[1]))
       + tmpvar_33[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_24 = bool(1);
    };
    tmpvar_23 = !(tmpvar_24);
    if (tmpvar_23) {
      tmpvar_24 = bool(1);
    };
    bool tmpvar_34;
    bool tmpvar_35;
    tmpvar_35 = bool(0);
    tmpvar_34 = (0 == v_funcs.z);
    if (tmpvar_34) {
      tmpvar_35 = bool(1);
    };
    tmpvar_34 = (tmpvar_34 || (1 == v_funcs.z));
    tmpvar_34 = (tmpvar_34 || (2 == v_funcs.z));
    tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
    if (tmpvar_34) {
      k_10 = int(floor((tmpvar_9[2] * 255.0)));
      highp int tmpvar_36;
      tmpvar_36 = ((v_table_address + offset_11) + (k_10 / 4));
      ivec2 tmpvar_37;
      tmpvar_37.x = int((uint(tmpvar_36) % 1024u));
      tmpvar_37.y = int((uint(tmpvar_36) / 1024u));
      vec4 tmpvar_38;
      tmpvar_38 = texelFetch (sGpuCache, tmpvar_37, 0);
      tmpvar_9[2] = min (max (tmpvar_38[(k_10 % 4)], 0.0), 1.0);
      offset_11 += 64;
      tmpvar_35 = bool(1);
    };
    tmpvar_34 = (tmpvar_34 || (3 == v_funcs.z));
    tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
    if (tmpvar_34) {
      highp int tmpvar_39;
      tmpvar_39 = (v_table_address + offset_11);
      ivec2 tmpvar_40;
      tmpvar_40.x = int((uint(tmpvar_39) % 1024u));
      tmpvar_40.y = int((uint(tmpvar_39) / 1024u));
      vec4 tmpvar_41;
      tmpvar_41 = texelFetch (sGpuCache, tmpvar_40, 0);
      tmpvar_9[2] = min (max ((
        (tmpvar_41[0] * tmpvar_9[2])
       + tmpvar_41[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_35 = bool(1);
    };
    tmpvar_34 = (tmpvar_34 || (4 == v_funcs.z));
    tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
    if (tmpvar_34) {
      highp int tmpvar_42;
      tmpvar_42 = (v_table_address + offset_11);
      ivec2 tmpvar_43;
      tmpvar_43.x = int((uint(tmpvar_42) % 1024u));
      tmpvar_43.y = int((uint(tmpvar_42) / 1024u));
      vec4 tmpvar_44;
      tmpvar_44 = texelFetch (sGpuCache, tmpvar_43, 0);
      tmpvar_9[2] = min (max ((
        (tmpvar_44[0] * pow (tmpvar_9[2], tmpvar_44[1]))
       + tmpvar_44[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_35 = bool(1);
    };
    tmpvar_34 = !(tmpvar_35);
    if (tmpvar_34) {
      tmpvar_35 = bool(1);
    };
    bool tmpvar_45;
    bool tmpvar_46;
    tmpvar_46 = bool(0);
    tmpvar_45 = (0 == v_funcs.w);
    if (tmpvar_45) {
      tmpvar_46 = bool(1);
    };
    tmpvar_45 = (tmpvar_45 || (1 == v_funcs.w));
    tmpvar_45 = (tmpvar_45 || (2 == v_funcs.w));
    tmpvar_45 = (tmpvar_45 && !(tmpvar_46));
    if (tmpvar_45) {
      k_10 = int(floor((tmpvar_9[3] * 255.0)));
      highp int tmpvar_47;
      tmpvar_47 = ((v_table_address + offset_11) + (k_10 / 4));
      ivec2 tmpvar_48;
      tmpvar_48.x = int((uint(tmpvar_47) % 1024u));
      tmpvar_48.y = int((uint(tmpvar_47) / 1024u));
      vec4 tmpvar_49;
      tmpvar_49 = texelFetch (sGpuCache, tmpvar_48, 0);
      tmpvar_9[3] = min (max (tmpvar_49[(k_10 % 4)], 0.0), 1.0);
      offset_11 += 64;
      tmpvar_46 = bool(1);
    };
    tmpvar_45 = (tmpvar_45 || (3 == v_funcs.w));
    tmpvar_45 = (tmpvar_45 && !(tmpvar_46));
    if (tmpvar_45) {
      highp int tmpvar_50;
      tmpvar_50 = (v_table_address + offset_11);
      ivec2 tmpvar_51;
      tmpvar_51.x = int((uint(tmpvar_50) % 1024u));
      tmpvar_51.y = int((uint(tmpvar_50) / 1024u));
      vec4 tmpvar_52;
      tmpvar_52 = texelFetch (sGpuCache, tmpvar_51, 0);
      tmpvar_9[3] = min (max ((
        (tmpvar_52[0] * tmpvar_9[3])
       + tmpvar_52[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_46 = bool(1);
    };
    tmpvar_45 = (tmpvar_45 || (4 == v_funcs.w));
    tmpvar_45 = (tmpvar_45 && !(tmpvar_46));
    if (tmpvar_45) {
      highp int tmpvar_53;
      tmpvar_53 = (v_table_address + offset_11);
      ivec2 tmpvar_54;
      tmpvar_54.x = int((uint(tmpvar_53) % 1024u));
      tmpvar_54.y = int((uint(tmpvar_53) / 1024u));
      vec4 tmpvar_55;
      tmpvar_55 = texelFetch (sGpuCache, tmpvar_54, 0);
      tmpvar_9[3] = min (max ((
        (tmpvar_55[0] * pow (tmpvar_9[3], tmpvar_55[1]))
       + tmpvar_55[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_46 = bool(1);
    };
    tmpvar_45 = !(tmpvar_46);
    if (tmpvar_45) {
      tmpvar_46 = bool(1);
    };
    tmpvar_3 = tmpvar_9.xyz;
    tmpvar_4 = tmpvar_9.w;
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (10 == v_op));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = v_color_offset.xyz;
    tmpvar_4 = v_color_offset.w;
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = !(tmpvar_7);
  if (tmpvar_6) {
    vec4 tmpvar_56;
    tmpvar_56.xyz = tmpvar_3;
    tmpvar_56.w = tmpvar_4;
    vec4 tmpvar_57;
    tmpvar_57 = min (max ((
      (v_color_mat * tmpvar_56)
     + v_color_offset), 0.0), 1.0);
    tmpvar_3 = tmpvar_57.xyz;
    tmpvar_4 = tmpvar_57.w;
  };
  vec2 tmpvar_58;
  tmpvar_58 = max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw));
  vec2 tmpvar_59;
  tmpvar_59 = (abs(dFdx(v_local_pos)) + abs(dFdy(v_local_pos)));
  vec4 tmpvar_60;
  tmpvar_60.w = 1.0;
  tmpvar_60.xyz = tmpvar_3;
  frag_color_1 = ((tmpvar_4 * min (
    max ((0.5 - (max (tmpvar_58.x, tmpvar_58.y) * inversesqrt(
      (0.5 * dot (tmpvar_59, tmpvar_59))
    ))), 0.0)
  , 1.0)) * tmpvar_60);
  float tmpvar_61;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_61 = 1.0;
  } else {
    vec2 tmpvar_62;
    tmpvar_62 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_63;
    tmpvar_63.xy = greaterThanEqual (tmpvar_62, vClipMaskUvBounds.xy);
    tmpvar_63.zw = lessThan (tmpvar_62, vClipMaskUvBounds.zw);
    bool tmpvar_64;
    tmpvar_64 = (tmpvar_63 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_64)) {
      tmpvar_61 = 0.0;
    } else {
      tmpvar_61 = texelFetch (sClipMask, ivec2(tmpvar_62), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_61);
  oFragColor = frag_color_1;
}


#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform highp sampler2D sGpuCache;
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
  vec4 tmpvar_1;
  tmpvar_1 = texture (sColor0, min (max ((v_uv * 
    mix (gl_FragCoord.w, 1.0, v_perspective_amount.x)
  ), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
  highp vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = tmpvar_1.w;
  vec3 tmpvar_4;
  if ((tmpvar_1.w != 0.0)) {
    tmpvar_4 = (tmpvar_1.xyz / tmpvar_1.w);
  } else {
    tmpvar_4 = tmpvar_1.xyz;
  };
  tmpvar_2 = tmpvar_4;
  bool tmpvar_5;
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  tmpvar_5 = (0 == v_op);
  if (tmpvar_5) {
    tmpvar_2 = min (max ((
      ((tmpvar_4 * v_perspective_amount.y) - (0.5 * v_perspective_amount.y))
     + 0.5), 0.0), 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (3 == v_op));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = mix (tmpvar_2, (vec3(1.0, 1.0, 1.0) - tmpvar_2), v_perspective_amount.y);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (6 == v_op));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = min (max ((tmpvar_2 * v_perspective_amount.y), 0.0), 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (8 == v_op));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = mix(pow ((
      (tmpvar_2 / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (tmpvar_2 / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), tmpvar_2)));
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (9 == v_op));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (tmpvar_2, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (tmpvar_2 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), tmpvar_2)));
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (11 == v_op));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    vec4 tmpvar_7;
    tmpvar_7.xyz = tmpvar_2;
    tmpvar_7.w = tmpvar_3;
    highp vec4 tmpvar_8;
    tmpvar_8 = tmpvar_7;
    mediump int k_9;
    mediump int offset_10;
    offset_10 = 0;
    bool tmpvar_11;
    bool tmpvar_12;
    tmpvar_12 = bool(0);
    tmpvar_11 = (0 == v_funcs.x);
    if (tmpvar_11) {
      tmpvar_12 = bool(1);
    };
    tmpvar_11 = (tmpvar_11 || (1 == v_funcs.x));
    tmpvar_11 = (tmpvar_11 || (2 == v_funcs.x));
    tmpvar_11 = (tmpvar_11 && !(tmpvar_12));
    if (tmpvar_11) {
      k_9 = int(floor((tmpvar_7[0] * 255.0)));
      highp int tmpvar_13;
      tmpvar_13 = (v_table_address + (k_9 / 4));
      ivec2 tmpvar_14;
      tmpvar_14.x = int((uint(tmpvar_13) % 1024u));
      tmpvar_14.y = int((uint(tmpvar_13) / 1024u));
      vec4 tmpvar_15;
      tmpvar_15 = texelFetch (sGpuCache, tmpvar_14, 0);
      tmpvar_8[0] = min (max (tmpvar_15[(k_9 % 4)], 0.0), 1.0);
      offset_10 = 64;
      tmpvar_12 = bool(1);
    };
    tmpvar_11 = (tmpvar_11 || (3 == v_funcs.x));
    tmpvar_11 = (tmpvar_11 && !(tmpvar_12));
    if (tmpvar_11) {
      highp int tmpvar_16;
      tmpvar_16 = (v_table_address + offset_10);
      ivec2 tmpvar_17;
      tmpvar_17.x = int((uint(tmpvar_16) % 1024u));
      tmpvar_17.y = int((uint(tmpvar_16) / 1024u));
      vec4 tmpvar_18;
      tmpvar_18 = texelFetch (sGpuCache, tmpvar_17, 0);
      tmpvar_8[0] = min (max ((
        (tmpvar_18[0] * tmpvar_8[0])
       + tmpvar_18[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_12 = bool(1);
    };
    tmpvar_11 = (tmpvar_11 || (4 == v_funcs.x));
    tmpvar_11 = (tmpvar_11 && !(tmpvar_12));
    if (tmpvar_11) {
      highp int tmpvar_19;
      tmpvar_19 = (v_table_address + offset_10);
      ivec2 tmpvar_20;
      tmpvar_20.x = int((uint(tmpvar_19) % 1024u));
      tmpvar_20.y = int((uint(tmpvar_19) / 1024u));
      vec4 tmpvar_21;
      tmpvar_21 = texelFetch (sGpuCache, tmpvar_20, 0);
      tmpvar_8[0] = min (max ((
        (tmpvar_21[0] * pow (tmpvar_8[0], tmpvar_21[1]))
       + tmpvar_21[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_12 = bool(1);
    };
    tmpvar_11 = !(tmpvar_12);
    if (tmpvar_11) {
      tmpvar_12 = bool(1);
    };
    bool tmpvar_22;
    bool tmpvar_23;
    tmpvar_23 = bool(0);
    tmpvar_22 = (0 == v_funcs.y);
    if (tmpvar_22) {
      tmpvar_23 = bool(1);
    };
    tmpvar_22 = (tmpvar_22 || (1 == v_funcs.y));
    tmpvar_22 = (tmpvar_22 || (2 == v_funcs.y));
    tmpvar_22 = (tmpvar_22 && !(tmpvar_23));
    if (tmpvar_22) {
      k_9 = int(floor((tmpvar_8[1] * 255.0)));
      highp int tmpvar_24;
      tmpvar_24 = ((v_table_address + offset_10) + (k_9 / 4));
      ivec2 tmpvar_25;
      tmpvar_25.x = int((uint(tmpvar_24) % 1024u));
      tmpvar_25.y = int((uint(tmpvar_24) / 1024u));
      vec4 tmpvar_26;
      tmpvar_26 = texelFetch (sGpuCache, tmpvar_25, 0);
      tmpvar_8[1] = min (max (tmpvar_26[(k_9 % 4)], 0.0), 1.0);
      offset_10 += 64;
      tmpvar_23 = bool(1);
    };
    tmpvar_22 = (tmpvar_22 || (3 == v_funcs.y));
    tmpvar_22 = (tmpvar_22 && !(tmpvar_23));
    if (tmpvar_22) {
      highp int tmpvar_27;
      tmpvar_27 = (v_table_address + offset_10);
      ivec2 tmpvar_28;
      tmpvar_28.x = int((uint(tmpvar_27) % 1024u));
      tmpvar_28.y = int((uint(tmpvar_27) / 1024u));
      vec4 tmpvar_29;
      tmpvar_29 = texelFetch (sGpuCache, tmpvar_28, 0);
      tmpvar_8[1] = min (max ((
        (tmpvar_29[0] * tmpvar_8[1])
       + tmpvar_29[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_23 = bool(1);
    };
    tmpvar_22 = (tmpvar_22 || (4 == v_funcs.y));
    tmpvar_22 = (tmpvar_22 && !(tmpvar_23));
    if (tmpvar_22) {
      highp int tmpvar_30;
      tmpvar_30 = (v_table_address + offset_10);
      ivec2 tmpvar_31;
      tmpvar_31.x = int((uint(tmpvar_30) % 1024u));
      tmpvar_31.y = int((uint(tmpvar_30) / 1024u));
      vec4 tmpvar_32;
      tmpvar_32 = texelFetch (sGpuCache, tmpvar_31, 0);
      tmpvar_8[1] = min (max ((
        (tmpvar_32[0] * pow (tmpvar_8[1], tmpvar_32[1]))
       + tmpvar_32[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_23 = bool(1);
    };
    tmpvar_22 = !(tmpvar_23);
    if (tmpvar_22) {
      tmpvar_23 = bool(1);
    };
    bool tmpvar_33;
    bool tmpvar_34;
    tmpvar_34 = bool(0);
    tmpvar_33 = (0 == v_funcs.z);
    if (tmpvar_33) {
      tmpvar_34 = bool(1);
    };
    tmpvar_33 = (tmpvar_33 || (1 == v_funcs.z));
    tmpvar_33 = (tmpvar_33 || (2 == v_funcs.z));
    tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
    if (tmpvar_33) {
      k_9 = int(floor((tmpvar_8[2] * 255.0)));
      highp int tmpvar_35;
      tmpvar_35 = ((v_table_address + offset_10) + (k_9 / 4));
      ivec2 tmpvar_36;
      tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
      tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
      vec4 tmpvar_37;
      tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
      tmpvar_8[2] = min (max (tmpvar_37[(k_9 % 4)], 0.0), 1.0);
      offset_10 += 64;
      tmpvar_34 = bool(1);
    };
    tmpvar_33 = (tmpvar_33 || (3 == v_funcs.z));
    tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
    if (tmpvar_33) {
      highp int tmpvar_38;
      tmpvar_38 = (v_table_address + offset_10);
      ivec2 tmpvar_39;
      tmpvar_39.x = int((uint(tmpvar_38) % 1024u));
      tmpvar_39.y = int((uint(tmpvar_38) / 1024u));
      vec4 tmpvar_40;
      tmpvar_40 = texelFetch (sGpuCache, tmpvar_39, 0);
      tmpvar_8[2] = min (max ((
        (tmpvar_40[0] * tmpvar_8[2])
       + tmpvar_40[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_34 = bool(1);
    };
    tmpvar_33 = (tmpvar_33 || (4 == v_funcs.z));
    tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
    if (tmpvar_33) {
      highp int tmpvar_41;
      tmpvar_41 = (v_table_address + offset_10);
      ivec2 tmpvar_42;
      tmpvar_42.x = int((uint(tmpvar_41) % 1024u));
      tmpvar_42.y = int((uint(tmpvar_41) / 1024u));
      vec4 tmpvar_43;
      tmpvar_43 = texelFetch (sGpuCache, tmpvar_42, 0);
      tmpvar_8[2] = min (max ((
        (tmpvar_43[0] * pow (tmpvar_8[2], tmpvar_43[1]))
       + tmpvar_43[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_34 = bool(1);
    };
    tmpvar_33 = !(tmpvar_34);
    if (tmpvar_33) {
      tmpvar_34 = bool(1);
    };
    bool tmpvar_44;
    bool tmpvar_45;
    tmpvar_45 = bool(0);
    tmpvar_44 = (0 == v_funcs.w);
    if (tmpvar_44) {
      tmpvar_45 = bool(1);
    };
    tmpvar_44 = (tmpvar_44 || (1 == v_funcs.w));
    tmpvar_44 = (tmpvar_44 || (2 == v_funcs.w));
    tmpvar_44 = (tmpvar_44 && !(tmpvar_45));
    if (tmpvar_44) {
      k_9 = int(floor((tmpvar_8[3] * 255.0)));
      highp int tmpvar_46;
      tmpvar_46 = ((v_table_address + offset_10) + (k_9 / 4));
      ivec2 tmpvar_47;
      tmpvar_47.x = int((uint(tmpvar_46) % 1024u));
      tmpvar_47.y = int((uint(tmpvar_46) / 1024u));
      vec4 tmpvar_48;
      tmpvar_48 = texelFetch (sGpuCache, tmpvar_47, 0);
      tmpvar_8[3] = min (max (tmpvar_48[(k_9 % 4)], 0.0), 1.0);
      offset_10 += 64;
      tmpvar_45 = bool(1);
    };
    tmpvar_44 = (tmpvar_44 || (3 == v_funcs.w));
    tmpvar_44 = (tmpvar_44 && !(tmpvar_45));
    if (tmpvar_44) {
      highp int tmpvar_49;
      tmpvar_49 = (v_table_address + offset_10);
      ivec2 tmpvar_50;
      tmpvar_50.x = int((uint(tmpvar_49) % 1024u));
      tmpvar_50.y = int((uint(tmpvar_49) / 1024u));
      vec4 tmpvar_51;
      tmpvar_51 = texelFetch (sGpuCache, tmpvar_50, 0);
      tmpvar_8[3] = min (max ((
        (tmpvar_51[0] * tmpvar_8[3])
       + tmpvar_51[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_45 = bool(1);
    };
    tmpvar_44 = (tmpvar_44 || (4 == v_funcs.w));
    tmpvar_44 = (tmpvar_44 && !(tmpvar_45));
    if (tmpvar_44) {
      highp int tmpvar_52;
      tmpvar_52 = (v_table_address + offset_10);
      ivec2 tmpvar_53;
      tmpvar_53.x = int((uint(tmpvar_52) % 1024u));
      tmpvar_53.y = int((uint(tmpvar_52) / 1024u));
      vec4 tmpvar_54;
      tmpvar_54 = texelFetch (sGpuCache, tmpvar_53, 0);
      tmpvar_8[3] = min (max ((
        (tmpvar_54[0] * pow (tmpvar_8[3], tmpvar_54[1]))
       + tmpvar_54[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_45 = bool(1);
    };
    tmpvar_44 = !(tmpvar_45);
    if (tmpvar_44) {
      tmpvar_45 = bool(1);
    };
    tmpvar_2 = tmpvar_8.xyz;
    tmpvar_3 = tmpvar_8.w;
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (10 == v_op));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = v_color_offset.xyz;
    tmpvar_3 = v_color_offset.w;
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = !(tmpvar_6);
  if (tmpvar_5) {
    vec4 tmpvar_55;
    tmpvar_55.xyz = tmpvar_2;
    tmpvar_55.w = tmpvar_3;
    vec4 tmpvar_56;
    tmpvar_56 = min (max ((
      (v_color_mat * tmpvar_55)
     + v_color_offset), 0.0), 1.0);
    tmpvar_2 = tmpvar_56.xyz;
    tmpvar_3 = tmpvar_56.w;
  };
  vec4 tmpvar_57;
  tmpvar_57.w = 1.0;
  tmpvar_57.xyz = tmpvar_2;
  oFragColor = (tmpvar_3 * tmpvar_57);
}


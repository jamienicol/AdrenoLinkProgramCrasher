#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sColor1;
uniform lowp sampler2D sClipMask;
flat in highp vec4 vClipMaskUvBounds;
in highp vec2 vClipMaskUv;
in highp vec2 v_src_uv;
flat in highp vec4 v_src_uv_sample_bounds;
in highp vec2 v_backdrop_uv;
flat in highp vec4 v_backdrop_uv_sample_bounds;
flat in highp float v_perspective;
flat in mediump int v_op;
void main ()
{
  vec4 frag_color_1;
  highp vec4 result_2;
  highp vec4 Cs_3;
  highp vec4 Cb_4;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, min (max (v_backdrop_uv, v_backdrop_uv_sample_bounds.xy), v_backdrop_uv_sample_bounds.zw));
  Cb_4 = tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = texture (sColor1, min (max ((v_src_uv * 
    mix (gl_FragCoord.w, 1.0, v_perspective)
  ), v_src_uv_sample_bounds.xy), v_src_uv_sample_bounds.zw));
  Cs_3 = tmpvar_6;
  if ((tmpvar_5.w != 0.0)) {
    Cb_4.xyz = (tmpvar_5.xyz / tmpvar_5.w);
  };
  if ((tmpvar_6.w != 0.0)) {
    Cs_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  };
  result_2 = vec4(1.0, 1.0, 0.0, 1.0);
  bool tmpvar_7;
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  tmpvar_7 = (1 == v_op);
  if (tmpvar_7) {
    result_2.xyz = (Cb_4.xyz * Cs_3.xyz);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (2 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = ((Cb_4.xyz + Cs_3.xyz) - (Cb_4.xyz * Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (3 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec3 tmpvar_9;
    tmpvar_9 = ((2.0 * Cb_4.xyz) - 1.0);
    result_2.xyz = mix ((Cs_3.xyz * (2.0 * Cb_4.xyz)), ((Cs_3.xyz + tmpvar_9) - (Cs_3.xyz * tmpvar_9)), vec3(greaterThanEqual (Cb_4.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (4 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = min (Cs_3.xyz, Cb_4.xyz);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (5 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = max (Cs_3.xyz, Cb_4.xyz);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (6 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    float tmpvar_10;
    if ((Cb_4.x == 0.0)) {
      tmpvar_10 = 0.0;
    } else {
      if ((Cs_3.x == 1.0)) {
        tmpvar_10 = 1.0;
      } else {
        tmpvar_10 = min (1.0, (Cb_4.x / (1.0 - Cs_3.x)));
      };
    };
    result_2.x = tmpvar_10;
    float tmpvar_11;
    if ((Cb_4.y == 0.0)) {
      tmpvar_11 = 0.0;
    } else {
      if ((Cs_3.y == 1.0)) {
        tmpvar_11 = 1.0;
      } else {
        tmpvar_11 = min (1.0, (Cb_4.y / (1.0 - Cs_3.y)));
      };
    };
    result_2.y = tmpvar_11;
    float tmpvar_12;
    if ((Cb_4.z == 0.0)) {
      tmpvar_12 = 0.0;
    } else {
      if ((Cs_3.z == 1.0)) {
        tmpvar_12 = 1.0;
      } else {
        tmpvar_12 = min (1.0, (Cb_4.z / (1.0 - Cs_3.z)));
      };
    };
    result_2.z = tmpvar_12;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (7 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    float tmpvar_13;
    if ((Cb_4.x == 1.0)) {
      tmpvar_13 = 1.0;
    } else {
      if ((Cs_3.x == 0.0)) {
        tmpvar_13 = 0.0;
      } else {
        tmpvar_13 = (1.0 - min (1.0, (
          (1.0 - Cb_4.x)
         / Cs_3.x)));
      };
    };
    result_2.x = tmpvar_13;
    float tmpvar_14;
    if ((Cb_4.y == 1.0)) {
      tmpvar_14 = 1.0;
    } else {
      if ((Cs_3.y == 0.0)) {
        tmpvar_14 = 0.0;
      } else {
        tmpvar_14 = (1.0 - min (1.0, (
          (1.0 - Cb_4.y)
         / Cs_3.y)));
      };
    };
    result_2.y = tmpvar_14;
    float tmpvar_15;
    if ((Cb_4.z == 1.0)) {
      tmpvar_15 = 1.0;
    } else {
      if ((Cs_3.z == 0.0)) {
        tmpvar_15 = 0.0;
      } else {
        tmpvar_15 = (1.0 - min (1.0, (
          (1.0 - Cb_4.z)
         / Cs_3.z)));
      };
    };
    result_2.z = tmpvar_15;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (8 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec3 tmpvar_16;
    tmpvar_16 = ((2.0 * Cs_3.xyz) - 1.0);
    result_2.xyz = mix ((Cb_4.xyz * (2.0 * Cs_3.xyz)), ((Cb_4.xyz + tmpvar_16) - (Cb_4.xyz * tmpvar_16)), vec3(greaterThanEqual (Cs_3.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (9 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    float tmpvar_17;
    if ((0.5 >= Cs_3.x)) {
      tmpvar_17 = (Cb_4.x - ((
        (1.0 - (2.0 * Cs_3.x))
       * Cb_4.x) * (1.0 - Cb_4.x)));
    } else {
      highp float D_18;
      if ((0.25 >= Cb_4.x)) {
        D_18 = (((
          ((16.0 * Cb_4.x) - 12.0)
         * Cb_4.x) + 4.0) * Cb_4.x);
      } else {
        D_18 = sqrt(Cb_4.x);
      };
      tmpvar_17 = (Cb_4.x + ((
        (2.0 * Cs_3.x)
       - 1.0) * (D_18 - Cb_4.x)));
    };
    result_2.x = tmpvar_17;
    float tmpvar_19;
    if ((0.5 >= Cs_3.y)) {
      tmpvar_19 = (Cb_4.y - ((
        (1.0 - (2.0 * Cs_3.y))
       * Cb_4.y) * (1.0 - Cb_4.y)));
    } else {
      highp float D_20;
      if ((0.25 >= Cb_4.y)) {
        D_20 = (((
          ((16.0 * Cb_4.y) - 12.0)
         * Cb_4.y) + 4.0) * Cb_4.y);
      } else {
        D_20 = sqrt(Cb_4.y);
      };
      tmpvar_19 = (Cb_4.y + ((
        (2.0 * Cs_3.y)
       - 1.0) * (D_20 - Cb_4.y)));
    };
    result_2.y = tmpvar_19;
    float tmpvar_21;
    if ((0.5 >= Cs_3.z)) {
      tmpvar_21 = (Cb_4.z - ((
        (1.0 - (2.0 * Cs_3.z))
       * Cb_4.z) * (1.0 - Cb_4.z)));
    } else {
      highp float D_22;
      if ((0.25 >= Cb_4.z)) {
        D_22 = (((
          ((16.0 * Cb_4.z) - 12.0)
         * Cb_4.z) + 4.0) * Cb_4.z);
      } else {
        D_22 = sqrt(Cb_4.z);
      };
      tmpvar_21 = (Cb_4.z + ((
        (2.0 * Cs_3.z)
       - 1.0) * (D_22 - Cb_4.z)));
    };
    result_2.z = tmpvar_21;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (10 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = abs((Cb_4.xyz - Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (11 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = ((Cb_4.xyz + Cs_3.xyz) - ((2.0 * Cb_4.xyz) * Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (12 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec3 tmpvar_23;
    tmpvar_23 = Cs_3.xyz;
    float tmpvar_24;
    tmpvar_24 = (max (Cb_4.x, max (Cb_4.y, Cb_4.z)) - min (Cb_4.x, min (Cb_4.y, Cb_4.z)));
    highp vec3 tmpvar_25;
    tmpvar_25 = tmpvar_23;
    if ((Cs_3.y >= Cs_3.x)) {
      if ((Cs_3.z >= Cs_3.y)) {
        float tmpvar_26;
        tmpvar_26 = tmpvar_23.x;
        float tmpvar_27;
        tmpvar_27 = tmpvar_23.y;
        float tmpvar_28;
        tmpvar_28 = tmpvar_23.z;
        highp float tmpvar_29;
        tmpvar_29 = tmpvar_26;
        highp float tmpvar_30;
        tmpvar_30 = tmpvar_27;
        highp float tmpvar_31;
        tmpvar_31 = tmpvar_28;
        if ((Cs_3.x < Cs_3.z)) {
          tmpvar_30 = (((Cs_3.y - Cs_3.x) * tmpvar_24) / (Cs_3.z - Cs_3.x));
          tmpvar_31 = tmpvar_24;
        } else {
          tmpvar_30 = 0.0;
          tmpvar_31 = 0.0;
        };
        tmpvar_29 = 0.0;
        tmpvar_26 = tmpvar_29;
        tmpvar_27 = tmpvar_30;
        tmpvar_28 = tmpvar_31;
        tmpvar_25.x = 0.0;
        tmpvar_25.y = tmpvar_30;
        tmpvar_25.z = tmpvar_31;
      } else {
        if ((Cs_3.z >= Cs_3.x)) {
          float tmpvar_32;
          tmpvar_32 = tmpvar_23.x;
          float tmpvar_33;
          tmpvar_33 = tmpvar_23.z;
          float tmpvar_34;
          tmpvar_34 = tmpvar_23.y;
          highp float tmpvar_35;
          tmpvar_35 = tmpvar_32;
          highp float tmpvar_36;
          tmpvar_36 = tmpvar_33;
          highp float tmpvar_37;
          tmpvar_37 = tmpvar_34;
          if ((Cs_3.x < Cs_3.y)) {
            tmpvar_36 = (((Cs_3.z - Cs_3.x) * tmpvar_24) / (Cs_3.y - Cs_3.x));
            tmpvar_37 = tmpvar_24;
          } else {
            tmpvar_36 = 0.0;
            tmpvar_37 = 0.0;
          };
          tmpvar_35 = 0.0;
          tmpvar_32 = tmpvar_35;
          tmpvar_33 = tmpvar_36;
          tmpvar_34 = tmpvar_37;
          tmpvar_25.x = 0.0;
          tmpvar_25.z = tmpvar_36;
          tmpvar_25.y = tmpvar_37;
        } else {
          float tmpvar_38;
          tmpvar_38 = tmpvar_23.z;
          float tmpvar_39;
          tmpvar_39 = tmpvar_23.x;
          float tmpvar_40;
          tmpvar_40 = tmpvar_23.y;
          highp float tmpvar_41;
          tmpvar_41 = tmpvar_38;
          highp float tmpvar_42;
          tmpvar_42 = tmpvar_39;
          highp float tmpvar_43;
          tmpvar_43 = tmpvar_40;
          if ((Cs_3.z < Cs_3.y)) {
            tmpvar_42 = (((Cs_3.x - Cs_3.z) * tmpvar_24) / (Cs_3.y - Cs_3.z));
            tmpvar_43 = tmpvar_24;
          } else {
            tmpvar_42 = 0.0;
            tmpvar_43 = 0.0;
          };
          tmpvar_41 = 0.0;
          tmpvar_38 = tmpvar_41;
          tmpvar_39 = tmpvar_42;
          tmpvar_40 = tmpvar_43;
          tmpvar_25.z = 0.0;
          tmpvar_25.x = tmpvar_42;
          tmpvar_25.y = tmpvar_43;
        };
      };
    } else {
      if ((Cs_3.z >= Cs_3.x)) {
        float tmpvar_44;
        tmpvar_44 = tmpvar_23.y;
        float tmpvar_45;
        tmpvar_45 = tmpvar_23.x;
        float tmpvar_46;
        tmpvar_46 = tmpvar_23.z;
        highp float tmpvar_47;
        tmpvar_47 = tmpvar_44;
        highp float tmpvar_48;
        tmpvar_48 = tmpvar_45;
        highp float tmpvar_49;
        tmpvar_49 = tmpvar_46;
        if ((Cs_3.y < Cs_3.z)) {
          tmpvar_48 = (((Cs_3.x - Cs_3.y) * tmpvar_24) / (Cs_3.z - Cs_3.y));
          tmpvar_49 = tmpvar_24;
        } else {
          tmpvar_48 = 0.0;
          tmpvar_49 = 0.0;
        };
        tmpvar_47 = 0.0;
        tmpvar_44 = tmpvar_47;
        tmpvar_45 = tmpvar_48;
        tmpvar_46 = tmpvar_49;
        tmpvar_25.y = 0.0;
        tmpvar_25.x = tmpvar_48;
        tmpvar_25.z = tmpvar_49;
      } else {
        if ((Cs_3.z >= Cs_3.y)) {
          float tmpvar_50;
          tmpvar_50 = tmpvar_23.y;
          float tmpvar_51;
          tmpvar_51 = tmpvar_23.z;
          float tmpvar_52;
          tmpvar_52 = tmpvar_23.x;
          highp float tmpvar_53;
          tmpvar_53 = tmpvar_50;
          highp float tmpvar_54;
          tmpvar_54 = tmpvar_51;
          highp float tmpvar_55;
          tmpvar_55 = tmpvar_52;
          if ((Cs_3.y < Cs_3.x)) {
            tmpvar_54 = (((Cs_3.z - Cs_3.y) * tmpvar_24) / (Cs_3.x - Cs_3.y));
            tmpvar_55 = tmpvar_24;
          } else {
            tmpvar_54 = 0.0;
            tmpvar_55 = 0.0;
          };
          tmpvar_53 = 0.0;
          tmpvar_50 = tmpvar_53;
          tmpvar_51 = tmpvar_54;
          tmpvar_52 = tmpvar_55;
          tmpvar_25.y = 0.0;
          tmpvar_25.z = tmpvar_54;
          tmpvar_25.x = tmpvar_55;
        } else {
          float tmpvar_56;
          tmpvar_56 = tmpvar_23.z;
          float tmpvar_57;
          tmpvar_57 = tmpvar_23.y;
          float tmpvar_58;
          tmpvar_58 = tmpvar_23.x;
          highp float tmpvar_59;
          tmpvar_59 = tmpvar_56;
          highp float tmpvar_60;
          tmpvar_60 = tmpvar_57;
          highp float tmpvar_61;
          tmpvar_61 = tmpvar_58;
          if ((Cs_3.z < Cs_3.x)) {
            tmpvar_60 = (((Cs_3.y - Cs_3.z) * tmpvar_24) / (Cs_3.x - Cs_3.z));
            tmpvar_61 = tmpvar_24;
          } else {
            tmpvar_60 = 0.0;
            tmpvar_61 = 0.0;
          };
          tmpvar_59 = 0.0;
          tmpvar_56 = tmpvar_59;
          tmpvar_57 = tmpvar_60;
          tmpvar_58 = tmpvar_61;
          tmpvar_25.z = 0.0;
          tmpvar_25.y = tmpvar_60;
          tmpvar_25.x = tmpvar_61;
        };
      };
    };
    highp vec3 tmpvar_62;
    tmpvar_62 = (tmpvar_25 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_25, vec3(0.3, 0.59, 0.11))));
    float tmpvar_63;
    tmpvar_63 = dot (tmpvar_62, vec3(0.3, 0.59, 0.11));
    float tmpvar_64;
    tmpvar_64 = min (tmpvar_62.x, min (tmpvar_62.y, tmpvar_62.z));
    float tmpvar_65;
    tmpvar_65 = max (tmpvar_62.x, max (tmpvar_62.y, tmpvar_62.z));
    if ((tmpvar_64 < 0.0)) {
      tmpvar_62 = (tmpvar_63 + ((
        (tmpvar_62 - tmpvar_63)
       * tmpvar_63) / (tmpvar_63 - tmpvar_64)));
    };
    if ((1.0 < tmpvar_65)) {
      tmpvar_62 = (tmpvar_63 + ((
        (tmpvar_62 - tmpvar_63)
       * 
        (1.0 - tmpvar_63)
      ) / (tmpvar_65 - tmpvar_63)));
    };
    result_2.xyz = tmpvar_62;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (13 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec3 tmpvar_66;
    tmpvar_66 = Cb_4.xyz;
    float tmpvar_67;
    tmpvar_67 = (max (Cs_3.x, max (Cs_3.y, Cs_3.z)) - min (Cs_3.x, min (Cs_3.y, Cs_3.z)));
    highp vec3 tmpvar_68;
    tmpvar_68 = tmpvar_66;
    if ((Cb_4.y >= Cb_4.x)) {
      if ((Cb_4.z >= Cb_4.y)) {
        float tmpvar_69;
        tmpvar_69 = tmpvar_66.x;
        float tmpvar_70;
        tmpvar_70 = tmpvar_66.y;
        float tmpvar_71;
        tmpvar_71 = tmpvar_66.z;
        highp float tmpvar_72;
        tmpvar_72 = tmpvar_69;
        highp float tmpvar_73;
        tmpvar_73 = tmpvar_70;
        highp float tmpvar_74;
        tmpvar_74 = tmpvar_71;
        if ((Cb_4.x < Cb_4.z)) {
          tmpvar_73 = (((Cb_4.y - Cb_4.x) * tmpvar_67) / (Cb_4.z - Cb_4.x));
          tmpvar_74 = tmpvar_67;
        } else {
          tmpvar_73 = 0.0;
          tmpvar_74 = 0.0;
        };
        tmpvar_72 = 0.0;
        tmpvar_69 = tmpvar_72;
        tmpvar_70 = tmpvar_73;
        tmpvar_71 = tmpvar_74;
        tmpvar_68.x = 0.0;
        tmpvar_68.y = tmpvar_73;
        tmpvar_68.z = tmpvar_74;
      } else {
        if ((Cb_4.z >= Cb_4.x)) {
          float tmpvar_75;
          tmpvar_75 = tmpvar_66.x;
          float tmpvar_76;
          tmpvar_76 = tmpvar_66.z;
          float tmpvar_77;
          tmpvar_77 = tmpvar_66.y;
          highp float tmpvar_78;
          tmpvar_78 = tmpvar_75;
          highp float tmpvar_79;
          tmpvar_79 = tmpvar_76;
          highp float tmpvar_80;
          tmpvar_80 = tmpvar_77;
          if ((Cb_4.x < Cb_4.y)) {
            tmpvar_79 = (((Cb_4.z - Cb_4.x) * tmpvar_67) / (Cb_4.y - Cb_4.x));
            tmpvar_80 = tmpvar_67;
          } else {
            tmpvar_79 = 0.0;
            tmpvar_80 = 0.0;
          };
          tmpvar_78 = 0.0;
          tmpvar_75 = tmpvar_78;
          tmpvar_76 = tmpvar_79;
          tmpvar_77 = tmpvar_80;
          tmpvar_68.x = 0.0;
          tmpvar_68.z = tmpvar_79;
          tmpvar_68.y = tmpvar_80;
        } else {
          float tmpvar_81;
          tmpvar_81 = tmpvar_66.z;
          float tmpvar_82;
          tmpvar_82 = tmpvar_66.x;
          float tmpvar_83;
          tmpvar_83 = tmpvar_66.y;
          highp float tmpvar_84;
          tmpvar_84 = tmpvar_81;
          highp float tmpvar_85;
          tmpvar_85 = tmpvar_82;
          highp float tmpvar_86;
          tmpvar_86 = tmpvar_83;
          if ((Cb_4.z < Cb_4.y)) {
            tmpvar_85 = (((Cb_4.x - Cb_4.z) * tmpvar_67) / (Cb_4.y - Cb_4.z));
            tmpvar_86 = tmpvar_67;
          } else {
            tmpvar_85 = 0.0;
            tmpvar_86 = 0.0;
          };
          tmpvar_84 = 0.0;
          tmpvar_81 = tmpvar_84;
          tmpvar_82 = tmpvar_85;
          tmpvar_83 = tmpvar_86;
          tmpvar_68.z = 0.0;
          tmpvar_68.x = tmpvar_85;
          tmpvar_68.y = tmpvar_86;
        };
      };
    } else {
      if ((Cb_4.z >= Cb_4.x)) {
        float tmpvar_87;
        tmpvar_87 = tmpvar_66.y;
        float tmpvar_88;
        tmpvar_88 = tmpvar_66.x;
        float tmpvar_89;
        tmpvar_89 = tmpvar_66.z;
        highp float tmpvar_90;
        tmpvar_90 = tmpvar_87;
        highp float tmpvar_91;
        tmpvar_91 = tmpvar_88;
        highp float tmpvar_92;
        tmpvar_92 = tmpvar_89;
        if ((Cb_4.y < Cb_4.z)) {
          tmpvar_91 = (((Cb_4.x - Cb_4.y) * tmpvar_67) / (Cb_4.z - Cb_4.y));
          tmpvar_92 = tmpvar_67;
        } else {
          tmpvar_91 = 0.0;
          tmpvar_92 = 0.0;
        };
        tmpvar_90 = 0.0;
        tmpvar_87 = tmpvar_90;
        tmpvar_88 = tmpvar_91;
        tmpvar_89 = tmpvar_92;
        tmpvar_68.y = 0.0;
        tmpvar_68.x = tmpvar_91;
        tmpvar_68.z = tmpvar_92;
      } else {
        if ((Cb_4.z >= Cb_4.y)) {
          float tmpvar_93;
          tmpvar_93 = tmpvar_66.y;
          float tmpvar_94;
          tmpvar_94 = tmpvar_66.z;
          float tmpvar_95;
          tmpvar_95 = tmpvar_66.x;
          highp float tmpvar_96;
          tmpvar_96 = tmpvar_93;
          highp float tmpvar_97;
          tmpvar_97 = tmpvar_94;
          highp float tmpvar_98;
          tmpvar_98 = tmpvar_95;
          if ((Cb_4.y < Cb_4.x)) {
            tmpvar_97 = (((Cb_4.z - Cb_4.y) * tmpvar_67) / (Cb_4.x - Cb_4.y));
            tmpvar_98 = tmpvar_67;
          } else {
            tmpvar_97 = 0.0;
            tmpvar_98 = 0.0;
          };
          tmpvar_96 = 0.0;
          tmpvar_93 = tmpvar_96;
          tmpvar_94 = tmpvar_97;
          tmpvar_95 = tmpvar_98;
          tmpvar_68.y = 0.0;
          tmpvar_68.z = tmpvar_97;
          tmpvar_68.x = tmpvar_98;
        } else {
          float tmpvar_99;
          tmpvar_99 = tmpvar_66.z;
          float tmpvar_100;
          tmpvar_100 = tmpvar_66.y;
          float tmpvar_101;
          tmpvar_101 = tmpvar_66.x;
          highp float tmpvar_102;
          tmpvar_102 = tmpvar_99;
          highp float tmpvar_103;
          tmpvar_103 = tmpvar_100;
          highp float tmpvar_104;
          tmpvar_104 = tmpvar_101;
          if ((Cb_4.z < Cb_4.x)) {
            tmpvar_103 = (((Cb_4.y - Cb_4.z) * tmpvar_67) / (Cb_4.x - Cb_4.z));
            tmpvar_104 = tmpvar_67;
          } else {
            tmpvar_103 = 0.0;
            tmpvar_104 = 0.0;
          };
          tmpvar_102 = 0.0;
          tmpvar_99 = tmpvar_102;
          tmpvar_100 = tmpvar_103;
          tmpvar_101 = tmpvar_104;
          tmpvar_68.z = 0.0;
          tmpvar_68.y = tmpvar_103;
          tmpvar_68.x = tmpvar_104;
        };
      };
    };
    highp vec3 tmpvar_105;
    tmpvar_105 = (tmpvar_68 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_68, vec3(0.3, 0.59, 0.11))));
    float tmpvar_106;
    tmpvar_106 = dot (tmpvar_105, vec3(0.3, 0.59, 0.11));
    float tmpvar_107;
    tmpvar_107 = min (tmpvar_105.x, min (tmpvar_105.y, tmpvar_105.z));
    float tmpvar_108;
    tmpvar_108 = max (tmpvar_105.x, max (tmpvar_105.y, tmpvar_105.z));
    if ((tmpvar_107 < 0.0)) {
      tmpvar_105 = (tmpvar_106 + ((
        (tmpvar_105 - tmpvar_106)
       * tmpvar_106) / (tmpvar_106 - tmpvar_107)));
    };
    if ((1.0 < tmpvar_108)) {
      tmpvar_105 = (tmpvar_106 + ((
        (tmpvar_105 - tmpvar_106)
       * 
        (1.0 - tmpvar_106)
      ) / (tmpvar_108 - tmpvar_106)));
    };
    result_2.xyz = tmpvar_105;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (14 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec3 tmpvar_109;
    tmpvar_109 = (Cs_3.xyz + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11))));
    float tmpvar_110;
    tmpvar_110 = dot (tmpvar_109, vec3(0.3, 0.59, 0.11));
    float tmpvar_111;
    tmpvar_111 = min (tmpvar_109.x, min (tmpvar_109.y, tmpvar_109.z));
    float tmpvar_112;
    tmpvar_112 = max (tmpvar_109.x, max (tmpvar_109.y, tmpvar_109.z));
    if ((tmpvar_111 < 0.0)) {
      tmpvar_109 = (tmpvar_110 + ((
        (tmpvar_109 - tmpvar_110)
       * tmpvar_110) / (tmpvar_110 - tmpvar_111)));
    };
    if ((1.0 < tmpvar_112)) {
      tmpvar_109 = (tmpvar_110 + ((
        (tmpvar_109 - tmpvar_110)
       * 
        (1.0 - tmpvar_110)
      ) / (tmpvar_112 - tmpvar_110)));
    };
    result_2.xyz = tmpvar_109;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (15 == v_op));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec3 tmpvar_113;
    tmpvar_113 = (Cb_4.xyz + (dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11))));
    float tmpvar_114;
    tmpvar_114 = dot (tmpvar_113, vec3(0.3, 0.59, 0.11));
    float tmpvar_115;
    tmpvar_115 = min (tmpvar_113.x, min (tmpvar_113.y, tmpvar_113.z));
    float tmpvar_116;
    tmpvar_116 = max (tmpvar_113.x, max (tmpvar_113.y, tmpvar_113.z));
    if ((tmpvar_115 < 0.0)) {
      tmpvar_113 = (tmpvar_114 + ((
        (tmpvar_113 - tmpvar_114)
       * tmpvar_114) / (tmpvar_114 - tmpvar_115)));
    };
    if ((1.0 < tmpvar_116)) {
      tmpvar_113 = (tmpvar_114 + ((
        (tmpvar_113 - tmpvar_114)
       * 
        (1.0 - tmpvar_114)
      ) / (tmpvar_116 - tmpvar_114)));
    };
    result_2.xyz = tmpvar_113;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = !(tmpvar_8);
  if (tmpvar_7) {
    tmpvar_8 = bool(1);
  };
  result_2.xyz = (((1.0 - tmpvar_5.w) * Cs_3.xyz) + (tmpvar_5.w * result_2.xyz));
  result_2.w = Cs_3.w;
  result_2.xyz = (result_2.xyz * tmpvar_6.w);
  frag_color_1 = result_2;
  float tmpvar_117;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_117 = 1.0;
  } else {
    vec2 tmpvar_118;
    tmpvar_118 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_119;
    tmpvar_119.xy = greaterThanEqual (tmpvar_118, vClipMaskUvBounds.xy);
    tmpvar_119.zw = lessThan (tmpvar_118, vClipMaskUvBounds.zw);
    bool tmpvar_120;
    tmpvar_120 = (tmpvar_119 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_120)) {
      tmpvar_117 = 0.0;
    } else {
      tmpvar_117 = texelFetch (sClipMask, ivec2(tmpvar_118), 0).x;
    };
  };
  frag_color_1 = (result_2 * tmpvar_117);
  oFragColor = frag_color_1;
}


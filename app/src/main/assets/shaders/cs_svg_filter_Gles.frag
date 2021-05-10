#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sColor1;
uniform highp sampler2D sGpuCache;
in highp vec2 vInput1Uv;
in highp vec2 vInput2Uv;
flat in highp vec4 vInput1UvRect;
flat in highp vec4 vInput2UvRect;
flat in mediump int vFilterInputCount;
flat in mediump int vFilterKind;
flat in mediump ivec4 vData;
flat in highp vec4 vFilterData0;
flat in highp vec4 vFilterData1;
flat in highp float vFloat0;
flat in highp mat4 vColorMat;
flat in mediump ivec4 vFuncs;
void main ()
{
  bool needsPremul_1;
  highp vec4 result_2;
  highp vec4 Cb_3;
  highp vec4 Ca_4;
  Ca_4 = vec4(0.0, 0.0, 0.0, 0.0);
  Cb_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((0 < vFilterInputCount)) {
    vec4 tmpvar_5;
    tmpvar_5 = texture (sColor0, min (max (vInput1Uv, vInput1UvRect.xy), vInput1UvRect.zw));
    Ca_4 = tmpvar_5;
    if ((tmpvar_5.w != 0.0)) {
      Ca_4.xyz = (tmpvar_5.xyz / tmpvar_5.w);
    };
  };
  if ((1 < vFilterInputCount)) {
    vec4 tmpvar_6;
    tmpvar_6 = texture (sColor1, min (max (vInput2Uv, vInput2UvRect.xy), vInput2UvRect.zw));
    Cb_3 = tmpvar_6;
    if ((tmpvar_6.w != 0.0)) {
      Cb_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
    };
  };
  result_2 = vec4(1.0, 0.0, 0.0, 1.0);
  needsPremul_1 = bool(1);
  bool tmpvar_7;
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  tmpvar_7 = (0 == vFilterKind);
  if (tmpvar_7) {
    highp vec4 result_9;
    result_9 = vec4(1.0, 0.0, 0.0, 1.0);
    bool tmpvar_10;
    bool tmpvar_11;
    tmpvar_11 = bool(0);
    tmpvar_10 = (0 == vData.x);
    if (tmpvar_10) {
      result_9.xyz = Ca_4.xyz;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (1 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      result_9.xyz = (Cb_3.xyz * Ca_4.xyz);
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (2 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      result_9.xyz = ((Cb_3.xyz + Ca_4.xyz) - (Cb_3.xyz * Ca_4.xyz));
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (3 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      highp vec3 tmpvar_12;
      tmpvar_12 = ((2.0 * Cb_3.xyz) - 1.0);
      result_9.xyz = mix ((Ca_4.xyz * (2.0 * Cb_3.xyz)), ((Ca_4.xyz + tmpvar_12) - (Ca_4.xyz * tmpvar_12)), vec3(greaterThanEqual (Cb_3.xyz, vec3(0.5, 0.5, 0.5))));
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (4 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      result_9.xyz = min (Ca_4.xyz, Cb_3.xyz);
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (5 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      result_9.xyz = max (Ca_4.xyz, Cb_3.xyz);
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (6 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      float tmpvar_13;
      if ((Cb_3.x == 0.0)) {
        tmpvar_13 = 0.0;
      } else {
        if ((Ca_4.x == 1.0)) {
          tmpvar_13 = 1.0;
        } else {
          tmpvar_13 = min (1.0, (Cb_3.x / (1.0 - Ca_4.x)));
        };
      };
      result_9.x = tmpvar_13;
      float tmpvar_14;
      if ((Cb_3.y == 0.0)) {
        tmpvar_14 = 0.0;
      } else {
        if ((Ca_4.y == 1.0)) {
          tmpvar_14 = 1.0;
        } else {
          tmpvar_14 = min (1.0, (Cb_3.y / (1.0 - Ca_4.y)));
        };
      };
      result_9.y = tmpvar_14;
      float tmpvar_15;
      if ((Cb_3.z == 0.0)) {
        tmpvar_15 = 0.0;
      } else {
        if ((Ca_4.z == 1.0)) {
          tmpvar_15 = 1.0;
        } else {
          tmpvar_15 = min (1.0, (Cb_3.z / (1.0 - Ca_4.z)));
        };
      };
      result_9.z = tmpvar_15;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (7 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      float tmpvar_16;
      if ((Cb_3.x == 1.0)) {
        tmpvar_16 = 1.0;
      } else {
        if ((Ca_4.x == 0.0)) {
          tmpvar_16 = 0.0;
        } else {
          tmpvar_16 = (1.0 - min (1.0, (
            (1.0 - Cb_3.x)
           / Ca_4.x)));
        };
      };
      result_9.x = tmpvar_16;
      float tmpvar_17;
      if ((Cb_3.y == 1.0)) {
        tmpvar_17 = 1.0;
      } else {
        if ((Ca_4.y == 0.0)) {
          tmpvar_17 = 0.0;
        } else {
          tmpvar_17 = (1.0 - min (1.0, (
            (1.0 - Cb_3.y)
           / Ca_4.y)));
        };
      };
      result_9.y = tmpvar_17;
      float tmpvar_18;
      if ((Cb_3.z == 1.0)) {
        tmpvar_18 = 1.0;
      } else {
        if ((Ca_4.z == 0.0)) {
          tmpvar_18 = 0.0;
        } else {
          tmpvar_18 = (1.0 - min (1.0, (
            (1.0 - Cb_3.z)
           / Ca_4.z)));
        };
      };
      result_9.z = tmpvar_18;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (8 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      highp vec3 tmpvar_19;
      tmpvar_19 = ((2.0 * Ca_4.xyz) - 1.0);
      result_9.xyz = mix ((Cb_3.xyz * (2.0 * Ca_4.xyz)), ((Cb_3.xyz + tmpvar_19) - (Cb_3.xyz * tmpvar_19)), vec3(greaterThanEqual (Ca_4.xyz, vec3(0.5, 0.5, 0.5))));
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (9 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      float tmpvar_20;
      if ((0.5 >= Ca_4.x)) {
        tmpvar_20 = (Cb_3.x - ((
          (1.0 - (2.0 * Ca_4.x))
         * Cb_3.x) * (1.0 - Cb_3.x)));
      } else {
        highp float D_21;
        if ((0.25 >= Cb_3.x)) {
          D_21 = (((
            ((16.0 * Cb_3.x) - 12.0)
           * Cb_3.x) + 4.0) * Cb_3.x);
        } else {
          D_21 = sqrt(Cb_3.x);
        };
        tmpvar_20 = (Cb_3.x + ((
          (2.0 * Ca_4.x)
         - 1.0) * (D_21 - Cb_3.x)));
      };
      result_9.x = tmpvar_20;
      float tmpvar_22;
      if ((0.5 >= Ca_4.y)) {
        tmpvar_22 = (Cb_3.y - ((
          (1.0 - (2.0 * Ca_4.y))
         * Cb_3.y) * (1.0 - Cb_3.y)));
      } else {
        highp float D_23;
        if ((0.25 >= Cb_3.y)) {
          D_23 = (((
            ((16.0 * Cb_3.y) - 12.0)
           * Cb_3.y) + 4.0) * Cb_3.y);
        } else {
          D_23 = sqrt(Cb_3.y);
        };
        tmpvar_22 = (Cb_3.y + ((
          (2.0 * Ca_4.y)
         - 1.0) * (D_23 - Cb_3.y)));
      };
      result_9.y = tmpvar_22;
      float tmpvar_24;
      if ((0.5 >= Ca_4.z)) {
        tmpvar_24 = (Cb_3.z - ((
          (1.0 - (2.0 * Ca_4.z))
         * Cb_3.z) * (1.0 - Cb_3.z)));
      } else {
        highp float D_25;
        if ((0.25 >= Cb_3.z)) {
          D_25 = (((
            ((16.0 * Cb_3.z) - 12.0)
           * Cb_3.z) + 4.0) * Cb_3.z);
        } else {
          D_25 = sqrt(Cb_3.z);
        };
        tmpvar_24 = (Cb_3.z + ((
          (2.0 * Ca_4.z)
         - 1.0) * (D_25 - Cb_3.z)));
      };
      result_9.z = tmpvar_24;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (10 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      result_9.xyz = abs((Cb_3.xyz - Ca_4.xyz));
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (11 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      result_9.xyz = ((Cb_3.xyz + Ca_4.xyz) - ((2.0 * Cb_3.xyz) * Ca_4.xyz));
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (12 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      highp vec3 tmpvar_26;
      tmpvar_26 = Ca_4.xyz;
      float tmpvar_27;
      tmpvar_27 = (max (Cb_3.x, max (Cb_3.y, Cb_3.z)) - min (Cb_3.x, min (Cb_3.y, Cb_3.z)));
      highp vec3 tmpvar_28;
      tmpvar_28 = tmpvar_26;
      if ((Ca_4.y >= Ca_4.x)) {
        if ((Ca_4.z >= Ca_4.y)) {
          float tmpvar_29;
          tmpvar_29 = tmpvar_26.x;
          float tmpvar_30;
          tmpvar_30 = tmpvar_26.y;
          float tmpvar_31;
          tmpvar_31 = tmpvar_26.z;
          highp float tmpvar_32;
          tmpvar_32 = tmpvar_29;
          highp float tmpvar_33;
          tmpvar_33 = tmpvar_30;
          highp float tmpvar_34;
          tmpvar_34 = tmpvar_31;
          if ((Ca_4.x < Ca_4.z)) {
            tmpvar_33 = (((Ca_4.y - Ca_4.x) * tmpvar_27) / (Ca_4.z - Ca_4.x));
            tmpvar_34 = tmpvar_27;
          } else {
            tmpvar_33 = 0.0;
            tmpvar_34 = 0.0;
          };
          tmpvar_32 = 0.0;
          tmpvar_29 = tmpvar_32;
          tmpvar_30 = tmpvar_33;
          tmpvar_31 = tmpvar_34;
          tmpvar_28.x = 0.0;
          tmpvar_28.y = tmpvar_33;
          tmpvar_28.z = tmpvar_34;
        } else {
          if ((Ca_4.z >= Ca_4.x)) {
            float tmpvar_35;
            tmpvar_35 = tmpvar_26.x;
            float tmpvar_36;
            tmpvar_36 = tmpvar_26.z;
            float tmpvar_37;
            tmpvar_37 = tmpvar_26.y;
            highp float tmpvar_38;
            tmpvar_38 = tmpvar_35;
            highp float tmpvar_39;
            tmpvar_39 = tmpvar_36;
            highp float tmpvar_40;
            tmpvar_40 = tmpvar_37;
            if ((Ca_4.x < Ca_4.y)) {
              tmpvar_39 = (((Ca_4.z - Ca_4.x) * tmpvar_27) / (Ca_4.y - Ca_4.x));
              tmpvar_40 = tmpvar_27;
            } else {
              tmpvar_39 = 0.0;
              tmpvar_40 = 0.0;
            };
            tmpvar_38 = 0.0;
            tmpvar_35 = tmpvar_38;
            tmpvar_36 = tmpvar_39;
            tmpvar_37 = tmpvar_40;
            tmpvar_28.x = 0.0;
            tmpvar_28.z = tmpvar_39;
            tmpvar_28.y = tmpvar_40;
          } else {
            float tmpvar_41;
            tmpvar_41 = tmpvar_26.z;
            float tmpvar_42;
            tmpvar_42 = tmpvar_26.x;
            float tmpvar_43;
            tmpvar_43 = tmpvar_26.y;
            highp float tmpvar_44;
            tmpvar_44 = tmpvar_41;
            highp float tmpvar_45;
            tmpvar_45 = tmpvar_42;
            highp float tmpvar_46;
            tmpvar_46 = tmpvar_43;
            if ((Ca_4.z < Ca_4.y)) {
              tmpvar_45 = (((Ca_4.x - Ca_4.z) * tmpvar_27) / (Ca_4.y - Ca_4.z));
              tmpvar_46 = tmpvar_27;
            } else {
              tmpvar_45 = 0.0;
              tmpvar_46 = 0.0;
            };
            tmpvar_44 = 0.0;
            tmpvar_41 = tmpvar_44;
            tmpvar_42 = tmpvar_45;
            tmpvar_43 = tmpvar_46;
            tmpvar_28.z = 0.0;
            tmpvar_28.x = tmpvar_45;
            tmpvar_28.y = tmpvar_46;
          };
        };
      } else {
        if ((Ca_4.z >= Ca_4.x)) {
          float tmpvar_47;
          tmpvar_47 = tmpvar_26.y;
          float tmpvar_48;
          tmpvar_48 = tmpvar_26.x;
          float tmpvar_49;
          tmpvar_49 = tmpvar_26.z;
          highp float tmpvar_50;
          tmpvar_50 = tmpvar_47;
          highp float tmpvar_51;
          tmpvar_51 = tmpvar_48;
          highp float tmpvar_52;
          tmpvar_52 = tmpvar_49;
          if ((Ca_4.y < Ca_4.z)) {
            tmpvar_51 = (((Ca_4.x - Ca_4.y) * tmpvar_27) / (Ca_4.z - Ca_4.y));
            tmpvar_52 = tmpvar_27;
          } else {
            tmpvar_51 = 0.0;
            tmpvar_52 = 0.0;
          };
          tmpvar_50 = 0.0;
          tmpvar_47 = tmpvar_50;
          tmpvar_48 = tmpvar_51;
          tmpvar_49 = tmpvar_52;
          tmpvar_28.y = 0.0;
          tmpvar_28.x = tmpvar_51;
          tmpvar_28.z = tmpvar_52;
        } else {
          if ((Ca_4.z >= Ca_4.y)) {
            float tmpvar_53;
            tmpvar_53 = tmpvar_26.y;
            float tmpvar_54;
            tmpvar_54 = tmpvar_26.z;
            float tmpvar_55;
            tmpvar_55 = tmpvar_26.x;
            highp float tmpvar_56;
            tmpvar_56 = tmpvar_53;
            highp float tmpvar_57;
            tmpvar_57 = tmpvar_54;
            highp float tmpvar_58;
            tmpvar_58 = tmpvar_55;
            if ((Ca_4.y < Ca_4.x)) {
              tmpvar_57 = (((Ca_4.z - Ca_4.y) * tmpvar_27) / (Ca_4.x - Ca_4.y));
              tmpvar_58 = tmpvar_27;
            } else {
              tmpvar_57 = 0.0;
              tmpvar_58 = 0.0;
            };
            tmpvar_56 = 0.0;
            tmpvar_53 = tmpvar_56;
            tmpvar_54 = tmpvar_57;
            tmpvar_55 = tmpvar_58;
            tmpvar_28.y = 0.0;
            tmpvar_28.z = tmpvar_57;
            tmpvar_28.x = tmpvar_58;
          } else {
            float tmpvar_59;
            tmpvar_59 = tmpvar_26.z;
            float tmpvar_60;
            tmpvar_60 = tmpvar_26.y;
            float tmpvar_61;
            tmpvar_61 = tmpvar_26.x;
            highp float tmpvar_62;
            tmpvar_62 = tmpvar_59;
            highp float tmpvar_63;
            tmpvar_63 = tmpvar_60;
            highp float tmpvar_64;
            tmpvar_64 = tmpvar_61;
            if ((Ca_4.z < Ca_4.x)) {
              tmpvar_63 = (((Ca_4.y - Ca_4.z) * tmpvar_27) / (Ca_4.x - Ca_4.z));
              tmpvar_64 = tmpvar_27;
            } else {
              tmpvar_63 = 0.0;
              tmpvar_64 = 0.0;
            };
            tmpvar_62 = 0.0;
            tmpvar_59 = tmpvar_62;
            tmpvar_60 = tmpvar_63;
            tmpvar_61 = tmpvar_64;
            tmpvar_28.z = 0.0;
            tmpvar_28.y = tmpvar_63;
            tmpvar_28.x = tmpvar_64;
          };
        };
      };
      highp vec3 tmpvar_65;
      tmpvar_65 = (tmpvar_28 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_28, vec3(0.3, 0.59, 0.11))));
      float tmpvar_66;
      tmpvar_66 = dot (tmpvar_65, vec3(0.3, 0.59, 0.11));
      float tmpvar_67;
      tmpvar_67 = min (tmpvar_65.x, min (tmpvar_65.y, tmpvar_65.z));
      float tmpvar_68;
      tmpvar_68 = max (tmpvar_65.x, max (tmpvar_65.y, tmpvar_65.z));
      if ((tmpvar_67 < 0.0)) {
        tmpvar_65 = (tmpvar_66 + ((
          (tmpvar_65 - tmpvar_66)
         * tmpvar_66) / (tmpvar_66 - tmpvar_67)));
      };
      if ((1.0 < tmpvar_68)) {
        tmpvar_65 = (tmpvar_66 + ((
          (tmpvar_65 - tmpvar_66)
         * 
          (1.0 - tmpvar_66)
        ) / (tmpvar_68 - tmpvar_66)));
      };
      result_9.xyz = tmpvar_65;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (13 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      highp vec3 tmpvar_69;
      tmpvar_69 = Cb_3.xyz;
      float tmpvar_70;
      tmpvar_70 = (max (Ca_4.x, max (Ca_4.y, Ca_4.z)) - min (Ca_4.x, min (Ca_4.y, Ca_4.z)));
      highp vec3 tmpvar_71;
      tmpvar_71 = tmpvar_69;
      if ((Cb_3.y >= Cb_3.x)) {
        if ((Cb_3.z >= Cb_3.y)) {
          float tmpvar_72;
          tmpvar_72 = tmpvar_69.x;
          float tmpvar_73;
          tmpvar_73 = tmpvar_69.y;
          float tmpvar_74;
          tmpvar_74 = tmpvar_69.z;
          highp float tmpvar_75;
          tmpvar_75 = tmpvar_72;
          highp float tmpvar_76;
          tmpvar_76 = tmpvar_73;
          highp float tmpvar_77;
          tmpvar_77 = tmpvar_74;
          if ((Cb_3.x < Cb_3.z)) {
            tmpvar_76 = (((Cb_3.y - Cb_3.x) * tmpvar_70) / (Cb_3.z - Cb_3.x));
            tmpvar_77 = tmpvar_70;
          } else {
            tmpvar_76 = 0.0;
            tmpvar_77 = 0.0;
          };
          tmpvar_75 = 0.0;
          tmpvar_72 = tmpvar_75;
          tmpvar_73 = tmpvar_76;
          tmpvar_74 = tmpvar_77;
          tmpvar_71.x = 0.0;
          tmpvar_71.y = tmpvar_76;
          tmpvar_71.z = tmpvar_77;
        } else {
          if ((Cb_3.z >= Cb_3.x)) {
            float tmpvar_78;
            tmpvar_78 = tmpvar_69.x;
            float tmpvar_79;
            tmpvar_79 = tmpvar_69.z;
            float tmpvar_80;
            tmpvar_80 = tmpvar_69.y;
            highp float tmpvar_81;
            tmpvar_81 = tmpvar_78;
            highp float tmpvar_82;
            tmpvar_82 = tmpvar_79;
            highp float tmpvar_83;
            tmpvar_83 = tmpvar_80;
            if ((Cb_3.x < Cb_3.y)) {
              tmpvar_82 = (((Cb_3.z - Cb_3.x) * tmpvar_70) / (Cb_3.y - Cb_3.x));
              tmpvar_83 = tmpvar_70;
            } else {
              tmpvar_82 = 0.0;
              tmpvar_83 = 0.0;
            };
            tmpvar_81 = 0.0;
            tmpvar_78 = tmpvar_81;
            tmpvar_79 = tmpvar_82;
            tmpvar_80 = tmpvar_83;
            tmpvar_71.x = 0.0;
            tmpvar_71.z = tmpvar_82;
            tmpvar_71.y = tmpvar_83;
          } else {
            float tmpvar_84;
            tmpvar_84 = tmpvar_69.z;
            float tmpvar_85;
            tmpvar_85 = tmpvar_69.x;
            float tmpvar_86;
            tmpvar_86 = tmpvar_69.y;
            highp float tmpvar_87;
            tmpvar_87 = tmpvar_84;
            highp float tmpvar_88;
            tmpvar_88 = tmpvar_85;
            highp float tmpvar_89;
            tmpvar_89 = tmpvar_86;
            if ((Cb_3.z < Cb_3.y)) {
              tmpvar_88 = (((Cb_3.x - Cb_3.z) * tmpvar_70) / (Cb_3.y - Cb_3.z));
              tmpvar_89 = tmpvar_70;
            } else {
              tmpvar_88 = 0.0;
              tmpvar_89 = 0.0;
            };
            tmpvar_87 = 0.0;
            tmpvar_84 = tmpvar_87;
            tmpvar_85 = tmpvar_88;
            tmpvar_86 = tmpvar_89;
            tmpvar_71.z = 0.0;
            tmpvar_71.x = tmpvar_88;
            tmpvar_71.y = tmpvar_89;
          };
        };
      } else {
        if ((Cb_3.z >= Cb_3.x)) {
          float tmpvar_90;
          tmpvar_90 = tmpvar_69.y;
          float tmpvar_91;
          tmpvar_91 = tmpvar_69.x;
          float tmpvar_92;
          tmpvar_92 = tmpvar_69.z;
          highp float tmpvar_93;
          tmpvar_93 = tmpvar_90;
          highp float tmpvar_94;
          tmpvar_94 = tmpvar_91;
          highp float tmpvar_95;
          tmpvar_95 = tmpvar_92;
          if ((Cb_3.y < Cb_3.z)) {
            tmpvar_94 = (((Cb_3.x - Cb_3.y) * tmpvar_70) / (Cb_3.z - Cb_3.y));
            tmpvar_95 = tmpvar_70;
          } else {
            tmpvar_94 = 0.0;
            tmpvar_95 = 0.0;
          };
          tmpvar_93 = 0.0;
          tmpvar_90 = tmpvar_93;
          tmpvar_91 = tmpvar_94;
          tmpvar_92 = tmpvar_95;
          tmpvar_71.y = 0.0;
          tmpvar_71.x = tmpvar_94;
          tmpvar_71.z = tmpvar_95;
        } else {
          if ((Cb_3.z >= Cb_3.y)) {
            float tmpvar_96;
            tmpvar_96 = tmpvar_69.y;
            float tmpvar_97;
            tmpvar_97 = tmpvar_69.z;
            float tmpvar_98;
            tmpvar_98 = tmpvar_69.x;
            highp float tmpvar_99;
            tmpvar_99 = tmpvar_96;
            highp float tmpvar_100;
            tmpvar_100 = tmpvar_97;
            highp float tmpvar_101;
            tmpvar_101 = tmpvar_98;
            if ((Cb_3.y < Cb_3.x)) {
              tmpvar_100 = (((Cb_3.z - Cb_3.y) * tmpvar_70) / (Cb_3.x - Cb_3.y));
              tmpvar_101 = tmpvar_70;
            } else {
              tmpvar_100 = 0.0;
              tmpvar_101 = 0.0;
            };
            tmpvar_99 = 0.0;
            tmpvar_96 = tmpvar_99;
            tmpvar_97 = tmpvar_100;
            tmpvar_98 = tmpvar_101;
            tmpvar_71.y = 0.0;
            tmpvar_71.z = tmpvar_100;
            tmpvar_71.x = tmpvar_101;
          } else {
            float tmpvar_102;
            tmpvar_102 = tmpvar_69.z;
            float tmpvar_103;
            tmpvar_103 = tmpvar_69.y;
            float tmpvar_104;
            tmpvar_104 = tmpvar_69.x;
            highp float tmpvar_105;
            tmpvar_105 = tmpvar_102;
            highp float tmpvar_106;
            tmpvar_106 = tmpvar_103;
            highp float tmpvar_107;
            tmpvar_107 = tmpvar_104;
            if ((Cb_3.z < Cb_3.x)) {
              tmpvar_106 = (((Cb_3.y - Cb_3.z) * tmpvar_70) / (Cb_3.x - Cb_3.z));
              tmpvar_107 = tmpvar_70;
            } else {
              tmpvar_106 = 0.0;
              tmpvar_107 = 0.0;
            };
            tmpvar_105 = 0.0;
            tmpvar_102 = tmpvar_105;
            tmpvar_103 = tmpvar_106;
            tmpvar_104 = tmpvar_107;
            tmpvar_71.z = 0.0;
            tmpvar_71.y = tmpvar_106;
            tmpvar_71.x = tmpvar_107;
          };
        };
      };
      highp vec3 tmpvar_108;
      tmpvar_108 = (tmpvar_71 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_71, vec3(0.3, 0.59, 0.11))));
      float tmpvar_109;
      tmpvar_109 = dot (tmpvar_108, vec3(0.3, 0.59, 0.11));
      float tmpvar_110;
      tmpvar_110 = min (tmpvar_108.x, min (tmpvar_108.y, tmpvar_108.z));
      float tmpvar_111;
      tmpvar_111 = max (tmpvar_108.x, max (tmpvar_108.y, tmpvar_108.z));
      if ((tmpvar_110 < 0.0)) {
        tmpvar_108 = (tmpvar_109 + ((
          (tmpvar_108 - tmpvar_109)
         * tmpvar_109) / (tmpvar_109 - tmpvar_110)));
      };
      if ((1.0 < tmpvar_111)) {
        tmpvar_108 = (tmpvar_109 + ((
          (tmpvar_108 - tmpvar_109)
         * 
          (1.0 - tmpvar_109)
        ) / (tmpvar_111 - tmpvar_109)));
      };
      result_9.xyz = tmpvar_108;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (14 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      highp vec3 tmpvar_112;
      tmpvar_112 = (Ca_4.xyz + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11))));
      float tmpvar_113;
      tmpvar_113 = dot (tmpvar_112, vec3(0.3, 0.59, 0.11));
      float tmpvar_114;
      tmpvar_114 = min (tmpvar_112.x, min (tmpvar_112.y, tmpvar_112.z));
      float tmpvar_115;
      tmpvar_115 = max (tmpvar_112.x, max (tmpvar_112.y, tmpvar_112.z));
      if ((tmpvar_114 < 0.0)) {
        tmpvar_112 = (tmpvar_113 + ((
          (tmpvar_112 - tmpvar_113)
         * tmpvar_113) / (tmpvar_113 - tmpvar_114)));
      };
      if ((1.0 < tmpvar_115)) {
        tmpvar_112 = (tmpvar_113 + ((
          (tmpvar_112 - tmpvar_113)
         * 
          (1.0 - tmpvar_113)
        ) / (tmpvar_115 - tmpvar_113)));
      };
      result_9.xyz = tmpvar_112;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = (tmpvar_10 || (15 == vData.x));
    tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
    if (tmpvar_10) {
      highp vec3 tmpvar_116;
      tmpvar_116 = (Cb_3.xyz + (dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11))));
      float tmpvar_117;
      tmpvar_117 = dot (tmpvar_116, vec3(0.3, 0.59, 0.11));
      float tmpvar_118;
      tmpvar_118 = min (tmpvar_116.x, min (tmpvar_116.y, tmpvar_116.z));
      float tmpvar_119;
      tmpvar_119 = max (tmpvar_116.x, max (tmpvar_116.y, tmpvar_116.z));
      if ((tmpvar_118 < 0.0)) {
        tmpvar_116 = (tmpvar_117 + ((
          (tmpvar_116 - tmpvar_117)
         * tmpvar_117) / (tmpvar_117 - tmpvar_118)));
      };
      if ((1.0 < tmpvar_119)) {
        tmpvar_116 = (tmpvar_117 + ((
          (tmpvar_116 - tmpvar_117)
         * 
          (1.0 - tmpvar_117)
        ) / (tmpvar_119 - tmpvar_117)));
      };
      result_9.xyz = tmpvar_116;
      tmpvar_11 = bool(1);
    };
    tmpvar_10 = !(tmpvar_11);
    if (tmpvar_10) {
      tmpvar_11 = bool(1);
    };
    vec4 tmpvar_120;
    tmpvar_120.xyz = (Cb_3.xyz * Cb_3.w);
    tmpvar_120.w = Cb_3.w;
    vec4 tmpvar_121;
    tmpvar_121.w = 1.0;
    tmpvar_121.xyz = (((1.0 - Cb_3.w) * Ca_4.xyz) + (Cb_3.w * result_9.xyz));
    vec4 tmpvar_122;
    tmpvar_122 = mix (tmpvar_120, tmpvar_121, Ca_4.w);
    result_9 = tmpvar_122;
    result_2 = tmpvar_122;
    needsPremul_1 = bool(0);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (1 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2 = vFilterData0;
    needsPremul_1 = bool(0);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (2 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (Ca_4.xyz, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (Ca_4.xyz * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), Ca_4.xyz)));
    result_2.w = Ca_4.w;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (3 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = mix(pow ((
      (Ca_4.xyz / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (Ca_4.xyz / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), Ca_4.xyz)));
    result_2.w = Ca_4.w;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (4 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = Ca_4.xyz;
    result_2.w = (Ca_4.w * vFloat0);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (5 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2 = ((vColorMat * Ca_4) + vFilterData0);
    result_2 = min (max (result_2, 0.0), 1.0);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (6 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec4 tmpvar_123;
    tmpvar_123.xyz = vFilterData0.xyz;
    tmpvar_123.w = (Cb_3.w * vFilterData0.w);
    vec4 tmpvar_124;
    tmpvar_124.xyz = (vFilterData0.xyz * tmpvar_123.w);
    tmpvar_124.w = tmpvar_123.w;
    vec4 tmpvar_125;
    tmpvar_125.w = 1.0;
    tmpvar_125.xyz = (((1.0 - tmpvar_123.w) * Ca_4.xyz) + (tmpvar_123.w * Ca_4.xyz));
    result_2 = mix (tmpvar_124, tmpvar_125, Ca_4.w);
    needsPremul_1 = bool(0);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (7 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec2 tmpvar_126;
    tmpvar_126 = (vInput1Uv + vFilterData0.xy);
    vec2 tmpvar_127;
    tmpvar_127.x = float((tmpvar_126.x >= vFilterData1.z));
    tmpvar_127.y = float((tmpvar_126.y >= vFilterData1.w));
    vec2 tmpvar_128;
    tmpvar_128 = (vec2(greaterThanEqual (tmpvar_126, vFilterData1.xy)) - tmpvar_127);
    result_2 = (texture (sColor0, min (max (tmpvar_126, vInput1UvRect.xy), vInput1UvRect.zw)) * (tmpvar_128.x * tmpvar_128.y));
    needsPremul_1 = bool(0);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (8 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec4 tmpvar_129;
    tmpvar_129 = Ca_4;
    mediump int k_130;
    mediump int offset_131;
    offset_131 = 0;
    bool tmpvar_132;
    bool tmpvar_133;
    tmpvar_133 = bool(0);
    tmpvar_132 = (0 == vFuncs.x);
    if (tmpvar_132) {
      tmpvar_133 = bool(1);
    };
    tmpvar_132 = (tmpvar_132 || (1 == vFuncs.x));
    tmpvar_132 = (tmpvar_132 || (2 == vFuncs.x));
    tmpvar_132 = (tmpvar_132 && !(tmpvar_133));
    if (tmpvar_132) {
      k_130 = int(floor((Ca_4[0] * 255.0)));
      ivec2 tmpvar_134;
      tmpvar_134.y = 0;
      tmpvar_134.x = (k_130 / 4);
      vec4 tmpvar_135;
      tmpvar_135 = texelFetch (sGpuCache, (vData.xy + tmpvar_134), 0);
      tmpvar_129[0] = min (max (tmpvar_135[(k_130 % 4)], 0.0), 1.0);
      offset_131 = 64;
      tmpvar_133 = bool(1);
    };
    tmpvar_132 = (tmpvar_132 || (3 == vFuncs.x));
    tmpvar_132 = (tmpvar_132 && !(tmpvar_133));
    if (tmpvar_132) {
      ivec2 tmpvar_136;
      tmpvar_136.y = 0;
      tmpvar_136.x = offset_131;
      vec4 tmpvar_137;
      tmpvar_137 = texelFetch (sGpuCache, (vData.xy + tmpvar_136), 0);
      tmpvar_129[0] = min (max ((
        (tmpvar_137[0] * tmpvar_129[0])
       + tmpvar_137[1]), 0.0), 1.0);
      offset_131++;
      tmpvar_133 = bool(1);
    };
    tmpvar_132 = (tmpvar_132 || (4 == vFuncs.x));
    tmpvar_132 = (tmpvar_132 && !(tmpvar_133));
    if (tmpvar_132) {
      ivec2 tmpvar_138;
      tmpvar_138.y = 0;
      tmpvar_138.x = offset_131;
      vec4 tmpvar_139;
      tmpvar_139 = texelFetch (sGpuCache, (vData.xy + tmpvar_138), 0);
      tmpvar_129[0] = min (max ((
        (tmpvar_139[0] * pow (tmpvar_129[0], tmpvar_139[1]))
       + tmpvar_139[2]), 0.0), 1.0);
      offset_131++;
      tmpvar_133 = bool(1);
    };
    tmpvar_132 = !(tmpvar_133);
    if (tmpvar_132) {
      tmpvar_133 = bool(1);
    };
    bool tmpvar_140;
    bool tmpvar_141;
    tmpvar_141 = bool(0);
    tmpvar_140 = (0 == vFuncs.y);
    if (tmpvar_140) {
      tmpvar_141 = bool(1);
    };
    tmpvar_140 = (tmpvar_140 || (1 == vFuncs.y));
    tmpvar_140 = (tmpvar_140 || (2 == vFuncs.y));
    tmpvar_140 = (tmpvar_140 && !(tmpvar_141));
    if (tmpvar_140) {
      k_130 = int(floor((tmpvar_129[1] * 255.0)));
      ivec2 tmpvar_142;
      tmpvar_142.y = 0;
      tmpvar_142.x = (offset_131 + (k_130 / 4));
      vec4 tmpvar_143;
      tmpvar_143 = texelFetch (sGpuCache, (vData.xy + tmpvar_142), 0);
      tmpvar_129[1] = min (max (tmpvar_143[(k_130 % 4)], 0.0), 1.0);
      offset_131 += 64;
      tmpvar_141 = bool(1);
    };
    tmpvar_140 = (tmpvar_140 || (3 == vFuncs.y));
    tmpvar_140 = (tmpvar_140 && !(tmpvar_141));
    if (tmpvar_140) {
      ivec2 tmpvar_144;
      tmpvar_144.y = 0;
      tmpvar_144.x = offset_131;
      vec4 tmpvar_145;
      tmpvar_145 = texelFetch (sGpuCache, (vData.xy + tmpvar_144), 0);
      tmpvar_129[1] = min (max ((
        (tmpvar_145[0] * tmpvar_129[1])
       + tmpvar_145[1]), 0.0), 1.0);
      offset_131++;
      tmpvar_141 = bool(1);
    };
    tmpvar_140 = (tmpvar_140 || (4 == vFuncs.y));
    tmpvar_140 = (tmpvar_140 && !(tmpvar_141));
    if (tmpvar_140) {
      ivec2 tmpvar_146;
      tmpvar_146.y = 0;
      tmpvar_146.x = offset_131;
      vec4 tmpvar_147;
      tmpvar_147 = texelFetch (sGpuCache, (vData.xy + tmpvar_146), 0);
      tmpvar_129[1] = min (max ((
        (tmpvar_147[0] * pow (tmpvar_129[1], tmpvar_147[1]))
       + tmpvar_147[2]), 0.0), 1.0);
      offset_131++;
      tmpvar_141 = bool(1);
    };
    tmpvar_140 = !(tmpvar_141);
    if (tmpvar_140) {
      tmpvar_141 = bool(1);
    };
    bool tmpvar_148;
    bool tmpvar_149;
    tmpvar_149 = bool(0);
    tmpvar_148 = (0 == vFuncs.z);
    if (tmpvar_148) {
      tmpvar_149 = bool(1);
    };
    tmpvar_148 = (tmpvar_148 || (1 == vFuncs.z));
    tmpvar_148 = (tmpvar_148 || (2 == vFuncs.z));
    tmpvar_148 = (tmpvar_148 && !(tmpvar_149));
    if (tmpvar_148) {
      k_130 = int(floor((tmpvar_129[2] * 255.0)));
      ivec2 tmpvar_150;
      tmpvar_150.y = 0;
      tmpvar_150.x = (offset_131 + (k_130 / 4));
      vec4 tmpvar_151;
      tmpvar_151 = texelFetch (sGpuCache, (vData.xy + tmpvar_150), 0);
      tmpvar_129[2] = min (max (tmpvar_151[(k_130 % 4)], 0.0), 1.0);
      offset_131 += 64;
      tmpvar_149 = bool(1);
    };
    tmpvar_148 = (tmpvar_148 || (3 == vFuncs.z));
    tmpvar_148 = (tmpvar_148 && !(tmpvar_149));
    if (tmpvar_148) {
      ivec2 tmpvar_152;
      tmpvar_152.y = 0;
      tmpvar_152.x = offset_131;
      vec4 tmpvar_153;
      tmpvar_153 = texelFetch (sGpuCache, (vData.xy + tmpvar_152), 0);
      tmpvar_129[2] = min (max ((
        (tmpvar_153[0] * tmpvar_129[2])
       + tmpvar_153[1]), 0.0), 1.0);
      offset_131++;
      tmpvar_149 = bool(1);
    };
    tmpvar_148 = (tmpvar_148 || (4 == vFuncs.z));
    tmpvar_148 = (tmpvar_148 && !(tmpvar_149));
    if (tmpvar_148) {
      ivec2 tmpvar_154;
      tmpvar_154.y = 0;
      tmpvar_154.x = offset_131;
      vec4 tmpvar_155;
      tmpvar_155 = texelFetch (sGpuCache, (vData.xy + tmpvar_154), 0);
      tmpvar_129[2] = min (max ((
        (tmpvar_155[0] * pow (tmpvar_129[2], tmpvar_155[1]))
       + tmpvar_155[2]), 0.0), 1.0);
      offset_131++;
      tmpvar_149 = bool(1);
    };
    tmpvar_148 = !(tmpvar_149);
    if (tmpvar_148) {
      tmpvar_149 = bool(1);
    };
    bool tmpvar_156;
    bool tmpvar_157;
    tmpvar_157 = bool(0);
    tmpvar_156 = (0 == vFuncs.w);
    if (tmpvar_156) {
      tmpvar_157 = bool(1);
    };
    tmpvar_156 = (tmpvar_156 || (1 == vFuncs.w));
    tmpvar_156 = (tmpvar_156 || (2 == vFuncs.w));
    tmpvar_156 = (tmpvar_156 && !(tmpvar_157));
    if (tmpvar_156) {
      k_130 = int(floor((tmpvar_129[3] * 255.0)));
      ivec2 tmpvar_158;
      tmpvar_158.y = 0;
      tmpvar_158.x = (offset_131 + (k_130 / 4));
      vec4 tmpvar_159;
      tmpvar_159 = texelFetch (sGpuCache, (vData.xy + tmpvar_158), 0);
      tmpvar_129[3] = min (max (tmpvar_159[(k_130 % 4)], 0.0), 1.0);
      offset_131 += 64;
      tmpvar_157 = bool(1);
    };
    tmpvar_156 = (tmpvar_156 || (3 == vFuncs.w));
    tmpvar_156 = (tmpvar_156 && !(tmpvar_157));
    if (tmpvar_156) {
      ivec2 tmpvar_160;
      tmpvar_160.y = 0;
      tmpvar_160.x = offset_131;
      vec4 tmpvar_161;
      tmpvar_161 = texelFetch (sGpuCache, (vData.xy + tmpvar_160), 0);
      tmpvar_129[3] = min (max ((
        (tmpvar_161[0] * tmpvar_129[3])
       + tmpvar_161[1]), 0.0), 1.0);
      offset_131++;
      tmpvar_157 = bool(1);
    };
    tmpvar_156 = (tmpvar_156 || (4 == vFuncs.w));
    tmpvar_156 = (tmpvar_156 && !(tmpvar_157));
    if (tmpvar_156) {
      ivec2 tmpvar_162;
      tmpvar_162.y = 0;
      tmpvar_162.x = offset_131;
      vec4 tmpvar_163;
      tmpvar_163 = texelFetch (sGpuCache, (vData.xy + tmpvar_162), 0);
      tmpvar_129[3] = min (max ((
        (tmpvar_163[0] * pow (tmpvar_129[3], tmpvar_163[1]))
       + tmpvar_163[2]), 0.0), 1.0);
      offset_131++;
      tmpvar_157 = bool(1);
    };
    tmpvar_156 = !(tmpvar_157);
    if (tmpvar_156) {
      tmpvar_157 = bool(1);
    };
    result_2 = tmpvar_129;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (9 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2 = Ca_4;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (10 == vFilterKind));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    highp vec4 Cr_164;
    Cr_164 = vec4(0.0, 1.0, 0.0, 1.0);
    bool tmpvar_165;
    bool tmpvar_166;
    tmpvar_166 = bool(0);
    tmpvar_165 = (0 == vData.x);
    if (tmpvar_165) {
      Cr_164.xyz = ((Ca_4.w * Ca_4.xyz) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
      Cr_164.w = (Ca_4.w + (Cb_3.w * (1.0 - Ca_4.w)));
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = (tmpvar_165 || (1 == vData.x));
    tmpvar_165 = (tmpvar_165 && !(tmpvar_166));
    if (tmpvar_165) {
      Cr_164.xyz = ((Ca_4.w * Ca_4.xyz) * Cb_3.w);
      Cr_164.w = (Ca_4.w * Cb_3.w);
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = (tmpvar_165 || (2 == vData.x));
    tmpvar_165 = (tmpvar_165 && !(tmpvar_166));
    if (tmpvar_165) {
      Cr_164.xyz = ((Ca_4.w * Ca_4.xyz) * (1.0 - Cb_3.w));
      Cr_164.w = (Ca_4.w * (1.0 - Cb_3.w));
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = (tmpvar_165 || (3 == vData.x));
    tmpvar_165 = (tmpvar_165 && !(tmpvar_166));
    if (tmpvar_165) {
      Cr_164.xyz = (((Ca_4.w * Ca_4.xyz) * Cb_3.w) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
      Cr_164.w = ((Ca_4.w * Cb_3.w) + (Cb_3.w * (1.0 - Ca_4.w)));
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = (tmpvar_165 || (4 == vData.x));
    tmpvar_165 = (tmpvar_165 && !(tmpvar_166));
    if (tmpvar_165) {
      Cr_164.xyz = (((Ca_4.w * Ca_4.xyz) * (1.0 - Cb_3.w)) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
      Cr_164.w = ((Ca_4.w * (1.0 - Cb_3.w)) + (Cb_3.w * (1.0 - Ca_4.w)));
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = (tmpvar_165 || (5 == vData.x));
    tmpvar_165 = (tmpvar_165 && !(tmpvar_166));
    if (tmpvar_165) {
      Cr_164.xyz = ((Ca_4.w * Ca_4.xyz) + (Cb_3.w * Cb_3.xyz));
      Cr_164.w = (Ca_4.w + Cb_3.w);
      Cr_164 = min (max (Cr_164, 0.0), 1.0);
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = (tmpvar_165 || (6 == vData.x));
    tmpvar_165 = (tmpvar_165 && !(tmpvar_166));
    if (tmpvar_165) {
      Cr_164 = (((
        ((vFilterData0.xxxx * Ca_4) * Cb_3)
       + 
        (vFilterData0.yyyy * Ca_4)
      ) + (vFilterData0.zzzz * Cb_3)) + vFilterData0.wwww);
      Cr_164 = min (max (Cr_164, 0.0), 1.0);
      tmpvar_166 = bool(1);
    };
    tmpvar_165 = !(tmpvar_166);
    if (tmpvar_165) {
      tmpvar_166 = bool(1);
    };
    result_2 = Cr_164;
    needsPremul_1 = bool(0);
  };
  tmpvar_7 = !(tmpvar_8);
  if (tmpvar_7) {
    tmpvar_8 = bool(1);
  };
  if (needsPremul_1) {
    result_2.xyz = (result_2.xyz * result_2.w);
  };
  oFragColor = result_2;
}


#version 300 es
precision highp float;
out highp vec4 oFragColor;
flat in highp vec4 vColor00;
flat in highp vec4 vColor01;
flat in highp vec4 vColor10;
flat in highp vec4 vColor11;
flat in highp vec4 vColorLine;
flat in mediump ivec4 vConfig;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipRadii;
flat in highp vec4 vEdgeReference;
flat in highp vec4 vPartialWidths;
flat in highp vec4 vClipParams1;
flat in highp vec4 vClipParams2;
in highp vec2 vPos;
void main ()
{
  highp float d_1;
  highp float mix_factor_2;
  highp vec4 color1_3;
  highp vec4 color0_4;
  vec2 tmpvar_5;
  tmpvar_5 = (abs(dFdx(vPos)) + abs(dFdy(vPos)));
  float tmpvar_6;
  tmpvar_6 = inversesqrt((0.5 * dot (tmpvar_5, tmpvar_5)));
  ivec2 tmpvar_7;
  tmpvar_7.x = (vConfig.y & 255);
  tmpvar_7.y = (vConfig.y >> 8);
  ivec2 tmpvar_8;
  tmpvar_8.x = (vConfig.z & 255);
  tmpvar_8.y = (vConfig.z >> 8);
  mix_factor_2 = 0.0;
  if ((tmpvar_8.x != tmpvar_8.y)) {
    mix_factor_2 = min (max ((0.5 - 
      (-(dot ((vColorLine.zw * 
        inversesqrt(dot (vColorLine.zw, vColorLine.zw))
      ), (vColorLine.xy - vPos))) * tmpvar_6)
    ), 0.0), 1.0);
  };
  vec2 tmpvar_9;
  tmpvar_9 = (vPos - vClipCenter_Sign.xy);
  bool tmpvar_10;
  tmpvar_10 = (lessThan ((vClipCenter_Sign.zw * tmpvar_9), vec2(0.0, 0.0)) == bvec2(1, 1));
  d_1 = -1.0;
  bool tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = bool(0);
  tmpvar_11 = (3 == vConfig.w);
  if (tmpvar_11) {
    vec2 tmpvar_13;
    tmpvar_13 = (vClipParams1.xy - vPos);
    d_1 = (sqrt(dot (tmpvar_13, tmpvar_13)) - vClipParams1.z);
    tmpvar_12 = bool(1);
  };
  tmpvar_11 = (tmpvar_11 || (2 == vConfig.w));
  tmpvar_11 = (tmpvar_11 && !(tmpvar_12));
  if (tmpvar_11) {
    bool tmpvar_14;
    tmpvar_14 = (vClipParams1.x == 0.0);
    float tmpvar_15;
    if (tmpvar_14) {
      tmpvar_15 = vClipParams1.y;
    } else {
      tmpvar_15 = vClipParams1.x;
    };
    float tmpvar_16;
    if (tmpvar_14) {
      tmpvar_16 = vPos.y;
    } else {
      tmpvar_16 = vPos.x;
    };
    bool tmpvar_17;
    tmpvar_17 = ((tmpvar_16 < tmpvar_15) || ((3.0 * tmpvar_15) < tmpvar_16));
    if (!(tmpvar_17)) {
      d_1 = 1.0;
    };
    tmpvar_12 = bool(1);
  };
  tmpvar_11 = (tmpvar_11 || (1 == vConfig.w));
  tmpvar_11 = (tmpvar_11 && !(tmpvar_12));
  if (tmpvar_11) {
    d_1 = max (dot ((vClipParams1.zw * 
      inversesqrt(dot (vClipParams1.zw, vClipParams1.zw))
    ), (vClipParams1.xy - vPos)), -(dot (
      (vClipParams2.zw * inversesqrt(dot (vClipParams2.zw, vClipParams2.zw)))
    , 
      (vClipParams2.xy - vPos)
    )));
    tmpvar_12 = bool(1);
  };
  tmpvar_11 = !(tmpvar_12);
  if (tmpvar_11) {
    tmpvar_12 = bool(1);
  };
  if (tmpvar_10) {
    highp float tmpvar_18;
    tmpvar_18 = float((lessThan (vec2(0.0, 0.0), vClipRadii.xy) == bvec2(1, 1)));
    vec2 tmpvar_19;
    tmpvar_19 = (tmpvar_9 * (1.0/(max (
      (vClipRadii.xy * vClipRadii.xy)
    , 1e-06))));
    vec2 tmpvar_20;
    tmpvar_20 = ((1.0 + tmpvar_18) * tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = float((lessThan (vec2(0.0, 0.0), vClipRadii.zw) == bvec2(1, 1)));
    vec2 tmpvar_22;
    tmpvar_22 = (tmpvar_9 * (1.0/(max (
      (vClipRadii.zw * vClipRadii.zw)
    , 1e-06))));
    vec2 tmpvar_23;
    tmpvar_23 = ((1.0 + tmpvar_21) * tmpvar_22);
    d_1 = max (d_1, max ((
      (dot (tmpvar_9, tmpvar_19) - tmpvar_18)
     * 
      inversesqrt(dot (tmpvar_20, tmpvar_20))
    ), -(
      ((dot (tmpvar_9, tmpvar_22) - tmpvar_21) * inversesqrt(dot (tmpvar_23, tmpvar_23)))
    )));
    highp vec4 tmpvar_24;
    tmpvar_24 = vColor00;
    bool tmpvar_25;
    bool tmpvar_26;
    tmpvar_26 = bool(0);
    tmpvar_25 = (2 == tmpvar_7.x);
    if (tmpvar_25) {
      highp vec2 tmpvar_27;
      tmpvar_27 = (vClipRadii.xy - vPartialWidths.xy);
      highp float tmpvar_28;
      tmpvar_28 = float((lessThan (vec2(0.0, 0.0), tmpvar_27) == bvec2(1, 1)));
      vec2 tmpvar_29;
      tmpvar_29 = (tmpvar_9 * (1.0/(max (
        (tmpvar_27 * tmpvar_27)
      , 1e-06))));
      vec2 tmpvar_30;
      tmpvar_30 = ((1.0 + tmpvar_28) * tmpvar_29);
      highp vec2 tmpvar_31;
      tmpvar_31 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
      highp float tmpvar_32;
      tmpvar_32 = float((lessThan (vec2(0.0, 0.0), tmpvar_31) == bvec2(1, 1)));
      vec2 tmpvar_33;
      tmpvar_33 = (tmpvar_9 * (1.0/(max (
        (tmpvar_31 * tmpvar_31)
      , 1e-06))));
      vec2 tmpvar_34;
      tmpvar_34 = ((1.0 + tmpvar_32) * tmpvar_33);
      tmpvar_24 = (vColor00 * min (max (
        (0.5 - (min (-(
          ((dot (tmpvar_9, tmpvar_29) - tmpvar_28) * inversesqrt(dot (tmpvar_30, tmpvar_30)))
        ), (
          (dot (tmpvar_9, tmpvar_33) - tmpvar_32)
         * 
          inversesqrt(dot (tmpvar_34, tmpvar_34))
        )) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_26 = bool(1);
    };
    tmpvar_25 = (tmpvar_25 || (6 == tmpvar_7.x));
    tmpvar_25 = (tmpvar_25 || (7 == tmpvar_7.x));
    tmpvar_25 = (tmpvar_25 && !(tmpvar_26));
    if (tmpvar_25) {
      highp float swizzled_factor_35;
      highp vec2 tmpvar_36;
      tmpvar_36 = (vClipRadii.xy - vPartialWidths.zw);
      highp float tmpvar_37;
      tmpvar_37 = float((lessThan (vec2(0.0, 0.0), tmpvar_36) == bvec2(1, 1)));
      vec2 tmpvar_38;
      tmpvar_38 = (tmpvar_9 * (1.0/(max (
        (tmpvar_36 * tmpvar_36)
      , 1e-06))));
      vec2 tmpvar_39;
      tmpvar_39 = ((1.0 + tmpvar_37) * tmpvar_38);
      float tmpvar_40;
      tmpvar_40 = min (max ((0.5 - 
        (((dot (tmpvar_9, tmpvar_38) - tmpvar_37) * inversesqrt(dot (tmpvar_39, tmpvar_39))) * tmpvar_6)
      ), 0.0), 1.0);
      bool tmpvar_41;
      bool tmpvar_42;
      tmpvar_42 = bool(0);
      tmpvar_41 = (0 == vConfig.x);
      if (tmpvar_41) {
        swizzled_factor_35 = 0.0;
        tmpvar_42 = bool(1);
      };
      tmpvar_41 = (tmpvar_41 || (1 == vConfig.x));
      tmpvar_41 = (tmpvar_41 && !(tmpvar_42));
      if (tmpvar_41) {
        swizzled_factor_35 = mix_factor_2;
        tmpvar_42 = bool(1);
      };
      tmpvar_41 = (tmpvar_41 || (2 == vConfig.x));
      tmpvar_41 = (tmpvar_41 && !(tmpvar_42));
      if (tmpvar_41) {
        swizzled_factor_35 = 1.0;
        tmpvar_42 = bool(1);
      };
      tmpvar_41 = (tmpvar_41 || (3 == vConfig.x));
      tmpvar_41 = (tmpvar_41 && !(tmpvar_42));
      if (tmpvar_41) {
        swizzled_factor_35 = (1.0 - mix_factor_2);
        tmpvar_42 = bool(1);
      };
      tmpvar_41 = !(tmpvar_42);
      if (tmpvar_41) {
        swizzled_factor_35 = 0.0;
        tmpvar_42 = bool(1);
      };
      tmpvar_24 = mix (mix (vColor01, tmpvar_24, swizzled_factor_35), mix (tmpvar_24, vColor01, swizzled_factor_35), tmpvar_40);
      tmpvar_26 = bool(1);
    };
    tmpvar_25 = !(tmpvar_26);
    if (tmpvar_25) {
      tmpvar_26 = bool(1);
    };
    color0_4 = tmpvar_24;
    highp vec4 tmpvar_43;
    tmpvar_43 = vColor10;
    bool tmpvar_44;
    bool tmpvar_45;
    tmpvar_45 = bool(0);
    tmpvar_44 = (2 == tmpvar_7.y);
    if (tmpvar_44) {
      highp vec2 tmpvar_46;
      tmpvar_46 = (vClipRadii.xy - vPartialWidths.xy);
      highp float tmpvar_47;
      tmpvar_47 = float((lessThan (vec2(0.0, 0.0), tmpvar_46) == bvec2(1, 1)));
      vec2 tmpvar_48;
      tmpvar_48 = (tmpvar_9 * (1.0/(max (
        (tmpvar_46 * tmpvar_46)
      , 1e-06))));
      vec2 tmpvar_49;
      tmpvar_49 = ((1.0 + tmpvar_47) * tmpvar_48);
      highp vec2 tmpvar_50;
      tmpvar_50 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
      highp float tmpvar_51;
      tmpvar_51 = float((lessThan (vec2(0.0, 0.0), tmpvar_50) == bvec2(1, 1)));
      vec2 tmpvar_52;
      tmpvar_52 = (tmpvar_9 * (1.0/(max (
        (tmpvar_50 * tmpvar_50)
      , 1e-06))));
      vec2 tmpvar_53;
      tmpvar_53 = ((1.0 + tmpvar_51) * tmpvar_52);
      tmpvar_43 = (vColor10 * min (max (
        (0.5 - (min (-(
          ((dot (tmpvar_9, tmpvar_48) - tmpvar_47) * inversesqrt(dot (tmpvar_49, tmpvar_49)))
        ), (
          (dot (tmpvar_9, tmpvar_52) - tmpvar_51)
         * 
          inversesqrt(dot (tmpvar_53, tmpvar_53))
        )) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_45 = bool(1);
    };
    tmpvar_44 = (tmpvar_44 || (6 == tmpvar_7.y));
    tmpvar_44 = (tmpvar_44 || (7 == tmpvar_7.y));
    tmpvar_44 = (tmpvar_44 && !(tmpvar_45));
    if (tmpvar_44) {
      highp float swizzled_factor_54;
      highp vec2 tmpvar_55;
      tmpvar_55 = (vClipRadii.xy - vPartialWidths.zw);
      highp float tmpvar_56;
      tmpvar_56 = float((lessThan (vec2(0.0, 0.0), tmpvar_55) == bvec2(1, 1)));
      vec2 tmpvar_57;
      tmpvar_57 = (tmpvar_9 * (1.0/(max (
        (tmpvar_55 * tmpvar_55)
      , 1e-06))));
      vec2 tmpvar_58;
      tmpvar_58 = ((1.0 + tmpvar_56) * tmpvar_57);
      float tmpvar_59;
      tmpvar_59 = min (max ((0.5 - 
        (((dot (tmpvar_9, tmpvar_57) - tmpvar_56) * inversesqrt(dot (tmpvar_58, tmpvar_58))) * tmpvar_6)
      ), 0.0), 1.0);
      bool tmpvar_60;
      bool tmpvar_61;
      tmpvar_61 = bool(0);
      tmpvar_60 = (0 == vConfig.x);
      if (tmpvar_60) {
        swizzled_factor_54 = 0.0;
        tmpvar_61 = bool(1);
      };
      tmpvar_60 = (tmpvar_60 || (1 == vConfig.x));
      tmpvar_60 = (tmpvar_60 && !(tmpvar_61));
      if (tmpvar_60) {
        swizzled_factor_54 = mix_factor_2;
        tmpvar_61 = bool(1);
      };
      tmpvar_60 = (tmpvar_60 || (2 == vConfig.x));
      tmpvar_60 = (tmpvar_60 && !(tmpvar_61));
      if (tmpvar_60) {
        swizzled_factor_54 = 1.0;
        tmpvar_61 = bool(1);
      };
      tmpvar_60 = (tmpvar_60 || (3 == vConfig.x));
      tmpvar_60 = (tmpvar_60 && !(tmpvar_61));
      if (tmpvar_60) {
        swizzled_factor_54 = (1.0 - mix_factor_2);
        tmpvar_61 = bool(1);
      };
      tmpvar_60 = !(tmpvar_61);
      if (tmpvar_60) {
        swizzled_factor_54 = 0.0;
        tmpvar_61 = bool(1);
      };
      tmpvar_43 = mix (mix (vColor11, tmpvar_43, swizzled_factor_54), mix (tmpvar_43, vColor11, swizzled_factor_54), tmpvar_59);
      tmpvar_45 = bool(1);
    };
    tmpvar_44 = !(tmpvar_45);
    if (tmpvar_44) {
      tmpvar_45 = bool(1);
    };
    color1_3 = tmpvar_43;
  } else {
    highp vec4 tmpvar_62;
    tmpvar_62 = vColor00;
    vec2 tmpvar_63;
    if ((tmpvar_8.x != 0)) {
      tmpvar_63 = vec2(0.0, 1.0);
    } else {
      tmpvar_63 = vec2(1.0, 0.0);
    };
    float tmpvar_64;
    tmpvar_64 = dot (vPos, tmpvar_63);
    bool tmpvar_65;
    bool tmpvar_66;
    tmpvar_66 = bool(0);
    tmpvar_65 = (2 == tmpvar_7.x);
    if (tmpvar_65) {
      highp float d_67;
      d_67 = -1.0;
      float tmpvar_68;
      tmpvar_68 = dot (vPartialWidths.xy, tmpvar_63);
      if ((tmpvar_68 >= 1.0)) {
        vec2 tmpvar_69;
        tmpvar_69.x = (dot (vEdgeReference.xy, tmpvar_63) + tmpvar_68);
        tmpvar_69.y = (dot (vEdgeReference.zw, tmpvar_63) - tmpvar_68);
        d_67 = min ((tmpvar_64 - tmpvar_69.x), (tmpvar_69.y - tmpvar_64));
      };
      tmpvar_62 = (vColor00 * min (max (
        (0.5 - (d_67 * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_66 = bool(1);
    };
    tmpvar_65 = (tmpvar_65 || (6 == tmpvar_7.x));
    tmpvar_65 = (tmpvar_65 || (7 == tmpvar_7.x));
    tmpvar_65 = (tmpvar_65 && !(tmpvar_66));
    if (tmpvar_65) {
      tmpvar_62 = mix (tmpvar_62, vColor01, min (max (
        (0.5 - ((tmpvar_64 - dot (
          (vEdgeReference.xy + vPartialWidths.zw)
        , tmpvar_63)) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_66 = bool(1);
    };
    tmpvar_65 = !(tmpvar_66);
    if (tmpvar_65) {
      tmpvar_66 = bool(1);
    };
    color0_4 = tmpvar_62;
    highp vec4 tmpvar_70;
    tmpvar_70 = vColor10;
    vec2 tmpvar_71;
    if ((tmpvar_8.y != 0)) {
      tmpvar_71 = vec2(0.0, 1.0);
    } else {
      tmpvar_71 = vec2(1.0, 0.0);
    };
    float tmpvar_72;
    tmpvar_72 = dot (vPos, tmpvar_71);
    bool tmpvar_73;
    bool tmpvar_74;
    tmpvar_74 = bool(0);
    tmpvar_73 = (2 == tmpvar_7.y);
    if (tmpvar_73) {
      highp float d_75;
      d_75 = -1.0;
      float tmpvar_76;
      tmpvar_76 = dot (vPartialWidths.xy, tmpvar_71);
      if ((tmpvar_76 >= 1.0)) {
        vec2 tmpvar_77;
        tmpvar_77.x = (dot (vEdgeReference.xy, tmpvar_71) + tmpvar_76);
        tmpvar_77.y = (dot (vEdgeReference.zw, tmpvar_71) - tmpvar_76);
        d_75 = min ((tmpvar_72 - tmpvar_77.x), (tmpvar_77.y - tmpvar_72));
      };
      tmpvar_70 = (vColor10 * min (max (
        (0.5 - (d_75 * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_74 = bool(1);
    };
    tmpvar_73 = (tmpvar_73 || (6 == tmpvar_7.y));
    tmpvar_73 = (tmpvar_73 || (7 == tmpvar_7.y));
    tmpvar_73 = (tmpvar_73 && !(tmpvar_74));
    if (tmpvar_73) {
      tmpvar_70 = mix (tmpvar_70, vColor11, min (max (
        (0.5 - ((tmpvar_72 - dot (
          (vEdgeReference.xy + vPartialWidths.zw)
        , tmpvar_71)) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_74 = bool(1);
    };
    tmpvar_73 = !(tmpvar_74);
    if (tmpvar_73) {
      tmpvar_74 = bool(1);
    };
    color1_3 = tmpvar_70;
  };
  oFragColor = (mix (color0_4, color1_3, mix_factor_2) * min (max (
    (0.5 - (d_1 * tmpvar_6))
  , 0.0), 1.0));
}


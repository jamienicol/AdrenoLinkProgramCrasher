#version 300 es
precision highp float;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
in highp vec2 vUv;
flat in highp vec4 vUvRect;
flat in highp vec2 vOffsetScale;
flat in mediump int vSupport;
flat in highp vec2 vGaussCoefficients;
void main ()
{
  mediump int i_1;
  highp float avg_color_2;
  highp vec3 gauss_coefficient_3;
  vec3 tmpvar_4;
  tmpvar_4.xy = vGaussCoefficients;
  tmpvar_4.z = (vGaussCoefficients.y * vGaussCoefficients.y);
  gauss_coefficient_3 = tmpvar_4;
  avg_color_2 = (texture (sColor0, vUv).x * vGaussCoefficients.x);
  i_1 = 1;
  for (; vSupport >= i_1; i_1 += 2) {
    highp float gauss_coefficient_subtotal_5;
    gauss_coefficient_3.xy = (gauss_coefficient_3.xy * gauss_coefficient_3.yz);
    float tmpvar_6;
    tmpvar_6 = gauss_coefficient_3.x;
    gauss_coefficient_3.xy = (gauss_coefficient_3.xy * gauss_coefficient_3.yz);
    gauss_coefficient_subtotal_5 = (tmpvar_6 + gauss_coefficient_3.x);
    vec2 tmpvar_7;
    tmpvar_7 = (vOffsetScale * (float(i_1) + (gauss_coefficient_3.x / gauss_coefficient_subtotal_5)));
    avg_color_2 = (avg_color_2 + ((texture (sColor0, 
      max ((vUv - tmpvar_7), vUvRect.xy)
    ).x + texture (sColor0, 
      min ((vUv + tmpvar_7), vUvRect.zw)
    ).x) * gauss_coefficient_subtotal_5));
  };
  oFragColor = vec4(avg_color_2);
}


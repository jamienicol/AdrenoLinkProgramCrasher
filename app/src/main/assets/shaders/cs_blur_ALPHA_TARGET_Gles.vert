#version 300 es
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp sampler2D sColor0;
uniform highp sampler2D sRenderTasks;
out highp vec2 vUv;
flat out highp vec4 vUvRect;
flat out highp vec2 vOffsetScale;
flat out highp int vSupport;
flat out highp vec2 vGaussCoefficients;
in highp int aBlurRenderTaskAddress;
in highp int aBlurSourceTaskAddress;
in highp int aBlurDirection;
void main ()
{
  ivec2 tmpvar_1;
  tmpvar_1.x = int((2u * (
    uint(aBlurRenderTaskAddress)
   % 512u)));
  tmpvar_1.y = int((uint(aBlurRenderTaskAddress) / 512u));
  vec4 tmpvar_2;
  tmpvar_2 = texelFetch (sRenderTasks, tmpvar_1, 0);
  vec4 tmpvar_3;
  tmpvar_3 = texelFetch (sRenderTasks, (tmpvar_1 + ivec2(1, 0)), 0);
  ivec2 tmpvar_4;
  tmpvar_4.x = int((2u * (
    uint(aBlurSourceTaskAddress)
   % 512u)));
  tmpvar_4.y = int((uint(aBlurSourceTaskAddress) / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetch (sRenderTasks, tmpvar_4, 0);
  vec2 tmpvar_6;
  tmpvar_6 = vec2(textureSize (sColor0, 0));
  vSupport = (int(ceil(
    (1.5 * tmpvar_3.x)
  )) * 2);
  if ((0 < vSupport)) {
    highp int i_7;
    highp float gauss_coefficient_total_8;
    highp vec3 gauss_coefficient_9;
    float tmpvar_10;
    tmpvar_10 = exp((-0.5 / (tmpvar_3.x * tmpvar_3.x)));
    vec2 tmpvar_11;
    tmpvar_11.x = (1.0/((2.506628 * tmpvar_3.x)));
    tmpvar_11.y = tmpvar_10;
    vGaussCoefficients = tmpvar_11;
    vec3 tmpvar_12;
    tmpvar_12.xy = tmpvar_11;
    tmpvar_12.z = (tmpvar_10 * tmpvar_10);
    gauss_coefficient_9 = tmpvar_12;
    gauss_coefficient_total_8 = tmpvar_12.x;
    i_7 = 1;
    for (; vSupport >= i_7; i_7 += 2) {
      gauss_coefficient_9.xy = (gauss_coefficient_9.xy * gauss_coefficient_9.yz);
      float tmpvar_13;
      tmpvar_13 = gauss_coefficient_9.x;
      gauss_coefficient_9.xy = (gauss_coefficient_9.xy * gauss_coefficient_9.yz);
      gauss_coefficient_total_8 = (gauss_coefficient_total_8 + (2.0 * (tmpvar_13 + gauss_coefficient_9.x)));
    };
    vGaussCoefficients.x = (tmpvar_11.x / gauss_coefficient_total_8);
  } else {
    vGaussCoefficients = vec2(1.0, 1.0);
  };
  bool tmpvar_14;
  bool tmpvar_15;
  tmpvar_15 = bool(0);
  tmpvar_14 = (0 == aBlurDirection);
  if (tmpvar_14) {
    vec2 tmpvar_16;
    tmpvar_16.y = 0.0;
    tmpvar_16.x = (1.0/(tmpvar_6.x));
    vOffsetScale = tmpvar_16;
    tmpvar_15 = bool(1);
  };
  tmpvar_14 = (tmpvar_14 || (1 == aBlurDirection));
  tmpvar_14 = (tmpvar_14 && !(tmpvar_15));
  if (tmpvar_14) {
    vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (1.0/(tmpvar_6.y));
    vOffsetScale = tmpvar_17;
    tmpvar_15 = bool(1);
  };
  tmpvar_14 = !(tmpvar_15);
  if (tmpvar_14) {
    vOffsetScale = vec2(0.0, 0.0);
  };
  vec4 tmpvar_18;
  tmpvar_18.xy = (tmpvar_5.xy + vec2(0.5, 0.5));
  tmpvar_18.zw = ((tmpvar_5.xy + tmpvar_3.yz) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_18 / tmpvar_6.xyxy);
  vUv = mix ((tmpvar_5.xy / tmpvar_6), ((tmpvar_5.xy + tmpvar_5.zw) / tmpvar_6), aPosition);
  vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.xy = (tmpvar_2.xy + (tmpvar_2.zw * aPosition));
  gl_Position = (uTransform * tmpvar_19);
}


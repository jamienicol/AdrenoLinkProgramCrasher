#version 300 es
in highp ivec4 aData;
void main ()
{
  // brush solid
  int tmpvar_1 = aData.z;
  ivec4 tmpvar_2 = tmpvar_1 & ivec4(1, 2, 4, 8);
  bvec4 tmpvar_3 = notEqual(tmpvar_2, ivec4(0, 0, 0, 0));
}

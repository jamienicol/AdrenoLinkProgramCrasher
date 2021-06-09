#version 300 es
in highp ivec4 aData;
void main ()
{
  int edge_flags = aData.z;
  bvec4 clip_edge_mask = bvec4(bool(edge_flags & 1), bool(edge_flags & 2), bool(edge_flags & 4), bool(edge_flags & 8));
}

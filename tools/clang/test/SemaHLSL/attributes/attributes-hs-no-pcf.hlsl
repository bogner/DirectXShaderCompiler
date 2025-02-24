// RUN: %dxc -E main -T hs_6_0 -verify %s

#define NumOutPoints 2

struct HsCpIn {
    float4 pos : SV_Position;
};

struct HsCpOut {
    float4 pos : SV_Position;
};

struct HsPcfOut
{
  float tessOuter[4] : SV_TessFactor;
  float tessInner[2] : SV_InsideTessFactor;
};

HsPcfOut pcf(InputPatch<HsCpIn, NumOutPoints> patch, uint patchId : SV_PrimitiveID) {
  HsPcfOut output;
  output = (HsPcfOut)0;
  return output;
}

// Missing patchconstantfunc attribute
[domain("quad")]
[partitioning("fractional_odd")]
[outputtopology("triangle_ccw")]
[outputcontrolpoints(NumOutPoints)]
HsCpOut main(InputPatch<HsCpIn, NumOutPoints> patch, /* expected-error{{hull entry point must have the patchconstantfunc attribute}} */
             uint cpId : SV_OutputControlPointID,
             uint patchId : SV_PrimitiveID) {
    HsCpOut output;
    output = (HsCpOut)0;
    return output;
}

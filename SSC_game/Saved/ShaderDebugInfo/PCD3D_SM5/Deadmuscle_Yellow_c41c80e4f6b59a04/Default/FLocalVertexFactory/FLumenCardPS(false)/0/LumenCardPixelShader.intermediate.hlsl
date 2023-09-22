#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToView : packoffset(c16);
    float4 View_View_NormalOverrideParameter : packoffset(c139);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[4] : packoffset(c0);
};


static float4 in_var_TEXCOORD10_centroid;
static float4 in_var_TEXCOORD11_centroid;
static float4 out_var_SV_Target0;
static float4 out_var_SV_Target1;
static float4 out_var_SV_Target2;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 in_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
    float4 out_var_SV_Target1 : SV_Target1;
    float4 out_var_SV_Target2 : SV_Target2;
};

void frag_main()
{
    float3 _70 = normalize(mul(normalize((float3(0.0f, 0.0f, 1.0f) * View_View_NormalOverrideParameter.w) + View_View_NormalOverrideParameter.xyz), float3x3(in_var_TEXCOORD10_centroid.xyz, cross(in_var_TEXCOORD11_centroid.xyz, in_var_TEXCOORD10_centroid.xyz) * in_var_TEXCOORD11_centroid.w, in_var_TEXCOORD11_centroid.xyz))) * 1.0f;
    float3 _77 = lerp(0.0f.xxx, Material_Material_PreshaderBuffer[1].yzw, Material_Material_PreshaderBuffer[1].x.xxx);
    bool3 _114 = isnan(_77);
    bool3 _115 = isnan(0.0f.xxx);
    float3 _116 = max(_77, 0.0f.xxx);
    float3 _117 = float3(_114.x ? 0.0f.xxx.x : _116.x, _114.y ? 0.0f.xxx.y : _116.y, _114.z ? 0.0f.xxx.z : _116.z);
    uint3 _85 = asuint(_70) & uint3(2139095040u, 2139095040u, 2139095040u);
    float3 _97 = 0.0f.xxx;
    if (all(bool3(_85.x != uint3(2139095040u, 2139095040u, 2139095040u).x, _85.y != uint3(2139095040u, 2139095040u, 2139095040u).y, _85.z != uint3(2139095040u, 2139095040u, 2139095040u).z)))
    {
        _97 = mul(float4(normalize(_70), 0.0f), View_View_TranslatedWorldToView).xyz;
    }
    else
    {
        _97 = float3(0.0f, 0.0f, 1.0f);
    }
    out_var_SV_Target0 = float4(sqrt(clamp(Material_Material_PreshaderBuffer[3].xyz, 0.0f.xxx, 1.0f.xxx) + 0.017999999225139617919921875f.xxx), 1.0f);
    out_var_SV_Target1 = float4((_97.xy * 0.5f) + 0.5f.xx, 0.0f, 1.0f);
    out_var_SV_Target2 = float4(float3(_115.x ? _77.x : _117.x, _115.y ? _77.y : _117.y, _115.z ? _77.z : _117.z), 0.0f);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    in_var_TEXCOORD10_centroid = stage_input.in_var_TEXCOORD10_centroid;
    in_var_TEXCOORD11_centroid = stage_input.in_var_TEXCOORD11_centroid;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    stage_output.out_var_SV_Target1 = out_var_SV_Target1;
    stage_output.out_var_SV_Target2 = out_var_SV_Target2;
    return stage_output;
}

#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float4 _271 = 0.0f.xxxx;

cbuffer View
{
    row_major float4x4 View_View_ViewToClip : packoffset(c32);
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c48);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_ViewForward : packoffset(c66);
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c71);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    float4 View_View_TemporalAAJitter : packoffset(c125);
    float4 View_View_ViewRectMin : packoffset(c128);
    float4 View_View_ViewSizeAndInvSize : packoffset(c129);
    float4 View_View_BufferSizeAndInvSize : packoffset(c132);
    float View_View_PreExposure : packoffset(c136.y);
    float4 View_View_DiffuseOverrideParameter : packoffset(c137);
    float4 View_View_SpecularOverrideParameter : packoffset(c138);
    float4 View_View_NormalOverrideParameter : packoffset(c139);
    float2 View_View_RoughnessOverrideParameter : packoffset(c140);
    float View_View_OutOfBoundsMask : packoffset(c141);
    float View_View_GameTime : packoffset(c143.y);
    float View_View_MaterialTextureMipBias : packoffset(c144);
    float View_View_UnlitViewmodeMask : packoffset(c146.y);
    float View_View_RenderingReflectionCaptureMask : packoffset(c183.w);
    float View_View_ShowDecalsMask : packoffset(c196.w);
    float View_View_bCheckerboardSubsurfaceProfileRendering : packoffset(c228.z);
    float3 View_View_VolumetricLightmapWorldToUVScale : packoffset(c233);
    float3 View_View_VolumetricLightmapWorldToUVAdd : packoffset(c234);
    float3 View_View_VolumetricLightmapIndirectionTextureSize : packoffset(c235);
    float View_View_VolumetricLightmapBrickSize : packoffset(c235.w);
    float3 View_View_VolumetricLightmapBrickTexelSize : packoffset(c236);
};

ByteAddressBuffer View_PrimitiveSceneData;
cbuffer MaterialCollection0
{
    float4 MaterialCollection0_MaterialCollection0_Vectors[22] : packoffset(c0);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[63] : packoffset(c0);
};

SamplerState View_MaterialTextureBilinearWrapedSampler;
Texture3D<uint4> View_VolumetricLightmapIndirectionTexture;
Texture3D<float4> View_DirectionalLightShadowingBrickTexture;
SamplerState View_SharedBilinearClampedSampler;
Texture2D<float4> OpaqueBasePass_DBufferATexture;
Texture2D<float4> OpaqueBasePass_DBufferBTexture;
Texture2D<float4> OpaqueBasePass_DBufferCTexture;
SamplerState OpaqueBasePass_DBufferATextureSampler;
SamplerState OpaqueBasePass_DBufferBTextureSampler;
SamplerState OpaqueBasePass_DBufferCTextureSampler;
Texture2D<float4> Material_Texture2D_0;
SamplerState Material_Texture2D_0Sampler;
Texture2D<float4> Material_Texture2D_1;
Texture2D<float4> Material_Texture2D_2;
SamplerState Material_Texture2D_2Sampler;
Texture2D<float4> Material_Texture2D_3;
SamplerState Material_Texture2D_3Sampler;
Texture2D<float4> Material_Texture2D_4;
SamplerState Material_Texture2D_4Sampler;
Texture2D<float4> Material_Texture2D_5;
Texture2D<float4> Material_Texture2D_6;
Texture2D<float4> Material_Texture2D_7;
Texture2D<float4> Material_Texture2D_8;
SamplerState Material_Texture2D_8Sampler;
Texture2D<float4> Material_Texture2D_9;
SamplerState Material_Texture2D_9Sampler;
Texture2D<float4> Material_Texture2D_10;
Texture2D<float4> Material_Texture2D_11;
SamplerState Material_Texture2D_11Sampler;
Texture2D<float4> Material_Texture2D_12;
SamplerState Material_Texture2D_12Sampler;
Texture2D<float4> Material_Texture2D_13;
SamplerState Material_Texture2D_13Sampler;
Texture2D<float4> Material_Texture2D_14;
SamplerState Material_Texture2D_14Sampler;
Texture2D<float4> Material_Texture2D_15;
SamplerState Material_Texture2D_15Sampler;
Texture2D<float4> Material_Texture2D_16;
Texture2D<float4> Material_Texture2D_17;
Texture2D<float4> Material_Texture2D_19;
SamplerState Material_Texture2D_19Sampler;
Texture2D<float4> Material_Texture2D_20;
Texture2D<float4> Material_Texture2D_21;
Texture2D<float4> Material_Texture2D_22;

static float4 gl_FragCoord;
static float gl_FragDepth;
static float4 in_var_TEXCOORD10_centroid;
static float4 in_var_TEXCOORD11_centroid;
static float4 in_var_TEXCOORD0[2];
static uint in_var_PRIMITIVE_ID;
static float3 in_var_TEXCOORD9;
static float4 in_var_VELOCITY_PREV_POS;
static float4 out_var_SV_Target0;
static float4 out_var_SV_Target1;
static float4 out_var_SV_Target2;
static float4 out_var_SV_Target3;
static float4 out_var_SV_Target4;
static float4 out_var_SV_Target6;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 in_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 in_var_TEXCOORD0[2] : TEXCOORD0;
    nointerpolation uint in_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float3 in_var_TEXCOORD9 : TEXCOORD9;
    float4 in_var_VELOCITY_PREV_POS : VELOCITY_PREV_POS;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
    float4 out_var_SV_Target1 : SV_Target1;
    float4 out_var_SV_Target2 : SV_Target2;
    float4 out_var_SV_Target3 : SV_Target3;
    float4 out_var_SV_Target4 : SV_Target4;
    float4 out_var_SV_Target6 : SV_Target6;
    float gl_FragDepth : SV_DepthLessEqual;
};

void frag_main()
{
    float3x3 _325 = float3x3(in_var_TEXCOORD10_centroid.xyz, cross(in_var_TEXCOORD11_centroid.xyz, in_var_TEXCOORD10_centroid.xyz) * in_var_TEXCOORD11_centroid.w, in_var_TEXCOORD11_centroid.xyz);
    float4 _336 = float4(mad(gl_FragCoord.xy - View_View_ViewRectMin.xy, View_View_ViewSizeAndInvSize.zw, (-0.5f).xx) * float2(2.0f, -2.0f), gl_FragCoord.z, 1.0f) * (1.0f / gl_FragCoord.w);
    float4 _340 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _344 = _340.xyz / _340.w.xxx;
    float3 _354 = 0.0f.xxx;
    if (View_View_ViewToClip[3].w >= 1.0f)
    {
        _354 = -View_View_ViewForward;
    }
    else
    {
        _354 = normalize(-_344);
    }
    float4 _360 = Material_Texture2D_0.SampleBias(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float2 _362 = mad(_360.xy, 2.0f.xx, (-1.0f).xx);
    float _366 = sqrt(clamp(1.0f - dot(_362, _362), 0.0f, 1.0f));
    float _367 = _362.x;
    float _370 = _366 + 1.0f;
    float2 _374 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[1].x.xx;
    float2 _380 = mad(Material_Texture2D_1.Sample(View_MaterialTextureBilinearWrapedSampler, _374).xy, 2.0f.xx, (-1.0f).xx);
    float4 _391 = Material_Texture2D_2.SampleBias(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float _392 = _391.x;
    float3 _396 = lerp(float4(_380, sqrt(clamp(1.0f - dot(_380, _380), 0.0f, 1.0f)), 1.0f).xyz, float3(0.0f, 0.0f, 1.0f), lerp(0.7999999523162841796875f, 1.0f, _392).xxx);
    float4 _400 = Material_Texture2D_3.SampleBias(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float3 _405 = (_400.w * Material_Material_PreshaderBuffer[1].y).xxx;
    float2 _411 = (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0f.xx) * Material_Material_PreshaderBuffer[1].z.xx;
    float2 _417 = mad(Material_Texture2D_4.SampleBias(Material_Texture2D_4Sampler, _411, View_View_MaterialTextureMipBias).xy, 2.0f.xx, (-1.0f).xx);
    float4 _428 = Material_Texture2D_5.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _429 = _428.y;
    float _430 = _428.z;
    float3 _432 = (isnan(_430) ? _429 : (isnan(_429) ? _430 : max(_429, _430))).xxx;
    float2 _437 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[1].w.xx;
    float2 _442 = mad(Material_Texture2D_6.Sample(View_MaterialTextureBilinearWrapedSampler, _437).xy, 2.0f.xx, (-1.0f).xx);
    float _455 = _428.x;
    float _456 = _428.w;
    float3 _458 = (isnan(_456) ? _455 : (isnan(_455) ? _456 : max(_455, _456))).xxx;
    float2 _463 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[2].y.xx;
    float2 _468 = mad(Material_Texture2D_7.Sample(View_MaterialTextureBilinearWrapedSampler, _463).xy, 2.0f.xx, (-1.0f).xx);
    float4 _481 = Material_Texture2D_8.SampleBias(Material_Texture2D_8Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float3 _483 = _481.x.xxx;
    float4 _488 = Material_Texture2D_9.SampleBias(Material_Texture2D_9Sampler, in_var_TEXCOORD0[0].zw, View_View_MaterialTextureMipBias);
    float3 _490 = _488.w.xxx;
    float2 _495 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[2].z.xx;
    float2 _500 = mad(Material_Texture2D_10.Sample(View_MaterialTextureBilinearWrapedSampler, _495).xy, 2.0f.xx, (-1.0f).xx);
    float3 _517 = (_391.z * Material_Material_PreshaderBuffer[3].x).xxx;
    float4 _522 = Material_Texture2D_11.SampleBias(Material_Texture2D_11Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float3 _524 = _522.x.xxx;
    float3 _525 = lerp(lerp(lerp(lerp(lerp(lerp(lerp(_396, float3(0.0f, 0.0f, 1.0f), _405), float4(_417, sqrt(clamp(1.0f - dot(_417, _417), 0.0f, 1.0f)), 1.0f).xyz, _432), lerp(float4(_442, sqrt(clamp(1.0f - dot(_442, _442), 0.0f, 1.0f)), 1.0f).xyz, float3(0.0f, 0.0f, 1.0f), Material_Material_PreshaderBuffer[2].x.xxx), _458), lerp(float4(_468, sqrt(clamp(1.0f - dot(_468, _468), 0.0f, 1.0f)), 1.0f).xyz, float3(0.0f, 0.0f, 1.0f), (-1.0f).xxx), _483), float3(0.0f, 0.0f, 1.0f), _490), lerp(float4(_500, sqrt(clamp(1.0f - dot(_500, _500), 0.0f, 1.0f)), 1.0f).xyz, float3(0.0f, 0.0f, 1.0f), Material_Material_PreshaderBuffer[2].w.xxx), _517), _396, _524);
    float3 _528 = float3(_367, _362.y, _370);
    float3 _532 = float3(_525.xy * (-1.0f).xx, _525.z);
    float3 _547 = normalize(mul(normalize((normalize(mad(_528, dot(_528, _532).xxx, -(_370.xxx * _532))) * View_View_NormalOverrideParameter.w) + View_View_NormalOverrideParameter.xyz), _325)) * 1.0f;
    float _552 = View_View_GameTime * Material_Material_PreshaderBuffer[7].w;
    float2 _565 = mul(_325, _354).xy;
    float _607 = View_View_GameTime * Material_Material_PreshaderBuffer[14].w;
    float _631 = dot(_547, _354);
    float _634 = abs(1.0f - (isnan(_631) ? 0.0f : (isnan(0.0f) ? _631 : max(0.0f, _631))));
    float _635 = isnan(9.9999997473787516355514526367188e-05f) ? _634 : (isnan(_634) ? 9.9999997473787516355514526367188e-05f : max(_634, 9.9999997473787516355514526367188e-05f));
    float _639 = 1.0f - ((_635 <= 0.0f) ? 0.0f : pow(_635, 1.0f));
    float3 _646 = mad(Material_Texture2D_14.SampleBias(Material_Texture2D_14Sampler, mad(_565, mad(0.0500000007450580596923828125f, Material_Material_PreshaderBuffer[15].y, -0.02500000037252902984619140625f).xx, mad(float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), Material_Material_PreshaderBuffer[15].x.xx, float2(frac(_607 * (-0.5f)), frac(_607 * 0.5f)))), View_View_MaterialTextureMipBias).xyz, Material_Material_PreshaderBuffer[17].xyz, lerp(lerp(Material_Material_PreshaderBuffer[11].xyz, Material_Texture2D_12.SampleBias(Material_Texture2D_12Sampler, mad(_565, mad(0.0500000007450580596923828125f, Material_Material_PreshaderBuffer[8].y, -0.02500000037252902984619140625f).xx, mad(float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), Material_Material_PreshaderBuffer[8].x.xx, float2(frac(_552), frac(_552 * 0.0500000007450580596923828125f)))), View_View_MaterialTextureMipBias).xyz * Material_Material_PreshaderBuffer[10].xyz, 0.5f.xxx), Material_Texture2D_13.SampleBias(Material_Texture2D_13Sampler, mad(_565, mad(0.0500000007450580596923828125f, Material_Material_PreshaderBuffer[12].x, -0.02500000037252902984619140625f).xx, mad(float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), Material_Material_PreshaderBuffer[11].w.xx, float2(frac(View_View_GameTime * (-0.3571430146694183349609375f)), frac(View_View_GameTime * 0.00999999977648258209228515625f)))), View_View_MaterialTextureMipBias).xyz * Material_Material_PreshaderBuffer[14].xyz, 0.5f.xxx)) * ((_639 <= 0.0f) ? 0.0f : pow(_639, Material_Material_PreshaderBuffer[17].w)).xxx;
    float3 _650 = lerp(_646, Material_Material_PreshaderBuffer[18].x.xxx, 0.5f.xxx);
    float _660 = dot(mul(float4(_367, _362.y, _366, 1.0f).xyz, _325), _354);
    float _663 = abs(1.0f - (isnan(_660) ? 0.0f : (isnan(0.0f) ? _660 : max(0.0f, _660))));
    float _664 = isnan(9.9999997473787516355514526367188e-05f) ? _663 : (isnan(_663) ? 9.9999997473787516355514526367188e-05f : max(_663, 9.9999997473787516355514526367188e-05f));
    float _672 = in_var_TEXCOORD0[0].x + 0.100000001490116119384765625f;
    float _682 = abs(sin(View_View_GameTime * 62.83185577392578125f)) * abs(cos(View_View_GameTime * 125.6637115478515625f));
    float _689 = abs(sin(View_View_GameTime * 41.88790130615234375f)) * abs(cos(View_View_GameTime * 15.7079639434814453125f));
    float _690 = _682 * _689;
    float _691 = isnan(_682) ? _690 : (isnan(_690) ? _682 : max(_690, _682));
    float3 _716 = mad(((lerp(float3(0.004999999888241291046142578125f, 0.0035480000078678131103515625f, 0.00045799999497830867767333984375f), float3(1.0f, 0.689500987529754638671875f, 0.039631001651287078857421875f), ((_664 <= 0.0f) ? 0.0f : pow(_664, 6.0f)).xxx) * float3(500.0f, 344.75048828125f, 19.8155002593994140625f)) * (((_672 <= 0.0f) ? 0.0f : pow(_672, 4.0f)) * (isnan(_689) ? _691 : (isnan(_691) ? _689 : min(_691, _689)))).xxx) * Material_Material_PreshaderBuffer[18].y.xxx, _483, lerp(lerp(lerp(lerp(lerp(lerp(lerp(0.0f.xxx, _650, _405), 0.0f.xxx, _432), 0.0f.xxx, _458), 0.0f.xxx, _483), 0.0f.xxx, _490), 0.0f.xxx, _517), 0.0f.xxx, _524)) + ((lerp(float4(0.89999997615814208984375f, 0.0f, 0.0f, 1.0f), MaterialCollection0_MaterialCollection0_Vectors[16], Material_Material_PreshaderBuffer[19].y.xxxx) * Material_Material_PreshaderBuffer[19].z.xxxx) * Material_Material_PreshaderBuffer[21].z.xxxx).xyz;
    bool3 _1427 = isnan(_716);
    bool3 _1428 = isnan(0.0f.xxx);
    float3 _1429 = max(_716, 0.0f.xxx);
    float3 _1430 = float3(_1427.x ? 0.0f.xxx.x : _1429.x, _1427.y ? 0.0f.xxx.y : _1429.y, _1427.z ? 0.0f.xxx.z : _1429.z);
    float _741 = 0.0f;
    do
    {
        [flatten]
        if (View_View_ViewToClip[3u].w < 1.0f)
        {
            _741 = _336.w;
            break;
        }
        else
        {
            float _726 = _336.z;
            _741 = mad(_726, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_726, View_View_InvDeviceZToWorldZTransform.z, -View_View_InvDeviceZToWorldZTransform.w));
            break;
        }
        break; // unreachable workaround
    } while(false);
    float4 _759 = Material_Texture2D_15.SampleBias(Material_Texture2D_15Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float _760 = _759.w;
    float4 _767 = Material_Texture2D_16.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float _774 = _767.w;
    float _780 = _767.y;
    float _794 = clamp((_767.x + _774) + _780, 0.0f, 1.0f);
    float3 _799 = lerp(Material_Material_PreshaderBuffer[31].xyz, lerp(lerp(lerp(Material_Material_PreshaderBuffer[26].xyz, Material_Material_PreshaderBuffer[25].xyz, _774.xxx), Material_Material_PreshaderBuffer[28].xyz, _780.xxx), Material_Material_PreshaderBuffer[30].xyz, Material_Texture2D_11.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)).z.xxx), _794.xxx);
    float4 _802 = Material_Texture2D_17.Sample(View_MaterialTextureBilinearWrapedSampler, _374);
    float3 _815 = _392.xxx;
    float3 _816 = lerp(_799 * _802.xyz, lerp(_799, dot(_799, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, Material_Material_PreshaderBuffer[33].x.xxx) * Material_Material_PreshaderBuffer[33].y.xxx, _815);
    float _830 = lerp(0.4000000059604644775390625f, 0.449999988079071044921875f, _802.w) * lerp(Material_Material_PreshaderBuffer[34].z, lerp(lerp(Material_Material_PreshaderBuffer[34].x, Material_Material_PreshaderBuffer[33].w, _774), Material_Material_PreshaderBuffer[34].y, _780), _794);
    float4 _837 = Material_Texture2D_19.SampleBias(Material_Texture2D_19Sampler, _411, View_View_MaterialTextureMipBias);
    float3 _841 = _837.xyz;
    float _845 = 1.0f - _631;
    float _860 = _837.w;
    float3 _862 = clamp(_860, 0.0f, 1.0f).xxx;
    float4 _867 = Material_Texture2D_20.Sample(View_MaterialTextureBilinearWrapedSampler, _437);
    float4 _880 = Material_Texture2D_21.Sample(View_MaterialTextureBilinearWrapedSampler, _463);
    float4 _891 = Material_Texture2D_22.Sample(View_MaterialTextureBilinearWrapedSampler, _495);
    float3 _903 = lerp(lerp(lerp(lerp(lerp(lerp(lerp(_816, _650, _405), lerp(Material_Material_PreshaderBuffer[38].xyz * _841, mad(-mad(-Material_Material_PreshaderBuffer[38].xyz, _841, 1.0f.xxx), mad(-clamp((_845 <= 0.0f) ? 0.0f : pow(_845, Material_Material_PreshaderBuffer[38].w), 0.0f, 1.0f).xxx, Material_Material_PreshaderBuffer[41].xyz, 1.0f.xxx), 1.0f.xxx), _862), _432), lerp(Material_Material_PreshaderBuffer[43].xyz * _867.xyz, Material_Material_PreshaderBuffer[45].x.xxx, _815), _458), Material_Material_PreshaderBuffer[49].xyz * _880.xyz, _483), _488.xyz, _490), Material_Material_PreshaderBuffer[51].xyz * _891.xyz, _517), _816, _524) * lerp(float3(0.800000011920928955078125f, 0.0f, 0.0f), 1.0f.xxx, Material_Material_PreshaderBuffer[51].w.xxx);
    uint _910 = in_var_PRIMITIVE_ID * 41u;
    uint _911 = _910 + 18u;
    float3 _924 = mad(clamp((_741 - MaterialCollection0_MaterialCollection0_Vectors[1].w) * 0.000833333353511989116668701171875f, 0.0f, 1.0f).xxx, (((clamp(dot(normalize(_354 + float3(0.0f, 0.0f, 1.5f)), _547), 0.0f, 1.0f) * MaterialCollection0_MaterialCollection0_Vectors[0].y) * ((_760 <= 0.0f) ? 0.0f : pow(_760, 2.0f))).xxx * lerp(_903, dot(_903, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, (-2.0f).xxx)) * clamp(lerp(-2.0f, 2.0f, (1.0f + (in_var_TEXCOORD0[1].z / (asfloat(View_PrimitiveSceneData.Load4(_911 * 16 + 0)).w * 2.0f))) * 0.5f), 0.0f, 1.0f).xxx, float3(_1428.x ? _716.x : _1430.x, _1428.y ? _716.y : _1430.y, _1428.z ? _716.z : _1430.z));
    bool3 _1433 = isnan(_924);
    bool3 _1434 = isnan(0.0f.xxx);
    float3 _1435 = max(_924, 0.0f.xxx);
    float3 _1436 = float3(_1433.x ? 0.0f.xxx.x : _1435.x, _1433.y ? 0.0f.xxx.y : _1435.y, _1433.z ? 0.0f.xxx.z : _1435.z);
    float3 _928 = Material_Material_PreshaderBuffer[52].w.xxx;
    float3 _936 = lerp(lerp(0.0f.xxx, float3(_1434.x ? _924.x : _1436.x, _1434.y ? _924.y : _1436.y, _1434.z ? _924.z : _1436.z), _928), Material_Material_PreshaderBuffer[53].yzw, Material_Material_PreshaderBuffer[53].x.xxx);
    float _953 = _880.w;
    float3 _974 = lerp(_830, _830 * 0.75f, _392).xxx;
    float3 _1006 = lerp(lerp(lerp(lerp(lerp(lerp(lerp(_974, 0.0f.xxx, _405), lerp(Material_Material_PreshaderBuffer[54].y, Material_Material_PreshaderBuffer[54].x, _860).xxx, _432), lerp(lerp(Material_Material_PreshaderBuffer[55].x, Material_Material_PreshaderBuffer[54].w, _867.w).xxx, 0.89999997615814208984375f.xxx, _815), _458), (lerp(1.08325898647308349609375f, 0.06421999633312225341796875f, _953 * 1.10716497898101806640625f) * Material_Material_PreshaderBuffer[55].y).xxx, _483), 0.699999988079071044921875f.xxx, _490), lerp(0.5f, 1.0f, _891.w).xxx, _517), _974, _524).x.xxx;
    float _1010 = 1.0f - _760;
    float _1026 = _336.z;
    float _1027 = _336.w;
    float _1029 = _1026 / (_1027 + lerp(lerp(lerp(lerp(lerp(lerp(lerp(0.0f.xxx, 0.0f.xxx, _405), 0.0f.xxx, _432), 0.0f.xxx, _458), 0.0f.xxx, _483), 0.0f.xxx, _490), 0.0f.xxx, _517), 0.0f.xxx, _524).x);
    float _1030 = isnan(gl_FragCoord.z) ? _1029 : (isnan(_1029) ? gl_FragCoord.z : min(_1029, gl_FragCoord.z));
    float _1033 = mad(-_1030, _1027, _1026) / _1030;
    float _1034 = _1027 + _1033;
    float3 _1037 = (_344 - View_View_RelativePreViewTranslation) + ((-_354) * _1033);
    float _1039 = in_var_VELOCITY_PREV_POS.w + _1033;
    float3 _1040 = clamp(lerp(0.0f.xxx, _903, _928), 0.0f.xxx, 1.0f.xxx);
    float _1041 = clamp(lerp(0.0f.xxx, lerp(lerp(lerp(lerp(lerp(lerp(lerp(1.0f.xxx, 0.0f.xxx, _405), lerp(0.0f.xxx, 0.0f.xxx, _862), _432), lerp(0.0f.xxx, 0.0f.xxx, _815), _458), 1.0f.xxx, _483), 0.0f.xxx, _490), 0.0f.xxx, _517), 1.0f.xxx, _524).x.xxx, _928).x, 0.0f, 1.0f);
    float _1042 = clamp(lerp(0.0f.xxx, lerp(lerp(lerp(lerp(lerp(lerp(lerp(0.5f.xxx, 1.0f.xxx, _405), 0.4000000059604644775390625f.xxx, _432), 0.4000000059604644775390625f.xxx, _458), (lerp(0.100000001490116119384765625f, 1.0f, _953) * 0.75764000415802001953125f).xxx, _483), 0.5f.xxx, _490), 0.5f.xxx, _517), 0.5f.xxx, _524).x.xxx * clamp(lerp(1.2000000476837158203125f, -2.0f, clamp(Material_Texture2D_15.SampleBias(Material_Texture2D_15Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), 3.0f + View_View_MaterialTextureMipBias).w - _760, 0.0f, 1.0f)), 0.0f, 1.0f).xxx, _928).x, 0.0f, 1.0f);
    float _1046 = mad(clamp(lerp(0.800000011920928955078125f.xxx, lerp(_1006, mad(_1006 - 1.0f.xxx, 1.0f.xxx - _1006, 1.0f.xxx), (_1010 * _1010).xxx), _928).x, 0.0f, 1.0f), View_View_RoughnessOverrideParameter.y, View_View_RoughnessOverrideParameter.x);
    float _1093 = 0.0f;
    float _1094 = 0.0f;
    float _1095 = 0.0f;
    float3 _1096 = 0.0f.xxx;
    float3 _1097 = 0.0f.xxx;
    [flatten]
    if (((asuint(asfloat(View_PrimitiveSceneData.Load4(_910 * 16 + 0)).x) & 8u) != 0u) && (View_View_ShowDecalsMask > 0.0f))
    {
        float2 _1062 = gl_FragCoord.xy * View_View_BufferSizeAndInvSize.zw;
        float4 _1066 = OpaqueBasePass_DBufferATexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _1062, 0.0f);
        float4 _1070 = OpaqueBasePass_DBufferBTexture.SampleLevel(OpaqueBasePass_DBufferBTextureSampler, _1062, 0.0f);
        float4 _1074 = OpaqueBasePass_DBufferCTexture.SampleLevel(OpaqueBasePass_DBufferCTextureSampler, _1062, 0.0f);
        float _1084 = _1074.w;
        _1093 = mad(_1046, _1084, _1074.z);
        _1094 = mad(_1042, _1084, _1074.y);
        _1095 = mad(_1041, _1084, _1074.x);
        _1096 = (_1040 * _1066.w) + _1066.xyz;
        _1097 = normalize((_547 * _1070.w) + ((_1070.xyz * 2.0f) - 1.00392162799835205078125f.xxx));
    }
    else
    {
        _1093 = _1046;
        _1094 = _1042;
        _1095 = _1041;
        _1096 = _1040;
        _1097 = _547;
    }
    uint _1100 = asuint(asfloat(View_PrimitiveSceneData.Load4(_910 * 16 + 0)).x);
    float _1158 = 0.0f;
    [branch]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4(_910 * 16 + 0)).x) & 4u) != 0u)
    {
        float3 _1126 = clamp(mad((View_View_ViewTilePosition * 2097152.0f) + _1037, View_View_VolumetricLightmapWorldToUVScale, View_View_VolumetricLightmapWorldToUVAdd), 0.0f.xxx, 0.9900000095367431640625f.xxx) * View_View_VolumetricLightmapIndirectionTextureSize;
        float4 _1137 = float4(View_VolumetricLightmapIndirectionTexture.Load(int4(int4(int(_1126.x), int(_1126.y), int(_1126.z), 0).xyz, 0)));
        _1158 = View_DirectionalLightShadowingBrickTexture.SampleLevel(View_SharedBilinearClampedSampler, (((_1137.xyz * (View_View_VolumetricLightmapBrickSize + 1.0f)) + (frac(_1126 / _1137.w.xxx) * View_View_VolumetricLightmapBrickSize)) + 0.5f.xxx) * View_View_VolumetricLightmapBrickTexelSize, 0.0f).x;
    }
    else
    {
        _1158 = 1.0f;
    }
    float4 _1209 = 0.0f.xxxx;
    [branch]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4(_910 * 16 + 0)).x) & 32u) != 0u)
    {
        float _1180 = (_1026 / _1034) - (in_var_VELOCITY_PREV_POS.z / _1039);
        float2 _1184 = float3(((_336.xy / _1034.xx) - View_View_TemporalAAJitter.xy) - ((in_var_VELOCITY_PREV_POS.xy / _1039.xx) - View_View_TemporalAAJitter.zw), _1180).xy;
        float2 _1194 = (((float2(int2(sign(_1184))) * sqrt(abs(_1184))) * 1.41421353816986083984375f).xy * 0.2495000064373016357421875f) + 0.49999237060546875f.xx;
        float4 _1195 = float4(_1194.x, _1194.y, _271.z, _271.w);
        uint _1196 = asuint(_1180);
        _1195.z = clamp(mad(float((_1196 >> 16u) & 65535u), 1.525902189314365386962890625e-05f, 1.525902234789100475609302520752e-06f), 0.0f, 1.0f);
        _1195.w = clamp(mad(float((_1196 >> 0u) & 65535u), 1.525902189314365386962890625e-05f, 1.525902234789100475609302520752e-06f), 0.0f, 1.0f);
        _1209 = _1195;
    }
    else
    {
        _1209 = 0.0f.xxxx;
    }
    float3 _1222 = ((_1096 - (_1096 * _1095)) * View_View_DiffuseOverrideParameter.w) + View_View_DiffuseOverrideParameter.xyz;
    float3 _1229 = (lerp((0.07999999821186065673828125f * _1094).xxx, _1096, _1095.xxx) * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    bool _1232 = View_View_RenderingReflectionCaptureMask != 0.0f;
    float3 _1237 = 0.0f.xxx;
    if (_1232)
    {
        _1237 = _1222 + (_1229 * 0.449999988079071044921875f);
    }
    else
    {
        _1237 = _1222;
    }
    bool3 _1238 = _1232.xxx;
    bool3 _1451 = isnan(_936);
    bool3 _1452 = isnan(0.0f.xxx);
    float3 _1453 = max(_936, 0.0f.xxx);
    float3 _1454 = float3(_1451.x ? 0.0f.xxx.x : _1453.x, _1451.y ? 0.0f.xxx.y : _1453.y, _1451.z ? 0.0f.xxx.z : _1453.z);
    float3 _1246 = float3(_1452.x ? _936.x : _1454.x, _1452.y ? _936.y : _1454.y, _1452.z ? _936.z : _1454.z);
    float3 _1324 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        uint _1270 = _910 + 31u;
        float3 _1279 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_910 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_1037 - asfloat(View_PrimitiveSceneData.Load4(_911 * 16 + 0)).xyz));
        float3 _1280 = float3(asfloat(View_PrimitiveSceneData.Load4((_910 + 17u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_910 + 24u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_910 + 25u) * 16 + 0)).w) + 1.0f.xxx;
        float3 _1323 = 0.0f.xxx;
        if (any(bool3(_1279.x > _1280.x, _1279.y > _1280.y, _1279.z > _1280.z)))
        {
            float3 _1303 = View_View_ViewTilePosition * 0.57700002193450927734375f.xxx;
            float3 _1304 = _1037 * 0.57700002193450927734375f.xxx;
            float3 _1319 = frac(mad((_1304.x + _1304.y) + _1304.z, 0.00200000009499490261077880859375f, frac(((_1303.x + _1303.y) + _1303.z) * 4194.30419921875f))).xxx;
            _1323 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_1319.x > 0.5f.xxx.x, _1319.y > 0.5f.xxx.y, _1319.z > 0.5f.xxx.z)));
        }
        else
        {
            float3 _1302 = 0.0f.xxx;
            if (asfloat(View_PrimitiveSceneData.Load4(_1270 * 16 + 0)).x > 0.0f)
            {
                float3 _1290 = abs(_344 - in_var_TEXCOORD9);
                float _1291 = _1290.x;
                float _1292 = _1290.y;
                float _1293 = _1290.z;
                float _1294 = isnan(_1293) ? _1292 : (isnan(_1292) ? _1293 : max(_1292, _1293));
                _1302 = float3(1.0f, 0.0f, 1.0f) * (1.0f - clamp(abs((isnan(_1294) ? _1291 : (isnan(_1291) ? _1294 : max(_1291, _1294))) - asfloat(View_PrimitiveSceneData.Load4(_1270 * 16 + 0)).x) * 20.0f, 0.0f, 1.0f));
            }
            else
            {
                _1302 = _1246;
            }
            _1323 = _1302;
        }
        _1324 = _1323;
    }
    else
    {
        _1324 = _1246;
    }
    float4 _1330 = float4((lerp(0.0f.xxx, _1237 + (float3(_1238.x ? 0.0f.xxx.x : _1229.x, _1238.y ? 0.0f.xxx.y : _1229.y, _1238.z ? 0.0f.xxx.z : _1229.z) * 0.449999988079071044921875f), View_View_UnlitViewmodeMask.xxx) + _1324) * 1.0f, 0.0f);
    float4 _1337 = 0.0f.xxxx;
    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
    {
        float4 _1336 = _1330;
        _1336.w = 0.0f;
        _1337 = _1336;
    }
    else
    {
        _1337 = _1330;
    }
    float2 _1341 = (frac(gl_FragCoord.xy * 0.0078125f.xx) * 128.0f) + float2(-64.3406219482421875f, -72.4656219482421875f);
    float3 _1350 = (_1097 * 0.5f) + 0.5f.xxx;
    float4 _1352 = 0.0f.xxxx;
    _1352.x = _1350.x;
    _1352.y = _1350.y;
    _1352.z = _1350.z;
    _1352.w = mad(2.0f, float((_1100 & 256u) != 0u), float((_1100 & 512u) != 0u)) * 0.3333333432674407958984375f;
    float4 _1359 = 0.0f.xxxx;
    _1359.x = _1096.x;
    _1359.y = _1096.y;
    _1359.z = _1096.z;
    _1359.w = (frac(dot(_1341.xyx * _1341.xyy, float3(20.390625f, 60.703125f, 2.4281208515167236328125f))) - 0.5f) * 0.0039215688593685626983642578125f;
    float4 _1366 = 0.0f.xxxx;
    _1366.x = _1209.x;
    _1366.y = _1209.y;
    _1366.z = _1209.z;
    _1366.w = _1209.w;
    float4 _1373 = 0.0f.xxxx;
    _1373.x = _1158;
    _1373.y = 1.0f;
    _1373.z = 1.0f;
    _1373.w = 1.0f;
    float4 _1380 = _1337 * View_View_PreExposure;
    float3 _1381 = _1380.xyz;
    bool3 _1470 = isnan(_1381);
    bool3 _1471 = isnan(32256.0f.xxx);
    float3 _1472 = min(_1381, 32256.0f.xxx);
    float3 _1473 = float3(_1470.x ? 32256.0f.xxx.x : _1472.x, _1470.y ? 32256.0f.xxx.y : _1472.y, _1470.z ? 32256.0f.xxx.z : _1472.z);
    float3 _1382 = float3(_1471.x ? _1381.x : _1473.x, _1471.y ? _1381.y : _1473.y, _1471.z ? _1381.z : _1473.z);
    out_var_SV_Target0 = float4(_1382.x, _1382.y, _1382.z, _1380.w);
    out_var_SV_Target1 = _1352;
    out_var_SV_Target2 = float4(_1095, _1094, _1093, 0.0039215688593685626983642578125f);
    out_var_SV_Target3 = _1359;
    out_var_SV_Target4 = _1366;
    out_var_SV_Target6 = _1373;
    gl_FragDepth = _1030;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD10_centroid = stage_input.in_var_TEXCOORD10_centroid;
    in_var_TEXCOORD11_centroid = stage_input.in_var_TEXCOORD11_centroid;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_PRIMITIVE_ID = stage_input.in_var_PRIMITIVE_ID;
    in_var_TEXCOORD9 = stage_input.in_var_TEXCOORD9;
    in_var_VELOCITY_PREV_POS = stage_input.in_var_VELOCITY_PREV_POS;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_FragDepth = gl_FragDepth;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    stage_output.out_var_SV_Target1 = out_var_SV_Target1;
    stage_output.out_var_SV_Target2 = out_var_SV_Target2;
    stage_output.out_var_SV_Target3 = out_var_SV_Target3;
    stage_output.out_var_SV_Target4 = out_var_SV_Target4;
    stage_output.out_var_SV_Target6 = out_var_SV_Target6;
    return stage_output;
}

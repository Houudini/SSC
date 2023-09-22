#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float3x3 _122 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);

cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    row_major float4x4 View_View_PrevTranslatedWorldToClip : packoffset(c85);
    float3 View_View_RelativePrevPreViewTranslation : packoffset(c108);
    uint View_View_FrameNumber : packoffset(c144.w);
    uint View_View_WorldIsPaused : packoffset(c145.w);
    uint View_View_InstanceSceneDataSOAStride : packoffset(c284);
};

ByteAddressBuffer View_PrimitiveSceneData;
ByteAddressBuffer View_InstanceSceneData;
ByteAddressBuffer View_InstancePayloadData;
ByteAddressBuffer InstanceCulling_InstanceIdsBuffer;
cbuffer LocalVFLooseParameters
{
    uint LocalVFLooseParameters_LocalVFLooseParameters_FrameNumber : packoffset(c0);
};

cbuffer LocalVF
{
    int4 LocalVF_LocalVF_VertexFetch_Parameters : packoffset(c0);
};

uint bIsGPUSkinPassThrough;

Buffer<float4> LocalVFLooseParameters_GPUSkinPassThroughPreviousPositionBuffer;
Buffer<float4> LocalVF_VertexFetch_TexCoordBuffer;
Buffer<float4> LocalVF_VertexFetch_PackedTangentsBuffer;

static float4 gl_Position;
static int gl_VertexIndex;
static int gl_InstanceIndex;
static float4 in_var_ATTRIBUTE0;
static uint in_var_ATTRIBUTE13;
static float4 out_var_TEXCOORD10_centroid;
static float4 out_var_TEXCOORD11_centroid;
static float4 out_var_TEXCOORD0[1];
static uint out_var_PRIMITIVE_ID;
static float3 out_var_TEXCOORD9;
static float4 out_var_VELOCITY_PREV_POS;

struct SPIRV_Cross_Input
{
    float4 in_var_ATTRIBUTE0 : ATTRIBUTE0;
    uint in_var_ATTRIBUTE13 : ATTRIBUTE13;
    uint gl_VertexIndex : SV_VertexID;
    uint gl_InstanceIndex : SV_InstanceID;
};

struct SPIRV_Cross_Output
{
    float4 out_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 out_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 out_var_TEXCOORD0[1] : TEXCOORD0;
    nointerpolation uint out_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float3 out_var_TEXCOORD9 : TEXCOORD9;
    float4 out_var_VELOCITY_PREV_POS : VELOCITY_PREV_POS;
    precise float4 gl_Position : SV_Position;
};

void vert_main()
{
    float3 _145 = -View_View_ViewTilePosition;
    uint _164 = 0u;
    if ((in_var_ATTRIBUTE13 & 2147483648u) != 0u)
    {
        _164 = uint(int(asuint(asfloat(View_PrimitiveSceneData.Load4(((in_var_ATTRIBUTE13 & 2147483647u) * 41u) * 16 + 0)).y))) + uint(gl_InstanceIndex);
    }
    else
    {
        _164 = InstanceCulling_InstanceIdsBuffer.Load((in_var_ATTRIBUTE13 + uint(gl_InstanceIndex)) * 4 + 0) & 268435455u;
    }
    uint _170 = asuint(asfloat(View_InstanceSceneData.Load4(_164 * 16 + 0)).x);
    uint _172 = (_170 >> 0u) & 1048575u;
    uint _174 = (_170 >> 20u) & 4095u;
    float3 _429 = 0.0f.xxx;
    float4x4 _430 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float3 _431 = 0.0f.xxx;
    float4x4 _432 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float _433 = 0.0f;
    [branch]
    if (false || (_172 != 1048575u))
    {
        uint _184 = _172 * 41u;
        uint _209 = ((_174 & 8u) != 0u) ? (((((asuint(asfloat(View_InstanceSceneData.Load4(_164 * 16 + 0)).y) >> 0u) & 16777215u) * asuint(asfloat(View_PrimitiveSceneData.Load4((_184 + 27u) * 16 + 0)).w)) + asuint(asfloat(View_PrimitiveSceneData.Load4((_184 + 26u) * 16 + 0)).w)) + (((_174 & 64u) != 0u) ? 2u : uint(((_174 & 32u) != 0u) || ((_174 & 128u) != 0u)))) : 4294967295u;
        uint4 _228 = asuint(asfloat(View_InstanceSceneData.Load4((View_View_InstanceSceneDataSOAStride + _164) * 16 + 0)));
        uint _230 = (2u * View_View_InstanceSceneDataSOAStride) + _164;
        float4x4 _234 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _234[3] = float4(asfloat(View_InstanceSceneData.Load4(_230 * 16 + 0)).x, asfloat(View_InstanceSceneData.Load4(_230 * 16 + 0)).y, asfloat(View_InstanceSceneData.Load4(_230 * 16 + 0)).z, 0.0f.xxxx.w);
        _234[3].w = 1.0f;
        uint _236 = _228.x;
        uint _243 = _228.y;
        float _246 = float((_243 >> 0u) & 32767u);
        float2 _250 = (float3(float((_236 >> 0u) & 65535u), float((_236 >> 16u) & 65535u), _246).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
        float _251 = _246 - 16384.0f;
        float _252 = _251 * 4.3161006033187732100486755371094e-05f;
        bool _254 = (_243 & 32768u) != 0u;
        float _255 = _250.x;
        float _256 = _250.y;
        float _257 = _255 + _256;
        float _258 = _255 - _256;
        float3 _264 = normalize(float3(_257, _258, 2.0f - dot(1.0f.xx, abs(float2(_257, _258)))));
        float4 _265 = float4(_264.x, _264.y, _264.z, 0.0f.xxxx.w);
        _234[2] = _265;
        float _269 = 1.0f / (1.0f + _264.z);
        float _270 = _264.x;
        float _271 = -_270;
        float _272 = _264.y;
        float _274 = (_271 * _272) * _269;
        float _286 = sqrt(mad(_251 * (-4.3161006033187732100486755371094e-05f), _252, 1.0f));
        float3 _291 = (float3(mad(-(_270 * _270), _269, 1.0f), _274, _271) * (_254 ? _252 : _286)) + (float3(_274, mad(-(_272 * _272), _269, 1.0f), -_272) * (_254 ? _286 : _252));
        float4 _292 = float4(_291.x, _291.y, _291.z, 0.0f.xxxx.w);
        _234[0] = _292;
        float3 _296 = cross(_264.xyz, _291.xyz);
        float4 _297 = float4(_296.x, _296.y, _296.z, 0.0f.xxxx.w);
        _234[1] = _297;
        uint _299 = _228.w;
        uint _304 = _228.z;
        float3 _312 = (float3(uint3(_304 >> 0u, _304 >> 16u, _299 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_299 >> 16u) - 15u) << 23u);
        _234[0] = _292 * _312.x;
        _234[1] = _297 * _312.y;
        _234[2] = _265 * _312.z;
        float4x4 _428 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        [branch]
        if (_209 != 4294967295u)
        {
            uint4 _335 = asuint(asfloat(View_InstancePayloadData.Load4(_209 * 16 + 0)));
            uint _336 = _209 + 1u;
            float4x4 _340 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
            _340[3] = float4(asfloat(View_InstancePayloadData.Load4(_336 * 16 + 0)).x, asfloat(View_InstancePayloadData.Load4(_336 * 16 + 0)).y, asfloat(View_InstancePayloadData.Load4(_336 * 16 + 0)).z, 0.0f.xxxx.w);
            _340[3].w = 1.0f;
            uint _342 = _335.x;
            uint _349 = _335.y;
            float _352 = float((_349 >> 0u) & 32767u);
            float2 _356 = (float3(float((_342 >> 0u) & 65535u), float((_342 >> 16u) & 65535u), _352).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
            float _357 = _352 - 16384.0f;
            float _358 = _357 * 4.3161006033187732100486755371094e-05f;
            bool _360 = (_349 & 32768u) != 0u;
            float _361 = _356.x;
            float _362 = _356.y;
            float _363 = _361 + _362;
            float _364 = _361 - _362;
            float3 _370 = normalize(float3(_363, _364, 2.0f - dot(1.0f.xx, abs(float2(_363, _364)))));
            float4 _371 = float4(_370.x, _370.y, _370.z, 0.0f.xxxx.w);
            _340[2] = _371;
            float _375 = 1.0f / (1.0f + _370.z);
            float _376 = _370.x;
            float _377 = -_376;
            float _378 = _370.y;
            float _380 = (_377 * _378) * _375;
            float _392 = sqrt(mad(_357 * (-4.3161006033187732100486755371094e-05f), _358, 1.0f));
            float3 _397 = (float3(mad(-(_376 * _376), _375, 1.0f), _380, _377) * (_360 ? _358 : _392)) + (float3(_380, mad(-(_378 * _378), _375, 1.0f), -_378) * (_360 ? _392 : _358));
            float4 _398 = float4(_397.x, _397.y, _397.z, 0.0f.xxxx.w);
            _340[0] = _398;
            float3 _402 = cross(_370.xyz, _397.xyz);
            float4 _403 = float4(_402.x, _402.y, _402.z, 0.0f.xxxx.w);
            _340[1] = _403;
            uint _405 = _335.w;
            uint _410 = _335.z;
            float3 _418 = (float3(uint3(_410 >> 0u, _410 >> 16u, _405 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_405 >> 16u) - 15u) << 23u);
            _340[0] = _398 * _418.x;
            _340[1] = _403 * _418.y;
            _340[2] = _371 * _418.z;
            _428 = _340;
        }
        else
        {
            _428 = mul(_234, transpose(float4x4(asfloat(View_PrimitiveSceneData.Load4((_184 + 14u) * 16 + 0)), asfloat(View_PrimitiveSceneData.Load4((_184 + 15u) * 16 + 0)), asfloat(View_PrimitiveSceneData.Load4((_184 + 16u) * 16 + 0)), float4(0.0f, 0.0f, 0.0f, 1.0f))));
        }
        _429 = 1.0f.xxx / abs(_312).xyz;
        _430 = _234;
        _431 = asfloat(View_PrimitiveSceneData.Load4((_184 + 1u) * 16 + 0)).xyz;
        _432 = _428;
        _433 = ((_174 & 1u) != 0u) ? (-1.0f) : 1.0f;
    }
    else
    {
        _429 = 0.0f.xxx;
        _430 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _431 = 0.0f.xxx;
        _432 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _433 = 0.0f;
    }
    uint _442 = uint(LocalVF_LocalVF_VertexFetch_Parameters.w) + uint(gl_VertexIndex);
    uint _443 = 2u * _442;
    float4 _448 = LocalVF_VertexFetch_PackedTangentsBuffer.Load(_443 + 1u);
    float _449 = _448.w;
    float3 _450 = _448.xyz;
    float3 _452 = cross(_450, LocalVF_VertexFetch_PackedTangentsBuffer.Load(_443).xyz) * _449;
    float3x3 _455 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);
    _455[0] = cross(_452, _450) * _449;
    _455[1] = _452;
    _455[2] = _450;
    float3x3 _464 = float3x3(_430[0].xyz, _430[1].xyz, _430[2].xyz);
    _464[0] = _430[0].xyz * _429.x;
    _464[1] = _430[1].xyz * _429.y;
    _464[2] = _430[2].xyz * _429.z;
    float3x3 _474 = mul(_455, _464);
    float3 _478 = in_var_ATTRIBUTE0.yyy * _430[1].xyz;
    float3 _479 = mad(in_var_ATTRIBUTE0.xxx, _430[0].xyz, _478);
    float3 _481 = mad(in_var_ATTRIBUTE0.zzz, _430[2].xyz, _479);
    float3 _484 = _431 + _145;
    float3 _485 = _430[3].xyz + View_View_RelativePreViewTranslation;
    float3 _486 = _484 * 2097152.0f;
    float3 _487 = _486 + _485;
    float3 _488 = _481 + _487;
    float _489 = _488.x;
    float _490 = _488.y;
    float _491 = _488.z;
    float4 _492 = float4(_489, _490, _491, 1.0f);
    uint _495 = uint(LocalVF_LocalVF_VertexFetch_Parameters.y);
    float4 _501 = LocalVF_VertexFetch_TexCoordBuffer.Load((_495 * _442) + min(0u, (_495 - 1u)));
    float4 _502 = float4(_492.x, _492.y, _492.z, _492.w);
    float4 _503 = mul(_502, View_View_TranslatedWorldToClip);
    float4 _516[1] = { float4(_501.x, _501.y, 0.0f.xxxx.z, 0.0f.xxxx.w) };
    float4 _569 = 0.0f.xxxx;
    [flatten]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4((_172 * 41u) * 16 + 0)).x) & 32u) != 0u)
    {
        float4 _546 = 0.0f.xxxx;
        if (bIsGPUSkinPassThrough != 0u)
        {
            float4 _545 = 0.0f.xxxx;
            if ((View_View_FrameNumber == LocalVFLooseParameters_LocalVFLooseParameters_FrameNumber) && (View_View_WorldIsPaused == 0u))
            {
                uint _534 = uint(gl_VertexIndex) * 3u;
                _545 = float4(LocalVFLooseParameters_GPUSkinPassThroughPreviousPositionBuffer.Load(_534).x, LocalVFLooseParameters_GPUSkinPassThroughPreviousPositionBuffer.Load(_534 + 1u).x, LocalVFLooseParameters_GPUSkinPassThroughPreviousPositionBuffer.Load(_534 + 2u).x, 1.0f);
            }
            else
            {
                _545 = in_var_ATTRIBUTE0;
            }
            _546 = _545;
        }
        else
        {
            _546 = in_var_ATTRIBUTE0;
        }
        _569 = mul(float4(mad(_546.zzz, _432[2].xyz, mad(_546.xxx, _432[0].xyz, _546.yyy * _432[1].xyz)) + (_486 + (_432[3].xyz + View_View_RelativePrevPreViewTranslation)), 1.0f), View_View_PrevTranslatedWorldToClip);
    }
    else
    {
        _569 = float4(0.0f, 0.0f, 0.0f, 1.0f);
    }
    out_var_TEXCOORD10_centroid = float4(_474[0], 0.0f);
    out_var_TEXCOORD11_centroid = float4(_474[2], _449 * _433);
    out_var_TEXCOORD0 = _516;
    out_var_PRIMITIVE_ID = _172;
    out_var_TEXCOORD9 = _492.xyz;
    out_var_VELOCITY_PREV_POS = _569;
    gl_Position = _503;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_VertexIndex = int(stage_input.gl_VertexIndex);
    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
    in_var_ATTRIBUTE0 = stage_input.in_var_ATTRIBUTE0;
    in_var_ATTRIBUTE13 = stage_input.in_var_ATTRIBUTE13;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.out_var_TEXCOORD10_centroid = out_var_TEXCOORD10_centroid;
    stage_output.out_var_TEXCOORD11_centroid = out_var_TEXCOORD11_centroid;
    stage_output.out_var_TEXCOORD0 = out_var_TEXCOORD0;
    stage_output.out_var_PRIMITIVE_ID = out_var_PRIMITIVE_ID;
    stage_output.out_var_TEXCOORD9 = out_var_TEXCOORD9;
    stage_output.out_var_VELOCITY_PREV_POS = out_var_VELOCITY_PREV_POS;
    return stage_output;
}

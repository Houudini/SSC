#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float4 _112 = 0.0f.xxxx;

cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    row_major float4x4 View_View_ViewToClip : packoffset(c32);
    row_major float4x4 View_View_ClipToView : packoffset(c40);
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c71);
    float4 View_View_ScreenPositionScaleBias : packoffset(c72);
    float3 View_View_TranslatedWorldCameraOrigin : packoffset(c74);
    float4 View_View_BufferSizeAndInvSize : packoffset(c132);
    float View_View_PreExposure : packoffset(c136.y);
    uint View_View_StateFrameIndexMod8 : packoffset(c145);
};

cbuffer DeferredLightUniforms
{
    float4 DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask : packoffset(c0);
    float2 DeferredLightUniforms_DeferredLightUniforms_DistanceFadeMAD : packoffset(c1);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength : packoffset(c1.z);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : packoffset(c1.w);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity : packoffset(c2);
    uint DeferredLightUniforms_DeferredLightUniforms_ShadowedBits : packoffset(c2.z);
    uint DeferredLightUniforms_DeferredLightUniforms_LightingChannelMask : packoffset(c2.w);
    float3 DeferredLightUniforms_DeferredLightUniforms_Direction : packoffset(c5);
};

Texture2D<float4> SceneTexturesStruct_SceneDepthTexture;
Texture2D<float4> SceneTexturesStruct_GBufferATexture;
Texture2D<float4> SceneTexturesStruct_GBufferBTexture;
Texture2D<float4> SceneTexturesStruct_GBufferDTexture;
Texture2D<float4> SceneTexturesStruct_GBufferETexture;
Texture2D<float4> SceneTexturesStruct_ScreenSpaceAOTexture;
SamplerState SceneTexturesStruct_PointClampSampler;
Texture2D<float4> LightAttenuationTexture;
SamplerState LightAttenuationTextureSampler;
Texture2D<uint4> LightingChannelsTexture;

static float4 gl_FragCoord;
static float2 in_var_TEXCOORD0;
static float3 in_var_TEXCOORD1;
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float2 in_var_TEXCOORD0 : TEXCOORD0;
    float3 in_var_TEXCOORD1 : TEXCOORD1;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

void frag_main()
{
    float4 _121 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float _122 = _121.x;
    float _132 = -View_View_InvDeviceZToWorldZTransform.w;
    float _135 = mad(_122, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_122, View_View_InvDeviceZToWorldZTransform.z, _132));
    float4 _144 = SceneTexturesStruct_GBufferETexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    uint _147 = uint(mad(SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f).w, 255.0f, 0.5f));
    uint _150 = ((_147 >> 0u) & 15u) << 0u;
    uint _153 = ((_147 >> 4u) & 15u) << 0u;
    float4 _155 = 0.0f.xxxx;
    _155.x = _144.x;
    _155.y = _144.y;
    _155.z = _144.z;
    _155.w = _144.w;
    float4 _163 = 0.0f.xxxx;
    _163.w = SceneTexturesStruct_GBufferDTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f).w;
    int _164 = int(_150);
    bool _167 = (_164 == 2) || (_164 == 3);
    bool _170 = _164 == 5;
    bool _172 = _164 == 6;
    bool _174 = _164 == 7;
    bool _178 = _164 == 9;
    bool4 _180 = ((((((_167 || (_164 == 4)) || _170) || _172) || _174) || (_164 == 8)) || _178).xxxx;
    float4 _181 = float4(_180.x ? _163.x : 0.0f.xxxx.x, _180.y ? _163.y : 0.0f.xxxx.y, _180.z ? _163.z : 0.0f.xxxx.z, _180.w ? _163.w : 0.0f.xxxx.w);
    bool4 _185 = (!((_153 & 2u) != 0u)).xxxx;
    float4 _189 = (((_153 & 4u) != 0u) ? 0.0f : 1.0f).xxxx;
    int3 _204 = int3(uint3(uint2(in_var_TEXCOORD0 * View_View_BufferSizeAndInvSize.xy), 0u));
    float4 _577 = 0.0f.xxxx;
    [branch]
    if ((_150 > 0u) && ((LightingChannelsTexture.Load(int3(_204.xy, _204.z)).x & DeferredLightUniforms_DeferredLightUniforms_LightingChannelMask) != 0u))
    {
        float4 _218 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
        float _219 = _218.x;
        float _232 = abs(DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength);
        float4 _256 = LightAttenuationTexture.SampleLevel(LightAttenuationTextureSampler, in_var_TEXCOORD0, 0.0f);
        float4 _257 = _256 * _256;
        float _258 = _181.w;
        float _261 = View_View_ClipToView[1u].y * _135;
        float _290 = 0.0f;
        float _291 = 0.0f;
        float _292 = 0.0f;
        [branch]
        if (DeferredLightUniforms_DeferredLightUniforms_ShadowedBits != 0u)
        {
            float _267 = lerp(1.0f, dot(float4(_185.x ? _155.x : _189.x, _185.y ? _155.y : _189.y, _185.z ? _155.z : _189.z, _185.w ? _155.w : _189.w), DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask), dot(DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask, 1.0f.xxxx));
            float _271 = clamp(mad(_135, DeferredLightUniforms_DeferredLightUniforms_DistanceFadeMAD.x, DeferredLightUniforms_DeferredLightUniforms_DistanceFadeMAD.y), 0.0f, 1.0f);
            float _272 = _271 * _271;
            float _276 = lerp(_257.y, _267, _272);
            float _277 = _257.w;
            float _279 = _257.z;
            float _289 = 0.0f;
            [flatten]
            if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits > 1u) && (_232 > 0.0f))
            {
                _289 = _232 * ((DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength < 0.0f) ? 1.0f : _261);
            }
            else
            {
                _289 = 0.0f;
            }
            _290 = (isnan(_277) ? _276 : (isnan(_276) ? _277 : min(_276, _277))) * _279;
            _291 = lerp(_257.x, _267, _272) * _279;
            _292 = _289;
        }
        else
        {
            _290 = 1.0f;
            _291 = SceneTexturesStruct_ScreenSpaceAOTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f).x;
            _292 = 0.0f;
        }
        float _299 = 0.0f;
        if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits < 2u) && (_150 == 7u))
        {
            _299 = 0.20000000298023223876953125f * _261;
        }
        else
        {
            _299 = _292;
        }
        float _301 = (_150 == 9u) ? 0.5f : _299;
        float _568 = 0.0f;
        float _569 = 0.0f;
        [branch]
        if (_301 > 0.0f)
        {
            float4 _312 = mul(float4((in_var_TEXCOORD1 * (mad(_219, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_219, View_View_InvDeviceZToWorldZTransform.z, _132)))) + View_View_TranslatedWorldCameraOrigin, 1.0f), View_View_TranslatedWorldToClip);
            float4 _319 = _312 + mul(float4(DeferredLightUniforms_DeferredLightUniforms_Direction * _301, 0.0f), View_View_TranslatedWorldToClip);
            float3 _323 = _312.xyz / _312.w.xxx;
            float3 _328 = (_319.xyz / _319.w.xxx) - _323;
            float _335 = _323.z;
            float3 _338 = float3(mad(_323.xy, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz), _335);
            float3 _344 = float3(_328.xy * View_View_ScreenPositionScaleBias.xy, _328.z);
            float4 _349 = _312 + mul(float4(0.0f, 0.0f, _301, 0.0f), View_View_ViewToClip);
            float _356 = abs((_349.xyz / _349.w.xxx).z - _335);
            float _357 = _356 * 0.25f;
            float _358 = mad(frac(52.98291778564453125f * frac(dot(gl_FragCoord.xy + (float2(32.66500091552734375f, 11.81499958038330078125f) * float(View_View_StateFrameIndexMod8)), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f)))) - 0.5f, 0.125f, 0.125f);
            float4 _361 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _338.xy, 0.0f);
            float _362 = _361.x;
            float3 _364 = _338 + (_344 * _358);
            float4 _367 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _364.xy, 0.0f);
            float _368 = _367.x;
            float _377 = (((abs(mad(_356, 0.25f, _364.z - _368)) < _357) && (_368 != _362)) && true) ? _358 : (-1.0f);
            float _378 = _358 + 0.125f;
            float3 _380 = _338 + (_344 * _378);
            float4 _383 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _380.xy, 0.0f);
            float _384 = _383.x;
            float _394 = (((abs(mad(_356, 0.25f, _380.z - _384)) < _357) && (_384 != _362)) && (_377 < 0.0f)) ? _378 : _377;
            float _395 = _358 + 0.25f;
            float3 _397 = _338 + (_344 * _395);
            float4 _400 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _397.xy, 0.0f);
            float _401 = _400.x;
            float _411 = (((abs(mad(_356, 0.25f, _397.z - _401)) < _357) && (_401 != _362)) && (_394 < 0.0f)) ? _395 : _394;
            float _412 = _358 + 0.375f;
            float3 _414 = _338 + (_344 * _412);
            float4 _417 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _414.xy, 0.0f);
            float _418 = _417.x;
            float _428 = (((abs(mad(_356, 0.25f, _414.z - _418)) < _357) && (_418 != _362)) && (_411 < 0.0f)) ? _412 : _411;
            float _429 = _358 + 0.5f;
            float3 _431 = _338 + (_344 * _429);
            float4 _434 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _431.xy, 0.0f);
            float _435 = _434.x;
            float _445 = (((abs(mad(_356, 0.25f, _431.z - _435)) < _357) && (_435 != _362)) && (_428 < 0.0f)) ? _429 : _428;
            float _446 = _358 + 0.625f;
            float3 _448 = _338 + (_344 * _446);
            float4 _451 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _448.xy, 0.0f);
            float _452 = _451.x;
            float _462 = (((abs(mad(_356, 0.25f, _448.z - _452)) < _357) && (_452 != _362)) && (_445 < 0.0f)) ? _446 : _445;
            float _463 = _358 + 0.75f;
            float3 _465 = _338 + (_344 * _463);
            float4 _468 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _465.xy, 0.0f);
            float _469 = _468.x;
            float _479 = (((abs(mad(_356, 0.25f, _465.z - _469)) < _357) && (_469 != _362)) && (_462 < 0.0f)) ? _463 : _462;
            float _480 = _358 + 0.875f;
            float3 _482 = _338 + (_344 * _480);
            float4 _485 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _482.xy, 0.0f);
            float _486 = _485.x;
            float _496 = (((abs(mad(_356, 0.25f, _482.z - _486)) < _357) && (_486 != _362)) && (_479 < 0.0f)) ? _480 : _479;
            bool _533 = false;
            float _534 = 0.0f;
            if (_496 > 0.0f)
            {
                float2 _502 = (_338 + (_344 * _496)).xy;
                bool2 _521 = bool2(0.0f.xx.x < _502.x, 0.0f.xx.y < _502.y);
                bool2 _522 = bool2(_502.x < 1.0f.xx.x, _502.y < 1.0f.xx.y);
                _533 = ((uint(SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _502, 0.0f).w * 3.999000072479248046875f) & 1u) != 0u) && ((((uint(mad(SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _502, 0.0f).w, 255.0f, 0.5f)) >> 0u) & 15u) << 0u) != 9u);
                _534 = all(bool2(_521.x && _522.x, _521.y && _522.y)) ? (_496 * _301) : (-1.0f);
            }
            else
            {
                _533 = false;
                _534 = -1.0f;
            }
            float _566 = 0.0f;
            float _567 = 0.0f;
            if (_534 > 0.0f)
            {
                float _538 = _533 ? DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity;
                float _562 = 0.0f;
                [branch]
                if (((((_538 > 0.0f) && ((((_167 || _170) || _172) || _174) || _178)) && (_150 != 7u)) && (_150 != 9u)) && (_150 != 5u))
                {
                    _562 = _538 * (1.0f - clamp(exp((log(1.0f - (isnan(0.9900000095367431640625f) ? _258 : (isnan(_258) ? 0.9900000095367431640625f : min(_258, 0.9900000095367431640625f)))) * 0.0500000007450580596923828125f) * _534), 0.0f, 1.0f));
                }
                else
                {
                    _562 = _538;
                }
                float _563 = 1.0f - _562;
                _566 = _290 * _563;
                _567 = _291 * _563;
            }
            else
            {
                _566 = _290;
                _567 = _291;
            }
            _568 = _566;
            _569 = _567;
        }
        else
        {
            _568 = _290;
            _569 = _291;
        }
        float _574 = 0.0f;
        [branch]
        if ((_569 + _568) > 0.0f)
        {
            _574 = 1.0f;
        }
        else
        {
            _574 = 0.60000002384185791015625f;
        }
        float4 _575 = float4(0.100000001490116119384765625f, 0.02500000037252902984619140625f, 0.007500000298023223876953125f, 0.0f) * _574;
        _577 = _575 + _575;
    }
    else
    {
        _577 = 0.0f.xxxx;
    }
    out_var_SV_Target0 = _577 * View_View_PreExposure;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}

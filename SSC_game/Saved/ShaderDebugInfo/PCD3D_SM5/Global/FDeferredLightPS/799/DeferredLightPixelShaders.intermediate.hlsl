#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float4 _188 = 0.0f.xxxx;
static float _189 = 0.0f;

cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    row_major float4x4 View_View_ViewToClip : packoffset(c32);
    row_major float4x4 View_View_ClipToView : packoffset(c40);
    row_major float4x4 View_View_ScreenToTranslatedWorld : packoffset(c56);
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c71);
    float4 View_View_ScreenPositionScaleBias : packoffset(c72);
    float3 View_View_TranslatedWorldCameraOrigin : packoffset(c74);
    float4 View_View_BufferSizeAndInvSize : packoffset(c132);
    float View_View_PreExposure : packoffset(c136.y);
    float4 View_View_DiffuseOverrideParameter : packoffset(c137);
    float4 View_View_SpecularOverrideParameter : packoffset(c138);
    uint View_View_StateFrameIndexMod8 : packoffset(c145);
    float4 View_View_TemporalAAParams : packoffset(c153);
    float View_View_bCheckerboardSubsurfaceProfileRendering : packoffset(c228.z);
    float View_View_MinRoughness : packoffset(c245.z);
    float View_View_bSubsurfacePostprocessEnabled : packoffset(c247.w);
    float View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : packoffset(c284.w);
};

cbuffer DeferredLightUniforms
{
    float4 DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask : packoffset(c0);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength : packoffset(c1.z);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : packoffset(c1.w);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity : packoffset(c2);
    uint DeferredLightUniforms_DeferredLightUniforms_ShadowedBits : packoffset(c2.z);
    uint DeferredLightUniforms_DeferredLightUniforms_LightingChannelMask : packoffset(c2.w);
    float3 DeferredLightUniforms_DeferredLightUniforms_TranslatedWorldPosition : packoffset(c3);
    float DeferredLightUniforms_DeferredLightUniforms_InvRadius : packoffset(c3.w);
    float3 DeferredLightUniforms_DeferredLightUniforms_Color : packoffset(c4);
    float DeferredLightUniforms_DeferredLightUniforms_FalloffExponent : packoffset(c4.w);
    float3 DeferredLightUniforms_DeferredLightUniforms_Direction : packoffset(c5);
    float DeferredLightUniforms_DeferredLightUniforms_SpecularScale : packoffset(c5.w);
    float3 DeferredLightUniforms_DeferredLightUniforms_Tangent : packoffset(c6);
    float DeferredLightUniforms_DeferredLightUniforms_SourceRadius : packoffset(c6.w);
    float2 DeferredLightUniforms_DeferredLightUniforms_SpotAngles : packoffset(c7);
    float DeferredLightUniforms_DeferredLightUniforms_SoftSourceRadius : packoffset(c7.z);
    float DeferredLightUniforms_DeferredLightUniforms_SourceLength : packoffset(c7.w);
    float DeferredLightUniforms_DeferredLightUniforms_IESAtlasIndex : packoffset(c9.w);
};

Texture2D<float4> View_PreIntegratedBRDF;
SamplerState View_PreIntegratedBRDFSampler;
Texture2D<float4> View_SSProfilesTexture;
Texture2DArray<float4> View_IESAtlasTexture;
SamplerState View_IESAtlasSampler;
Texture2D<float4> SceneTexturesStruct_SceneDepthTexture;
Texture2D<float4> SceneTexturesStruct_GBufferATexture;
Texture2D<float4> SceneTexturesStruct_GBufferBTexture;
Texture2D<float4> SceneTexturesStruct_GBufferCTexture;
Texture2D<float4> SceneTexturesStruct_GBufferDTexture;
Texture2D<float4> SceneTexturesStruct_GBufferETexture;
Texture2D<float4> SceneTexturesStruct_GBufferFTexture;
Texture2D<float4> SceneTexturesStruct_ScreenSpaceAOTexture;
SamplerState SceneTexturesStruct_PointClampSampler;
Texture2D<float4> LightAttenuationTexture;
SamplerState LightAttenuationTextureSampler;
Texture2D<uint4> LightingChannelsTexture;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD0;
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD0 : TEXCOORD0;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

void frag_main()
{
    float2 _204 = in_var_TEXCOORD0.xy / in_var_TEXCOORD0.w.xx;
    float2 _209 = mad(_204, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz);
    float4 _213 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    float _214 = _213.x;
    float _224 = -View_View_InvDeviceZToWorldZTransform.w;
    float4 _230 = SceneTexturesStruct_GBufferFTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    float4 _233 = SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    float4 _236 = SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    float4 _239 = SceneTexturesStruct_GBufferCTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    float4 _242 = SceneTexturesStruct_GBufferDTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    float4 _245 = SceneTexturesStruct_GBufferETexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
    uint2 _250 = uint2(_209 * View_View_BufferSizeAndInvSize.xy);
    uint _254 = _250.x;
    bool _259 = (((_254 + _250.y) + uint(View_View_TemporalAAParams.x)) % 2u) != 0u;
    float3 _261 = 0.0f.xxx;
    _261.x = _233.x;
    _261.y = _233.y;
    _261.z = _233.z;
    float _266 = _236.x;
    float _267 = _236.y;
    float _268 = _236.z;
    uint _271 = uint(mad(_236.w, 255.0f, 0.5f));
    uint _274 = ((_271 >> 0u) & 15u) << 0u;
    uint _277 = ((_271 >> 4u) & 15u) << 0u;
    float3 _279 = 0.0f.xxx;
    _279.x = _239.x;
    _279.y = _239.y;
    _279.z = _239.z;
    float4 _285 = 0.0f.xxxx;
    _285.x = _245.x;
    _285.y = _245.y;
    _285.z = _245.z;
    _285.w = _245.w;
    float4 _293 = 0.0f.xxxx;
    _293.x = _242.x;
    _293.y = _242.y;
    _293.z = _242.z;
    _293.w = _242.w;
    int _304 = int(_274);
    bool _307 = (_304 == 2) || (_304 == 3);
    bool _310 = _304 == 5;
    bool _312 = _304 == 6;
    bool _314 = _304 == 7;
    bool _318 = _304 == 9;
    bool4 _320 = ((((((_307 || (_304 == 4)) || _310) || _312) || _314) || (_304 == 8)) || _318).xxxx;
    float4 _321 = float4(_320.x ? _293.x : 0.0f.xxxx.x, _320.y ? _293.y : 0.0f.xxxx.y, _320.z ? _293.z : 0.0f.xxxx.z, _320.w ? _293.w : 0.0f.xxxx.w);
    bool4 _325 = (!((_277 & 2u) != 0u)).xxxx;
    float4 _329 = (((_277 & 4u) != 0u) ? 0.0f : 1.0f).xxxx;
    float3 _333 = normalize((_261 * 2.0f) - 1.0f.xxx);
    bool _334 = _274 == 9u;
    float _335 = _334 ? 0.0f : _266;
    float3 _338 = _335.xxx;
    float3 _339 = lerp((0.07999999821186065673828125f * _267).xxx, _279, _338);
    bool _340 = _310 || _318;
    float3 _364 = 0.0f.xxx;
    float _365 = 0.0f;
    float3 _366 = 0.0f.xxx;
    if (_340)
    {
        bool3 _351 = (View_View_bSubsurfacePostprocessEnabled != 0.0f).xxx;
        float3 _361 = 0.0f.xxx;
        float _362 = 0.0f;
        float3 _363 = 0.0f.xxx;
        if ((View_View_bSubsurfacePostprocessEnabled > 0.0f) && (View_View_bCheckerboardSubsurfaceProfileRendering > 0.0f))
        {
            float _358 = float(!_259);
            _361 = float(_259).xxx;
            _362 = _267 * _358;
            _363 = _339 * _358;
        }
        else
        {
            _361 = float3(_351.x ? 1.0f.xxx.x : _279.x, _351.y ? 1.0f.xxx.y : _279.y, _351.z ? 1.0f.xxx.z : _279.z);
            _362 = _267;
            _363 = _339;
        }
        _364 = _361;
        _365 = _362;
        _366 = _363;
    }
    else
    {
        _364 = _279;
        _365 = _267;
        _366 = _339;
    }
    float3 _373 = mad(_364 - (_364 * _335), View_View_DiffuseOverrideParameter.www, View_View_DiffuseOverrideParameter.xyz);
    float3 _380 = (_366 * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    float3 _388 = 0.0f.xxx;
    float _389 = 0.0f;
    if ((_277 & 1u) != 0u)
    {
        _388 = normalize((_230.xyz * 2.0f) - 1.0f.xxx);
        _389 = mad(_230.w, 2.0f, -1.0f);
    }
    else
    {
        _388 = 0.0f.xxx;
        _389 = 0.0f;
    }
    uint _390 = _277 << 4u;
    int3 _397 = int3(uint3(_254, _250.y, 0u));
    float4 _3463 = 0.0f.xxxx;
    [branch]
    if ((_274 > 0u) && ((LightingChannelsTexture.Load(int3(_397.xy, _397.z)).x & DeferredLightUniforms_DeferredLightUniforms_LightingChannelMask) != 0u))
    {
        float4 _411 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f);
        float _412 = _411.x;
        float _416 = mad(_412, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_412, View_View_InvDeviceZToWorldZTransform.z, _224));
        float4 _428 = mul(float4(_204 * ((View_View_ViewToClip[3u].w < 1.0f) ? _416 : 1.0f), _416, 1.0f), View_View_ScreenToTranslatedWorld);
        float3 _429 = _428.xyz;
        float3 _433 = normalize(_429 - View_View_TranslatedWorldCameraOrigin);
        float _458 = abs(DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength);
        bool _469 = true && (DeferredLightUniforms_DeferredLightUniforms_FalloffExponent == 0.0f);
        float3 _470 = -DeferredLightUniforms_DeferredLightUniforms_Direction;
        float _514 = 0.0f;
        if (DeferredLightUniforms_DeferredLightUniforms_IESAtlasIndex >= 0.0f)
        {
            float3 _493 = normalize(DeferredLightUniforms_DeferredLightUniforms_TranslatedWorldPosition - _429);
            float4 _498 = mul(float4(_493, 0.0f), transpose(float4x4(float4(_470, 0.0f), float4(normalize(cross(DeferredLightUniforms_DeferredLightUniforms_Tangent, _470)), 0.0f), float4(DeferredLightUniforms_DeferredLightUniforms_Tangent, 0.0f), float4(0.0f, 0.0f, 0.0f, 1.0f))));
            _514 = View_IESAtlasTexture.SampleLevel(View_IESAtlasSampler, float3(mad(asin(dot(_493, _470)), 0.3183098733425140380859375f, 0.5f), mad(atan2(-_498.z, -_498.y), 0.15915493667125701904296875f, 0.5f), DeferredLightUniforms_DeferredLightUniforms_IESAtlasIndex), 0.0f).x;
        }
        else
        {
            _514 = 1.0f;
        }
        float4 _529 = LightAttenuationTexture.SampleLevel(LightAttenuationTextureSampler, _209, 0.0f);
        float4 _530 = _529 * _529;
        float3 _531 = -_433;
        float3 _532 = DeferredLightUniforms_DeferredLightUniforms_TranslatedWorldPosition - _429;
        float _533 = dot(_532, _532);
        float3 _535 = _532 * rsqrt(_533);
        float _550 = 0.0f;
        if (_469)
        {
            float _545 = _533 * (DeferredLightUniforms_DeferredLightUniforms_InvRadius * DeferredLightUniforms_DeferredLightUniforms_InvRadius);
            float _548 = clamp(mad(-_545, _545, 1.0f), 0.0f, 1.0f);
            _550 = _548 * _548;
        }
        else
        {
            float3 _539 = _532 * DeferredLightUniforms_DeferredLightUniforms_InvRadius;
            _550 = pow(1.0f - clamp(dot(_539, _539), 0.0f, 1.0f), DeferredLightUniforms_DeferredLightUniforms_FalloffExponent);
        }
        float _556 = clamp((dot(_535, DeferredLightUniforms_DeferredLightUniforms_Direction) - DeferredLightUniforms_DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms_DeferredLightUniforms_SpotAngles.y, 0.0f, 1.0f);
        float _558 = _550 * (_556 * _556);
        float3 _559 = (DeferredLightUniforms_DeferredLightUniforms_Color * (1.0f.xxx * _514)) * _558;
        float _3444 = 0.0f;
        float3 _3445 = 0.0f.xxx;
        float3 _3446 = 0.0f.xxx;
        [branch]
        if (_558 > 0.0f)
        {
            float _563 = _321.w;
            float _566 = View_View_ClipToView[1u].y * (mad(_214, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_214, View_View_InvDeviceZToWorldZTransform.z, _224)));
            float _585 = 0.0f;
            float _586 = 0.0f;
            float _587 = 0.0f;
            float _588 = 0.0f;
            [branch]
            if (DeferredLightUniforms_DeferredLightUniforms_ShadowedBits != 0u)
            {
                float _572 = lerp(1.0f, dot(float4(_325.x ? _285.x : _329.x, _325.y ? _285.y : _329.y, _325.z ? _285.z : _329.z, _325.w ? _285.w : _329.w), DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask), dot(DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask, 1.0f.xxxx));
                float _575 = _530.w;
                float _584 = 0.0f;
                [flatten]
                if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits > 1u) && (_458 > 0.0f))
                {
                    _584 = _458 * ((DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength < 0.0f) ? 1.0f : _566);
                }
                else
                {
                    _584 = 0.0f;
                }
                _585 = _575;
                _586 = _575 * _572;
                _587 = _530.z * _572;
                _588 = _584;
            }
            else
            {
                _585 = 1.0f;
                _586 = 1.0f;
                _587 = SceneTexturesStruct_ScreenSpaceAOTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _209, 0.0f).x;
                _588 = 0.0f;
            }
            float _595 = 0.0f;
            if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits < 2u) && (_274 == 7u))
            {
                _595 = 0.20000000298023223876953125f * _566;
            }
            else
            {
                _595 = _588;
            }
            float _596 = _334 ? 0.5f : _595;
            float _857 = 0.0f;
            float _858 = 0.0f;
            [branch]
            if (_596 > 0.0f)
            {
                float4 _607 = mul(float4(_428.xyz, 1.0f), View_View_TranslatedWorldToClip);
                float4 _614 = _607 + mul(float4(_535 * _596, 0.0f), View_View_TranslatedWorldToClip);
                float3 _618 = _607.xyz / _607.w.xxx;
                float3 _623 = (_614.xyz / _614.w.xxx) - _618;
                float _626 = _618.z;
                float3 _629 = float3(mad(_618.xy, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz), _626);
                float3 _635 = float3(_623.xy * View_View_ScreenPositionScaleBias.xy, _623.z);
                float4 _639 = _607 + mul(float4(0.0f, 0.0f, _596, 0.0f), View_View_ViewToClip);
                float _646 = abs((_639.xyz / _639.w.xxx).z - _626);
                float _647 = _646 * 0.25f;
                float _648 = mad(frac(52.98291778564453125f * frac(dot(gl_FragCoord.xy + (float2(32.66500091552734375f, 11.81499958038330078125f) * float(View_View_StateFrameIndexMod8)), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f)))) - 0.5f, 0.125f, 0.125f);
                float4 _651 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _629.xy, 0.0f);
                float _652 = _651.x;
                float3 _654 = _629 + (_635 * _648);
                float4 _657 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _654.xy, 0.0f);
                float _658 = _657.x;
                float _667 = (((abs(mad(_646, 0.25f, _654.z - _658)) < _647) && (_658 != _652)) && true) ? _648 : (-1.0f);
                float _668 = _648 + 0.125f;
                float3 _670 = _629 + (_635 * _668);
                float4 _673 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _670.xy, 0.0f);
                float _674 = _673.x;
                float _684 = (((abs(mad(_646, 0.25f, _670.z - _674)) < _647) && (_674 != _652)) && (_667 < 0.0f)) ? _668 : _667;
                float _685 = _648 + 0.25f;
                float3 _687 = _629 + (_635 * _685);
                float4 _690 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _687.xy, 0.0f);
                float _691 = _690.x;
                float _701 = (((abs(mad(_646, 0.25f, _687.z - _691)) < _647) && (_691 != _652)) && (_684 < 0.0f)) ? _685 : _684;
                float _702 = _648 + 0.375f;
                float3 _704 = _629 + (_635 * _702);
                float4 _707 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _704.xy, 0.0f);
                float _708 = _707.x;
                float _718 = (((abs(mad(_646, 0.25f, _704.z - _708)) < _647) && (_708 != _652)) && (_701 < 0.0f)) ? _702 : _701;
                float _719 = _648 + 0.5f;
                float3 _721 = _629 + (_635 * _719);
                float4 _724 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _721.xy, 0.0f);
                float _725 = _724.x;
                float _735 = (((abs(mad(_646, 0.25f, _721.z - _725)) < _647) && (_725 != _652)) && (_718 < 0.0f)) ? _719 : _718;
                float _736 = _648 + 0.625f;
                float3 _738 = _629 + (_635 * _736);
                float4 _741 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _738.xy, 0.0f);
                float _742 = _741.x;
                float _752 = (((abs(mad(_646, 0.25f, _738.z - _742)) < _647) && (_742 != _652)) && (_735 < 0.0f)) ? _736 : _735;
                float _753 = _648 + 0.75f;
                float3 _755 = _629 + (_635 * _753);
                float4 _758 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _755.xy, 0.0f);
                float _759 = _758.x;
                float _769 = (((abs(mad(_646, 0.25f, _755.z - _759)) < _647) && (_759 != _652)) && (_752 < 0.0f)) ? _753 : _752;
                float _770 = _648 + 0.875f;
                float3 _772 = _629 + (_635 * _770);
                float4 _775 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _772.xy, 0.0f);
                float _776 = _775.x;
                float _786 = (((abs(mad(_646, 0.25f, _772.z - _776)) < _647) && (_776 != _652)) && (_769 < 0.0f)) ? _770 : _769;
                bool _822 = false;
                float _823 = 0.0f;
                if (_786 > 0.0f)
                {
                    float2 _792 = (_629 + (_635 * _786)).xy;
                    bool2 _810 = bool2(0.0f.xx.x < _792.x, 0.0f.xx.y < _792.y);
                    bool2 _811 = bool2(_792.x < 1.0f.xx.x, _792.y < 1.0f.xx.y);
                    _822 = ((uint(SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _792, 0.0f).w * 3.999000072479248046875f) & 1u) != 0u) && ((((uint(mad(SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _792, 0.0f).w, 255.0f, 0.5f)) >> 0u) & 15u) << 0u) != 9u);
                    _823 = all(bool2(_810.x && _811.x, _810.y && _811.y)) ? (_786 * _596) : (-1.0f);
                }
                else
                {
                    _822 = false;
                    _823 = -1.0f;
                }
                float _855 = 0.0f;
                float _856 = 0.0f;
                if (_823 > 0.0f)
                {
                    float _827 = _822 ? DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity;
                    float _851 = 0.0f;
                    [branch]
                    if (((((_827 > 0.0f) && ((((_307 || _310) || _312) || _314) || _318)) && (_274 != 7u)) && (_274 != 9u)) && (_274 != 5u))
                    {
                        _851 = _827 * (1.0f - clamp(exp((log(1.0f - (isnan(0.9900000095367431640625f) ? _563 : (isnan(_563) ? 0.9900000095367431640625f : min(_563, 0.9900000095367431640625f)))) * 0.0500000007450580596923828125f) * _823), 0.0f, 1.0f));
                    }
                    else
                    {
                        _851 = _827;
                    }
                    float _852 = 1.0f - _851;
                    _855 = _586 * _852;
                    _856 = _587 * _852;
                }
                else
                {
                    _855 = _586;
                    _856 = _587;
                }
                _857 = _855;
                _858 = _856;
            }
            else
            {
                _857 = _586;
                _858 = _587;
            }
            float _3441 = 0.0f;
            float3 _3442 = 0.0f.xxx;
            float3 _3443 = 0.0f.xxx;
            [branch]
            if ((_858 + _857) > 0.0f)
            {
                float3 _864 = DeferredLightUniforms_DeferredLightUniforms_Tangent * (0.5f * DeferredLightUniforms_DeferredLightUniforms_SourceLength);
                float3 _865 = _532 - _864;
                float3 _866 = _532 + _864;
                float _869 = isnan(View_View_MinRoughness) ? _268 : (isnan(_268) ? View_View_MinRoughness : max(_268, View_View_MinRoughness));
                bool _870 = DeferredLightUniforms_DeferredLightUniforms_SourceLength > 0.0f;
                float _895 = 0.0f;
                float _896 = 0.0f;
                float _897 = 0.0f;
                [branch]
                if (_870)
                {
                    float _882 = rsqrt(dot(_865, _865));
                    float _883 = rsqrt(dot(_866, _866));
                    float _884 = _882 * _883;
                    float _886 = dot(_865, _866) * _884;
                    _895 = _886;
                    _896 = 0.5f * mad(dot(_333, _865), _882, dot(_333, _866) * _883);
                    _897 = _884 / mad(_882, _883, mad(_886, 0.5f, 0.5f));
                }
                else
                {
                    float _874 = dot(_865, _865);
                    _895 = 1.0f;
                    _896 = dot(_333, _865 * rsqrt(_874));
                    _897 = 1.0f / (_874 + 1.0f);
                }
                float _915 = 0.0f;
                if (DeferredLightUniforms_DeferredLightUniforms_SourceRadius > 0.0f)
                {
                    float _904 = sqrt(clamp((DeferredLightUniforms_DeferredLightUniforms_SourceRadius * DeferredLightUniforms_DeferredLightUniforms_SourceRadius) * _897, 0.0f, 1.0f));
                    float _914 = 0.0f;
                    if (_896 < _904)
                    {
                        float _908 = -_904;
                        float _910 = _904 + (isnan(_908) ? _896 : (isnan(_896) ? _908 : max(_896, _908)));
                        _914 = (_910 * _910) / (4.0f * _904);
                    }
                    else
                    {
                        _914 = _896;
                    }
                    _915 = _914;
                }
                else
                {
                    _915 = _896;
                }
                float _916 = clamp(_915, 0.0f, 1.0f);
                float _917 = _469 ? _897 : 1.0f;
                float3 _933 = 0.0f.xxx;
                if (_870)
                {
                    float3 _920 = reflect(_433, _333);
                    float3 _921 = _866 - _865;
                    float _922 = dot(_920, _921);
                    _933 = _865 + (_921 * clamp(dot(_865, (_920 * _922) - _921) / mad(DeferredLightUniforms_DeferredLightUniforms_SourceLength, DeferredLightUniforms_DeferredLightUniforms_SourceLength, -(_922 * _922)), 0.0f, 1.0f));
                }
                else
                {
                    _933 = _865;
                }
                float _935 = rsqrt(dot(_933, _933));
                float3 _936 = _933 * _935;
                float _937 = isnan(View_View_MinRoughness) ? _869 : (isnan(_869) ? View_View_MinRoughness : max(_869, View_View_MinRoughness));
                float _942 = clamp((DeferredLightUniforms_DeferredLightUniforms_SourceRadius * _935) * mad(-_937, _937, 1.0f), 0.0f, 1.0f);
                float _944 = clamp(DeferredLightUniforms_DeferredLightUniforms_SoftSourceRadius * _935, 0.0f, 1.0f);
                uint _951 = 0u | (asuint(clamp(mad(-(isnan(DeferredLightUniforms_DeferredLightUniforms_SourceRadius) ? DeferredLightUniforms_DeferredLightUniforms_SourceLength : (isnan(DeferredLightUniforms_DeferredLightUniforms_SourceLength) ? DeferredLightUniforms_DeferredLightUniforms_SourceRadius : max(DeferredLightUniforms_DeferredLightUniforms_SourceLength, DeferredLightUniforms_DeferredLightUniforms_SourceRadius))), 0.0500000007450580596923828125f, 1.0f), 0.0f, 1.0f)) << 1u);
                float3 _3409 = 0.0f.xxx;
                float3 _3410 = 0.0f.xxx;
                float3 _3411 = 0.0f.xxx;
                switch (_274)
                {
                    case 1u:
                    {
                        int _3141 = int(_390);
                        int _3142 = _3141 & 16;
                        bool _3143 = _3142 != 0;
                        float _3258 = 0.0f;
                        float _3259 = 0.0f;
                        float _3260 = 0.0f;
                        float _3261 = 0.0f;
                        float _3262 = 0.0f;
                        float _3263 = 0.0f;
                        float _3264 = 0.0f;
                        float _3265 = 0.0f;
                        float _3266 = 0.0f;
                        [branch]
                        if (_3143)
                        {
                            float3 _3238 = cross(_333, _388);
                            float3 _3239 = normalize(_3238);
                            float _3240 = dot(_333, _936);
                            float _3241 = dot(_333, _531);
                            float _3242 = dot(_531, _936);
                            float _3243 = mad(2.0f, _3242, 2.0f);
                            float _3244 = rsqrt(_3243);
                            float _3245 = _3240 + _3241;
                            float _3246 = _3245 * _3244;
                            float _3247 = clamp(_3246, 0.0f, 1.0f);
                            float _3248 = mad(_3244, _3242, _3244);
                            float _3249 = clamp(_3248, 0.0f, 1.0f);
                            float _3250 = dot(_388, _531);
                            float _3251 = dot(_388, _936);
                            float _3252 = _3251 + _3250;
                            float _3253 = _3252 * _3244;
                            float _3254 = dot(_3239, _531);
                            float _3255 = dot(_3239, _936);
                            float _3256 = _3255 + _3254;
                            float _3257 = _3256 * _3244;
                            _3258 = _3247;
                            _3259 = _3249;
                            _3260 = _3250;
                            _3261 = _3251;
                            _3262 = _3253;
                            _3263 = _3254;
                            _3264 = _3255;
                            _3265 = _3257;
                            _3266 = _3241;
                        }
                        else
                        {
                            float _3147 = dot(_333, _936);
                            float _3148 = dot(_333, _531);
                            float _3149 = dot(_531, _936);
                            float _3150 = mad(2.0f, _3149, 2.0f);
                            float _3151 = rsqrt(_3150);
                            float _3152 = _3147 + _3148;
                            float _3153 = _3152 * _3151;
                            float _3154 = clamp(_3153, 0.0f, 1.0f);
                            float _3155 = mad(_3151, _3149, _3151);
                            float _3156 = clamp(_3155, 0.0f, 1.0f);
                            bool _3157 = _942 > 0.0f;
                            float _3236 = 0.0f;
                            float _3237 = 0.0f;
                            if (_3157)
                            {
                                float _3160 = -_942;
                                float _3161 = mad(_3160, _942, 1.0f);
                                float _3162 = sqrt(_3161);
                                float _3163 = 2.0f * _3147;
                                float _3164 = -_3149;
                                float _3165 = mad(_3163, _3148, _3164);
                                bool _3166 = _3165 >= _3162;
                                float _3234 = 0.0f;
                                float _3235 = 0.0f;
                                if (_3166)
                                {
                                    float _3233 = abs(_3148);
                                    _3234 = 1.0f;
                                    _3235 = _3233;
                                }
                                else
                                {
                                    float _3170 = -_3165;
                                    float _3171 = mad(_3170, _3165, 1.0f);
                                    float _3172 = rsqrt(_3171);
                                    float _3173 = _942 * _3172;
                                    float _3174 = mad(_3170, _3147, _3148);
                                    float _3175 = _3173 * _3174;
                                    float _3176 = 2.0f * _3148;
                                    float _3177 = mad(_3176, _3148, -1.0f);
                                    float _3178 = mad(_3170, _3149, _3177);
                                    float _3179 = _3173 * _3178;
                                    float _3180 = -_3147;
                                    float _3181 = mad(_3180, _3147, 1.0f);
                                    float _3182 = -_3148;
                                    float _3183 = mad(_3182, _3148, _3181);
                                    float _3184 = mad(_3164, _3149, _3183);
                                    float _3185 = _3163 * _3148;
                                    float _3186 = mad(_3185, _3149, _3184);
                                    float _3187 = clamp(_3186, 0.0f, 1.0f);
                                    float _3188 = sqrt(_3187);
                                    float _3189 = _3173 * _3188;
                                    float _3190 = _3189 * 2.0f;
                                    float _3191 = _3190 * _3148;
                                    float _3192 = mad(_3147, _3162, _3148);
                                    float _3193 = mad(_3173, _3174, _3192);
                                    float _3194 = mad(_3149, _3162, 1.0f);
                                    float _3195 = mad(_3173, _3178, _3194);
                                    float _3196 = _3189 * _3195;
                                    float _3197 = _3193 * _3195;
                                    float _3198 = _3191 * _3193;
                                    float _3199 = 0.25f * _3191;
                                    float _3200 = _3199 * _3193;
                                    float _3201 = mad(-0.5f, _3196, _3200);
                                    float _3202 = _3197 * _3201;
                                    float _3203 = _3196 * (-2.0f);
                                    float _3204 = mad(_3191, _3193, _3203);
                                    float _3205 = _3198 * _3204;
                                    float _3206 = mad(_3196, _3196, _3205);
                                    float _3207 = _3195 * _3195;
                                    float _3208 = mad(_3149, _3162, _3195);
                                    float _3209 = mad(-0.5f, _3208, -0.5f);
                                    float _3210 = _3197 * _3209;
                                    float _3211 = mad(_3192, _3207, _3210);
                                    float _3212 = mad(_3193, _3211, _3206);
                                    float _3213 = 2.0f * _3202;
                                    float _3214 = _3202 * _3202;
                                    float _3215 = mad(_3212, _3212, _3214);
                                    float _3216 = _3213 / _3215;
                                    float _3217 = _3216 * _3212;
                                    float _3218 = -_3216;
                                    float _3219 = mad(_3218, _3202, 1.0f);
                                    float _3220 = _3217 * _3189;
                                    float _3221 = mad(_3219, _3175, _3220);
                                    float _3222 = _3217 * _3191;
                                    float _3223 = mad(_3219, _3179, _3222);
                                    float _3224 = mad(_3147, _3162, _3221);
                                    float _3225 = mad(_3149, _3162, _3223);
                                    float _3226 = mad(2.0f, _3225, 2.0f);
                                    float _3227 = rsqrt(_3226);
                                    float _3228 = _3224 + _3148;
                                    float _3229 = _3228 * _3227;
                                    float _3230 = clamp(_3229, 0.0f, 1.0f);
                                    float _3231 = mad(_3227, _3225, _3227);
                                    float _3232 = clamp(_3231, 0.0f, 1.0f);
                                    _3234 = _3230;
                                    _3235 = _3232;
                                }
                                _3236 = _3234;
                                _3237 = _3235;
                            }
                            else
                            {
                                _3236 = _3154;
                                _3237 = _3156;
                            }
                            _3258 = _3236;
                            _3259 = _3237;
                            _3260 = 0.0f;
                            _3261 = 0.0f;
                            _3262 = 0.0f;
                            _3263 = 0.0f;
                            _3264 = 0.0f;
                            _3265 = 0.0f;
                            _3266 = _3148;
                        }
                        float _3267 = abs(_3266);
                        float _3268 = _3267 + 9.9999997473787516355514526367188e-06f;
                        float _3269 = clamp(_3268, 0.0f, 1.0f);
                        float3 _3270 = _373 * 0.3183098733425140380859375f;
                        float _3271 = _917 * _916;
                        float3 _3272 = 1.0f.xxx * _3271;
                        float3 _3273 = _3270 * _3272;
                        float3 _3407 = 0.0f.xxx;
                        [branch]
                        if (_3143)
                        {
                            float _3361 = _869 * _869;
                            float _3362 = 1.0f + _389;
                            float _3363 = _3361 * _3362;
                            bool _3549 = isnan(_3363);
                            bool _3550 = isnan(0.001000000047497451305389404296875f);
                            float _3551 = max(_3363, 0.001000000047497451305389404296875f);
                            float _3552 = _3549 ? 0.001000000047497451305389404296875f : _3551;
                            float _3364 = _3550 ? _3363 : _3552;
                            float _3365 = 1.0f - _389;
                            float _3366 = _3361 * _3365;
                            bool _3554 = isnan(_3366);
                            bool _3555 = isnan(0.001000000047497451305389404296875f);
                            float _3556 = max(_3366, 0.001000000047497451305389404296875f);
                            float _3557 = _3554 ? 0.001000000047497451305389404296875f : _3556;
                            float _3367 = _3555 ? _3366 : _3557;
                            float _3368 = _3364 * _3367;
                            float _3369 = _3367 * _3262;
                            float _3370 = _3364 * _3265;
                            float _3371 = _3368 * _3258;
                            float3 _3372 = float3(_3369, _3370, _3371);
                            float _3373 = dot(_3372, _3372);
                            float _3374 = 0.3183098733425140380859375f * _3368;
                            float _3375 = _3368 / _3373;
                            float _3376 = _3375 * _3375;
                            float _3377 = _3374 * _3376;
                            float3 _3378 = _3377.xxx;
                            float _3379 = _3364 * _3260;
                            float _3380 = _3367 * _3263;
                            float3 _3381 = float3(_3379, _3380, _3269);
                            float _3382 = length(_3381);
                            float _3383 = _3364 * _3261;
                            float _3384 = _3367 * _3264;
                            float3 _3385 = float3(_3383, _3384, _916);
                            float _3386 = length(_3385);
                            float _3387 = _3269 * _3386;
                            float _3388 = mad(_916, _3382, _3387);
                            float _3389 = 0.5f / _3388;
                            float3 _3390 = _3389.xxx;
                            float _3391 = 1.0f - _3259;
                            float _3392 = _3391 * _3391;
                            float _3393 = _3392 * _3392;
                            float _3394 = _3393 * _3391;
                            float _3395 = _380.y;
                            float _3396 = 50.0f * _3395;
                            float _3397 = clamp(_3396, 0.0f, 1.0f);
                            float _3398 = _3397 * _3394;
                            float3 _3399 = _3398.xxx;
                            float _3400 = -_3393;
                            float _3401 = mad(_3400, _3391, 1.0f);
                            float3 _3402 = _380 * _3401;
                            float3 _3403 = _3399 + _3402;
                            float3 _3404 = _3378 * _3390;
                            float3 _3405 = _3404 * _3403;
                            float3 _3406 = _3272 * _3405;
                            _3407 = _3406;
                        }
                        else
                        {
                            uint _3277 = _951 & 1u;
                            bool _3278 = _3277 == 1u;
                            float3 _3360 = 0.0f.xxx;
                            if (_3278)
                            {
                                _3360 = 0.0f.xxx;
                            }
                            else
                            {
                                float _3282 = _869 * _869;
                                float _3283 = _3282 * _3282;
                                bool _3284 = _944 > 0.0f;
                                float _3292 = 0.0f;
                                if (_3284)
                                {
                                    float _3287 = _944 * _944;
                                    float _3288 = mad(_3259, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                    float _3289 = _3287 / _3288;
                                    float _3290 = mad(_3282, _3282, _3289);
                                    float _3291 = clamp(_3290, 0.0f, 1.0f);
                                    _3292 = _3291;
                                }
                                else
                                {
                                    _3292 = _3283;
                                }
                                bool _3293 = _942 > 0.0f;
                                float _3307 = 0.0f;
                                float _3308 = 0.0f;
                                if (_3293)
                                {
                                    float _3296 = 0.25f * _942;
                                    int _3297 = asint(_3292);
                                    int _3298 = _3297 >> 1;
                                    int _3299 = 532487669 + _3298;
                                    float _3300 = asfloat(_3299);
                                    float _3301 = mad(3.0f, _3300, _942);
                                    float _3302 = _3296 * _3301;
                                    float _3303 = _3259 + 0.001000000047497451305389404296875f;
                                    float _3304 = _3302 / _3303;
                                    float _3305 = _3292 + _3304;
                                    float _3306 = _3292 / _3305;
                                    _3307 = _3306;
                                    _3308 = _3305;
                                }
                                else
                                {
                                    _3307 = 1.0f;
                                    _3308 = _3292;
                                }
                                bool _3309 = _895 < 1.0f;
                                float _3329 = 0.0f;
                                if (_3309)
                                {
                                    float _3312 = 1.00010001659393310546875f - _895;
                                    float _3313 = 1.0f + _895;
                                    float _3314 = _3312 / _3313;
                                    float _3315 = sqrt(_3314);
                                    float _3316 = 0.25f * _3315;
                                    int _3317 = asint(_3308);
                                    int _3318 = _3317 >> 1;
                                    int _3319 = 532487669 + _3318;
                                    float _3320 = asfloat(_3319);
                                    float _3321 = mad(3.0f, _3320, _3315);
                                    float _3322 = _3316 * _3321;
                                    float _3323 = _3259 + 0.001000000047497451305389404296875f;
                                    float _3324 = _3322 / _3323;
                                    float _3325 = _3308 + _3324;
                                    float _3326 = _3308 / _3325;
                                    float _3327 = sqrt(_3326);
                                    float _3328 = _3307 * _3327;
                                    _3329 = _3328;
                                }
                                else
                                {
                                    _3329 = _3307;
                                }
                                float _3330 = -_3258;
                                float _3331 = mad(_3258, _3292, _3330);
                                float _3332 = mad(_3331, _3258, 1.0f);
                                float _3333 = 3.1415927410125732421875f * _3332;
                                float _3334 = _3333 * _3332;
                                float _3335 = _3292 / _3334;
                                float _3336 = _3335 * _3329;
                                float _3337 = sqrt(_3292);
                                float _3338 = 1.0f - _3337;
                                float _3339 = mad(_3269, _3338, _3337);
                                float _3340 = mad(_916, _3338, _3337);
                                float _3341 = _3269 * _3340;
                                float _3342 = mad(_916, _3339, _3341);
                                float _3343 = 0.5f / _3342;
                                float _3344 = 1.0f - _3259;
                                float _3345 = _3344 * _3344;
                                float _3346 = _3345 * _3345;
                                float _3347 = _3346 * _3344;
                                float _3348 = _380.y;
                                float _3349 = 50.0f * _3348;
                                float _3350 = clamp(_3349, 0.0f, 1.0f);
                                float _3351 = _3350 * _3347;
                                float3 _3352 = _3351.xxx;
                                float _3353 = -_3346;
                                float _3354 = mad(_3353, _3344, 1.0f);
                                float3 _3355 = _380 * _3354;
                                float3 _3356 = _3352 + _3355;
                                float _3357 = _3336 * _3343;
                                float3 _3358 = _3356 * _3357;
                                float3 _3359 = _3272 * _3358;
                                _3360 = _3359;
                            }
                            _3407 = _3360;
                        }
                        float3 _3408 = _3273 * 1.0f;
                        _3409 = _3408;
                        _3410 = _3407;
                        _3411 = 0.0f.xxx;
                        break;
                    }
                    case 10u:
                    {
                        int _3141 = int(_390);
                        int _3142 = _3141 & 16;
                        bool _3143 = _3142 != 0;
                        float _3258 = 0.0f;
                        float _3259 = 0.0f;
                        float _3260 = 0.0f;
                        float _3261 = 0.0f;
                        float _3262 = 0.0f;
                        float _3263 = 0.0f;
                        float _3264 = 0.0f;
                        float _3265 = 0.0f;
                        float _3266 = 0.0f;
                        [branch]
                        if (_3143)
                        {
                            float3 _3238 = cross(_333, _388);
                            float3 _3239 = normalize(_3238);
                            float _3240 = dot(_333, _936);
                            float _3241 = dot(_333, _531);
                            float _3242 = dot(_531, _936);
                            float _3243 = mad(2.0f, _3242, 2.0f);
                            float _3244 = rsqrt(_3243);
                            float _3245 = _3240 + _3241;
                            float _3246 = _3245 * _3244;
                            float _3247 = clamp(_3246, 0.0f, 1.0f);
                            float _3248 = mad(_3244, _3242, _3244);
                            float _3249 = clamp(_3248, 0.0f, 1.0f);
                            float _3250 = dot(_388, _531);
                            float _3251 = dot(_388, _936);
                            float _3252 = _3251 + _3250;
                            float _3253 = _3252 * _3244;
                            float _3254 = dot(_3239, _531);
                            float _3255 = dot(_3239, _936);
                            float _3256 = _3255 + _3254;
                            float _3257 = _3256 * _3244;
                            _3258 = _3247;
                            _3259 = _3249;
                            _3260 = _3250;
                            _3261 = _3251;
                            _3262 = _3253;
                            _3263 = _3254;
                            _3264 = _3255;
                            _3265 = _3257;
                            _3266 = _3241;
                        }
                        else
                        {
                            float _3147 = dot(_333, _936);
                            float _3148 = dot(_333, _531);
                            float _3149 = dot(_531, _936);
                            float _3150 = mad(2.0f, _3149, 2.0f);
                            float _3151 = rsqrt(_3150);
                            float _3152 = _3147 + _3148;
                            float _3153 = _3152 * _3151;
                            float _3154 = clamp(_3153, 0.0f, 1.0f);
                            float _3155 = mad(_3151, _3149, _3151);
                            float _3156 = clamp(_3155, 0.0f, 1.0f);
                            bool _3157 = _942 > 0.0f;
                            float _3236 = 0.0f;
                            float _3237 = 0.0f;
                            if (_3157)
                            {
                                float _3160 = -_942;
                                float _3161 = mad(_3160, _942, 1.0f);
                                float _3162 = sqrt(_3161);
                                float _3163 = 2.0f * _3147;
                                float _3164 = -_3149;
                                float _3165 = mad(_3163, _3148, _3164);
                                bool _3166 = _3165 >= _3162;
                                float _3234 = 0.0f;
                                float _3235 = 0.0f;
                                if (_3166)
                                {
                                    float _3233 = abs(_3148);
                                    _3234 = 1.0f;
                                    _3235 = _3233;
                                }
                                else
                                {
                                    float _3170 = -_3165;
                                    float _3171 = mad(_3170, _3165, 1.0f);
                                    float _3172 = rsqrt(_3171);
                                    float _3173 = _942 * _3172;
                                    float _3174 = mad(_3170, _3147, _3148);
                                    float _3175 = _3173 * _3174;
                                    float _3176 = 2.0f * _3148;
                                    float _3177 = mad(_3176, _3148, -1.0f);
                                    float _3178 = mad(_3170, _3149, _3177);
                                    float _3179 = _3173 * _3178;
                                    float _3180 = -_3147;
                                    float _3181 = mad(_3180, _3147, 1.0f);
                                    float _3182 = -_3148;
                                    float _3183 = mad(_3182, _3148, _3181);
                                    float _3184 = mad(_3164, _3149, _3183);
                                    float _3185 = _3163 * _3148;
                                    float _3186 = mad(_3185, _3149, _3184);
                                    float _3187 = clamp(_3186, 0.0f, 1.0f);
                                    float _3188 = sqrt(_3187);
                                    float _3189 = _3173 * _3188;
                                    float _3190 = _3189 * 2.0f;
                                    float _3191 = _3190 * _3148;
                                    float _3192 = mad(_3147, _3162, _3148);
                                    float _3193 = mad(_3173, _3174, _3192);
                                    float _3194 = mad(_3149, _3162, 1.0f);
                                    float _3195 = mad(_3173, _3178, _3194);
                                    float _3196 = _3189 * _3195;
                                    float _3197 = _3193 * _3195;
                                    float _3198 = _3191 * _3193;
                                    float _3199 = 0.25f * _3191;
                                    float _3200 = _3199 * _3193;
                                    float _3201 = mad(-0.5f, _3196, _3200);
                                    float _3202 = _3197 * _3201;
                                    float _3203 = _3196 * (-2.0f);
                                    float _3204 = mad(_3191, _3193, _3203);
                                    float _3205 = _3198 * _3204;
                                    float _3206 = mad(_3196, _3196, _3205);
                                    float _3207 = _3195 * _3195;
                                    float _3208 = mad(_3149, _3162, _3195);
                                    float _3209 = mad(-0.5f, _3208, -0.5f);
                                    float _3210 = _3197 * _3209;
                                    float _3211 = mad(_3192, _3207, _3210);
                                    float _3212 = mad(_3193, _3211, _3206);
                                    float _3213 = 2.0f * _3202;
                                    float _3214 = _3202 * _3202;
                                    float _3215 = mad(_3212, _3212, _3214);
                                    float _3216 = _3213 / _3215;
                                    float _3217 = _3216 * _3212;
                                    float _3218 = -_3216;
                                    float _3219 = mad(_3218, _3202, 1.0f);
                                    float _3220 = _3217 * _3189;
                                    float _3221 = mad(_3219, _3175, _3220);
                                    float _3222 = _3217 * _3191;
                                    float _3223 = mad(_3219, _3179, _3222);
                                    float _3224 = mad(_3147, _3162, _3221);
                                    float _3225 = mad(_3149, _3162, _3223);
                                    float _3226 = mad(2.0f, _3225, 2.0f);
                                    float _3227 = rsqrt(_3226);
                                    float _3228 = _3224 + _3148;
                                    float _3229 = _3228 * _3227;
                                    float _3230 = clamp(_3229, 0.0f, 1.0f);
                                    float _3231 = mad(_3227, _3225, _3227);
                                    float _3232 = clamp(_3231, 0.0f, 1.0f);
                                    _3234 = _3230;
                                    _3235 = _3232;
                                }
                                _3236 = _3234;
                                _3237 = _3235;
                            }
                            else
                            {
                                _3236 = _3154;
                                _3237 = _3156;
                            }
                            _3258 = _3236;
                            _3259 = _3237;
                            _3260 = 0.0f;
                            _3261 = 0.0f;
                            _3262 = 0.0f;
                            _3263 = 0.0f;
                            _3264 = 0.0f;
                            _3265 = 0.0f;
                            _3266 = _3148;
                        }
                        float _3267 = abs(_3266);
                        float _3268 = _3267 + 9.9999997473787516355514526367188e-06f;
                        float _3269 = clamp(_3268, 0.0f, 1.0f);
                        float3 _3270 = _373 * 0.3183098733425140380859375f;
                        float _3271 = _917 * _916;
                        float3 _3272 = 1.0f.xxx * _3271;
                        float3 _3273 = _3270 * _3272;
                        float3 _3407 = 0.0f.xxx;
                        [branch]
                        if (_3143)
                        {
                            float _3361 = _869 * _869;
                            float _3362 = 1.0f + _389;
                            float _3363 = _3361 * _3362;
                            bool _3549 = isnan(_3363);
                            bool _3550 = isnan(0.001000000047497451305389404296875f);
                            float _3551 = max(_3363, 0.001000000047497451305389404296875f);
                            float _3552 = _3549 ? 0.001000000047497451305389404296875f : _3551;
                            float _3364 = _3550 ? _3363 : _3552;
                            float _3365 = 1.0f - _389;
                            float _3366 = _3361 * _3365;
                            bool _3554 = isnan(_3366);
                            bool _3555 = isnan(0.001000000047497451305389404296875f);
                            float _3556 = max(_3366, 0.001000000047497451305389404296875f);
                            float _3557 = _3554 ? 0.001000000047497451305389404296875f : _3556;
                            float _3367 = _3555 ? _3366 : _3557;
                            float _3368 = _3364 * _3367;
                            float _3369 = _3367 * _3262;
                            float _3370 = _3364 * _3265;
                            float _3371 = _3368 * _3258;
                            float3 _3372 = float3(_3369, _3370, _3371);
                            float _3373 = dot(_3372, _3372);
                            float _3374 = 0.3183098733425140380859375f * _3368;
                            float _3375 = _3368 / _3373;
                            float _3376 = _3375 * _3375;
                            float _3377 = _3374 * _3376;
                            float3 _3378 = _3377.xxx;
                            float _3379 = _3364 * _3260;
                            float _3380 = _3367 * _3263;
                            float3 _3381 = float3(_3379, _3380, _3269);
                            float _3382 = length(_3381);
                            float _3383 = _3364 * _3261;
                            float _3384 = _3367 * _3264;
                            float3 _3385 = float3(_3383, _3384, _916);
                            float _3386 = length(_3385);
                            float _3387 = _3269 * _3386;
                            float _3388 = mad(_916, _3382, _3387);
                            float _3389 = 0.5f / _3388;
                            float3 _3390 = _3389.xxx;
                            float _3391 = 1.0f - _3259;
                            float _3392 = _3391 * _3391;
                            float _3393 = _3392 * _3392;
                            float _3394 = _3393 * _3391;
                            float _3395 = _380.y;
                            float _3396 = 50.0f * _3395;
                            float _3397 = clamp(_3396, 0.0f, 1.0f);
                            float _3398 = _3397 * _3394;
                            float3 _3399 = _3398.xxx;
                            float _3400 = -_3393;
                            float _3401 = mad(_3400, _3391, 1.0f);
                            float3 _3402 = _380 * _3401;
                            float3 _3403 = _3399 + _3402;
                            float3 _3404 = _3378 * _3390;
                            float3 _3405 = _3404 * _3403;
                            float3 _3406 = _3272 * _3405;
                            _3407 = _3406;
                        }
                        else
                        {
                            uint _3277 = _951 & 1u;
                            bool _3278 = _3277 == 1u;
                            float3 _3360 = 0.0f.xxx;
                            if (_3278)
                            {
                                _3360 = 0.0f.xxx;
                            }
                            else
                            {
                                float _3282 = _869 * _869;
                                float _3283 = _3282 * _3282;
                                bool _3284 = _944 > 0.0f;
                                float _3292 = 0.0f;
                                if (_3284)
                                {
                                    float _3287 = _944 * _944;
                                    float _3288 = mad(_3259, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                    float _3289 = _3287 / _3288;
                                    float _3290 = mad(_3282, _3282, _3289);
                                    float _3291 = clamp(_3290, 0.0f, 1.0f);
                                    _3292 = _3291;
                                }
                                else
                                {
                                    _3292 = _3283;
                                }
                                bool _3293 = _942 > 0.0f;
                                float _3307 = 0.0f;
                                float _3308 = 0.0f;
                                if (_3293)
                                {
                                    float _3296 = 0.25f * _942;
                                    int _3297 = asint(_3292);
                                    int _3298 = _3297 >> 1;
                                    int _3299 = 532487669 + _3298;
                                    float _3300 = asfloat(_3299);
                                    float _3301 = mad(3.0f, _3300, _942);
                                    float _3302 = _3296 * _3301;
                                    float _3303 = _3259 + 0.001000000047497451305389404296875f;
                                    float _3304 = _3302 / _3303;
                                    float _3305 = _3292 + _3304;
                                    float _3306 = _3292 / _3305;
                                    _3307 = _3306;
                                    _3308 = _3305;
                                }
                                else
                                {
                                    _3307 = 1.0f;
                                    _3308 = _3292;
                                }
                                bool _3309 = _895 < 1.0f;
                                float _3329 = 0.0f;
                                if (_3309)
                                {
                                    float _3312 = 1.00010001659393310546875f - _895;
                                    float _3313 = 1.0f + _895;
                                    float _3314 = _3312 / _3313;
                                    float _3315 = sqrt(_3314);
                                    float _3316 = 0.25f * _3315;
                                    int _3317 = asint(_3308);
                                    int _3318 = _3317 >> 1;
                                    int _3319 = 532487669 + _3318;
                                    float _3320 = asfloat(_3319);
                                    float _3321 = mad(3.0f, _3320, _3315);
                                    float _3322 = _3316 * _3321;
                                    float _3323 = _3259 + 0.001000000047497451305389404296875f;
                                    float _3324 = _3322 / _3323;
                                    float _3325 = _3308 + _3324;
                                    float _3326 = _3308 / _3325;
                                    float _3327 = sqrt(_3326);
                                    float _3328 = _3307 * _3327;
                                    _3329 = _3328;
                                }
                                else
                                {
                                    _3329 = _3307;
                                }
                                float _3330 = -_3258;
                                float _3331 = mad(_3258, _3292, _3330);
                                float _3332 = mad(_3331, _3258, 1.0f);
                                float _3333 = 3.1415927410125732421875f * _3332;
                                float _3334 = _3333 * _3332;
                                float _3335 = _3292 / _3334;
                                float _3336 = _3335 * _3329;
                                float _3337 = sqrt(_3292);
                                float _3338 = 1.0f - _3337;
                                float _3339 = mad(_3269, _3338, _3337);
                                float _3340 = mad(_916, _3338, _3337);
                                float _3341 = _3269 * _3340;
                                float _3342 = mad(_916, _3339, _3341);
                                float _3343 = 0.5f / _3342;
                                float _3344 = 1.0f - _3259;
                                float _3345 = _3344 * _3344;
                                float _3346 = _3345 * _3345;
                                float _3347 = _3346 * _3344;
                                float _3348 = _380.y;
                                float _3349 = 50.0f * _3348;
                                float _3350 = clamp(_3349, 0.0f, 1.0f);
                                float _3351 = _3350 * _3347;
                                float3 _3352 = _3351.xxx;
                                float _3353 = -_3346;
                                float _3354 = mad(_3353, _3344, 1.0f);
                                float3 _3355 = _380 * _3354;
                                float3 _3356 = _3352 + _3355;
                                float _3357 = _3336 * _3343;
                                float3 _3358 = _3356 * _3357;
                                float3 _3359 = _3272 * _3358;
                                _3360 = _3359;
                            }
                            _3407 = _3360;
                        }
                        float3 _3408 = _3273 * 1.0f;
                        _3409 = _3408;
                        _3410 = _3407;
                        _3411 = 0.0f.xxx;
                        break;
                    }
                    case 11u:
                    {
                        int _3141 = int(_390);
                        int _3142 = _3141 & 16;
                        bool _3143 = _3142 != 0;
                        float _3258 = 0.0f;
                        float _3259 = 0.0f;
                        float _3260 = 0.0f;
                        float _3261 = 0.0f;
                        float _3262 = 0.0f;
                        float _3263 = 0.0f;
                        float _3264 = 0.0f;
                        float _3265 = 0.0f;
                        float _3266 = 0.0f;
                        [branch]
                        if (_3143)
                        {
                            float3 _3238 = cross(_333, _388);
                            float3 _3239 = normalize(_3238);
                            float _3240 = dot(_333, _936);
                            float _3241 = dot(_333, _531);
                            float _3242 = dot(_531, _936);
                            float _3243 = mad(2.0f, _3242, 2.0f);
                            float _3244 = rsqrt(_3243);
                            float _3245 = _3240 + _3241;
                            float _3246 = _3245 * _3244;
                            float _3247 = clamp(_3246, 0.0f, 1.0f);
                            float _3248 = mad(_3244, _3242, _3244);
                            float _3249 = clamp(_3248, 0.0f, 1.0f);
                            float _3250 = dot(_388, _531);
                            float _3251 = dot(_388, _936);
                            float _3252 = _3251 + _3250;
                            float _3253 = _3252 * _3244;
                            float _3254 = dot(_3239, _531);
                            float _3255 = dot(_3239, _936);
                            float _3256 = _3255 + _3254;
                            float _3257 = _3256 * _3244;
                            _3258 = _3247;
                            _3259 = _3249;
                            _3260 = _3250;
                            _3261 = _3251;
                            _3262 = _3253;
                            _3263 = _3254;
                            _3264 = _3255;
                            _3265 = _3257;
                            _3266 = _3241;
                        }
                        else
                        {
                            float _3147 = dot(_333, _936);
                            float _3148 = dot(_333, _531);
                            float _3149 = dot(_531, _936);
                            float _3150 = mad(2.0f, _3149, 2.0f);
                            float _3151 = rsqrt(_3150);
                            float _3152 = _3147 + _3148;
                            float _3153 = _3152 * _3151;
                            float _3154 = clamp(_3153, 0.0f, 1.0f);
                            float _3155 = mad(_3151, _3149, _3151);
                            float _3156 = clamp(_3155, 0.0f, 1.0f);
                            bool _3157 = _942 > 0.0f;
                            float _3236 = 0.0f;
                            float _3237 = 0.0f;
                            if (_3157)
                            {
                                float _3160 = -_942;
                                float _3161 = mad(_3160, _942, 1.0f);
                                float _3162 = sqrt(_3161);
                                float _3163 = 2.0f * _3147;
                                float _3164 = -_3149;
                                float _3165 = mad(_3163, _3148, _3164);
                                bool _3166 = _3165 >= _3162;
                                float _3234 = 0.0f;
                                float _3235 = 0.0f;
                                if (_3166)
                                {
                                    float _3233 = abs(_3148);
                                    _3234 = 1.0f;
                                    _3235 = _3233;
                                }
                                else
                                {
                                    float _3170 = -_3165;
                                    float _3171 = mad(_3170, _3165, 1.0f);
                                    float _3172 = rsqrt(_3171);
                                    float _3173 = _942 * _3172;
                                    float _3174 = mad(_3170, _3147, _3148);
                                    float _3175 = _3173 * _3174;
                                    float _3176 = 2.0f * _3148;
                                    float _3177 = mad(_3176, _3148, -1.0f);
                                    float _3178 = mad(_3170, _3149, _3177);
                                    float _3179 = _3173 * _3178;
                                    float _3180 = -_3147;
                                    float _3181 = mad(_3180, _3147, 1.0f);
                                    float _3182 = -_3148;
                                    float _3183 = mad(_3182, _3148, _3181);
                                    float _3184 = mad(_3164, _3149, _3183);
                                    float _3185 = _3163 * _3148;
                                    float _3186 = mad(_3185, _3149, _3184);
                                    float _3187 = clamp(_3186, 0.0f, 1.0f);
                                    float _3188 = sqrt(_3187);
                                    float _3189 = _3173 * _3188;
                                    float _3190 = _3189 * 2.0f;
                                    float _3191 = _3190 * _3148;
                                    float _3192 = mad(_3147, _3162, _3148);
                                    float _3193 = mad(_3173, _3174, _3192);
                                    float _3194 = mad(_3149, _3162, 1.0f);
                                    float _3195 = mad(_3173, _3178, _3194);
                                    float _3196 = _3189 * _3195;
                                    float _3197 = _3193 * _3195;
                                    float _3198 = _3191 * _3193;
                                    float _3199 = 0.25f * _3191;
                                    float _3200 = _3199 * _3193;
                                    float _3201 = mad(-0.5f, _3196, _3200);
                                    float _3202 = _3197 * _3201;
                                    float _3203 = _3196 * (-2.0f);
                                    float _3204 = mad(_3191, _3193, _3203);
                                    float _3205 = _3198 * _3204;
                                    float _3206 = mad(_3196, _3196, _3205);
                                    float _3207 = _3195 * _3195;
                                    float _3208 = mad(_3149, _3162, _3195);
                                    float _3209 = mad(-0.5f, _3208, -0.5f);
                                    float _3210 = _3197 * _3209;
                                    float _3211 = mad(_3192, _3207, _3210);
                                    float _3212 = mad(_3193, _3211, _3206);
                                    float _3213 = 2.0f * _3202;
                                    float _3214 = _3202 * _3202;
                                    float _3215 = mad(_3212, _3212, _3214);
                                    float _3216 = _3213 / _3215;
                                    float _3217 = _3216 * _3212;
                                    float _3218 = -_3216;
                                    float _3219 = mad(_3218, _3202, 1.0f);
                                    float _3220 = _3217 * _3189;
                                    float _3221 = mad(_3219, _3175, _3220);
                                    float _3222 = _3217 * _3191;
                                    float _3223 = mad(_3219, _3179, _3222);
                                    float _3224 = mad(_3147, _3162, _3221);
                                    float _3225 = mad(_3149, _3162, _3223);
                                    float _3226 = mad(2.0f, _3225, 2.0f);
                                    float _3227 = rsqrt(_3226);
                                    float _3228 = _3224 + _3148;
                                    float _3229 = _3228 * _3227;
                                    float _3230 = clamp(_3229, 0.0f, 1.0f);
                                    float _3231 = mad(_3227, _3225, _3227);
                                    float _3232 = clamp(_3231, 0.0f, 1.0f);
                                    _3234 = _3230;
                                    _3235 = _3232;
                                }
                                _3236 = _3234;
                                _3237 = _3235;
                            }
                            else
                            {
                                _3236 = _3154;
                                _3237 = _3156;
                            }
                            _3258 = _3236;
                            _3259 = _3237;
                            _3260 = 0.0f;
                            _3261 = 0.0f;
                            _3262 = 0.0f;
                            _3263 = 0.0f;
                            _3264 = 0.0f;
                            _3265 = 0.0f;
                            _3266 = _3148;
                        }
                        float _3267 = abs(_3266);
                        float _3268 = _3267 + 9.9999997473787516355514526367188e-06f;
                        float _3269 = clamp(_3268, 0.0f, 1.0f);
                        float3 _3270 = _373 * 0.3183098733425140380859375f;
                        float _3271 = _917 * _916;
                        float3 _3272 = 1.0f.xxx * _3271;
                        float3 _3273 = _3270 * _3272;
                        float3 _3407 = 0.0f.xxx;
                        [branch]
                        if (_3143)
                        {
                            float _3361 = _869 * _869;
                            float _3362 = 1.0f + _389;
                            float _3363 = _3361 * _3362;
                            bool _3549 = isnan(_3363);
                            bool _3550 = isnan(0.001000000047497451305389404296875f);
                            float _3551 = max(_3363, 0.001000000047497451305389404296875f);
                            float _3552 = _3549 ? 0.001000000047497451305389404296875f : _3551;
                            float _3364 = _3550 ? _3363 : _3552;
                            float _3365 = 1.0f - _389;
                            float _3366 = _3361 * _3365;
                            bool _3554 = isnan(_3366);
                            bool _3555 = isnan(0.001000000047497451305389404296875f);
                            float _3556 = max(_3366, 0.001000000047497451305389404296875f);
                            float _3557 = _3554 ? 0.001000000047497451305389404296875f : _3556;
                            float _3367 = _3555 ? _3366 : _3557;
                            float _3368 = _3364 * _3367;
                            float _3369 = _3367 * _3262;
                            float _3370 = _3364 * _3265;
                            float _3371 = _3368 * _3258;
                            float3 _3372 = float3(_3369, _3370, _3371);
                            float _3373 = dot(_3372, _3372);
                            float _3374 = 0.3183098733425140380859375f * _3368;
                            float _3375 = _3368 / _3373;
                            float _3376 = _3375 * _3375;
                            float _3377 = _3374 * _3376;
                            float3 _3378 = _3377.xxx;
                            float _3379 = _3364 * _3260;
                            float _3380 = _3367 * _3263;
                            float3 _3381 = float3(_3379, _3380, _3269);
                            float _3382 = length(_3381);
                            float _3383 = _3364 * _3261;
                            float _3384 = _3367 * _3264;
                            float3 _3385 = float3(_3383, _3384, _916);
                            float _3386 = length(_3385);
                            float _3387 = _3269 * _3386;
                            float _3388 = mad(_916, _3382, _3387);
                            float _3389 = 0.5f / _3388;
                            float3 _3390 = _3389.xxx;
                            float _3391 = 1.0f - _3259;
                            float _3392 = _3391 * _3391;
                            float _3393 = _3392 * _3392;
                            float _3394 = _3393 * _3391;
                            float _3395 = _380.y;
                            float _3396 = 50.0f * _3395;
                            float _3397 = clamp(_3396, 0.0f, 1.0f);
                            float _3398 = _3397 * _3394;
                            float3 _3399 = _3398.xxx;
                            float _3400 = -_3393;
                            float _3401 = mad(_3400, _3391, 1.0f);
                            float3 _3402 = _380 * _3401;
                            float3 _3403 = _3399 + _3402;
                            float3 _3404 = _3378 * _3390;
                            float3 _3405 = _3404 * _3403;
                            float3 _3406 = _3272 * _3405;
                            _3407 = _3406;
                        }
                        else
                        {
                            uint _3277 = _951 & 1u;
                            bool _3278 = _3277 == 1u;
                            float3 _3360 = 0.0f.xxx;
                            if (_3278)
                            {
                                _3360 = 0.0f.xxx;
                            }
                            else
                            {
                                float _3282 = _869 * _869;
                                float _3283 = _3282 * _3282;
                                bool _3284 = _944 > 0.0f;
                                float _3292 = 0.0f;
                                if (_3284)
                                {
                                    float _3287 = _944 * _944;
                                    float _3288 = mad(_3259, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                    float _3289 = _3287 / _3288;
                                    float _3290 = mad(_3282, _3282, _3289);
                                    float _3291 = clamp(_3290, 0.0f, 1.0f);
                                    _3292 = _3291;
                                }
                                else
                                {
                                    _3292 = _3283;
                                }
                                bool _3293 = _942 > 0.0f;
                                float _3307 = 0.0f;
                                float _3308 = 0.0f;
                                if (_3293)
                                {
                                    float _3296 = 0.25f * _942;
                                    int _3297 = asint(_3292);
                                    int _3298 = _3297 >> 1;
                                    int _3299 = 532487669 + _3298;
                                    float _3300 = asfloat(_3299);
                                    float _3301 = mad(3.0f, _3300, _942);
                                    float _3302 = _3296 * _3301;
                                    float _3303 = _3259 + 0.001000000047497451305389404296875f;
                                    float _3304 = _3302 / _3303;
                                    float _3305 = _3292 + _3304;
                                    float _3306 = _3292 / _3305;
                                    _3307 = _3306;
                                    _3308 = _3305;
                                }
                                else
                                {
                                    _3307 = 1.0f;
                                    _3308 = _3292;
                                }
                                bool _3309 = _895 < 1.0f;
                                float _3329 = 0.0f;
                                if (_3309)
                                {
                                    float _3312 = 1.00010001659393310546875f - _895;
                                    float _3313 = 1.0f + _895;
                                    float _3314 = _3312 / _3313;
                                    float _3315 = sqrt(_3314);
                                    float _3316 = 0.25f * _3315;
                                    int _3317 = asint(_3308);
                                    int _3318 = _3317 >> 1;
                                    int _3319 = 532487669 + _3318;
                                    float _3320 = asfloat(_3319);
                                    float _3321 = mad(3.0f, _3320, _3315);
                                    float _3322 = _3316 * _3321;
                                    float _3323 = _3259 + 0.001000000047497451305389404296875f;
                                    float _3324 = _3322 / _3323;
                                    float _3325 = _3308 + _3324;
                                    float _3326 = _3308 / _3325;
                                    float _3327 = sqrt(_3326);
                                    float _3328 = _3307 * _3327;
                                    _3329 = _3328;
                                }
                                else
                                {
                                    _3329 = _3307;
                                }
                                float _3330 = -_3258;
                                float _3331 = mad(_3258, _3292, _3330);
                                float _3332 = mad(_3331, _3258, 1.0f);
                                float _3333 = 3.1415927410125732421875f * _3332;
                                float _3334 = _3333 * _3332;
                                float _3335 = _3292 / _3334;
                                float _3336 = _3335 * _3329;
                                float _3337 = sqrt(_3292);
                                float _3338 = 1.0f - _3337;
                                float _3339 = mad(_3269, _3338, _3337);
                                float _3340 = mad(_916, _3338, _3337);
                                float _3341 = _3269 * _3340;
                                float _3342 = mad(_916, _3339, _3341);
                                float _3343 = 0.5f / _3342;
                                float _3344 = 1.0f - _3259;
                                float _3345 = _3344 * _3344;
                                float _3346 = _3345 * _3345;
                                float _3347 = _3346 * _3344;
                                float _3348 = _380.y;
                                float _3349 = 50.0f * _3348;
                                float _3350 = clamp(_3349, 0.0f, 1.0f);
                                float _3351 = _3350 * _3347;
                                float3 _3352 = _3351.xxx;
                                float _3353 = -_3346;
                                float _3354 = mad(_3353, _3344, 1.0f);
                                float3 _3355 = _380 * _3354;
                                float3 _3356 = _3352 + _3355;
                                float _3357 = _3336 * _3343;
                                float3 _3358 = _3356 * _3357;
                                float3 _3359 = _3272 * _3358;
                                _3360 = _3359;
                            }
                            _3407 = _3360;
                        }
                        float3 _3408 = _3273 * 1.0f;
                        _3409 = _3408;
                        _3410 = _3407;
                        _3411 = 0.0f.xxx;
                        break;
                    }
                    case 2u:
                    {
                        bool _2784 = (int(_390) & 16) != 0;
                        float _2899 = 0.0f;
                        float _2900 = 0.0f;
                        float _2901 = 0.0f;
                        float _2902 = 0.0f;
                        float _2903 = 0.0f;
                        float _2904 = 0.0f;
                        float _2905 = 0.0f;
                        float _2906 = 0.0f;
                        float _2907 = 0.0f;
                        [branch]
                        if (_2784)
                        {
                            float3 _2880 = normalize(cross(_333, _388));
                            float _2882 = dot(_333, _531);
                            float _2883 = dot(_531, _936);
                            float _2885 = rsqrt(mad(2.0f, _2883, 2.0f));
                            float _2891 = dot(_388, _531);
                            float _2892 = dot(_388, _936);
                            float _2895 = dot(_2880, _531);
                            float _2896 = dot(_2880, _936);
                            _2899 = clamp((dot(_333, _936) + _2882) * _2885, 0.0f, 1.0f);
                            _2900 = clamp(mad(_2885, _2883, _2885), 0.0f, 1.0f);
                            _2901 = _2891;
                            _2902 = _2892;
                            _2903 = (_2892 + _2891) * _2885;
                            _2904 = _2895;
                            _2905 = _2896;
                            _2906 = (_2896 + _2895) * _2885;
                            _2907 = _2882;
                        }
                        else
                        {
                            float _2788 = dot(_333, _936);
                            float _2789 = dot(_333, _531);
                            float _2790 = dot(_531, _936);
                            float _2792 = rsqrt(mad(2.0f, _2790, 2.0f));
                            float _2877 = 0.0f;
                            float _2878 = 0.0f;
                            if (_942 > 0.0f)
                            {
                                float _2803 = sqrt(mad(-_942, _942, 1.0f));
                                float _2804 = 2.0f * _2788;
                                float _2805 = -_2790;
                                float _2806 = mad(_2804, _2789, _2805);
                                float _2875 = 0.0f;
                                float _2876 = 0.0f;
                                if (_2806 >= _2803)
                                {
                                    _2875 = 1.0f;
                                    _2876 = abs(_2789);
                                }
                                else
                                {
                                    float _2811 = -_2806;
                                    float _2814 = _942 * rsqrt(mad(_2811, _2806, 1.0f));
                                    float _2815 = mad(_2811, _2788, _2789);
                                    float _2819 = mad(_2811, _2790, mad(2.0f * _2789, _2789, -1.0f));
                                    float _2830 = _2814 * sqrt(clamp(mad(_2804 * _2789, _2790, mad(_2805, _2790, mad(-_2789, _2789, mad(-_2788, _2788, 1.0f)))), 0.0f, 1.0f));
                                    float _2832 = (_2830 * 2.0f) * _2789;
                                    float _2833 = mad(_2788, _2803, _2789);
                                    float _2834 = mad(_2814, _2815, _2833);
                                    float _2836 = mad(_2814, _2819, mad(_2790, _2803, 1.0f));
                                    float _2837 = _2830 * _2836;
                                    float _2838 = _2834 * _2836;
                                    float _2843 = _2838 * mad(-0.5f, _2837, (0.25f * _2832) * _2834);
                                    float _2853 = mad(_2834, mad(_2833, _2836 * _2836, _2838 * mad(-0.5f, mad(_2790, _2803, _2836), -0.5f)), mad(_2837, _2837, (_2832 * _2834) * mad(_2832, _2834, _2837 * (-2.0f))));
                                    float _2857 = (2.0f * _2843) / mad(_2853, _2853, _2843 * _2843);
                                    float _2858 = _2857 * _2853;
                                    float _2860 = mad(-_2857, _2843, 1.0f);
                                    float _2866 = mad(_2790, _2803, mad(_2860, _2814 * _2819, _2858 * _2832));
                                    float _2868 = rsqrt(mad(2.0f, _2866, 2.0f));
                                    _2875 = clamp((mad(_2788, _2803, mad(_2860, _2814 * _2815, _2858 * _2830)) + _2789) * _2868, 0.0f, 1.0f);
                                    _2876 = clamp(mad(_2868, _2866, _2868), 0.0f, 1.0f);
                                }
                                _2877 = _2875;
                                _2878 = _2876;
                            }
                            else
                            {
                                _2877 = clamp((_2788 + _2789) * _2792, 0.0f, 1.0f);
                                _2878 = clamp(mad(_2792, _2790, _2792), 0.0f, 1.0f);
                            }
                            _2899 = _2877;
                            _2900 = _2878;
                            _2901 = 0.0f;
                            _2902 = 0.0f;
                            _2903 = 0.0f;
                            _2904 = 0.0f;
                            _2905 = 0.0f;
                            _2906 = 0.0f;
                            _2907 = _2789;
                        }
                        float _2910 = clamp(abs(_2907) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _2913 = 1.0f.xxx * (_917 * _916);
                        float3 _3048 = 0.0f.xxx;
                        [branch]
                        if (_2784)
                        {
                            float _3002 = _869 * _869;
                            float _3004 = _3002 * (1.0f + _389);
                            float _3005 = isnan(0.001000000047497451305389404296875f) ? _3004 : (isnan(_3004) ? 0.001000000047497451305389404296875f : max(_3004, 0.001000000047497451305389404296875f));
                            float _3007 = _3002 * (1.0f - _389);
                            float _3008 = isnan(0.001000000047497451305389404296875f) ? _3007 : (isnan(_3007) ? 0.001000000047497451305389404296875f : max(_3007, 0.001000000047497451305389404296875f));
                            float _3009 = _3005 * _3008;
                            float3 _3013 = float3(_3008 * _2903, _3005 * _2906, _3009 * _2899);
                            float _3016 = _3009 / dot(_3013, _3013);
                            float _3032 = 1.0f - _2900;
                            float _3033 = _3032 * _3032;
                            float _3034 = _3033 * _3033;
                            _3048 = _2913 * ((((0.3183098733425140380859375f * _3009) * (_3016 * _3016)).xxx * (0.5f / mad(_916, length(float3(_3005 * _2901, _3008 * _2904, _2910)), _2910 * length(float3(_3005 * _2902, _3008 * _2905, _916)))).xxx) * ((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_3034 * _3032)).xxx + (_380 * mad(-_3034, _3032, 1.0f))));
                        }
                        else
                        {
                            float3 _3001 = 0.0f.xxx;
                            if ((_951 & 1u) == 1u)
                            {
                                _3001 = 0.0f.xxx;
                            }
                            else
                            {
                                float _2923 = _869 * _869;
                                float _2933 = 0.0f;
                                if (_944 > 0.0f)
                                {
                                    _2933 = clamp(mad(_2923, _2923, (_944 * _944) / mad(_2900, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                                }
                                else
                                {
                                    _2933 = _2923 * _2923;
                                }
                                float _2948 = 0.0f;
                                float _2949 = 0.0f;
                                if (_942 > 0.0f)
                                {
                                    float _2946 = _2933 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_2933) >> 1)), _942)) / (_2900 + 0.001000000047497451305389404296875f));
                                    _2948 = _2933 / _2946;
                                    _2949 = _2946;
                                }
                                else
                                {
                                    _2948 = 1.0f;
                                    _2949 = _2933;
                                }
                                float _2970 = 0.0f;
                                if (_895 < 1.0f)
                                {
                                    float _2956 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                    _2970 = _2948 * sqrt(_2949 / (_2949 + (((0.25f * _2956) * mad(3.0f, asfloat(532487669 + (asint(_2949) >> 1)), _2956)) / (_2900 + 0.001000000047497451305389404296875f))));
                                }
                                else
                                {
                                    _2970 = _2948;
                                }
                                float _2973 = mad(mad(_2899, _2933, -_2899), _2899, 1.0f);
                                float _2978 = sqrt(_2933);
                                float _2979 = 1.0f - _2978;
                                float _2985 = 1.0f - _2900;
                                float _2986 = _2985 * _2985;
                                float _2987 = _2986 * _2986;
                                _3001 = _2913 * (((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_2987 * _2985)).xxx + (_380 * mad(-_2987, _2985, 1.0f))) * (((_2933 / ((3.1415927410125732421875f * _2973) * _2973)) * _2970) * (0.5f / mad(_916, mad(_2910, _2979, _2978), _2910 * mad(_916, _2979, _2978)))));
                            }
                            _3048 = _3001;
                        }
                        float3 _3050 = _321.xyz;
                        float3 _3051 = _3050 * _3050;
                        float3 _3074 = exp((-((-log(clamp(_3051, 9.9999999600419720025001879548654e-13f.xxx, 1.0f.xxx))) / (isnan(View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters) ? 9.9999999600419720025001879548654e-13f : (isnan(9.9999999600419720025001879548654e-13f) ? View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : max(9.9999999600419720025001879548654e-13f, View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters))).xxx)) * 1.0f);
                        float _3075 = _3074.y;
                        float _3076 = _3074.z;
                        bool4 _3078 = (_3075 < _3076).xxxx;
                        float4 _3079 = float4(_3076, _3075, -1.0f, 0.666666686534881591796875f);
                        float4 _3080 = float4(_3075, _3076, 0.0f, -0.3333333432674407958984375f);
                        float4 _3081 = float4(_3078.x ? _3079.x : _3080.x, _3078.y ? _3079.y : _3080.y, _3078.z ? _3079.z : _3080.z, _3078.w ? _3079.w : _3080.w);
                        float _3082 = _3074.x;
                        float _3083 = _3081.x;
                        bool4 _3085 = (_3082 < _3083).xxxx;
                        float4 _3088 = float4(_3083, _3081.yw, _3082);
                        float4 _3090 = float4(_3082, _3081.yz, _3083);
                        float4 _3091 = float4(_3085.x ? _3088.x : _3090.x, _3085.y ? _3088.y : _3090.y, _3085.z ? _3088.z : _3090.z, _3085.w ? _3088.w : _3090.w);
                        float _3092 = _3091.x;
                        float _3093 = _3091.w;
                        float _3094 = _3091.y;
                        float _3096 = _3092 - (isnan(_3094) ? _3093 : (isnan(_3093) ? _3094 : min(_3093, _3094)));
                        float _3102 = abs(((_3093 - _3094) / mad(6.0f, _3096, 1.0000000133514319600180897396058e-10f)) + _3091.z);
                        float _3105 = _3051.y;
                        float _3106 = _3051.z;
                        bool4 _3108 = (_3105 < _3106).xxxx;
                        float4 _3109 = float4(_3106, _3105, -1.0f, 0.666666686534881591796875f);
                        float4 _3110 = float4(_3105, _3106, 0.0f, -0.3333333432674407958984375f);
                        float4 _3111 = float4(_3108.x ? _3109.x : _3110.x, _3108.y ? _3109.y : _3110.y, _3108.z ? _3109.z : _3110.z, _3108.w ? _3109.w : _3110.w);
                        float _3112 = _3051.x;
                        float _3113 = _3111.x;
                        bool4 _3115 = (_3112 < _3113).xxxx;
                        float4 _3116 = float4(_3113, _189, _189, _3112);
                        float4 _3117 = float4(_3112, _189, _189, _3113);
                        _3409 = ((_373 * 0.3183098733425140380859375f) * _2913) * 1.0f;
                        _3410 = _3048;
                        _3411 = (1.0f.xxx * (_917 * lerp(lerp(1.0f, pow(clamp(mad(dot(_333, _936), 0.666666686534881591796875f, 0.3333333432674407958984375f), 0.0f, 1.0f), 1.5f) * 1.66666662693023681640625f, _563) * 0.15915493667125701904296875f, 1.0f, pow(clamp(dot(_936, _433), 0.0f, 1.0f), 12.0f) * lerp(3.0f, 0.100000001490116119384765625f, _563)))) * lerp((((clamp(float3(abs(mad(_3102, 6.0f, -3.0f)) - 1.0f, 2.0f - abs(mad(_3102, 6.0f, -2.0f)), 2.0f - abs(mad(_3102, 6.0f, -4.0f))), 0.0f.xxx, 1.0f.xxx) - 1.0f.xxx) * (_3096 / (_3092 + 1.0000000133514319600180897396058e-10f))) + 1.0f.xxx) * float4(_3115.x ? _3116.x : _3117.x, _3115.y ? _3116.y : _3117.y, _3115.z ? _3116.z : _3117.z, _3115.w ? _3116.w : _3117.w).x, _3051, _585.xxx);
                        break;
                    }
                    case 3u:
                    {
                        bool _2501 = (int(_390) & 16) != 0;
                        float _2616 = 0.0f;
                        float _2617 = 0.0f;
                        float _2618 = 0.0f;
                        float _2619 = 0.0f;
                        float _2620 = 0.0f;
                        float _2621 = 0.0f;
                        float _2622 = 0.0f;
                        float _2623 = 0.0f;
                        float _2624 = 0.0f;
                        [branch]
                        if (_2501)
                        {
                            float3 _2597 = normalize(cross(_333, _388));
                            float _2599 = dot(_333, _531);
                            float _2600 = dot(_531, _936);
                            float _2602 = rsqrt(mad(2.0f, _2600, 2.0f));
                            float _2608 = dot(_388, _531);
                            float _2609 = dot(_388, _936);
                            float _2612 = dot(_2597, _531);
                            float _2613 = dot(_2597, _936);
                            _2616 = clamp((dot(_333, _936) + _2599) * _2602, 0.0f, 1.0f);
                            _2617 = clamp(mad(_2602, _2600, _2602), 0.0f, 1.0f);
                            _2618 = _2608;
                            _2619 = _2609;
                            _2620 = (_2609 + _2608) * _2602;
                            _2621 = _2612;
                            _2622 = _2613;
                            _2623 = (_2613 + _2612) * _2602;
                            _2624 = _2599;
                        }
                        else
                        {
                            float _2505 = dot(_333, _936);
                            float _2506 = dot(_333, _531);
                            float _2507 = dot(_531, _936);
                            float _2509 = rsqrt(mad(2.0f, _2507, 2.0f));
                            float _2594 = 0.0f;
                            float _2595 = 0.0f;
                            if (_942 > 0.0f)
                            {
                                float _2520 = sqrt(mad(-_942, _942, 1.0f));
                                float _2521 = 2.0f * _2505;
                                float _2522 = -_2507;
                                float _2523 = mad(_2521, _2506, _2522);
                                float _2592 = 0.0f;
                                float _2593 = 0.0f;
                                if (_2523 >= _2520)
                                {
                                    _2592 = 1.0f;
                                    _2593 = abs(_2506);
                                }
                                else
                                {
                                    float _2528 = -_2523;
                                    float _2531 = _942 * rsqrt(mad(_2528, _2523, 1.0f));
                                    float _2532 = mad(_2528, _2505, _2506);
                                    float _2536 = mad(_2528, _2507, mad(2.0f * _2506, _2506, -1.0f));
                                    float _2547 = _2531 * sqrt(clamp(mad(_2521 * _2506, _2507, mad(_2522, _2507, mad(-_2506, _2506, mad(-_2505, _2505, 1.0f)))), 0.0f, 1.0f));
                                    float _2549 = (_2547 * 2.0f) * _2506;
                                    float _2550 = mad(_2505, _2520, _2506);
                                    float _2551 = mad(_2531, _2532, _2550);
                                    float _2553 = mad(_2531, _2536, mad(_2507, _2520, 1.0f));
                                    float _2554 = _2547 * _2553;
                                    float _2555 = _2551 * _2553;
                                    float _2560 = _2555 * mad(-0.5f, _2554, (0.25f * _2549) * _2551);
                                    float _2570 = mad(_2551, mad(_2550, _2553 * _2553, _2555 * mad(-0.5f, mad(_2507, _2520, _2553), -0.5f)), mad(_2554, _2554, (_2549 * _2551) * mad(_2549, _2551, _2554 * (-2.0f))));
                                    float _2574 = (2.0f * _2560) / mad(_2570, _2570, _2560 * _2560);
                                    float _2575 = _2574 * _2570;
                                    float _2577 = mad(-_2574, _2560, 1.0f);
                                    float _2583 = mad(_2507, _2520, mad(_2577, _2531 * _2536, _2575 * _2549));
                                    float _2585 = rsqrt(mad(2.0f, _2583, 2.0f));
                                    _2592 = clamp((mad(_2505, _2520, mad(_2577, _2531 * _2532, _2575 * _2547)) + _2506) * _2585, 0.0f, 1.0f);
                                    _2593 = clamp(mad(_2585, _2583, _2585), 0.0f, 1.0f);
                                }
                                _2594 = _2592;
                                _2595 = _2593;
                            }
                            else
                            {
                                _2594 = clamp((_2505 + _2506) * _2509, 0.0f, 1.0f);
                                _2595 = clamp(mad(_2509, _2507, _2509), 0.0f, 1.0f);
                            }
                            _2616 = _2594;
                            _2617 = _2595;
                            _2618 = 0.0f;
                            _2619 = 0.0f;
                            _2620 = 0.0f;
                            _2621 = 0.0f;
                            _2622 = 0.0f;
                            _2623 = 0.0f;
                            _2624 = _2506;
                        }
                        float _2627 = clamp(abs(_2624) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _2630 = 1.0f.xxx * (_917 * _916);
                        float3 _2765 = 0.0f.xxx;
                        [branch]
                        if (_2501)
                        {
                            float _2719 = _869 * _869;
                            float _2721 = _2719 * (1.0f + _389);
                            float _2722 = isnan(0.001000000047497451305389404296875f) ? _2721 : (isnan(_2721) ? 0.001000000047497451305389404296875f : max(_2721, 0.001000000047497451305389404296875f));
                            float _2724 = _2719 * (1.0f - _389);
                            float _2725 = isnan(0.001000000047497451305389404296875f) ? _2724 : (isnan(_2724) ? 0.001000000047497451305389404296875f : max(_2724, 0.001000000047497451305389404296875f));
                            float _2726 = _2722 * _2725;
                            float3 _2730 = float3(_2725 * _2620, _2722 * _2623, _2726 * _2616);
                            float _2733 = _2726 / dot(_2730, _2730);
                            float _2749 = 1.0f - _2617;
                            float _2750 = _2749 * _2749;
                            float _2751 = _2750 * _2750;
                            _2765 = _2630 * ((((0.3183098733425140380859375f * _2726) * (_2733 * _2733)).xxx * (0.5f / mad(_916, length(float3(_2722 * _2618, _2725 * _2621, _2627)), _2627 * length(float3(_2722 * _2619, _2725 * _2622, _916)))).xxx) * ((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_2751 * _2749)).xxx + (_380 * mad(-_2751, _2749, 1.0f))));
                        }
                        else
                        {
                            float3 _2718 = 0.0f.xxx;
                            if ((_951 & 1u) == 1u)
                            {
                                _2718 = 0.0f.xxx;
                            }
                            else
                            {
                                float _2640 = _869 * _869;
                                float _2650 = 0.0f;
                                if (_944 > 0.0f)
                                {
                                    _2650 = clamp(mad(_2640, _2640, (_944 * _944) / mad(_2617, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                                }
                                else
                                {
                                    _2650 = _2640 * _2640;
                                }
                                float _2665 = 0.0f;
                                float _2666 = 0.0f;
                                if (_942 > 0.0f)
                                {
                                    float _2663 = _2650 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_2650) >> 1)), _942)) / (_2617 + 0.001000000047497451305389404296875f));
                                    _2665 = _2650 / _2663;
                                    _2666 = _2663;
                                }
                                else
                                {
                                    _2665 = 1.0f;
                                    _2666 = _2650;
                                }
                                float _2687 = 0.0f;
                                if (_895 < 1.0f)
                                {
                                    float _2673 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                    _2687 = _2665 * sqrt(_2666 / (_2666 + (((0.25f * _2673) * mad(3.0f, asfloat(532487669 + (asint(_2666) >> 1)), _2673)) / (_2617 + 0.001000000047497451305389404296875f))));
                                }
                                else
                                {
                                    _2687 = _2665;
                                }
                                float _2690 = mad(mad(_2616, _2650, -_2616), _2616, 1.0f);
                                float _2695 = sqrt(_2650);
                                float _2696 = 1.0f - _2695;
                                float _2702 = 1.0f - _2617;
                                float _2703 = _2702 * _2702;
                                float _2704 = _2703 * _2703;
                                _2718 = _2630 * (((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_2704 * _2702)).xxx + (_380 * mad(-_2704, _2702, 1.0f))) * (((_2650 / ((3.1415927410125732421875f * _2690) * _2690)) * _2687) * (0.5f / mad(_916, mad(_2627, _2696, _2695), _2627 * mad(_916, _2696, _2695)))));
                            }
                            _2765 = _2718;
                        }
                        float3 _2767 = _321.xyz;
                        _3409 = ((_373 * 0.3183098733425140380859375f) * _2630) * 1.0f;
                        _3410 = _2765;
                        _3411 = ((1.0f.xxx * _917) * View_PreIntegratedBRDF.SampleLevel(View_PreIntegratedBRDFSampler, float2(clamp(mad(dot(_333, _936), 0.5f, 0.5f), 0.0f, 1.0f), 1.0f - _563), 0.0f).xyz) * (_2767 * _2767);
                        break;
                    }
                    case 4u:
                    {
                        float _2109 = _321.x;
                        float _2110 = _321.y;
                        float _2111 = isnan(0.0199999995529651641845703125f) ? _2110 : (isnan(_2110) ? 0.0199999995529651641845703125f : max(_2110, 0.0199999995529651641845703125f));
                        bool _2114 = (int(_390) & 16) != 0;
                        float _2115 = dot(_333, _936);
                        float _2116 = dot(_333, _531);
                        float _2117 = dot(_531, _936);
                        float _2119 = rsqrt(mad(2.0f, _2117, 2.0f));
                        float _2122 = clamp((_2115 + _2116) * _2119, 0.0f, 1.0f);
                        float _2124 = clamp(mad(_2119, _2117, _2119), 0.0f, 1.0f);
                        float _2126 = mad(-_869, _869, 1.0f);
                        float _2127 = _2111 * _2111;
                        float _2134 = clamp(_942 * ((_2126 > 0.0f) ? (mad(-_2111, _2111, 1.0f) / _2126) : 0.0f), 0.0f, 1.0f);
                        bool _2135 = _2134 > 0.0f;
                        float _2215 = 0.0f;
                        float _2216 = 0.0f;
                        float _2217 = 0.0f;
                        if (_2135)
                        {
                            float _2140 = sqrt(mad(-_2134, _2134, 1.0f));
                            float _2141 = 2.0f * _2115;
                            float _2142 = -_2117;
                            float _2143 = mad(_2141, _2116, _2142);
                            float _2212 = 0.0f;
                            float _2213 = 0.0f;
                            float _2214 = 0.0f;
                            if (_2143 >= _2140)
                            {
                                _2212 = _2115;
                                _2213 = 1.0f;
                                _2214 = abs(_2116);
                            }
                            else
                            {
                                float _2148 = -_2143;
                                float _2151 = _2134 * rsqrt(mad(_2148, _2143, 1.0f));
                                float _2152 = mad(_2148, _2115, _2116);
                                float _2156 = mad(_2148, _2117, mad(2.0f * _2116, _2116, -1.0f));
                                float _2167 = _2151 * sqrt(clamp(mad(_2141 * _2116, _2117, mad(_2142, _2117, mad(-_2116, _2116, mad(-_2115, _2115, 1.0f)))), 0.0f, 1.0f));
                                float _2169 = (_2167 * 2.0f) * _2116;
                                float _2170 = mad(_2115, _2140, _2116);
                                float _2171 = mad(_2151, _2152, _2170);
                                float _2173 = mad(_2151, _2156, mad(_2117, _2140, 1.0f));
                                float _2174 = _2167 * _2173;
                                float _2175 = _2171 * _2173;
                                float _2180 = _2175 * mad(-0.5f, _2174, (0.25f * _2169) * _2171);
                                float _2190 = mad(_2171, mad(_2170, _2173 * _2173, _2175 * mad(-0.5f, mad(_2117, _2140, _2173), -0.5f)), mad(_2174, _2174, (_2169 * _2171) * mad(_2169, _2171, _2174 * (-2.0f))));
                                float _2194 = (2.0f * _2180) / mad(_2190, _2190, _2180 * _2180);
                                float _2195 = _2194 * _2190;
                                float _2197 = mad(-_2194, _2180, 1.0f);
                                float _2202 = mad(_2115, _2140, mad(_2197, _2151 * _2152, _2195 * _2167));
                                float _2203 = mad(_2117, _2140, mad(_2197, _2151 * _2156, _2195 * _2169));
                                float _2205 = rsqrt(mad(2.0f, _2203, 2.0f));
                                _2212 = _2202;
                                _2213 = clamp((_2202 + _2116) * _2205, 0.0f, 1.0f);
                                _2214 = clamp(mad(_2205, _2203, _2205), 0.0f, 1.0f);
                            }
                            _2215 = _2212;
                            _2216 = _2213;
                            _2217 = _2214;
                        }
                        else
                        {
                            _2215 = _2115;
                            _2216 = _2122;
                            _2217 = _2124;
                        }
                        float _2220 = clamp(abs(_2116) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        bool _2222 = (_951 & 1u) == 1u;
                        float _2223 = _2222 ? _2220 : _2217;
                        float _2224 = 1.0f - _2223;
                        float _2225 = _2224 * _2224;
                        float _2226 = _2225 * _2225;
                        float _2230 = mad(_2226, _2224, mad(-_2226, _2224, 1.0f) * 0.039999999105930328369140625f);
                        float3 _2300 = 0.0f.xxx;
                        if (_2222)
                        {
                            _2300 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2243 = 0.0f;
                            if (_944 > 0.0f)
                            {
                                _2243 = clamp(mad(_2127, _2127, (_944 * _944) / mad(_2223, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2243 = _2127 * _2127;
                            }
                            float _2257 = 0.0f;
                            float _2258 = 0.0f;
                            if (_2135)
                            {
                                float _2255 = _2243 + (((0.25f * _2134) * mad(3.0f, asfloat(532487669 + (asint(_2243) >> 1)), _2134)) / (_2223 + 0.001000000047497451305389404296875f));
                                _2257 = _2243 / _2255;
                                _2258 = _2255;
                            }
                            else
                            {
                                _2257 = 1.0f;
                                _2258 = _2243;
                            }
                            float _2279 = 0.0f;
                            if (_895 < 1.0f)
                            {
                                float _2265 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                _2279 = _2257 * sqrt(_2258 / (_2258 + (((0.25f * _2265) * mad(3.0f, asfloat(532487669 + (asint(_2258) >> 1)), _2265)) / (_2223 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2279 = _2257;
                            }
                            float _2280 = sqrt(_2243);
                            float _2281 = 1.0f - _2280;
                            float _2289 = mad(mad(_2216, _2243, -_2216), _2216, 1.0f);
                            _2300 = (1.0f.xxx * _2109) * ((_917 * _916) * ((((_2243 / ((3.1415927410125732421875f * _2289) * _2289)) * _2279) * (0.5f / mad(_916, mad(_2220, _2281, _2280), _2220 * mad(_916, _2281, _2280)))) * _2230));
                        }
                        float _2301 = _869 * _869;
                        float _2302 = 1.0f - _2230;
                        float _2316 = 0.0f;
                        float _2317 = 0.0f;
                        float _2318 = 0.0f;
                        float _2319 = 0.0f;
                        float _2320 = 0.0f;
                        float _2321 = 0.0f;
                        if (_2114)
                        {
                            float3 _2307 = normalize(cross(_333, _388));
                            float _2308 = dot(_388, _531);
                            float _2309 = dot(_388, _936);
                            float _2312 = dot(_2307, _531);
                            float _2313 = dot(_2307, _936);
                            _2316 = _2308;
                            _2317 = _2309;
                            _2318 = (_2309 + _2308) * _2119;
                            _2319 = _2312;
                            _2320 = _2313;
                            _2321 = (_2313 + _2312) * _2119;
                        }
                        else
                        {
                            _2316 = 0.0f;
                            _2317 = 0.0f;
                            _2318 = 0.0f;
                            _2319 = 0.0f;
                            _2320 = 0.0f;
                            _2321 = 0.0f;
                        }
                        float _2324 = _2114 ? _2122 : _2216;
                        float _2325 = _2114 ? _2124 : _2223;
                        float _2327 = mad(mad(-0.2199999988079071044921875f, _2325, 0.62999999523162841796875f), _2325, -0.74500000476837158203125f);
                        float _2329 = -(_2327 * _2324);
                        float _2331 = clamp(mad(0.666666686534881591796875f, _2114 ? _2116 : _2220, _2329), 0.001000000047497451305389404296875f, 1.0f);
                        float _2333 = clamp(mad(0.666666686534881591796875f, _2114 ? _2115 : _2215, _2329), 0.001000000047497451305389404296875f, 1.0f);
                        float3 _2354 = 0.0f.xxx;
                        if (_335 > 0.0f)
                        {
                            float3 _2344 = _364 * 0.3183098733425140380859375f;
                            bool3 _3693 = isnan(_2344);
                            bool3 _3694 = isnan(9.9999997473787516355514526367188e-05f.xxx);
                            float3 _3695 = max(_2344, 9.9999997473787516355514526367188e-05f.xxx);
                            float3 _3696 = float3(_3693.x ? 9.9999997473787516355514526367188e-05f.xxx.x : _3695.x, _3693.y ? 9.9999997473787516355514526367188e-05f.xxx.y : _3695.y, _3693.z ? 9.9999997473787516355514526367188e-05f.xxx.z : _3695.z);
                            float _2348 = ((1.0f / _2331) + (1.0f / _2333)) - 2.0f;
                            _2354 = lerp(1.0f.xxx, exp(-((log(float3(_3694.x ? _2344.x : _3696.x, _3694.y ? _2344.y : _3696.y, _3694.z ? _2344.z : _3696.z)) * (-0.5f).xxx) * (isnan(0.0f) ? _2348 : (isnan(_2348) ? 0.0f : max(_2348, 0.0f))))), _338);
                        }
                        else
                        {
                            _2354 = 1.0f.xxx;
                        }
                        float3 _2359 = ((1.0f.xxx * (_917 * _916)) * (_373 * 0.3183098733425140380859375f)) * 1.0f;
                        float3 _2360 = _2354 * (_2302 * _2302);
                        float3 _2362 = _2109.xxx;
                        float3 _2498 = 0.0f.xxx;
                        if ((!_2114) && _2222)
                        {
                            _2498 = _2300 + lerp(0.0f.xxx, 0.0f.xxx, _2362);
                        }
                        else
                        {
                            float _2369 = _2301 * _2301;
                            float _2413 = 0.0f;
                            float _2414 = 0.0f;
                            [branch]
                            if (_2114)
                            {
                                float _2387 = _2301 * (1.0f + _389);
                                float _2388 = isnan(0.001000000047497451305389404296875f) ? _2387 : (isnan(_2387) ? 0.001000000047497451305389404296875f : max(_2387, 0.001000000047497451305389404296875f));
                                float _2390 = _2301 * (1.0f - _389);
                                float _2391 = isnan(0.001000000047497451305389404296875f) ? _2390 : (isnan(_2390) ? 0.001000000047497451305389404296875f : max(_2390, 0.001000000047497451305389404296875f));
                                float _2392 = _2388 * _2391;
                                float3 _2396 = float3(_2391 * _2318, _2388 * _2321, _2392 * _2324);
                                float _2399 = _2392 / dot(_2396, _2396);
                                _2413 = 0.5f / mad(_2333, length(float3(_2388 * _2316, _2391 * _2319, _2331)), _2331 * length(float3(_2388 * _2317, _2391 * _2320, _2333)));
                                _2414 = (0.3183098733425140380859375f * _2392) * (_2399 * _2399);
                            }
                            else
                            {
                                float _2373 = sqrt(_2369);
                                float _2374 = 1.0f - _2373;
                                float _2382 = mad(mad(_2324, _2369, -_2324), _2324, 1.0f);
                                _2413 = 0.5f / mad(_916, mad(_2331, _2374, _2373), _2331 * mad(_916, _2374, _2373));
                                _2414 = _2369 / ((3.1415927410125732421875f * _2382) * _2382);
                            }
                            float _2415 = 1.0f - (_2222 ? _2331 : clamp(mad(0.666666686534881591796875f, _2325, -_2327), 0.0f, 1.0f));
                            float _2416 = _2415 * _2415;
                            float _2417 = _2416 * _2416;
                            float _2421 = clamp(50.0f * _380.y, 0.0f, 1.0f);
                            float _2428 = 1.0f - _2325;
                            float _2429 = _2428 * _2428;
                            float _2430 = _2429 * _2429;
                            float _2487 = 0.0f;
                            [branch]
                            if (_2114)
                            {
                                _2487 = 1.0f;
                            }
                            else
                            {
                                float _2449 = 0.0f;
                                if (_944 > 0.0f)
                                {
                                    _2449 = clamp(mad(_2301, _2301, (_944 * _944) / mad(_2325, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                                }
                                else
                                {
                                    _2449 = _2369;
                                }
                                float _2464 = 0.0f;
                                float _2465 = 0.0f;
                                if (_942 > 0.0f)
                                {
                                    float _2462 = _2449 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_2449) >> 1)), _942)) / (_2325 + 0.001000000047497451305389404296875f));
                                    _2464 = _2449 / _2462;
                                    _2465 = _2462;
                                }
                                else
                                {
                                    _2464 = 1.0f;
                                    _2465 = _2449;
                                }
                                float _2486 = 0.0f;
                                if (_895 < 1.0f)
                                {
                                    float _2472 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                    _2486 = _2464 * sqrt(_2465 / (_2465 + (((0.25f * _2472) * mad(3.0f, asfloat(532487669 + (asint(_2465) >> 1)), _2472)) / (_2325 + 0.001000000047497451305389404296875f))));
                                }
                                else
                                {
                                    _2486 = _2464;
                                }
                                _2487 = _2486;
                            }
                            _2498 = mad(1.0f.xxx * ((((_2487 * _917) * _916) * _2414) * _2413), lerp((_2421 * (_2430 * _2428)).xxx + (_380 * mad(-_2430, _2428, 1.0f)), _2360 * ((_2421 * (_2417 * _2415)).xxx + (_380 * mad(-_2417, _2415, 1.0f))), _2362), _2300);
                        }
                        _3409 = lerp(_2359, _2360 * _2359, _2362);
                        _3410 = _2498;
                        _3411 = 0.0f.xxx;
                        break;
                    }
                    case 5u:
                    {
                        float _1831 = dot(_333, _936);
                        float _1832 = dot(_333, _531);
                        float _1833 = dot(_531, _936);
                        float _1835 = rsqrt(mad(2.0f, _1833, 2.0f));
                        bool _1841 = _942 > 0.0f;
                        float _1920 = 0.0f;
                        float _1921 = 0.0f;
                        if (_1841)
                        {
                            float _1846 = sqrt(mad(-_942, _942, 1.0f));
                            float _1847 = 2.0f * _1831;
                            float _1848 = -_1833;
                            float _1849 = mad(_1847, _1832, _1848);
                            float _1918 = 0.0f;
                            float _1919 = 0.0f;
                            if (_1849 >= _1846)
                            {
                                _1918 = 1.0f;
                                _1919 = abs(_1832);
                            }
                            else
                            {
                                float _1854 = -_1849;
                                float _1857 = _942 * rsqrt(mad(_1854, _1849, 1.0f));
                                float _1858 = mad(_1854, _1831, _1832);
                                float _1862 = mad(_1854, _1833, mad(2.0f * _1832, _1832, -1.0f));
                                float _1873 = _1857 * sqrt(clamp(mad(_1847 * _1832, _1833, mad(_1848, _1833, mad(-_1832, _1832, mad(-_1831, _1831, 1.0f)))), 0.0f, 1.0f));
                                float _1875 = (_1873 * 2.0f) * _1832;
                                float _1876 = mad(_1831, _1846, _1832);
                                float _1877 = mad(_1857, _1858, _1876);
                                float _1879 = mad(_1857, _1862, mad(_1833, _1846, 1.0f));
                                float _1880 = _1873 * _1879;
                                float _1881 = _1877 * _1879;
                                float _1886 = _1881 * mad(-0.5f, _1880, (0.25f * _1875) * _1877);
                                float _1896 = mad(_1877, mad(_1876, _1879 * _1879, _1881 * mad(-0.5f, mad(_1833, _1846, _1879), -0.5f)), mad(_1880, _1880, (_1875 * _1877) * mad(_1875, _1877, _1880 * (-2.0f))));
                                float _1900 = (2.0f * _1886) / mad(_1896, _1896, _1886 * _1886);
                                float _1901 = _1900 * _1896;
                                float _1903 = mad(-_1900, _1886, 1.0f);
                                float _1909 = mad(_1833, _1846, mad(_1903, _1857 * _1862, _1901 * _1875));
                                float _1911 = rsqrt(mad(2.0f, _1909, 2.0f));
                                _1918 = clamp((mad(_1831, _1846, mad(_1903, _1857 * _1858, _1901 * _1873)) + _1832) * _1911, 0.0f, 1.0f);
                                _1919 = clamp(mad(_1911, _1909, _1911), 0.0f, 1.0f);
                            }
                            _1920 = _1918;
                            _1921 = _1919;
                        }
                        else
                        {
                            _1920 = clamp((_1831 + _1832) * _1835, 0.0f, 1.0f);
                            _1921 = clamp(mad(_1835, _1833, _1835), 0.0f, 1.0f);
                        }
                        float _1924 = clamp(abs(_1832) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float4 _1932 = View_SSProfilesTexture.Load(int3(int3(5, int(uint(mad(_321.x, 255.0f, 0.5f))), 0).xy, 0));
                        float _1937 = clamp((_563 - 0.100000001490116119384765625f) * 10.0f, 0.0f, 1.0f);
                        float _1942 = _1932.z;
                        float _1944 = clamp(_869 * lerp(1.0f, _1932.x * 2.0f, _1937), 0.0f, 1.0f);
                        float _1945 = isnan(0.0199999995529651641845703125f) ? _1944 : (isnan(_1944) ? 0.0199999995529651641845703125f : max(_1944, 0.0199999995529651641845703125f));
                        float _1947 = clamp(_869 * lerp(1.0f, _1932.y * 2.0f, _1937), 0.0f, 1.0f);
                        float _1948 = lerp(_1945, _1947, _1942);
                        float _1952 = mad((2.0f * _1921) * _1921, _869, 0.5f) - 1.0f;
                        float _1953 = 1.0f - _1924;
                        float _1954 = _1953 * _1953;
                        float _1958 = 1.0f - _916;
                        float _1959 = _1958 * _1958;
                        float3 _1967 = 1.0f.xxx * (_917 * _916);
                        float3 _2107 = 0.0f.xxx;
                        if ((_951 & 1u) == 1u)
                        {
                            _2107 = lerp(0.0f.xxx, 0.0f.xxx, _1942.xxx);
                        }
                        else
                        {
                            float _1974 = _1948 * _1948;
                            float _1976 = _1945 * _1945;
                            float _1978 = _1947 * _1947;
                            bool _1980 = _944 > 0.0f;
                            float _1988 = 0.0f;
                            if (_1980)
                            {
                                _1988 = clamp(mad(_1976, _1976, (_944 * _944) / mad(_1921, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1988 = _1976 * _1976;
                            }
                            float _2002 = 0.0f;
                            float _2003 = 0.0f;
                            if (_1841)
                            {
                                float _2000 = _1988 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_1988) >> 1)), _942)) / (_1921 + 0.001000000047497451305389404296875f));
                                _2002 = _1988 / _2000;
                                _2003 = _2000;
                            }
                            else
                            {
                                _2002 = 1.0f;
                                _2003 = _1988;
                            }
                            bool _2004 = _895 < 1.0f;
                            float _2024 = 0.0f;
                            if (_2004)
                            {
                                float _2010 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                _2024 = _2002 * sqrt(_2003 / (_2003 + (((0.25f * _2010) * mad(3.0f, asfloat(532487669 + (asint(_2003) >> 1)), _2010)) / (_1921 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2024 = _2002;
                            }
                            float _2032 = 0.0f;
                            if (_1980)
                            {
                                _2032 = clamp(mad(_1978, _1978, (_944 * _944) / mad(_1921, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2032 = _1978 * _1978;
                            }
                            float _2046 = 0.0f;
                            float _2047 = 0.0f;
                            if (_1841)
                            {
                                float _2044 = _2032 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_2032) >> 1)), _942)) / (_1921 + 0.001000000047497451305389404296875f));
                                _2046 = _2032 / _2044;
                                _2047 = _2044;
                            }
                            else
                            {
                                _2046 = 1.0f;
                                _2047 = _2032;
                            }
                            float _2067 = 0.0f;
                            if (_2004)
                            {
                                float _2053 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                _2067 = _2046 * sqrt(_2047 / (_2047 + (((0.25f * _2053) * mad(3.0f, asfloat(532487669 + (asint(_2047) >> 1)), _2053)) / (_1921 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2067 = _2046;
                            }
                            float _2068 = -_1920;
                            float _2070 = mad(mad(_1920, _1988, _2068), _1920, 1.0f);
                            float _2076 = mad(mad(_1920, _2032, _2068), _1920, 1.0f);
                            float _2082 = sqrt(_1974 * _1974);
                            float _2083 = 1.0f - _2082;
                            float _2089 = 1.0f - _1921;
                            float _2090 = _2089 * _2089;
                            float _2091 = _2090 * _2090;
                            _2107 = _1967 * (((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_2091 * _2089)).xxx + (_380 * mad(-_2091, _2089, 1.0f))) * (lerp((_1988 / ((3.1415927410125732421875f * _2070) * _2070)) * _2024, (_2032 / ((3.1415927410125732421875f * _2076) * _2076)) * _2067, _1942) * (0.5f / mad(_916, mad(_1924, _2083, _2082), _1924 * mad(_916, _2083, _2082)))));
                        }
                        _3409 = (_1967 * (_373 * ((0.3183098733425140380859375f * mad(_1952, (_1954 * _1954) * _1953, 1.0f)) * mad(_1952, (_1959 * _1959) * _1958, 1.0f)))) * 1.0f;
                        _3410 = _2107;
                        _3411 = 0.0f.xxx;
                        break;
                    }
                    case 6u:
                    {
                        bool _1546 = (int(_390) & 16) != 0;
                        float _1661 = 0.0f;
                        float _1662 = 0.0f;
                        float _1663 = 0.0f;
                        float _1664 = 0.0f;
                        float _1665 = 0.0f;
                        float _1666 = 0.0f;
                        float _1667 = 0.0f;
                        float _1668 = 0.0f;
                        float _1669 = 0.0f;
                        [branch]
                        if (_1546)
                        {
                            float3 _1642 = normalize(cross(_333, _388));
                            float _1644 = dot(_333, _531);
                            float _1645 = dot(_531, _936);
                            float _1647 = rsqrt(mad(2.0f, _1645, 2.0f));
                            float _1653 = dot(_388, _531);
                            float _1654 = dot(_388, _936);
                            float _1657 = dot(_1642, _531);
                            float _1658 = dot(_1642, _936);
                            _1661 = clamp((dot(_333, _936) + _1644) * _1647, 0.0f, 1.0f);
                            _1662 = clamp(mad(_1647, _1645, _1647), 0.0f, 1.0f);
                            _1663 = _1653;
                            _1664 = _1654;
                            _1665 = (_1654 + _1653) * _1647;
                            _1666 = _1657;
                            _1667 = _1658;
                            _1668 = (_1658 + _1657) * _1647;
                            _1669 = _1644;
                        }
                        else
                        {
                            float _1550 = dot(_333, _936);
                            float _1551 = dot(_333, _531);
                            float _1552 = dot(_531, _936);
                            float _1554 = rsqrt(mad(2.0f, _1552, 2.0f));
                            float _1639 = 0.0f;
                            float _1640 = 0.0f;
                            if (_942 > 0.0f)
                            {
                                float _1565 = sqrt(mad(-_942, _942, 1.0f));
                                float _1566 = 2.0f * _1550;
                                float _1567 = -_1552;
                                float _1568 = mad(_1566, _1551, _1567);
                                float _1637 = 0.0f;
                                float _1638 = 0.0f;
                                if (_1568 >= _1565)
                                {
                                    _1637 = 1.0f;
                                    _1638 = abs(_1551);
                                }
                                else
                                {
                                    float _1573 = -_1568;
                                    float _1576 = _942 * rsqrt(mad(_1573, _1568, 1.0f));
                                    float _1577 = mad(_1573, _1550, _1551);
                                    float _1581 = mad(_1573, _1552, mad(2.0f * _1551, _1551, -1.0f));
                                    float _1592 = _1576 * sqrt(clamp(mad(_1566 * _1551, _1552, mad(_1567, _1552, mad(-_1551, _1551, mad(-_1550, _1550, 1.0f)))), 0.0f, 1.0f));
                                    float _1594 = (_1592 * 2.0f) * _1551;
                                    float _1595 = mad(_1550, _1565, _1551);
                                    float _1596 = mad(_1576, _1577, _1595);
                                    float _1598 = mad(_1576, _1581, mad(_1552, _1565, 1.0f));
                                    float _1599 = _1592 * _1598;
                                    float _1600 = _1596 * _1598;
                                    float _1605 = _1600 * mad(-0.5f, _1599, (0.25f * _1594) * _1596);
                                    float _1615 = mad(_1596, mad(_1595, _1598 * _1598, _1600 * mad(-0.5f, mad(_1552, _1565, _1598), -0.5f)), mad(_1599, _1599, (_1594 * _1596) * mad(_1594, _1596, _1599 * (-2.0f))));
                                    float _1619 = (2.0f * _1605) / mad(_1615, _1615, _1605 * _1605);
                                    float _1620 = _1619 * _1615;
                                    float _1622 = mad(-_1619, _1605, 1.0f);
                                    float _1628 = mad(_1552, _1565, mad(_1622, _1576 * _1581, _1620 * _1594));
                                    float _1630 = rsqrt(mad(2.0f, _1628, 2.0f));
                                    _1637 = clamp((mad(_1550, _1565, mad(_1622, _1576 * _1577, _1620 * _1592)) + _1551) * _1630, 0.0f, 1.0f);
                                    _1638 = clamp(mad(_1630, _1628, _1630), 0.0f, 1.0f);
                                }
                                _1639 = _1637;
                                _1640 = _1638;
                            }
                            else
                            {
                                _1639 = clamp((_1550 + _1551) * _1554, 0.0f, 1.0f);
                                _1640 = clamp(mad(_1554, _1552, _1554), 0.0f, 1.0f);
                            }
                            _1661 = _1639;
                            _1662 = _1640;
                            _1663 = 0.0f;
                            _1664 = 0.0f;
                            _1665 = 0.0f;
                            _1666 = 0.0f;
                            _1667 = 0.0f;
                            _1668 = 0.0f;
                            _1669 = _1551;
                        }
                        float _1672 = clamp(abs(_1669) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _1675 = 1.0f.xxx * (_917 * _916);
                        float3 _1810 = 0.0f.xxx;
                        [branch]
                        if (_1546)
                        {
                            float _1764 = _869 * _869;
                            float _1766 = _1764 * (1.0f + _389);
                            float _1767 = isnan(0.001000000047497451305389404296875f) ? _1766 : (isnan(_1766) ? 0.001000000047497451305389404296875f : max(_1766, 0.001000000047497451305389404296875f));
                            float _1769 = _1764 * (1.0f - _389);
                            float _1770 = isnan(0.001000000047497451305389404296875f) ? _1769 : (isnan(_1769) ? 0.001000000047497451305389404296875f : max(_1769, 0.001000000047497451305389404296875f));
                            float _1771 = _1767 * _1770;
                            float3 _1775 = float3(_1770 * _1665, _1767 * _1668, _1771 * _1661);
                            float _1778 = _1771 / dot(_1775, _1775);
                            float _1794 = 1.0f - _1662;
                            float _1795 = _1794 * _1794;
                            float _1796 = _1795 * _1795;
                            _1810 = _1675 * ((((0.3183098733425140380859375f * _1771) * (_1778 * _1778)).xxx * (0.5f / mad(_916, length(float3(_1767 * _1663, _1770 * _1666, _1672)), _1672 * length(float3(_1767 * _1664, _1770 * _1667, _916)))).xxx) * ((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_1796 * _1794)).xxx + (_380 * mad(-_1796, _1794, 1.0f))));
                        }
                        else
                        {
                            float3 _1763 = 0.0f.xxx;
                            if ((_951 & 1u) == 1u)
                            {
                                _1763 = 0.0f.xxx;
                            }
                            else
                            {
                                float _1685 = _869 * _869;
                                float _1695 = 0.0f;
                                if (_944 > 0.0f)
                                {
                                    _1695 = clamp(mad(_1685, _1685, (_944 * _944) / mad(_1662, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                                }
                                else
                                {
                                    _1695 = _1685 * _1685;
                                }
                                float _1710 = 0.0f;
                                float _1711 = 0.0f;
                                if (_942 > 0.0f)
                                {
                                    float _1708 = _1695 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_1695) >> 1)), _942)) / (_1662 + 0.001000000047497451305389404296875f));
                                    _1710 = _1695 / _1708;
                                    _1711 = _1708;
                                }
                                else
                                {
                                    _1710 = 1.0f;
                                    _1711 = _1695;
                                }
                                float _1732 = 0.0f;
                                if (_895 < 1.0f)
                                {
                                    float _1718 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                    _1732 = _1710 * sqrt(_1711 / (_1711 + (((0.25f * _1718) * mad(3.0f, asfloat(532487669 + (asint(_1711) >> 1)), _1718)) / (_1662 + 0.001000000047497451305389404296875f))));
                                }
                                else
                                {
                                    _1732 = _1710;
                                }
                                float _1735 = mad(mad(_1661, _1695, -_1661), _1661, 1.0f);
                                float _1740 = sqrt(_1695);
                                float _1741 = 1.0f - _1740;
                                float _1747 = 1.0f - _1662;
                                float _1748 = _1747 * _1747;
                                float _1749 = _1748 * _1748;
                                _1763 = _1675 * (((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_1749 * _1747)).xxx + (_380 * mad(-_1749, _1747, 1.0f))) * (((_1695 / ((3.1415927410125732421875f * _1735) * _1735)) * _1732) * (0.5f / mad(_916, mad(_1672, _1741, _1740), _1672 * mad(_916, _1741, _1740)))));
                            }
                            _1810 = _1763;
                        }
                        float3 _1812 = _321.xyz;
                        float _1820 = clamp(-dot(_531, _936), 0.0f, 1.0f);
                        float _1823 = mad(mad(_1820, 0.36000001430511474609375f, -_1820), _1820, 1.0f);
                        _3409 = ((_373 * 0.3183098733425140380859375f) * _1675) * 1.0f;
                        _3410 = _1810;
                        _3411 = (1.0f.xxx * ((_917 * clamp((0.5f - dot(_333, _936)) * 0.4444444477558135986328125f, 0.0f, 1.0f)) * (0.36000001430511474609375f / ((3.1415927410125732421875f * _1823) * _1823)))) * (_1812 * _1812);
                        break;
                    }
                    case 7u:
                    {
                        float _1365 = clamp(_869, 0.0039215688593685626983642578125f, 1.0f);
                        float _1366 = isnan(1.0f) ? 1.0f : (isnan(1.0f) ? 1.0f : min(1.0f, 1.0f));
                        float _1367 = dot(_531, _936);
                        float _1368 = dot(_333, _936);
                        float _1369 = clamp(_1368, -1.0f, 1.0f);
                        float _1371 = clamp(dot(_333, _531), -1.0f, 1.0f);
                        float _1372 = abs(_1371);
                        float _1373 = mad(-0.15658299624919891357421875f, _1372, 1.57079637050628662109375f);
                        float _1375 = sqrt(1.0f - _1372);
                        float _1382 = abs(_1369);
                        float _1383 = mad(-0.15658299624919891357421875f, _1382, 1.57079637050628662109375f);
                        float _1385 = sqrt(1.0f - _1382);
                        float _1395 = cos(0.5f * abs((1.57079637050628662109375f - ((_1371 >= 0.0f) ? (_1373 * _1375) : mad(-_1373, _1375, 3.1415927410125732421875f))) - (1.57079637050628662109375f - ((_1369 >= 0.0f) ? (_1383 * _1385) : mad(-_1383, _1385, 3.1415927410125732421875f)))));
                        float3 _1397 = _936 - (_333 * _1369);
                        float3 _1399 = _531 - (_333 * _1371);
                        float _1405 = dot(_1397, _1399) * rsqrt(mad(dot(_1397, _1397), dot(_1399, _1399), 9.9999997473787516355514526367188e-05f));
                        float _1408 = sqrt(clamp(mad(0.5f, _1405, 0.5f), 0.0f, 1.0f));
                        float _1411 = _1365 * _1365;
                        float _1412 = _1411 * 0.5f;
                        float _1413 = _1411 * 2.0f;
                        float _1421 = _1411 * (1.41421353816986083984375f * _1408);
                        float _1422 = _1369 + _1371;
                        float _1423 = mad(0.1398856937885284423828125f, mad(0.997551023960113525390625f * _1408, sqrt(mad(-_1371, _1371, 1.0f)), (-0.06994284689426422119140625f) * _1371), _1422);
                        float _1435 = 1.0f - sqrt(clamp(mad(0.5f, _1367, 0.5f), 0.0f, 1.0f));
                        float _1436 = _1435 * _1435;
                        float _1449 = _1422 - 0.0350000001490116119384765625f;
                        float _1457 = 1.0f / mad(0.36000001430511474609375f, _1395, 1.190000057220458984375f / _1395);
                        float _1460 = _1408 * mad(_1457, mad(-0.800000011920928955078125f, _1405, 0.60000002384185791015625f), 1.0f);
                        float _1465 = -_1395;
                        float _1466 = mad(_1465, sqrt(clamp(mad(-_1460, _1460, 1.0f), 0.0f, 1.0f)), 1.0f);
                        float _1467 = _1466 * _1466;
                        float _1471 = 1.0f - mad(0.95347940921783447265625f, (_1467 * _1467) * _1466, 0.0465205647051334381103515625f);
                        float3 _1473 = abs(_364);
                        float _1474 = _1460 * _1457;
                        float _1489 = _1422 - 0.14000000059604644775390625f;
                        float _1497 = mad(_1465, 0.5f, 1.0f);
                        float _1498 = _1497 * _1497;
                        float _1501 = mad(0.95347940921783447265625f, (_1498 * _1498) * _1497, 0.0465205647051334381103515625f);
                        float _1502 = 1.0f - _1501;
                        float3 _1514 = (((((((exp(((-0.5f) * (_1423 * _1423)) / (_1421 * _1421)) / (2.5066282749176025390625f * _1421)) * (0.25f * _1408)) * mad(0.95347940921783447265625f, (_1436 * _1436) * _1435, 0.0465205647051334381103515625f)) * (_365 * 2.0f)) * lerp(1.0f, _1366, clamp(-_1367, 0.0f, 1.0f))).xxx + ((pow(_1473, ((0.5f * sqrt(mad(-_1474, _1474, 1.0f))) / _1395).xxx) * (((exp(((-0.5f) * (_1449 * _1449)) / (_1412 * _1412)) / (_1411 * 1.25331413745880126953125f)) * exp(mad(-3.650000095367431640625f, _1405, -3.980000019073486328125f))) * (_1471 * _1471))) * _1366)) + (pow(_1473, (0.800000011920928955078125f / _1395).xxx) * (((exp(((-0.5f) * (_1489 * _1489)) / (_1413 * _1413)) / (_1411 * 5.013256549835205078125f)) * exp(mad(17.0f, _1405, -16.7800006866455078125f))) * ((_1502 * _1502) * _1501)))) * _858;
                        float _1528 = dot(_364, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                        float3 _1539 = -mad(sqrt(_1473) * ((0.3183098733425140380859375f * lerp(clamp((dot(normalize(_531 - (_333 * dot(_531, _333))), _936) + 1.0f) * 0.25f, 0.0f, 1.0f), 1.0f - abs(_1368), 0.3300000131130218505859375f)) * _335), pow(abs(_364 / (isnan(9.9999997473787516355514526367188e-05f) ? _1528 : (isnan(_1528) ? 9.9999997473787516355514526367188e-05f : max(_1528, 9.9999997473787516355514526367188e-05f))).xxx), (1.0f - _857).xxx), _1514);
                        bool3 _3778 = isnan(_1539);
                        bool3 _3779 = isnan(0.0f.xxx);
                        float3 _3780 = min(_1539, 0.0f.xxx);
                        float3 _3781 = float3(_3778.x ? 0.0f.xxx.x : _3780.x, _3778.y ? 0.0f.xxx.y : _3780.y, _3778.z ? 0.0f.xxx.z : _3780.z);
                        _3409 = 0.0f.xxx;
                        _3410 = 0.0f.xxx;
                        _3411 = (1.0f.xxx * _917) * (-float3(_3779.x ? _1539.x : _3781.x, _3779.y ? _1539.y : _3781.y, _3779.z ? _1539.z : _3781.z));
                        break;
                    }
                    case 8u:
                    {
                        float3 _1141 = _321.xyz;
                        float3 _1142 = _1141 * _1141;
                        float _1143 = clamp(_563, 0.0f, 1.0f);
                        float _1144 = dot(_333, _936);
                        float _1145 = dot(_333, _531);
                        float _1146 = dot(_531, _936);
                        float _1148 = rsqrt(mad(2.0f, _1146, 2.0f));
                        bool _1154 = _942 > 0.0f;
                        float _1233 = 0.0f;
                        float _1234 = 0.0f;
                        if (_1154)
                        {
                            float _1159 = sqrt(mad(-_942, _942, 1.0f));
                            float _1160 = 2.0f * _1144;
                            float _1161 = -_1146;
                            float _1162 = mad(_1160, _1145, _1161);
                            float _1231 = 0.0f;
                            float _1232 = 0.0f;
                            if (_1162 >= _1159)
                            {
                                _1231 = 1.0f;
                                _1232 = abs(_1145);
                            }
                            else
                            {
                                float _1167 = -_1162;
                                float _1170 = _942 * rsqrt(mad(_1167, _1162, 1.0f));
                                float _1171 = mad(_1167, _1144, _1145);
                                float _1175 = mad(_1167, _1146, mad(2.0f * _1145, _1145, -1.0f));
                                float _1186 = _1170 * sqrt(clamp(mad(_1160 * _1145, _1146, mad(_1161, _1146, mad(-_1145, _1145, mad(-_1144, _1144, 1.0f)))), 0.0f, 1.0f));
                                float _1188 = (_1186 * 2.0f) * _1145;
                                float _1189 = mad(_1144, _1159, _1145);
                                float _1190 = mad(_1170, _1171, _1189);
                                float _1192 = mad(_1170, _1175, mad(_1146, _1159, 1.0f));
                                float _1193 = _1186 * _1192;
                                float _1194 = _1190 * _1192;
                                float _1199 = _1194 * mad(-0.5f, _1193, (0.25f * _1188) * _1190);
                                float _1209 = mad(_1190, mad(_1189, _1192 * _1192, _1194 * mad(-0.5f, mad(_1146, _1159, _1192), -0.5f)), mad(_1193, _1193, (_1188 * _1190) * mad(_1188, _1190, _1193 * (-2.0f))));
                                float _1213 = (2.0f * _1199) / mad(_1209, _1209, _1199 * _1199);
                                float _1214 = _1213 * _1209;
                                float _1216 = mad(-_1213, _1199, 1.0f);
                                float _1222 = mad(_1146, _1159, mad(_1216, _1170 * _1175, _1214 * _1188));
                                float _1224 = rsqrt(mad(2.0f, _1222, 2.0f));
                                _1231 = clamp((mad(_1144, _1159, mad(_1216, _1170 * _1171, _1214 * _1186)) + _1145) * _1224, 0.0f, 1.0f);
                                _1232 = clamp(mad(_1224, _1222, _1224), 0.0f, 1.0f);
                            }
                            _1233 = _1231;
                            _1234 = _1232;
                        }
                        else
                        {
                            _1233 = clamp((_1144 + _1145) * _1148, 0.0f, 1.0f);
                            _1234 = clamp(mad(_1148, _1146, _1148), 0.0f, 1.0f);
                        }
                        float _1237 = clamp(abs(_1145) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _1322 = 0.0f.xxx;
                        if ((_951 & 1u) == 1u)
                        {
                            _1322 = 0.0f.xxx;
                        }
                        else
                        {
                            float _1245 = _869 * _869;
                            float _1255 = 0.0f;
                            if (_944 > 0.0f)
                            {
                                _1255 = clamp(mad(_1245, _1245, (_944 * _944) / mad(_1234, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1255 = _1245 * _1245;
                            }
                            float _1269 = 0.0f;
                            float _1270 = 0.0f;
                            if (_1154)
                            {
                                float _1267 = _1255 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_1255) >> 1)), _942)) / (_1234 + 0.001000000047497451305389404296875f));
                                _1269 = _1255 / _1267;
                                _1270 = _1267;
                            }
                            else
                            {
                                _1269 = 1.0f;
                                _1270 = _1255;
                            }
                            float _1291 = 0.0f;
                            if (_895 < 1.0f)
                            {
                                float _1277 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                _1291 = _1269 * sqrt(_1270 / (_1270 + (((0.25f * _1277) * mad(3.0f, asfloat(532487669 + (asint(_1270) >> 1)), _1277)) / (_1234 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1291 = _1269;
                            }
                            float _1294 = mad(mad(_1233, _1255, -_1233), _1233, 1.0f);
                            float _1299 = sqrt(_1255);
                            float _1300 = 1.0f - _1299;
                            float _1306 = 1.0f - _1234;
                            float _1307 = _1306 * _1306;
                            float _1308 = _1307 * _1307;
                            _1322 = (1.0f.xxx * (_917 * _916)) * (((clamp(50.0f * _380.y, 0.0f, 1.0f) * (_1308 * _1306)).xxx + (_380 * mad(-_1308, _1306, 1.0f))) * (((_1255 / ((3.1415927410125732421875f * _1294) * _1294)) * _1291) * (0.5f / mad(_916, mad(_1237, _1300, _1299), _1237 * mad(_916, _1300, _1299)))));
                        }
                        float _1323 = _869 * _869;
                        float _1324 = _1323 * _1323;
                        float _1327 = mad(mad(-_1324, _1233, _1233), _1233, _1324);
                        float _1340 = 1.0f - _1234;
                        float _1341 = _1340 * _1340;
                        float _1342 = _1341 * _1341;
                        float3 _1354 = 1.0f.xxx * (_917 * _916);
                        _3409 = (_1354 * (_373 * 0.3183098733425140380859375f)) * lerp(1.0f, 1.0f, _1143);
                        _3410 = lerp(_1322, ((_1354 * (((0.3183098733425140380859375f / mad(4.0f, _1324, 1.0f)) * (1.0f + (((4.0f * _1324) * _1324) / (_1327 * _1327)))) * (0.25f / mad(-_916, _1237, _916 + _1237)))) * ((clamp(50.0f * _1142.y, 0.0f, 1.0f) * (_1342 * _1340)).xxx + (_1142 * mad(-_1342, _1340, 1.0f)))) * 1.0f, _1143.xxx);
                        _3411 = 0.0f.xxx;
                        break;
                    }
                    case 9u:
                    {
                        float2 _967 = (_321.yz * 2.0f) - 1.0f.xx;
                        float _969 = dot(1.0f.xx, abs(_967));
                        float3 _973 = float3(_967, 1.0f - _969);
                        float _974 = _969 - 1.0f;
                        float _975 = isnan(0.0f) ? _974 : (isnan(_974) ? 0.0f : max(_974, 0.0f));
                        float2 _976 = _973.xy;
                        bool2 _977 = bool2(_976.x >= 0.0f.xx.x, _976.y >= 0.0f.xx.y);
                        float _978 = -_975;
                        float2 _984 = _976 + float2(_977.x ? _978 : _975, _977.y ? _978 : _975);
                        float3 _986 = normalize(float3(_984.x, _984.y, _973.z));
                        float _987 = 1.0f - _563;
                        float _993 = dot(_333, _936);
                        float _994 = dot(_333, _531);
                        float _995 = dot(_531, _936);
                        float _997 = rsqrt(mad(2.0f, _995, 2.0f));
                        bool _1003 = _942 > 0.0f;
                        float _1038 = 0.0f;
                        float _1039 = 0.0f;
                        if (_1003)
                        {
                            float _1008 = sqrt(mad(-_942, _942, 1.0f));
                            float _1011 = mad(2.0f * _993, _994, -_995);
                            float _1036 = 0.0f;
                            float _1037 = 0.0f;
                            if (_1011 >= _1008)
                            {
                                _1036 = 1.0f;
                                _1037 = abs(_994);
                            }
                            else
                            {
                                float _1016 = -_1011;
                                float _1019 = _942 * rsqrt(mad(_1016, _1011, 1.0f));
                                float _1027 = mad(_995, _1008, _1019 * mad(_1016, _995, mad(2.0f * _994, _994, -1.0f)));
                                float _1029 = rsqrt(mad(2.0f, _1027, 2.0f));
                                _1036 = clamp((mad(_993, _1008, _1019 * mad(_1016, _993, _994)) + _994) * _1029, 0.0f, 1.0f);
                                _1037 = clamp(mad(_1029, _1027, _1029), 0.0f, 1.0f);
                            }
                            _1038 = _1036;
                            _1039 = _1037;
                        }
                        else
                        {
                            _1038 = clamp((_993 + _994) * _997, 0.0f, 1.0f);
                            _1039 = clamp(mad(_997, _995, _997), 0.0f, 1.0f);
                        }
                        float _1042 = clamp(abs(_994) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        bool _1044 = (_951 & 1u) == 1u;
                        float _1045 = _1044 ? _1042 : _1039;
                        float _1047 = 1.0f - _1045;
                        float _1048 = _1047 * _1047;
                        float _1049 = _1048 * _1048;
                        float _1053 = mad(_1049, _1047, mad(-_1049, _1047, 1.0f) * (_365 * 0.07999999821186065673828125f));
                        float3 _1123 = 0.0f.xxx;
                        if (_1044)
                        {
                            _1123 = 0.0f.xxx;
                        }
                        else
                        {
                            float _1057 = _869 * _869;
                            float _1067 = 0.0f;
                            if (_944 > 0.0f)
                            {
                                _1067 = clamp(mad(_1057, _1057, (_944 * _944) / mad(_1045, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1067 = _1057 * _1057;
                            }
                            float _1081 = 0.0f;
                            float _1082 = 0.0f;
                            if (_1003)
                            {
                                float _1079 = _1067 + (((0.25f * _942) * mad(3.0f, asfloat(532487669 + (asint(_1067) >> 1)), _942)) / (_1045 + 0.001000000047497451305389404296875f));
                                _1081 = _1067 / _1079;
                                _1082 = _1079;
                            }
                            else
                            {
                                _1081 = 1.0f;
                                _1082 = _1067;
                            }
                            float _1103 = 0.0f;
                            if (_895 < 1.0f)
                            {
                                float _1089 = sqrt((1.00010001659393310546875f - _895) / (1.0f + _895));
                                _1103 = _1081 * sqrt(_1082 / (_1082 + (((0.25f * _1089) * mad(3.0f, asfloat(532487669 + (asint(_1082) >> 1)), _1089)) / (_1045 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1103 = _1081;
                            }
                            float _1104 = sqrt(_1067);
                            float _1105 = 1.0f - _1104;
                            float _1113 = mad(mad(_1038, _1067, -_1038), _1038, 1.0f);
                            _1123 = (((1.0f.xxx * (_917 * _916)) * ((_1067 / ((3.1415927410125732421875f * _1113) * _1113)) * _1103)) * (0.5f / mad(_916, mad(_1042, _1105, _1104), _1042 * mad(_916, _1105, _1104)))) * _1053;
                        }
                        float _1125 = clamp(dot(_986, _936), 0.0f, 1.0f);
                        float _1126 = lerp(12.0f, 1.0f, _1125);
                        _3409 = 0.0f.xxx;
                        _3410 = _1123;
                        _3411 = (1.0f.xxx * ((_917 * lerp(_916, _1125 * mad(0.20000000298023223876953125f * (_1126 + 1.0f), pow(clamp(dot(normalize(lerp(_986, -_333, (_987 * _266).xxx)), _936), 0.0f, 1.0f), _1126), 0.800000011920928955078125f), _987)) * (1.0f - _1053))) * (_373 * 0.3183098733425140380859375f);
                        break;
                    }
                    default:
                    {
                        _3409 = 0.0f.xxx;
                        _3410 = 0.0f.xxx;
                        _3411 = 0.0f.xxx;
                        break;
                    }
                }
                float3 _3413 = _559 * _858;
                float _3424 = 0.0f;
                if (_340)
                {
                    float _3423 = 0.0f;
                    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                    {
                        _3423 = dot(_3409 * _3413, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    }
                    else
                    {
                        _3423 = 0.0f;
                    }
                    _3424 = _3423;
                }
                else
                {
                    _3424 = 0.0f;
                }
                float3 _3426 = _559 * _857;
                float _3438 = 0.0f;
                if (_340)
                {
                    float _3437 = 0.0f;
                    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                    {
                        _3437 = _3424 + dot(_3411 * _3426, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    }
                    else
                    {
                        _3437 = _3424;
                    }
                    _3438 = _3437;
                }
                else
                {
                    _3438 = _3424;
                }
                _3441 = _3438;
                _3442 = mad(_3409, _3413, _3411 * _3426);
                _3443 = (_3410 * DeferredLightUniforms_DeferredLightUniforms_SpecularScale) * _3413;
            }
            else
            {
                _3441 = 0.0f;
                _3442 = 0.0f.xxx;
                _3443 = 0.0f.xxx;
            }
            _3444 = _3441;
            _3445 = _3442;
            _3446 = _3443;
        }
        else
        {
            _3444 = 0.0f;
            _3445 = 0.0f.xxx;
            _3446 = 0.0f.xxx;
        }
        float4 _3450 = float4(_3445, 0.0f);
        float4 _3461 = 0.0f.xxxx;
        if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
        {
            float4 _3460 = _3450;
            _3460.w = _3444;
            _3461 = _3460;
        }
        else
        {
            _3461 = _3450;
        }
        _3463 = float4(_3446, 0.0f) + _3461;
    }
    else
    {
        _3463 = 0.0f.xxxx;
    }
    out_var_SV_Target0 = _3463 * View_View_PreExposure;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}

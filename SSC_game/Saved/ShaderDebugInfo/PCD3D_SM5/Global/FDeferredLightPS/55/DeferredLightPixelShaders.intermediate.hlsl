#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float4 _184 = 0.0f.xxxx;
static float _185 = 0.0f;

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
    float4 View_View_SSProfilesTextureSizeAndInvSize : packoffset(c248);
    float View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : packoffset(c284.w);
};

cbuffer DeferredLightUniforms
{
    float4 DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask : packoffset(c0);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength : packoffset(c1.z);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : packoffset(c1.w);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity : packoffset(c2);
    uint DeferredLightUniforms_DeferredLightUniforms_ShadowedBits : packoffset(c2.z);
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
SamplerState View_SSProfilesTransmissionSampler;
Texture2DArray<float4> View_IESAtlasTexture;
SamplerState View_IESAtlasSampler;
Texture2D<float4> SceneTexturesStruct_SceneDepthTexture;
Texture2D<float4> SceneTexturesStruct_GBufferATexture;
Texture2D<float4> SceneTexturesStruct_GBufferBTexture;
Texture2D<float4> SceneTexturesStruct_GBufferCTexture;
Texture2D<float4> SceneTexturesStruct_GBufferDTexture;
Texture2D<float4> SceneTexturesStruct_GBufferETexture;
Texture2D<float4> SceneTexturesStruct_ScreenSpaceAOTexture;
SamplerState SceneTexturesStruct_PointClampSampler;
Texture2D<float4> LightAttenuationTexture;
SamplerState LightAttenuationTextureSampler;

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
    float2 _200 = in_var_TEXCOORD0.xy / in_var_TEXCOORD0.w.xx;
    float2 _205 = mad(_200, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz);
    float4 _209 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
    float _210 = _209.x;
    float _220 = -View_View_InvDeviceZToWorldZTransform.w;
    float4 _226 = SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
    float4 _229 = SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
    float4 _232 = SceneTexturesStruct_GBufferCTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
    float4 _235 = SceneTexturesStruct_GBufferDTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
    float4 _238 = SceneTexturesStruct_GBufferETexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
    uint2 _243 = uint2(_205 * View_View_BufferSizeAndInvSize.xy);
    bool _252 = (((_243.x + _243.y) + uint(View_View_TemporalAAParams.x)) % 2u) != 0u;
    float3 _254 = 0.0f.xxx;
    _254.x = _226.x;
    _254.y = _226.y;
    _254.z = _226.z;
    float _259 = _229.x;
    float _260 = _229.y;
    float _261 = _229.z;
    uint _264 = uint(mad(_229.w, 255.0f, 0.5f));
    uint _267 = ((_264 >> 0u) & 15u) << 0u;
    uint _270 = ((_264 >> 4u) & 15u) << 0u;
    float3 _272 = 0.0f.xxx;
    _272.x = _232.x;
    _272.y = _232.y;
    _272.z = _232.z;
    float4 _278 = 0.0f.xxxx;
    _278.x = _238.x;
    _278.y = _238.y;
    _278.z = _238.z;
    _278.w = _238.w;
    float4 _286 = 0.0f.xxxx;
    _286.x = _235.x;
    _286.y = _235.y;
    _286.z = _235.z;
    _286.w = _235.w;
    int _295 = int(_267);
    bool _298 = (_295 == 2) || (_295 == 3);
    bool _301 = _295 == 5;
    bool _303 = _295 == 6;
    bool _305 = _295 == 7;
    bool _309 = _295 == 9;
    bool4 _311 = ((((((_298 || (_295 == 4)) || _301) || _303) || _305) || (_295 == 8)) || _309).xxxx;
    float4 _312 = float4(_311.x ? _286.x : 0.0f.xxxx.x, _311.y ? _286.y : 0.0f.xxxx.y, _311.z ? _286.z : 0.0f.xxxx.z, _311.w ? _286.w : 0.0f.xxxx.w);
    bool4 _316 = (!((_270 & 2u) != 0u)).xxxx;
    float4 _320 = (((_270 & 4u) != 0u) ? 0.0f : 1.0f).xxxx;
    float3 _322 = normalize((_254 * 2.0f) - 1.0f.xxx);
    bool _323 = _267 == 9u;
    float _324 = _323 ? 0.0f : _259;
    float3 _327 = _324.xxx;
    float3 _328 = lerp((0.07999999821186065673828125f * _260).xxx, _272, _327);
    bool _329 = _301 || _309;
    float3 _353 = 0.0f.xxx;
    float _354 = 0.0f;
    float3 _355 = 0.0f.xxx;
    if (_329)
    {
        bool3 _340 = (View_View_bSubsurfacePostprocessEnabled != 0.0f).xxx;
        float3 _350 = 0.0f.xxx;
        float _351 = 0.0f;
        float3 _352 = 0.0f.xxx;
        if ((View_View_bSubsurfacePostprocessEnabled > 0.0f) && (View_View_bCheckerboardSubsurfaceProfileRendering > 0.0f))
        {
            float _347 = float(!_252);
            _350 = float(_252).xxx;
            _351 = _260 * _347;
            _352 = _328 * _347;
        }
        else
        {
            _350 = float3(_340.x ? 1.0f.xxx.x : _272.x, _340.y ? 1.0f.xxx.y : _272.y, _340.z ? 1.0f.xxx.z : _272.z);
            _351 = _260;
            _352 = _328;
        }
        _353 = _350;
        _354 = _351;
        _355 = _352;
    }
    else
    {
        _353 = _272;
        _354 = _260;
        _355 = _328;
    }
    float3 _362 = mad(_353 - (_353 * _324), View_View_DiffuseOverrideParameter.www, View_View_DiffuseOverrideParameter.xyz);
    float3 _369 = (_355 * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    float4 _3048 = 0.0f.xxxx;
    [branch]
    if (_267 > 0u)
    {
        float4 _378 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f);
        float _379 = _378.x;
        float _383 = mad(_379, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_379, View_View_InvDeviceZToWorldZTransform.z, _220));
        float4 _395 = mul(float4(_200 * ((View_View_ViewToClip[3u].w < 1.0f) ? _383 : 1.0f), _383, 1.0f), View_View_ScreenToTranslatedWorld);
        float3 _396 = _395.xyz;
        float3 _400 = normalize(_396 - View_View_TranslatedWorldCameraOrigin);
        float _425 = abs(DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength);
        bool _436 = true && (DeferredLightUniforms_DeferredLightUniforms_FalloffExponent == 0.0f);
        float3 _437 = -DeferredLightUniforms_DeferredLightUniforms_Direction;
        float _481 = 0.0f;
        if (DeferredLightUniforms_DeferredLightUniforms_IESAtlasIndex >= 0.0f)
        {
            float3 _460 = normalize(DeferredLightUniforms_DeferredLightUniforms_TranslatedWorldPosition - _396);
            float4 _465 = mul(float4(_460, 0.0f), transpose(float4x4(float4(_437, 0.0f), float4(normalize(cross(DeferredLightUniforms_DeferredLightUniforms_Tangent, _437)), 0.0f), float4(DeferredLightUniforms_DeferredLightUniforms_Tangent, 0.0f), float4(0.0f, 0.0f, 0.0f, 1.0f))));
            _481 = View_IESAtlasTexture.SampleLevel(View_IESAtlasSampler, float3(mad(asin(dot(_460, _437)), 0.3183098733425140380859375f, 0.5f), mad(atan2(-_465.z, -_465.y), 0.15915493667125701904296875f, 0.5f), DeferredLightUniforms_DeferredLightUniforms_IESAtlasIndex), 0.0f).x;
        }
        else
        {
            _481 = 1.0f;
        }
        float4 _496 = LightAttenuationTexture.SampleLevel(LightAttenuationTextureSampler, _205, 0.0f);
        float4 _497 = _496 * _496;
        float3 _498 = -_400;
        float3 _499 = DeferredLightUniforms_DeferredLightUniforms_TranslatedWorldPosition - _396;
        float _500 = dot(_499, _499);
        float3 _502 = _499 * rsqrt(_500);
        float _517 = 0.0f;
        if (_436)
        {
            float _512 = _500 * (DeferredLightUniforms_DeferredLightUniforms_InvRadius * DeferredLightUniforms_DeferredLightUniforms_InvRadius);
            float _515 = clamp(mad(-_512, _512, 1.0f), 0.0f, 1.0f);
            _517 = _515 * _515;
        }
        else
        {
            float3 _506 = _499 * DeferredLightUniforms_DeferredLightUniforms_InvRadius;
            _517 = pow(1.0f - clamp(dot(_506, _506), 0.0f, 1.0f), DeferredLightUniforms_DeferredLightUniforms_FalloffExponent);
        }
        float _523 = clamp((dot(_502, DeferredLightUniforms_DeferredLightUniforms_Direction) - DeferredLightUniforms_DeferredLightUniforms_SpotAngles.x) * DeferredLightUniforms_DeferredLightUniforms_SpotAngles.y, 0.0f, 1.0f);
        float _525 = _517 * (_523 * _523);
        float3 _526 = (DeferredLightUniforms_DeferredLightUniforms_Color * (1.0f.xxx * _481)) * _525;
        float _3029 = 0.0f;
        float3 _3030 = 0.0f.xxx;
        float3 _3031 = 0.0f.xxx;
        [branch]
        if (_525 > 0.0f)
        {
            float _530 = _312.w;
            float _533 = View_View_ClipToView[1u].y * (mad(_210, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_210, View_View_InvDeviceZToWorldZTransform.z, _220)));
            float _552 = 0.0f;
            float _553 = 0.0f;
            float _554 = 0.0f;
            float _555 = 0.0f;
            [branch]
            if (DeferredLightUniforms_DeferredLightUniforms_ShadowedBits != 0u)
            {
                float _539 = lerp(1.0f, dot(float4(_316.x ? _278.x : _320.x, _316.y ? _278.y : _320.y, _316.z ? _278.z : _320.z, _316.w ? _278.w : _320.w), DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask), dot(DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask, 1.0f.xxxx));
                float _542 = _497.w;
                float _551 = 0.0f;
                [flatten]
                if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits > 1u) && (_425 > 0.0f))
                {
                    _551 = _425 * ((DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength < 0.0f) ? 1.0f : _533);
                }
                else
                {
                    _551 = 0.0f;
                }
                _552 = _542;
                _553 = _542 * _539;
                _554 = _497.z * _539;
                _555 = _551;
            }
            else
            {
                _552 = 1.0f;
                _553 = 1.0f;
                _554 = SceneTexturesStruct_ScreenSpaceAOTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _205, 0.0f).x;
                _555 = 0.0f;
            }
            float _562 = 0.0f;
            if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits < 2u) && (_267 == 7u))
            {
                _562 = 0.20000000298023223876953125f * _533;
            }
            else
            {
                _562 = _555;
            }
            float _563 = _323 ? 0.5f : _562;
            float _824 = 0.0f;
            float _825 = 0.0f;
            [branch]
            if (_563 > 0.0f)
            {
                float4 _574 = mul(float4(_395.xyz, 1.0f), View_View_TranslatedWorldToClip);
                float4 _581 = _574 + mul(float4(_502 * _563, 0.0f), View_View_TranslatedWorldToClip);
                float3 _585 = _574.xyz / _574.w.xxx;
                float3 _590 = (_581.xyz / _581.w.xxx) - _585;
                float _593 = _585.z;
                float3 _596 = float3(mad(_585.xy, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz), _593);
                float3 _602 = float3(_590.xy * View_View_ScreenPositionScaleBias.xy, _590.z);
                float4 _606 = _574 + mul(float4(0.0f, 0.0f, _563, 0.0f), View_View_ViewToClip);
                float _613 = abs((_606.xyz / _606.w.xxx).z - _593);
                float _614 = _613 * 0.25f;
                float _615 = mad(frac(52.98291778564453125f * frac(dot(gl_FragCoord.xy + (float2(32.66500091552734375f, 11.81499958038330078125f) * float(View_View_StateFrameIndexMod8)), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f)))) - 0.5f, 0.125f, 0.125f);
                float4 _618 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _596.xy, 0.0f);
                float _619 = _618.x;
                float3 _621 = _596 + (_602 * _615);
                float4 _624 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _621.xy, 0.0f);
                float _625 = _624.x;
                float _634 = (((abs(mad(_613, 0.25f, _621.z - _625)) < _614) && (_625 != _619)) && true) ? _615 : (-1.0f);
                float _635 = _615 + 0.125f;
                float3 _637 = _596 + (_602 * _635);
                float4 _640 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _637.xy, 0.0f);
                float _641 = _640.x;
                float _651 = (((abs(mad(_613, 0.25f, _637.z - _641)) < _614) && (_641 != _619)) && (_634 < 0.0f)) ? _635 : _634;
                float _652 = _615 + 0.25f;
                float3 _654 = _596 + (_602 * _652);
                float4 _657 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _654.xy, 0.0f);
                float _658 = _657.x;
                float _668 = (((abs(mad(_613, 0.25f, _654.z - _658)) < _614) && (_658 != _619)) && (_651 < 0.0f)) ? _652 : _651;
                float _669 = _615 + 0.375f;
                float3 _671 = _596 + (_602 * _669);
                float4 _674 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _671.xy, 0.0f);
                float _675 = _674.x;
                float _685 = (((abs(mad(_613, 0.25f, _671.z - _675)) < _614) && (_675 != _619)) && (_668 < 0.0f)) ? _669 : _668;
                float _686 = _615 + 0.5f;
                float3 _688 = _596 + (_602 * _686);
                float4 _691 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _688.xy, 0.0f);
                float _692 = _691.x;
                float _702 = (((abs(mad(_613, 0.25f, _688.z - _692)) < _614) && (_692 != _619)) && (_685 < 0.0f)) ? _686 : _685;
                float _703 = _615 + 0.625f;
                float3 _705 = _596 + (_602 * _703);
                float4 _708 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _705.xy, 0.0f);
                float _709 = _708.x;
                float _719 = (((abs(mad(_613, 0.25f, _705.z - _709)) < _614) && (_709 != _619)) && (_702 < 0.0f)) ? _703 : _702;
                float _720 = _615 + 0.75f;
                float3 _722 = _596 + (_602 * _720);
                float4 _725 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _722.xy, 0.0f);
                float _726 = _725.x;
                float _736 = (((abs(mad(_613, 0.25f, _722.z - _726)) < _614) && (_726 != _619)) && (_719 < 0.0f)) ? _720 : _719;
                float _737 = _615 + 0.875f;
                float3 _739 = _596 + (_602 * _737);
                float4 _742 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _739.xy, 0.0f);
                float _743 = _742.x;
                float _753 = (((abs(mad(_613, 0.25f, _739.z - _743)) < _614) && (_743 != _619)) && (_736 < 0.0f)) ? _737 : _736;
                bool _789 = false;
                float _790 = 0.0f;
                if (_753 > 0.0f)
                {
                    float2 _759 = (_596 + (_602 * _753)).xy;
                    bool2 _777 = bool2(0.0f.xx.x < _759.x, 0.0f.xx.y < _759.y);
                    bool2 _778 = bool2(_759.x < 1.0f.xx.x, _759.y < 1.0f.xx.y);
                    _789 = ((uint(SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _759, 0.0f).w * 3.999000072479248046875f) & 1u) != 0u) && ((((uint(mad(SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _759, 0.0f).w, 255.0f, 0.5f)) >> 0u) & 15u) << 0u) != 9u);
                    _790 = all(bool2(_777.x && _778.x, _777.y && _778.y)) ? (_753 * _563) : (-1.0f);
                }
                else
                {
                    _789 = false;
                    _790 = -1.0f;
                }
                float _822 = 0.0f;
                float _823 = 0.0f;
                if (_790 > 0.0f)
                {
                    float _794 = _789 ? DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity;
                    float _818 = 0.0f;
                    [branch]
                    if (((((_794 > 0.0f) && ((((_298 || _301) || _303) || _305) || _309)) && (_267 != 7u)) && (_267 != 9u)) && (_267 != 5u))
                    {
                        _818 = _794 * (1.0f - clamp(exp((log(1.0f - (isnan(0.9900000095367431640625f) ? _530 : (isnan(_530) ? 0.9900000095367431640625f : min(_530, 0.9900000095367431640625f)))) * 0.0500000007450580596923828125f) * _790), 0.0f, 1.0f));
                    }
                    else
                    {
                        _818 = _794;
                    }
                    float _819 = 1.0f - _818;
                    _822 = _553 * _819;
                    _823 = _554 * _819;
                }
                else
                {
                    _822 = _553;
                    _823 = _554;
                }
                _824 = _822;
                _825 = _823;
            }
            else
            {
                _824 = _553;
                _825 = _554;
            }
            float _3026 = 0.0f;
            float3 _3027 = 0.0f.xxx;
            float3 _3028 = 0.0f.xxx;
            [branch]
            if ((_825 + _824) > 0.0f)
            {
                float3 _831 = DeferredLightUniforms_DeferredLightUniforms_Tangent * (0.5f * DeferredLightUniforms_DeferredLightUniforms_SourceLength);
                float3 _832 = _499 - _831;
                float3 _833 = _499 + _831;
                float _836 = isnan(View_View_MinRoughness) ? _261 : (isnan(_261) ? View_View_MinRoughness : max(_261, View_View_MinRoughness));
                bool _837 = DeferredLightUniforms_DeferredLightUniforms_SourceLength > 0.0f;
                float _862 = 0.0f;
                float _863 = 0.0f;
                float _864 = 0.0f;
                [branch]
                if (_837)
                {
                    float _849 = rsqrt(dot(_832, _832));
                    float _850 = rsqrt(dot(_833, _833));
                    float _851 = _849 * _850;
                    float _853 = dot(_832, _833) * _851;
                    _862 = _853;
                    _863 = 0.5f * mad(dot(_322, _832), _849, dot(_322, _833) * _850);
                    _864 = _851 / mad(_849, _850, mad(_853, 0.5f, 0.5f));
                }
                else
                {
                    float _841 = dot(_832, _832);
                    _862 = 1.0f;
                    _863 = dot(_322, _832 * rsqrt(_841));
                    _864 = 1.0f / (_841 + 1.0f);
                }
                float _882 = 0.0f;
                if (DeferredLightUniforms_DeferredLightUniforms_SourceRadius > 0.0f)
                {
                    float _871 = sqrt(clamp((DeferredLightUniforms_DeferredLightUniforms_SourceRadius * DeferredLightUniforms_DeferredLightUniforms_SourceRadius) * _864, 0.0f, 1.0f));
                    float _881 = 0.0f;
                    if (_863 < _871)
                    {
                        float _875 = -_871;
                        float _877 = _871 + (isnan(_875) ? _863 : (isnan(_863) ? _875 : max(_863, _875)));
                        _881 = (_877 * _877) / (4.0f * _871);
                    }
                    else
                    {
                        _881 = _863;
                    }
                    _882 = _881;
                }
                else
                {
                    _882 = _863;
                }
                float _883 = clamp(_882, 0.0f, 1.0f);
                float _884 = _436 ? _864 : 1.0f;
                float3 _900 = 0.0f.xxx;
                if (_837)
                {
                    float3 _887 = reflect(_400, _322);
                    float3 _888 = _833 - _832;
                    float _889 = dot(_887, _888);
                    _900 = _832 + (_888 * clamp(dot(_832, (_887 * _889) - _888) / mad(DeferredLightUniforms_DeferredLightUniforms_SourceLength, DeferredLightUniforms_DeferredLightUniforms_SourceLength, -(_889 * _889)), 0.0f, 1.0f));
                }
                else
                {
                    _900 = _832;
                }
                float _902 = rsqrt(dot(_900, _900));
                float3 _903 = _900 * _902;
                float _904 = isnan(View_View_MinRoughness) ? _836 : (isnan(_836) ? View_View_MinRoughness : max(_836, View_View_MinRoughness));
                float _909 = clamp((DeferredLightUniforms_DeferredLightUniforms_SourceRadius * _902) * mad(-_904, _904, 1.0f), 0.0f, 1.0f);
                float _911 = clamp(DeferredLightUniforms_DeferredLightUniforms_SoftSourceRadius * _902, 0.0f, 1.0f);
                uint _918 = 0u | (asuint(clamp(mad(-(isnan(DeferredLightUniforms_DeferredLightUniforms_SourceRadius) ? DeferredLightUniforms_DeferredLightUniforms_SourceLength : (isnan(DeferredLightUniforms_DeferredLightUniforms_SourceLength) ? DeferredLightUniforms_DeferredLightUniforms_SourceRadius : max(DeferredLightUniforms_DeferredLightUniforms_SourceLength, DeferredLightUniforms_DeferredLightUniforms_SourceRadius))), 0.0500000007450580596923828125f, 1.0f), 0.0f, 1.0f)) << 1u);
                float3 _2994 = 0.0f.xxx;
                float3 _2995 = 0.0f.xxx;
                float3 _2996 = 0.0f.xxx;
                switch (_267)
                {
                    case 1u:
                    {
                        float _2812 = dot(_322, _903);
                        float _2813 = dot(_322, _498);
                        float _2814 = dot(_498, _903);
                        float _2815 = mad(2.0f, _2814, 2.0f);
                        float _2816 = rsqrt(_2815);
                        float _2817 = _2812 + _2813;
                        float _2818 = _2817 * _2816;
                        float _2819 = clamp(_2818, 0.0f, 1.0f);
                        float _2820 = mad(_2816, _2814, _2816);
                        float _2821 = clamp(_2820, 0.0f, 1.0f);
                        bool _2822 = _909 > 0.0f;
                        float _2901 = 0.0f;
                        float _2902 = 0.0f;
                        if (_2822)
                        {
                            float _2825 = -_909;
                            float _2826 = mad(_2825, _909, 1.0f);
                            float _2827 = sqrt(_2826);
                            float _2828 = 2.0f * _2812;
                            float _2829 = -_2814;
                            float _2830 = mad(_2828, _2813, _2829);
                            bool _2831 = _2830 >= _2827;
                            float _2899 = 0.0f;
                            float _2900 = 0.0f;
                            if (_2831)
                            {
                                float _2898 = abs(_2813);
                                _2899 = 1.0f;
                                _2900 = _2898;
                            }
                            else
                            {
                                float _2835 = -_2830;
                                float _2836 = mad(_2835, _2830, 1.0f);
                                float _2837 = rsqrt(_2836);
                                float _2838 = _909 * _2837;
                                float _2839 = mad(_2835, _2812, _2813);
                                float _2840 = _2838 * _2839;
                                float _2841 = 2.0f * _2813;
                                float _2842 = mad(_2841, _2813, -1.0f);
                                float _2843 = mad(_2835, _2814, _2842);
                                float _2844 = _2838 * _2843;
                                float _2845 = -_2812;
                                float _2846 = mad(_2845, _2812, 1.0f);
                                float _2847 = -_2813;
                                float _2848 = mad(_2847, _2813, _2846);
                                float _2849 = mad(_2829, _2814, _2848);
                                float _2850 = _2828 * _2813;
                                float _2851 = mad(_2850, _2814, _2849);
                                float _2852 = clamp(_2851, 0.0f, 1.0f);
                                float _2853 = sqrt(_2852);
                                float _2854 = _2838 * _2853;
                                float _2855 = _2854 * 2.0f;
                                float _2856 = _2855 * _2813;
                                float _2857 = mad(_2812, _2827, _2813);
                                float _2858 = mad(_2838, _2839, _2857);
                                float _2859 = mad(_2814, _2827, 1.0f);
                                float _2860 = mad(_2838, _2843, _2859);
                                float _2861 = _2854 * _2860;
                                float _2862 = _2858 * _2860;
                                float _2863 = _2856 * _2858;
                                float _2864 = 0.25f * _2856;
                                float _2865 = _2864 * _2858;
                                float _2866 = mad(-0.5f, _2861, _2865);
                                float _2867 = _2862 * _2866;
                                float _2868 = _2861 * (-2.0f);
                                float _2869 = mad(_2856, _2858, _2868);
                                float _2870 = _2863 * _2869;
                                float _2871 = mad(_2861, _2861, _2870);
                                float _2872 = _2860 * _2860;
                                float _2873 = mad(_2814, _2827, _2860);
                                float _2874 = mad(-0.5f, _2873, -0.5f);
                                float _2875 = _2862 * _2874;
                                float _2876 = mad(_2857, _2872, _2875);
                                float _2877 = mad(_2858, _2876, _2871);
                                float _2878 = 2.0f * _2867;
                                float _2879 = _2867 * _2867;
                                float _2880 = mad(_2877, _2877, _2879);
                                float _2881 = _2878 / _2880;
                                float _2882 = _2881 * _2877;
                                float _2883 = -_2881;
                                float _2884 = mad(_2883, _2867, 1.0f);
                                float _2885 = _2882 * _2854;
                                float _2886 = mad(_2884, _2840, _2885);
                                float _2887 = _2882 * _2856;
                                float _2888 = mad(_2884, _2844, _2887);
                                float _2889 = mad(_2812, _2827, _2886);
                                float _2890 = mad(_2814, _2827, _2888);
                                float _2891 = mad(2.0f, _2890, 2.0f);
                                float _2892 = rsqrt(_2891);
                                float _2893 = _2889 + _2813;
                                float _2894 = _2893 * _2892;
                                float _2895 = clamp(_2894, 0.0f, 1.0f);
                                float _2896 = mad(_2892, _2890, _2892);
                                float _2897 = clamp(_2896, 0.0f, 1.0f);
                                _2899 = _2895;
                                _2900 = _2897;
                            }
                            _2901 = _2899;
                            _2902 = _2900;
                        }
                        else
                        {
                            _2901 = _2819;
                            _2902 = _2821;
                        }
                        float _2903 = abs(_2813);
                        float _2904 = _2903 + 9.9999997473787516355514526367188e-06f;
                        float _2905 = clamp(_2904, 0.0f, 1.0f);
                        float3 _2906 = _362 * 0.3183098733425140380859375f;
                        float _2907 = _884 * _883;
                        float3 _2908 = 1.0f.xxx * _2907;
                        float3 _2909 = _2906 * _2908;
                        uint _2910 = _918 & 1u;
                        bool _2911 = _2910 == 1u;
                        float3 _2992 = 0.0f.xxx;
                        if (_2911)
                        {
                            _2992 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2915 = _836 * _836;
                            float _2916 = _2915 * _2915;
                            bool _2917 = _911 > 0.0f;
                            float _2925 = 0.0f;
                            if (_2917)
                            {
                                float _2920 = _911 * _911;
                                float _2921 = mad(_2902, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                float _2922 = _2920 / _2921;
                                float _2923 = mad(_2915, _2915, _2922);
                                float _2924 = clamp(_2923, 0.0f, 1.0f);
                                _2925 = _2924;
                            }
                            else
                            {
                                _2925 = _2916;
                            }
                            float _2939 = 0.0f;
                            float _2940 = 0.0f;
                            if (_2822)
                            {
                                float _2928 = 0.25f * _909;
                                int _2929 = asint(_2925);
                                int _2930 = _2929 >> 1;
                                int _2931 = 532487669 + _2930;
                                float _2932 = asfloat(_2931);
                                float _2933 = mad(3.0f, _2932, _909);
                                float _2934 = _2928 * _2933;
                                float _2935 = _2902 + 0.001000000047497451305389404296875f;
                                float _2936 = _2934 / _2935;
                                float _2937 = _2925 + _2936;
                                float _2938 = _2925 / _2937;
                                _2939 = _2938;
                                _2940 = _2937;
                            }
                            else
                            {
                                _2939 = 1.0f;
                                _2940 = _2925;
                            }
                            bool _2941 = _862 < 1.0f;
                            float _2961 = 0.0f;
                            if (_2941)
                            {
                                float _2944 = 1.00010001659393310546875f - _862;
                                float _2945 = 1.0f + _862;
                                float _2946 = _2944 / _2945;
                                float _2947 = sqrt(_2946);
                                float _2948 = 0.25f * _2947;
                                int _2949 = asint(_2940);
                                int _2950 = _2949 >> 1;
                                int _2951 = 532487669 + _2950;
                                float _2952 = asfloat(_2951);
                                float _2953 = mad(3.0f, _2952, _2947);
                                float _2954 = _2948 * _2953;
                                float _2955 = _2902 + 0.001000000047497451305389404296875f;
                                float _2956 = _2954 / _2955;
                                float _2957 = _2940 + _2956;
                                float _2958 = _2940 / _2957;
                                float _2959 = sqrt(_2958);
                                float _2960 = _2939 * _2959;
                                _2961 = _2960;
                            }
                            else
                            {
                                _2961 = _2939;
                            }
                            float _2962 = -_2901;
                            float _2963 = mad(_2901, _2925, _2962);
                            float _2964 = mad(_2963, _2901, 1.0f);
                            float _2965 = 3.1415927410125732421875f * _2964;
                            float _2966 = _2965 * _2964;
                            float _2967 = _2925 / _2966;
                            float _2968 = _2967 * _2961;
                            float _2969 = sqrt(_2925);
                            float _2970 = 1.0f - _2969;
                            float _2971 = mad(_2905, _2970, _2969);
                            float _2972 = mad(_883, _2970, _2969);
                            float _2973 = _2905 * _2972;
                            float _2974 = mad(_883, _2971, _2973);
                            float _2975 = 0.5f / _2974;
                            float _2976 = 1.0f - _2902;
                            float _2977 = _2976 * _2976;
                            float _2978 = _2977 * _2977;
                            float _2979 = _2978 * _2976;
                            float _2980 = _369.y;
                            float _2981 = 50.0f * _2980;
                            float _2982 = clamp(_2981, 0.0f, 1.0f);
                            float _2983 = _2982 * _2979;
                            float3 _2984 = _2983.xxx;
                            float _2985 = -_2978;
                            float _2986 = mad(_2985, _2976, 1.0f);
                            float3 _2987 = _369 * _2986;
                            float3 _2988 = _2984 + _2987;
                            float _2989 = _2968 * _2975;
                            float3 _2990 = _2988 * _2989;
                            float3 _2991 = _2908 * _2990;
                            _2992 = _2991;
                        }
                        float3 _2993 = _2909 * 1.0f;
                        _2994 = _2993;
                        _2995 = _2992;
                        _2996 = 0.0f.xxx;
                        break;
                    }
                    case 10u:
                    {
                        float _2812 = dot(_322, _903);
                        float _2813 = dot(_322, _498);
                        float _2814 = dot(_498, _903);
                        float _2815 = mad(2.0f, _2814, 2.0f);
                        float _2816 = rsqrt(_2815);
                        float _2817 = _2812 + _2813;
                        float _2818 = _2817 * _2816;
                        float _2819 = clamp(_2818, 0.0f, 1.0f);
                        float _2820 = mad(_2816, _2814, _2816);
                        float _2821 = clamp(_2820, 0.0f, 1.0f);
                        bool _2822 = _909 > 0.0f;
                        float _2901 = 0.0f;
                        float _2902 = 0.0f;
                        if (_2822)
                        {
                            float _2825 = -_909;
                            float _2826 = mad(_2825, _909, 1.0f);
                            float _2827 = sqrt(_2826);
                            float _2828 = 2.0f * _2812;
                            float _2829 = -_2814;
                            float _2830 = mad(_2828, _2813, _2829);
                            bool _2831 = _2830 >= _2827;
                            float _2899 = 0.0f;
                            float _2900 = 0.0f;
                            if (_2831)
                            {
                                float _2898 = abs(_2813);
                                _2899 = 1.0f;
                                _2900 = _2898;
                            }
                            else
                            {
                                float _2835 = -_2830;
                                float _2836 = mad(_2835, _2830, 1.0f);
                                float _2837 = rsqrt(_2836);
                                float _2838 = _909 * _2837;
                                float _2839 = mad(_2835, _2812, _2813);
                                float _2840 = _2838 * _2839;
                                float _2841 = 2.0f * _2813;
                                float _2842 = mad(_2841, _2813, -1.0f);
                                float _2843 = mad(_2835, _2814, _2842);
                                float _2844 = _2838 * _2843;
                                float _2845 = -_2812;
                                float _2846 = mad(_2845, _2812, 1.0f);
                                float _2847 = -_2813;
                                float _2848 = mad(_2847, _2813, _2846);
                                float _2849 = mad(_2829, _2814, _2848);
                                float _2850 = _2828 * _2813;
                                float _2851 = mad(_2850, _2814, _2849);
                                float _2852 = clamp(_2851, 0.0f, 1.0f);
                                float _2853 = sqrt(_2852);
                                float _2854 = _2838 * _2853;
                                float _2855 = _2854 * 2.0f;
                                float _2856 = _2855 * _2813;
                                float _2857 = mad(_2812, _2827, _2813);
                                float _2858 = mad(_2838, _2839, _2857);
                                float _2859 = mad(_2814, _2827, 1.0f);
                                float _2860 = mad(_2838, _2843, _2859);
                                float _2861 = _2854 * _2860;
                                float _2862 = _2858 * _2860;
                                float _2863 = _2856 * _2858;
                                float _2864 = 0.25f * _2856;
                                float _2865 = _2864 * _2858;
                                float _2866 = mad(-0.5f, _2861, _2865);
                                float _2867 = _2862 * _2866;
                                float _2868 = _2861 * (-2.0f);
                                float _2869 = mad(_2856, _2858, _2868);
                                float _2870 = _2863 * _2869;
                                float _2871 = mad(_2861, _2861, _2870);
                                float _2872 = _2860 * _2860;
                                float _2873 = mad(_2814, _2827, _2860);
                                float _2874 = mad(-0.5f, _2873, -0.5f);
                                float _2875 = _2862 * _2874;
                                float _2876 = mad(_2857, _2872, _2875);
                                float _2877 = mad(_2858, _2876, _2871);
                                float _2878 = 2.0f * _2867;
                                float _2879 = _2867 * _2867;
                                float _2880 = mad(_2877, _2877, _2879);
                                float _2881 = _2878 / _2880;
                                float _2882 = _2881 * _2877;
                                float _2883 = -_2881;
                                float _2884 = mad(_2883, _2867, 1.0f);
                                float _2885 = _2882 * _2854;
                                float _2886 = mad(_2884, _2840, _2885);
                                float _2887 = _2882 * _2856;
                                float _2888 = mad(_2884, _2844, _2887);
                                float _2889 = mad(_2812, _2827, _2886);
                                float _2890 = mad(_2814, _2827, _2888);
                                float _2891 = mad(2.0f, _2890, 2.0f);
                                float _2892 = rsqrt(_2891);
                                float _2893 = _2889 + _2813;
                                float _2894 = _2893 * _2892;
                                float _2895 = clamp(_2894, 0.0f, 1.0f);
                                float _2896 = mad(_2892, _2890, _2892);
                                float _2897 = clamp(_2896, 0.0f, 1.0f);
                                _2899 = _2895;
                                _2900 = _2897;
                            }
                            _2901 = _2899;
                            _2902 = _2900;
                        }
                        else
                        {
                            _2901 = _2819;
                            _2902 = _2821;
                        }
                        float _2903 = abs(_2813);
                        float _2904 = _2903 + 9.9999997473787516355514526367188e-06f;
                        float _2905 = clamp(_2904, 0.0f, 1.0f);
                        float3 _2906 = _362 * 0.3183098733425140380859375f;
                        float _2907 = _884 * _883;
                        float3 _2908 = 1.0f.xxx * _2907;
                        float3 _2909 = _2906 * _2908;
                        uint _2910 = _918 & 1u;
                        bool _2911 = _2910 == 1u;
                        float3 _2992 = 0.0f.xxx;
                        if (_2911)
                        {
                            _2992 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2915 = _836 * _836;
                            float _2916 = _2915 * _2915;
                            bool _2917 = _911 > 0.0f;
                            float _2925 = 0.0f;
                            if (_2917)
                            {
                                float _2920 = _911 * _911;
                                float _2921 = mad(_2902, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                float _2922 = _2920 / _2921;
                                float _2923 = mad(_2915, _2915, _2922);
                                float _2924 = clamp(_2923, 0.0f, 1.0f);
                                _2925 = _2924;
                            }
                            else
                            {
                                _2925 = _2916;
                            }
                            float _2939 = 0.0f;
                            float _2940 = 0.0f;
                            if (_2822)
                            {
                                float _2928 = 0.25f * _909;
                                int _2929 = asint(_2925);
                                int _2930 = _2929 >> 1;
                                int _2931 = 532487669 + _2930;
                                float _2932 = asfloat(_2931);
                                float _2933 = mad(3.0f, _2932, _909);
                                float _2934 = _2928 * _2933;
                                float _2935 = _2902 + 0.001000000047497451305389404296875f;
                                float _2936 = _2934 / _2935;
                                float _2937 = _2925 + _2936;
                                float _2938 = _2925 / _2937;
                                _2939 = _2938;
                                _2940 = _2937;
                            }
                            else
                            {
                                _2939 = 1.0f;
                                _2940 = _2925;
                            }
                            bool _2941 = _862 < 1.0f;
                            float _2961 = 0.0f;
                            if (_2941)
                            {
                                float _2944 = 1.00010001659393310546875f - _862;
                                float _2945 = 1.0f + _862;
                                float _2946 = _2944 / _2945;
                                float _2947 = sqrt(_2946);
                                float _2948 = 0.25f * _2947;
                                int _2949 = asint(_2940);
                                int _2950 = _2949 >> 1;
                                int _2951 = 532487669 + _2950;
                                float _2952 = asfloat(_2951);
                                float _2953 = mad(3.0f, _2952, _2947);
                                float _2954 = _2948 * _2953;
                                float _2955 = _2902 + 0.001000000047497451305389404296875f;
                                float _2956 = _2954 / _2955;
                                float _2957 = _2940 + _2956;
                                float _2958 = _2940 / _2957;
                                float _2959 = sqrt(_2958);
                                float _2960 = _2939 * _2959;
                                _2961 = _2960;
                            }
                            else
                            {
                                _2961 = _2939;
                            }
                            float _2962 = -_2901;
                            float _2963 = mad(_2901, _2925, _2962);
                            float _2964 = mad(_2963, _2901, 1.0f);
                            float _2965 = 3.1415927410125732421875f * _2964;
                            float _2966 = _2965 * _2964;
                            float _2967 = _2925 / _2966;
                            float _2968 = _2967 * _2961;
                            float _2969 = sqrt(_2925);
                            float _2970 = 1.0f - _2969;
                            float _2971 = mad(_2905, _2970, _2969);
                            float _2972 = mad(_883, _2970, _2969);
                            float _2973 = _2905 * _2972;
                            float _2974 = mad(_883, _2971, _2973);
                            float _2975 = 0.5f / _2974;
                            float _2976 = 1.0f - _2902;
                            float _2977 = _2976 * _2976;
                            float _2978 = _2977 * _2977;
                            float _2979 = _2978 * _2976;
                            float _2980 = _369.y;
                            float _2981 = 50.0f * _2980;
                            float _2982 = clamp(_2981, 0.0f, 1.0f);
                            float _2983 = _2982 * _2979;
                            float3 _2984 = _2983.xxx;
                            float _2985 = -_2978;
                            float _2986 = mad(_2985, _2976, 1.0f);
                            float3 _2987 = _369 * _2986;
                            float3 _2988 = _2984 + _2987;
                            float _2989 = _2968 * _2975;
                            float3 _2990 = _2988 * _2989;
                            float3 _2991 = _2908 * _2990;
                            _2992 = _2991;
                        }
                        float3 _2993 = _2909 * 1.0f;
                        _2994 = _2993;
                        _2995 = _2992;
                        _2996 = 0.0f.xxx;
                        break;
                    }
                    case 11u:
                    {
                        float _2812 = dot(_322, _903);
                        float _2813 = dot(_322, _498);
                        float _2814 = dot(_498, _903);
                        float _2815 = mad(2.0f, _2814, 2.0f);
                        float _2816 = rsqrt(_2815);
                        float _2817 = _2812 + _2813;
                        float _2818 = _2817 * _2816;
                        float _2819 = clamp(_2818, 0.0f, 1.0f);
                        float _2820 = mad(_2816, _2814, _2816);
                        float _2821 = clamp(_2820, 0.0f, 1.0f);
                        bool _2822 = _909 > 0.0f;
                        float _2901 = 0.0f;
                        float _2902 = 0.0f;
                        if (_2822)
                        {
                            float _2825 = -_909;
                            float _2826 = mad(_2825, _909, 1.0f);
                            float _2827 = sqrt(_2826);
                            float _2828 = 2.0f * _2812;
                            float _2829 = -_2814;
                            float _2830 = mad(_2828, _2813, _2829);
                            bool _2831 = _2830 >= _2827;
                            float _2899 = 0.0f;
                            float _2900 = 0.0f;
                            if (_2831)
                            {
                                float _2898 = abs(_2813);
                                _2899 = 1.0f;
                                _2900 = _2898;
                            }
                            else
                            {
                                float _2835 = -_2830;
                                float _2836 = mad(_2835, _2830, 1.0f);
                                float _2837 = rsqrt(_2836);
                                float _2838 = _909 * _2837;
                                float _2839 = mad(_2835, _2812, _2813);
                                float _2840 = _2838 * _2839;
                                float _2841 = 2.0f * _2813;
                                float _2842 = mad(_2841, _2813, -1.0f);
                                float _2843 = mad(_2835, _2814, _2842);
                                float _2844 = _2838 * _2843;
                                float _2845 = -_2812;
                                float _2846 = mad(_2845, _2812, 1.0f);
                                float _2847 = -_2813;
                                float _2848 = mad(_2847, _2813, _2846);
                                float _2849 = mad(_2829, _2814, _2848);
                                float _2850 = _2828 * _2813;
                                float _2851 = mad(_2850, _2814, _2849);
                                float _2852 = clamp(_2851, 0.0f, 1.0f);
                                float _2853 = sqrt(_2852);
                                float _2854 = _2838 * _2853;
                                float _2855 = _2854 * 2.0f;
                                float _2856 = _2855 * _2813;
                                float _2857 = mad(_2812, _2827, _2813);
                                float _2858 = mad(_2838, _2839, _2857);
                                float _2859 = mad(_2814, _2827, 1.0f);
                                float _2860 = mad(_2838, _2843, _2859);
                                float _2861 = _2854 * _2860;
                                float _2862 = _2858 * _2860;
                                float _2863 = _2856 * _2858;
                                float _2864 = 0.25f * _2856;
                                float _2865 = _2864 * _2858;
                                float _2866 = mad(-0.5f, _2861, _2865);
                                float _2867 = _2862 * _2866;
                                float _2868 = _2861 * (-2.0f);
                                float _2869 = mad(_2856, _2858, _2868);
                                float _2870 = _2863 * _2869;
                                float _2871 = mad(_2861, _2861, _2870);
                                float _2872 = _2860 * _2860;
                                float _2873 = mad(_2814, _2827, _2860);
                                float _2874 = mad(-0.5f, _2873, -0.5f);
                                float _2875 = _2862 * _2874;
                                float _2876 = mad(_2857, _2872, _2875);
                                float _2877 = mad(_2858, _2876, _2871);
                                float _2878 = 2.0f * _2867;
                                float _2879 = _2867 * _2867;
                                float _2880 = mad(_2877, _2877, _2879);
                                float _2881 = _2878 / _2880;
                                float _2882 = _2881 * _2877;
                                float _2883 = -_2881;
                                float _2884 = mad(_2883, _2867, 1.0f);
                                float _2885 = _2882 * _2854;
                                float _2886 = mad(_2884, _2840, _2885);
                                float _2887 = _2882 * _2856;
                                float _2888 = mad(_2884, _2844, _2887);
                                float _2889 = mad(_2812, _2827, _2886);
                                float _2890 = mad(_2814, _2827, _2888);
                                float _2891 = mad(2.0f, _2890, 2.0f);
                                float _2892 = rsqrt(_2891);
                                float _2893 = _2889 + _2813;
                                float _2894 = _2893 * _2892;
                                float _2895 = clamp(_2894, 0.0f, 1.0f);
                                float _2896 = mad(_2892, _2890, _2892);
                                float _2897 = clamp(_2896, 0.0f, 1.0f);
                                _2899 = _2895;
                                _2900 = _2897;
                            }
                            _2901 = _2899;
                            _2902 = _2900;
                        }
                        else
                        {
                            _2901 = _2819;
                            _2902 = _2821;
                        }
                        float _2903 = abs(_2813);
                        float _2904 = _2903 + 9.9999997473787516355514526367188e-06f;
                        float _2905 = clamp(_2904, 0.0f, 1.0f);
                        float3 _2906 = _362 * 0.3183098733425140380859375f;
                        float _2907 = _884 * _883;
                        float3 _2908 = 1.0f.xxx * _2907;
                        float3 _2909 = _2906 * _2908;
                        uint _2910 = _918 & 1u;
                        bool _2911 = _2910 == 1u;
                        float3 _2992 = 0.0f.xxx;
                        if (_2911)
                        {
                            _2992 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2915 = _836 * _836;
                            float _2916 = _2915 * _2915;
                            bool _2917 = _911 > 0.0f;
                            float _2925 = 0.0f;
                            if (_2917)
                            {
                                float _2920 = _911 * _911;
                                float _2921 = mad(_2902, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                float _2922 = _2920 / _2921;
                                float _2923 = mad(_2915, _2915, _2922);
                                float _2924 = clamp(_2923, 0.0f, 1.0f);
                                _2925 = _2924;
                            }
                            else
                            {
                                _2925 = _2916;
                            }
                            float _2939 = 0.0f;
                            float _2940 = 0.0f;
                            if (_2822)
                            {
                                float _2928 = 0.25f * _909;
                                int _2929 = asint(_2925);
                                int _2930 = _2929 >> 1;
                                int _2931 = 532487669 + _2930;
                                float _2932 = asfloat(_2931);
                                float _2933 = mad(3.0f, _2932, _909);
                                float _2934 = _2928 * _2933;
                                float _2935 = _2902 + 0.001000000047497451305389404296875f;
                                float _2936 = _2934 / _2935;
                                float _2937 = _2925 + _2936;
                                float _2938 = _2925 / _2937;
                                _2939 = _2938;
                                _2940 = _2937;
                            }
                            else
                            {
                                _2939 = 1.0f;
                                _2940 = _2925;
                            }
                            bool _2941 = _862 < 1.0f;
                            float _2961 = 0.0f;
                            if (_2941)
                            {
                                float _2944 = 1.00010001659393310546875f - _862;
                                float _2945 = 1.0f + _862;
                                float _2946 = _2944 / _2945;
                                float _2947 = sqrt(_2946);
                                float _2948 = 0.25f * _2947;
                                int _2949 = asint(_2940);
                                int _2950 = _2949 >> 1;
                                int _2951 = 532487669 + _2950;
                                float _2952 = asfloat(_2951);
                                float _2953 = mad(3.0f, _2952, _2947);
                                float _2954 = _2948 * _2953;
                                float _2955 = _2902 + 0.001000000047497451305389404296875f;
                                float _2956 = _2954 / _2955;
                                float _2957 = _2940 + _2956;
                                float _2958 = _2940 / _2957;
                                float _2959 = sqrt(_2958);
                                float _2960 = _2939 * _2959;
                                _2961 = _2960;
                            }
                            else
                            {
                                _2961 = _2939;
                            }
                            float _2962 = -_2901;
                            float _2963 = mad(_2901, _2925, _2962);
                            float _2964 = mad(_2963, _2901, 1.0f);
                            float _2965 = 3.1415927410125732421875f * _2964;
                            float _2966 = _2965 * _2964;
                            float _2967 = _2925 / _2966;
                            float _2968 = _2967 * _2961;
                            float _2969 = sqrt(_2925);
                            float _2970 = 1.0f - _2969;
                            float _2971 = mad(_2905, _2970, _2969);
                            float _2972 = mad(_883, _2970, _2969);
                            float _2973 = _2905 * _2972;
                            float _2974 = mad(_883, _2971, _2973);
                            float _2975 = 0.5f / _2974;
                            float _2976 = 1.0f - _2902;
                            float _2977 = _2976 * _2976;
                            float _2978 = _2977 * _2977;
                            float _2979 = _2978 * _2976;
                            float _2980 = _369.y;
                            float _2981 = 50.0f * _2980;
                            float _2982 = clamp(_2981, 0.0f, 1.0f);
                            float _2983 = _2982 * _2979;
                            float3 _2984 = _2983.xxx;
                            float _2985 = -_2978;
                            float _2986 = mad(_2985, _2976, 1.0f);
                            float3 _2987 = _369 * _2986;
                            float3 _2988 = _2984 + _2987;
                            float _2989 = _2968 * _2975;
                            float3 _2990 = _2988 * _2989;
                            float3 _2991 = _2908 * _2990;
                            _2992 = _2991;
                        }
                        float3 _2993 = _2909 * 1.0f;
                        _2994 = _2993;
                        _2995 = _2992;
                        _2996 = 0.0f.xxx;
                        break;
                    }
                    case 2u:
                    {
                        float _2540 = dot(_322, _903);
                        float _2541 = dot(_322, _498);
                        float _2542 = dot(_498, _903);
                        float _2544 = rsqrt(mad(2.0f, _2542, 2.0f));
                        bool _2550 = _909 > 0.0f;
                        float _2629 = 0.0f;
                        float _2630 = 0.0f;
                        if (_2550)
                        {
                            float _2555 = sqrt(mad(-_909, _909, 1.0f));
                            float _2556 = 2.0f * _2540;
                            float _2557 = -_2542;
                            float _2558 = mad(_2556, _2541, _2557);
                            float _2627 = 0.0f;
                            float _2628 = 0.0f;
                            if (_2558 >= _2555)
                            {
                                _2627 = 1.0f;
                                _2628 = abs(_2541);
                            }
                            else
                            {
                                float _2563 = -_2558;
                                float _2566 = _909 * rsqrt(mad(_2563, _2558, 1.0f));
                                float _2567 = mad(_2563, _2540, _2541);
                                float _2571 = mad(_2563, _2542, mad(2.0f * _2541, _2541, -1.0f));
                                float _2582 = _2566 * sqrt(clamp(mad(_2556 * _2541, _2542, mad(_2557, _2542, mad(-_2541, _2541, mad(-_2540, _2540, 1.0f)))), 0.0f, 1.0f));
                                float _2584 = (_2582 * 2.0f) * _2541;
                                float _2585 = mad(_2540, _2555, _2541);
                                float _2586 = mad(_2566, _2567, _2585);
                                float _2588 = mad(_2566, _2571, mad(_2542, _2555, 1.0f));
                                float _2589 = _2582 * _2588;
                                float _2590 = _2586 * _2588;
                                float _2595 = _2590 * mad(-0.5f, _2589, (0.25f * _2584) * _2586);
                                float _2605 = mad(_2586, mad(_2585, _2588 * _2588, _2590 * mad(-0.5f, mad(_2542, _2555, _2588), -0.5f)), mad(_2589, _2589, (_2584 * _2586) * mad(_2584, _2586, _2589 * (-2.0f))));
                                float _2609 = (2.0f * _2595) / mad(_2605, _2605, _2595 * _2595);
                                float _2610 = _2609 * _2605;
                                float _2612 = mad(-_2609, _2595, 1.0f);
                                float _2618 = mad(_2542, _2555, mad(_2612, _2566 * _2571, _2610 * _2584));
                                float _2620 = rsqrt(mad(2.0f, _2618, 2.0f));
                                _2627 = clamp((mad(_2540, _2555, mad(_2612, _2566 * _2567, _2610 * _2582)) + _2541) * _2620, 0.0f, 1.0f);
                                _2628 = clamp(mad(_2620, _2618, _2620), 0.0f, 1.0f);
                            }
                            _2629 = _2627;
                            _2630 = _2628;
                        }
                        else
                        {
                            _2629 = clamp((_2540 + _2541) * _2544, 0.0f, 1.0f);
                            _2630 = clamp(mad(_2544, _2542, _2544), 0.0f, 1.0f);
                        }
                        float _2633 = clamp(abs(_2541) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _2636 = 1.0f.xxx * (_884 * _883);
                        float3 _2720 = 0.0f.xxx;
                        if ((_918 & 1u) == 1u)
                        {
                            _2720 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2643 = _836 * _836;
                            float _2653 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _2653 = clamp(mad(_2643, _2643, (_911 * _911) / mad(_2630, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2653 = _2643 * _2643;
                            }
                            float _2667 = 0.0f;
                            float _2668 = 0.0f;
                            if (_2550)
                            {
                                float _2665 = _2653 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_2653) >> 1)), _909)) / (_2630 + 0.001000000047497451305389404296875f));
                                _2667 = _2653 / _2665;
                                _2668 = _2665;
                            }
                            else
                            {
                                _2667 = 1.0f;
                                _2668 = _2653;
                            }
                            float _2689 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _2675 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _2689 = _2667 * sqrt(_2668 / (_2668 + (((0.25f * _2675) * mad(3.0f, asfloat(532487669 + (asint(_2668) >> 1)), _2675)) / (_2630 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2689 = _2667;
                            }
                            float _2692 = mad(mad(_2629, _2653, -_2629), _2629, 1.0f);
                            float _2697 = sqrt(_2653);
                            float _2698 = 1.0f - _2697;
                            float _2704 = 1.0f - _2630;
                            float _2705 = _2704 * _2704;
                            float _2706 = _2705 * _2705;
                            _2720 = _2636 * (((clamp(50.0f * _369.y, 0.0f, 1.0f) * (_2706 * _2704)).xxx + (_369 * mad(-_2706, _2704, 1.0f))) * (((_2653 / ((3.1415927410125732421875f * _2692) * _2692)) * _2689) * (0.5f / mad(_883, mad(_2633, _2698, _2697), _2633 * mad(_883, _2698, _2697)))));
                        }
                        float3 _2722 = _312.xyz;
                        float3 _2723 = _2722 * _2722;
                        float3 _2745 = exp((-((-log(clamp(_2723, 9.9999999600419720025001879548654e-13f.xxx, 1.0f.xxx))) / (isnan(View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters) ? 9.9999999600419720025001879548654e-13f : (isnan(9.9999999600419720025001879548654e-13f) ? View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : max(9.9999999600419720025001879548654e-13f, View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters))).xxx)) * 1.0f);
                        float _2746 = _2745.y;
                        float _2747 = _2745.z;
                        bool4 _2749 = (_2746 < _2747).xxxx;
                        float4 _2750 = float4(_2747, _2746, -1.0f, 0.666666686534881591796875f);
                        float4 _2751 = float4(_2746, _2747, 0.0f, -0.3333333432674407958984375f);
                        float4 _2752 = float4(_2749.x ? _2750.x : _2751.x, _2749.y ? _2750.y : _2751.y, _2749.z ? _2750.z : _2751.z, _2749.w ? _2750.w : _2751.w);
                        float _2753 = _2745.x;
                        float _2754 = _2752.x;
                        bool4 _2756 = (_2753 < _2754).xxxx;
                        float4 _2759 = float4(_2754, _2752.yw, _2753);
                        float4 _2761 = float4(_2753, _2752.yz, _2754);
                        float4 _2762 = float4(_2756.x ? _2759.x : _2761.x, _2756.y ? _2759.y : _2761.y, _2756.z ? _2759.z : _2761.z, _2756.w ? _2759.w : _2761.w);
                        float _2763 = _2762.x;
                        float _2764 = _2762.w;
                        float _2765 = _2762.y;
                        float _2767 = _2763 - (isnan(_2765) ? _2764 : (isnan(_2764) ? _2765 : min(_2764, _2765)));
                        float _2773 = abs(((_2764 - _2765) / mad(6.0f, _2767, 1.0000000133514319600180897396058e-10f)) + _2762.z);
                        float _2776 = _2723.y;
                        float _2777 = _2723.z;
                        bool4 _2779 = (_2776 < _2777).xxxx;
                        float4 _2780 = float4(_2777, _2776, -1.0f, 0.666666686534881591796875f);
                        float4 _2781 = float4(_2776, _2777, 0.0f, -0.3333333432674407958984375f);
                        float4 _2782 = float4(_2779.x ? _2780.x : _2781.x, _2779.y ? _2780.y : _2781.y, _2779.z ? _2780.z : _2781.z, _2779.w ? _2780.w : _2781.w);
                        float _2783 = _2723.x;
                        float _2784 = _2782.x;
                        bool4 _2786 = (_2783 < _2784).xxxx;
                        float4 _2787 = float4(_2784, _185, _185, _2783);
                        float4 _2788 = float4(_2783, _185, _185, _2784);
                        _2994 = ((_362 * 0.3183098733425140380859375f) * _2636) * 1.0f;
                        _2995 = _2720;
                        _2996 = (1.0f.xxx * (_884 * lerp(lerp(1.0f, pow(clamp(mad(_2540, 0.666666686534881591796875f, 0.3333333432674407958984375f), 0.0f, 1.0f), 1.5f) * 1.66666662693023681640625f, _530) * 0.15915493667125701904296875f, 1.0f, pow(clamp(dot(_903, _400), 0.0f, 1.0f), 12.0f) * lerp(3.0f, 0.100000001490116119384765625f, _530)))) * lerp((((clamp(float3(abs(mad(_2773, 6.0f, -3.0f)) - 1.0f, 2.0f - abs(mad(_2773, 6.0f, -2.0f)), 2.0f - abs(mad(_2773, 6.0f, -4.0f))), 0.0f.xxx, 1.0f.xxx) - 1.0f.xxx) * (_2767 / (_2763 + 1.0000000133514319600180897396058e-10f))) + 1.0f.xxx) * float4(_2786.x ? _2787.x : _2788.x, _2786.y ? _2787.y : _2788.y, _2786.z ? _2787.z : _2788.z, _2786.w ? _2787.w : _2788.w).x, _2723, _552.xxx);
                        break;
                    }
                    case 3u:
                    {
                        float _2344 = dot(_322, _903);
                        float _2345 = dot(_322, _498);
                        float _2346 = dot(_498, _903);
                        float _2348 = rsqrt(mad(2.0f, _2346, 2.0f));
                        bool _2354 = _909 > 0.0f;
                        float _2433 = 0.0f;
                        float _2434 = 0.0f;
                        if (_2354)
                        {
                            float _2359 = sqrt(mad(-_909, _909, 1.0f));
                            float _2360 = 2.0f * _2344;
                            float _2361 = -_2346;
                            float _2362 = mad(_2360, _2345, _2361);
                            float _2431 = 0.0f;
                            float _2432 = 0.0f;
                            if (_2362 >= _2359)
                            {
                                _2431 = 1.0f;
                                _2432 = abs(_2345);
                            }
                            else
                            {
                                float _2367 = -_2362;
                                float _2370 = _909 * rsqrt(mad(_2367, _2362, 1.0f));
                                float _2371 = mad(_2367, _2344, _2345);
                                float _2375 = mad(_2367, _2346, mad(2.0f * _2345, _2345, -1.0f));
                                float _2386 = _2370 * sqrt(clamp(mad(_2360 * _2345, _2346, mad(_2361, _2346, mad(-_2345, _2345, mad(-_2344, _2344, 1.0f)))), 0.0f, 1.0f));
                                float _2388 = (_2386 * 2.0f) * _2345;
                                float _2389 = mad(_2344, _2359, _2345);
                                float _2390 = mad(_2370, _2371, _2389);
                                float _2392 = mad(_2370, _2375, mad(_2346, _2359, 1.0f));
                                float _2393 = _2386 * _2392;
                                float _2394 = _2390 * _2392;
                                float _2399 = _2394 * mad(-0.5f, _2393, (0.25f * _2388) * _2390);
                                float _2409 = mad(_2390, mad(_2389, _2392 * _2392, _2394 * mad(-0.5f, mad(_2346, _2359, _2392), -0.5f)), mad(_2393, _2393, (_2388 * _2390) * mad(_2388, _2390, _2393 * (-2.0f))));
                                float _2413 = (2.0f * _2399) / mad(_2409, _2409, _2399 * _2399);
                                float _2414 = _2413 * _2409;
                                float _2416 = mad(-_2413, _2399, 1.0f);
                                float _2422 = mad(_2346, _2359, mad(_2416, _2370 * _2375, _2414 * _2388));
                                float _2424 = rsqrt(mad(2.0f, _2422, 2.0f));
                                _2431 = clamp((mad(_2344, _2359, mad(_2416, _2370 * _2371, _2414 * _2386)) + _2345) * _2424, 0.0f, 1.0f);
                                _2432 = clamp(mad(_2424, _2422, _2424), 0.0f, 1.0f);
                            }
                            _2433 = _2431;
                            _2434 = _2432;
                        }
                        else
                        {
                            _2433 = clamp((_2344 + _2345) * _2348, 0.0f, 1.0f);
                            _2434 = clamp(mad(_2348, _2346, _2348), 0.0f, 1.0f);
                        }
                        float _2437 = clamp(abs(_2345) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _2440 = 1.0f.xxx * (_884 * _883);
                        float3 _2524 = 0.0f.xxx;
                        if ((_918 & 1u) == 1u)
                        {
                            _2524 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2447 = _836 * _836;
                            float _2457 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _2457 = clamp(mad(_2447, _2447, (_911 * _911) / mad(_2434, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2457 = _2447 * _2447;
                            }
                            float _2471 = 0.0f;
                            float _2472 = 0.0f;
                            if (_2354)
                            {
                                float _2469 = _2457 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_2457) >> 1)), _909)) / (_2434 + 0.001000000047497451305389404296875f));
                                _2471 = _2457 / _2469;
                                _2472 = _2469;
                            }
                            else
                            {
                                _2471 = 1.0f;
                                _2472 = _2457;
                            }
                            float _2493 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _2479 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _2493 = _2471 * sqrt(_2472 / (_2472 + (((0.25f * _2479) * mad(3.0f, asfloat(532487669 + (asint(_2472) >> 1)), _2479)) / (_2434 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2493 = _2471;
                            }
                            float _2496 = mad(mad(_2433, _2457, -_2433), _2433, 1.0f);
                            float _2501 = sqrt(_2457);
                            float _2502 = 1.0f - _2501;
                            float _2508 = 1.0f - _2434;
                            float _2509 = _2508 * _2508;
                            float _2510 = _2509 * _2509;
                            _2524 = _2440 * (((clamp(50.0f * _369.y, 0.0f, 1.0f) * (_2510 * _2508)).xxx + (_369 * mad(-_2510, _2508, 1.0f))) * (((_2457 / ((3.1415927410125732421875f * _2496) * _2496)) * _2493) * (0.5f / mad(_883, mad(_2437, _2502, _2501), _2437 * mad(_883, _2502, _2501)))));
                        }
                        float3 _2526 = _312.xyz;
                        _2994 = ((_362 * 0.3183098733425140380859375f) * _2440) * 1.0f;
                        _2995 = _2524;
                        _2996 = ((1.0f.xxx * _884) * View_PreIntegratedBRDF.SampleLevel(View_PreIntegratedBRDFSampler, float2(clamp(mad(_2344, 0.5f, 0.5f), 0.0f, 1.0f), 1.0f - _530), 0.0f).xyz) * (_2526 * _2526);
                        break;
                    }
                    case 4u:
                    {
                        float _2021 = _312.x;
                        float _2022 = _312.y;
                        float _2023 = isnan(0.0199999995529651641845703125f) ? _2022 : (isnan(_2022) ? 0.0199999995529651641845703125f : max(_2022, 0.0199999995529651641845703125f));
                        float _2024 = dot(_322, _903);
                        float _2025 = dot(_322, _498);
                        float _2026 = dot(_498, _903);
                        float _2028 = rsqrt(mad(2.0f, _2026, 2.0f));
                        float _2035 = mad(-_836, _836, 1.0f);
                        float _2036 = _2023 * _2023;
                        float _2043 = clamp(_909 * ((_2035 > 0.0f) ? (mad(-_2023, _2023, 1.0f) / _2035) : 0.0f), 0.0f, 1.0f);
                        bool _2044 = _2043 > 0.0f;
                        float _2124 = 0.0f;
                        float _2125 = 0.0f;
                        float _2126 = 0.0f;
                        if (_2044)
                        {
                            float _2049 = sqrt(mad(-_2043, _2043, 1.0f));
                            float _2050 = 2.0f * _2024;
                            float _2051 = -_2026;
                            float _2052 = mad(_2050, _2025, _2051);
                            float _2121 = 0.0f;
                            float _2122 = 0.0f;
                            float _2123 = 0.0f;
                            if (_2052 >= _2049)
                            {
                                _2121 = _2024;
                                _2122 = 1.0f;
                                _2123 = abs(_2025);
                            }
                            else
                            {
                                float _2057 = -_2052;
                                float _2060 = _2043 * rsqrt(mad(_2057, _2052, 1.0f));
                                float _2061 = mad(_2057, _2024, _2025);
                                float _2065 = mad(_2057, _2026, mad(2.0f * _2025, _2025, -1.0f));
                                float _2076 = _2060 * sqrt(clamp(mad(_2050 * _2025, _2026, mad(_2051, _2026, mad(-_2025, _2025, mad(-_2024, _2024, 1.0f)))), 0.0f, 1.0f));
                                float _2078 = (_2076 * 2.0f) * _2025;
                                float _2079 = mad(_2024, _2049, _2025);
                                float _2080 = mad(_2060, _2061, _2079);
                                float _2082 = mad(_2060, _2065, mad(_2026, _2049, 1.0f));
                                float _2083 = _2076 * _2082;
                                float _2084 = _2080 * _2082;
                                float _2089 = _2084 * mad(-0.5f, _2083, (0.25f * _2078) * _2080);
                                float _2099 = mad(_2080, mad(_2079, _2082 * _2082, _2084 * mad(-0.5f, mad(_2026, _2049, _2082), -0.5f)), mad(_2083, _2083, (_2078 * _2080) * mad(_2078, _2080, _2083 * (-2.0f))));
                                float _2103 = (2.0f * _2089) / mad(_2099, _2099, _2089 * _2089);
                                float _2104 = _2103 * _2099;
                                float _2106 = mad(-_2103, _2089, 1.0f);
                                float _2111 = mad(_2024, _2049, mad(_2106, _2060 * _2061, _2104 * _2076));
                                float _2112 = mad(_2026, _2049, mad(_2106, _2060 * _2065, _2104 * _2078));
                                float _2114 = rsqrt(mad(2.0f, _2112, 2.0f));
                                _2121 = _2111;
                                _2122 = clamp((_2111 + _2025) * _2114, 0.0f, 1.0f);
                                _2123 = clamp(mad(_2114, _2112, _2114), 0.0f, 1.0f);
                            }
                            _2124 = _2121;
                            _2125 = _2122;
                            _2126 = _2123;
                        }
                        else
                        {
                            _2124 = _2024;
                            _2125 = clamp((_2024 + _2025) * _2028, 0.0f, 1.0f);
                            _2126 = clamp(mad(_2028, _2026, _2028), 0.0f, 1.0f);
                        }
                        float _2129 = clamp(abs(_2025) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        bool _2131 = (_918 & 1u) == 1u;
                        float _2132 = _2131 ? _2129 : _2126;
                        float _2133 = 1.0f - _2132;
                        float _2134 = _2133 * _2133;
                        float _2135 = _2134 * _2134;
                        float _2137 = mad(-_2135, _2133, 1.0f);
                        float _2139 = mad(_2135, _2133, _2137 * 0.039999999105930328369140625f);
                        float3 _2209 = 0.0f.xxx;
                        if (_2131)
                        {
                            _2209 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2152 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _2152 = clamp(mad(_2036, _2036, (_911 * _911) / mad(_2132, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2152 = _2036 * _2036;
                            }
                            float _2166 = 0.0f;
                            float _2167 = 0.0f;
                            if (_2044)
                            {
                                float _2164 = _2152 + (((0.25f * _2043) * mad(3.0f, asfloat(532487669 + (asint(_2152) >> 1)), _2043)) / (_2132 + 0.001000000047497451305389404296875f));
                                _2166 = _2152 / _2164;
                                _2167 = _2164;
                            }
                            else
                            {
                                _2166 = 1.0f;
                                _2167 = _2152;
                            }
                            float _2188 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _2174 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _2188 = _2166 * sqrt(_2167 / (_2167 + (((0.25f * _2174) * mad(3.0f, asfloat(532487669 + (asint(_2167) >> 1)), _2174)) / (_2132 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2188 = _2166;
                            }
                            float _2189 = sqrt(_2152);
                            float _2190 = 1.0f - _2189;
                            float _2198 = mad(mad(_2125, _2152, -_2125), _2125, 1.0f);
                            _2209 = (1.0f.xxx * _2021) * ((_884 * _883) * ((((_2152 / ((3.1415927410125732421875f * _2198) * _2198)) * _2188) * (0.5f / mad(_883, mad(_2129, _2190, _2189), _2129 * mad(_883, _2190, _2189)))) * _2139));
                        }
                        float _2210 = 1.0f - _2139;
                        float _2213 = mad(mad(-0.2199999988079071044921875f, _2132, 0.62999999523162841796875f), _2132, -0.74500000476837158203125f);
                        float _2215 = -(_2213 * _2125);
                        float _2217 = clamp(mad(0.666666686534881591796875f, _2129, _2215), 0.001000000047497451305389404296875f, 1.0f);
                        float3 _2240 = 0.0f.xxx;
                        if (_324 > 0.0f)
                        {
                            float3 _2230 = _353 * 0.3183098733425140380859375f;
                            bool3 _3190 = isnan(_2230);
                            bool3 _3191 = isnan(9.9999997473787516355514526367188e-05f.xxx);
                            float3 _3192 = max(_2230, 9.9999997473787516355514526367188e-05f.xxx);
                            float3 _3193 = float3(_3190.x ? 9.9999997473787516355514526367188e-05f.xxx.x : _3192.x, _3190.y ? 9.9999997473787516355514526367188e-05f.xxx.y : _3192.y, _3190.z ? 9.9999997473787516355514526367188e-05f.xxx.z : _3192.z);
                            float _2234 = ((1.0f / _2217) + (1.0f / clamp(mad(0.666666686534881591796875f, _2124, _2215), 0.001000000047497451305389404296875f, 1.0f))) - 2.0f;
                            _2240 = lerp(1.0f.xxx, exp(-((log(float3(_3191.x ? _2230.x : _3193.x, _3191.y ? _2230.y : _3193.y, _3191.z ? _2230.z : _3193.z)) * (-0.5f).xxx) * (isnan(0.0f) ? _2234 : (isnan(_2234) ? 0.0f : max(_2234, 0.0f))))), _327);
                        }
                        else
                        {
                            _2240 = 1.0f.xxx;
                        }
                        float3 _2245 = ((1.0f.xxx * (_884 * _883)) * (_362 * 0.3183098733425140380859375f)) * 1.0f;
                        float3 _2246 = _2240 * (_2210 * _2210);
                        float3 _2248 = _2021.xxx;
                        float3 _2343 = 0.0f.xxx;
                        if (true && _2131)
                        {
                            _2343 = _2209 + lerp(0.0f.xxx, 0.0f.xxx, _2248);
                        }
                        else
                        {
                            float _2254 = _836 * _836;
                            float _2255 = _2254 * _2254;
                            float _2256 = sqrt(_2255);
                            float _2257 = 1.0f - _2256;
                            float _2265 = mad(mad(_2125, _2255, -_2125), _2125, 1.0f);
                            float _2269 = 1.0f - (_2131 ? _2217 : clamp(mad(0.666666686534881591796875f, _2132, -_2213), 0.0f, 1.0f));
                            float _2270 = _2269 * _2269;
                            float _2271 = _2270 * _2270;
                            float _2275 = clamp(50.0f * _369.y, 0.0f, 1.0f);
                            float _2295 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _2295 = clamp(mad(_2254, _2254, (_911 * _911) / mad(_2132, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2295 = _2255;
                            }
                            float _2310 = 0.0f;
                            float _2311 = 0.0f;
                            if (_909 > 0.0f)
                            {
                                float _2308 = _2295 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_2295) >> 1)), _909)) / (_2132 + 0.001000000047497451305389404296875f));
                                _2310 = _2295 / _2308;
                                _2311 = _2308;
                            }
                            else
                            {
                                _2310 = 1.0f;
                                _2311 = _2295;
                            }
                            float _2332 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _2318 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _2332 = _2310 * sqrt(_2311 / (_2311 + (((0.25f * _2318) * mad(3.0f, asfloat(532487669 + (asint(_2311) >> 1)), _2318)) / (_2132 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _2332 = _2310;
                            }
                            _2343 = mad(1.0f.xxx * ((((_2332 * _884) * _883) * (_2255 / ((3.1415927410125732421875f * _2265) * _2265))) * (0.5f / mad(_883, mad(_2217, _2257, _2256), _2217 * mad(_883, _2257, _2256)))), lerp((_2275 * (_2135 * _2133)).xxx + (_369 * _2137), _2246 * ((_2275 * (_2271 * _2269)).xxx + (_369 * mad(-_2271, _2269, 1.0f))), _2248), _2209);
                        }
                        _2994 = lerp(_2245, _2246 * _2245, _2248);
                        _2995 = _2343;
                        _2996 = 0.0f.xxx;
                        break;
                    }
                    case 5u:
                    {
                        float _1710 = dot(_322, _903);
                        float _1711 = dot(_322, _498);
                        float _1712 = dot(_498, _903);
                        float _1714 = rsqrt(mad(2.0f, _1712, 2.0f));
                        bool _1720 = _909 > 0.0f;
                        float _1799 = 0.0f;
                        float _1800 = 0.0f;
                        if (_1720)
                        {
                            float _1725 = sqrt(mad(-_909, _909, 1.0f));
                            float _1726 = 2.0f * _1710;
                            float _1727 = -_1712;
                            float _1728 = mad(_1726, _1711, _1727);
                            float _1797 = 0.0f;
                            float _1798 = 0.0f;
                            if (_1728 >= _1725)
                            {
                                _1797 = 1.0f;
                                _1798 = abs(_1711);
                            }
                            else
                            {
                                float _1733 = -_1728;
                                float _1736 = _909 * rsqrt(mad(_1733, _1728, 1.0f));
                                float _1737 = mad(_1733, _1710, _1711);
                                float _1741 = mad(_1733, _1712, mad(2.0f * _1711, _1711, -1.0f));
                                float _1752 = _1736 * sqrt(clamp(mad(_1726 * _1711, _1712, mad(_1727, _1712, mad(-_1711, _1711, mad(-_1710, _1710, 1.0f)))), 0.0f, 1.0f));
                                float _1754 = (_1752 * 2.0f) * _1711;
                                float _1755 = mad(_1710, _1725, _1711);
                                float _1756 = mad(_1736, _1737, _1755);
                                float _1758 = mad(_1736, _1741, mad(_1712, _1725, 1.0f));
                                float _1759 = _1752 * _1758;
                                float _1760 = _1756 * _1758;
                                float _1765 = _1760 * mad(-0.5f, _1759, (0.25f * _1754) * _1756);
                                float _1775 = mad(_1756, mad(_1755, _1758 * _1758, _1760 * mad(-0.5f, mad(_1712, _1725, _1758), -0.5f)), mad(_1759, _1759, (_1754 * _1756) * mad(_1754, _1756, _1759 * (-2.0f))));
                                float _1779 = (2.0f * _1765) / mad(_1775, _1775, _1765 * _1765);
                                float _1780 = _1779 * _1775;
                                float _1782 = mad(-_1779, _1765, 1.0f);
                                float _1788 = mad(_1712, _1725, mad(_1782, _1736 * _1741, _1780 * _1754));
                                float _1790 = rsqrt(mad(2.0f, _1788, 2.0f));
                                _1797 = clamp((mad(_1710, _1725, mad(_1782, _1736 * _1737, _1780 * _1752)) + _1711) * _1790, 0.0f, 1.0f);
                                _1798 = clamp(mad(_1790, _1788, _1790), 0.0f, 1.0f);
                            }
                            _1799 = _1797;
                            _1800 = _1798;
                        }
                        else
                        {
                            _1799 = clamp((_1710 + _1711) * _1714, 0.0f, 1.0f);
                            _1800 = clamp(mad(_1714, _1712, _1714), 0.0f, 1.0f);
                        }
                        float _1803 = clamp(abs(_1711) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        uint _1806 = uint(mad(_312.x, 255.0f, 0.5f));
                        int _1807 = int(_1806);
                        float4 _1811 = View_SSProfilesTexture.Load(int3(int3(5, _1807, 0).xy, 0));
                        float _1816 = clamp((_530 - 0.100000001490116119384765625f) * 10.0f, 0.0f, 1.0f);
                        float _1821 = _1811.z;
                        float _1823 = clamp(_836 * lerp(1.0f, _1811.x * 2.0f, _1816), 0.0f, 1.0f);
                        float _1824 = isnan(0.0199999995529651641845703125f) ? _1823 : (isnan(_1823) ? 0.0199999995529651641845703125f : max(_1823, 0.0199999995529651641845703125f));
                        float _1826 = clamp(_836 * lerp(1.0f, _1811.y * 2.0f, _1816), 0.0f, 1.0f);
                        float _1827 = lerp(_1824, _1826, _1821);
                        float _1831 = mad((2.0f * _1800) * _1800, _836, 0.5f) - 1.0f;
                        float _1832 = 1.0f - _1803;
                        float _1833 = _1832 * _1832;
                        float _1837 = 1.0f - _883;
                        float _1838 = _1837 * _1837;
                        float3 _1846 = 1.0f.xxx * (_884 * _883);
                        float3 _1986 = 0.0f.xxx;
                        if ((_918 & 1u) == 1u)
                        {
                            _1986 = lerp(0.0f.xxx, 0.0f.xxx, _1821.xxx);
                        }
                        else
                        {
                            float _1853 = _1827 * _1827;
                            float _1855 = _1824 * _1824;
                            float _1857 = _1826 * _1826;
                            bool _1859 = _911 > 0.0f;
                            float _1867 = 0.0f;
                            if (_1859)
                            {
                                _1867 = clamp(mad(_1855, _1855, (_911 * _911) / mad(_1800, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1867 = _1855 * _1855;
                            }
                            float _1881 = 0.0f;
                            float _1882 = 0.0f;
                            if (_1720)
                            {
                                float _1879 = _1867 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_1867) >> 1)), _909)) / (_1800 + 0.001000000047497451305389404296875f));
                                _1881 = _1867 / _1879;
                                _1882 = _1879;
                            }
                            else
                            {
                                _1881 = 1.0f;
                                _1882 = _1867;
                            }
                            bool _1883 = _862 < 1.0f;
                            float _1903 = 0.0f;
                            if (_1883)
                            {
                                float _1889 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _1903 = _1881 * sqrt(_1882 / (_1882 + (((0.25f * _1889) * mad(3.0f, asfloat(532487669 + (asint(_1882) >> 1)), _1889)) / (_1800 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1903 = _1881;
                            }
                            float _1911 = 0.0f;
                            if (_1859)
                            {
                                _1911 = clamp(mad(_1857, _1857, (_911 * _911) / mad(_1800, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1911 = _1857 * _1857;
                            }
                            float _1925 = 0.0f;
                            float _1926 = 0.0f;
                            if (_1720)
                            {
                                float _1923 = _1911 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_1911) >> 1)), _909)) / (_1800 + 0.001000000047497451305389404296875f));
                                _1925 = _1911 / _1923;
                                _1926 = _1923;
                            }
                            else
                            {
                                _1925 = 1.0f;
                                _1926 = _1911;
                            }
                            float _1946 = 0.0f;
                            if (_1883)
                            {
                                float _1932 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _1946 = _1925 * sqrt(_1926 / (_1926 + (((0.25f * _1932) * mad(3.0f, asfloat(532487669 + (asint(_1926) >> 1)), _1932)) / (_1800 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1946 = _1925;
                            }
                            float _1947 = -_1799;
                            float _1949 = mad(mad(_1799, _1867, _1947), _1799, 1.0f);
                            float _1955 = mad(mad(_1799, _1911, _1947), _1799, 1.0f);
                            float _1961 = sqrt(_1853 * _1853);
                            float _1962 = 1.0f - _1961;
                            float _1968 = 1.0f - _1800;
                            float _1969 = _1968 * _1968;
                            float _1970 = _1969 * _1969;
                            _1986 = _1846 * (((clamp(50.0f * _369.y, 0.0f, 1.0f) * (_1970 * _1968)).xxx + (_369 * mad(-_1970, _1968, 1.0f))) * (lerp((_1867 / ((3.1415927410125732421875f * _1949) * _1949)) * _1903, (_1911 / ((3.1415927410125732421875f * _1955) * _1955)) * _1946, _1821) * (0.5f / mad(_883, mad(_1803, _1962, _1961), _1803 * mad(_883, _1962, _1961)))));
                        }
                        float4 _1990 = View_SSProfilesTexture.Load(int3(int3(3, _1807, 0).xy, 0));
                        float _1992 = mad(_1990.z, 2.0f, -1.0f);
                        float _2012 = -_1992;
                        float _2013 = mad(_2012, dot(-_903, refract(_498, -_322, _1990.w)), 1.0f);
                        float _2014 = _2013 * _2013;
                        _2994 = (_1846 * (_362 * ((0.3183098733425140380859375f * mad(_1831, (_1833 * _1833) * _1832, 1.0f)) * mad(_1831, (_1838 * _1838) * _1837, 1.0f)))) * 1.0f;
                        _2995 = _1986;
                        _2996 = View_SSProfilesTexture.SampleLevel(View_SSProfilesTransmissionSampler, float2(mad(1.0f - _552, 31.0f, 34.0f) + 0.5f, float(_1806) + 0.5f) / View_View_SSProfilesTextureSizeAndInvSize.xy, 0.0f).xyz * (_884 * ((0.5f * mad(_2012, _1992, 1.0f)) / (isnan(_2014) ? 9.9999997473787516355514526367188e-06f : (isnan(9.9999997473787516355514526367188e-06f) ? _2014 : max(9.9999997473787516355514526367188e-06f, _2014)))));
                        break;
                    }
                    case 6u:
                    {
                        float _1511 = dot(_322, _903);
                        float _1512 = dot(_322, _498);
                        float _1513 = dot(_498, _903);
                        float _1515 = rsqrt(mad(2.0f, _1513, 2.0f));
                        bool _1521 = _909 > 0.0f;
                        float _1600 = 0.0f;
                        float _1601 = 0.0f;
                        if (_1521)
                        {
                            float _1526 = sqrt(mad(-_909, _909, 1.0f));
                            float _1527 = 2.0f * _1511;
                            float _1528 = -_1513;
                            float _1529 = mad(_1527, _1512, _1528);
                            float _1598 = 0.0f;
                            float _1599 = 0.0f;
                            if (_1529 >= _1526)
                            {
                                _1598 = 1.0f;
                                _1599 = abs(_1512);
                            }
                            else
                            {
                                float _1534 = -_1529;
                                float _1537 = _909 * rsqrt(mad(_1534, _1529, 1.0f));
                                float _1538 = mad(_1534, _1511, _1512);
                                float _1542 = mad(_1534, _1513, mad(2.0f * _1512, _1512, -1.0f));
                                float _1553 = _1537 * sqrt(clamp(mad(_1527 * _1512, _1513, mad(_1528, _1513, mad(-_1512, _1512, mad(-_1511, _1511, 1.0f)))), 0.0f, 1.0f));
                                float _1555 = (_1553 * 2.0f) * _1512;
                                float _1556 = mad(_1511, _1526, _1512);
                                float _1557 = mad(_1537, _1538, _1556);
                                float _1559 = mad(_1537, _1542, mad(_1513, _1526, 1.0f));
                                float _1560 = _1553 * _1559;
                                float _1561 = _1557 * _1559;
                                float _1566 = _1561 * mad(-0.5f, _1560, (0.25f * _1555) * _1557);
                                float _1576 = mad(_1557, mad(_1556, _1559 * _1559, _1561 * mad(-0.5f, mad(_1513, _1526, _1559), -0.5f)), mad(_1560, _1560, (_1555 * _1557) * mad(_1555, _1557, _1560 * (-2.0f))));
                                float _1580 = (2.0f * _1566) / mad(_1576, _1576, _1566 * _1566);
                                float _1581 = _1580 * _1576;
                                float _1583 = mad(-_1580, _1566, 1.0f);
                                float _1589 = mad(_1513, _1526, mad(_1583, _1537 * _1542, _1581 * _1555));
                                float _1591 = rsqrt(mad(2.0f, _1589, 2.0f));
                                _1598 = clamp((mad(_1511, _1526, mad(_1583, _1537 * _1538, _1581 * _1553)) + _1512) * _1591, 0.0f, 1.0f);
                                _1599 = clamp(mad(_1591, _1589, _1591), 0.0f, 1.0f);
                            }
                            _1600 = _1598;
                            _1601 = _1599;
                        }
                        else
                        {
                            _1600 = clamp((_1511 + _1512) * _1515, 0.0f, 1.0f);
                            _1601 = clamp(mad(_1515, _1513, _1515), 0.0f, 1.0f);
                        }
                        float _1604 = clamp(abs(_1512) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _1607 = 1.0f.xxx * (_884 * _883);
                        float3 _1691 = 0.0f.xxx;
                        if ((_918 & 1u) == 1u)
                        {
                            _1691 = 0.0f.xxx;
                        }
                        else
                        {
                            float _1614 = _836 * _836;
                            float _1624 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _1624 = clamp(mad(_1614, _1614, (_911 * _911) / mad(_1601, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1624 = _1614 * _1614;
                            }
                            float _1638 = 0.0f;
                            float _1639 = 0.0f;
                            if (_1521)
                            {
                                float _1636 = _1624 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_1624) >> 1)), _909)) / (_1601 + 0.001000000047497451305389404296875f));
                                _1638 = _1624 / _1636;
                                _1639 = _1636;
                            }
                            else
                            {
                                _1638 = 1.0f;
                                _1639 = _1624;
                            }
                            float _1660 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _1646 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _1660 = _1638 * sqrt(_1639 / (_1639 + (((0.25f * _1646) * mad(3.0f, asfloat(532487669 + (asint(_1639) >> 1)), _1646)) / (_1601 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1660 = _1638;
                            }
                            float _1663 = mad(mad(_1600, _1624, -_1600), _1600, 1.0f);
                            float _1668 = sqrt(_1624);
                            float _1669 = 1.0f - _1668;
                            float _1675 = 1.0f - _1601;
                            float _1676 = _1675 * _1675;
                            float _1677 = _1676 * _1676;
                            _1691 = _1607 * (((clamp(50.0f * _369.y, 0.0f, 1.0f) * (_1677 * _1675)).xxx + (_369 * mad(-_1677, _1675, 1.0f))) * (((_1624 / ((3.1415927410125732421875f * _1663) * _1663)) * _1660) * (0.5f / mad(_883, mad(_1604, _1669, _1668), _1604 * mad(_883, _1669, _1668)))));
                        }
                        float3 _1693 = _312.xyz;
                        float _1699 = clamp(-_1513, 0.0f, 1.0f);
                        float _1702 = mad(mad(_1699, 0.36000001430511474609375f, -_1699), _1699, 1.0f);
                        _2994 = ((_362 * 0.3183098733425140380859375f) * _1607) * 1.0f;
                        _2995 = _1691;
                        _2996 = (1.0f.xxx * ((_884 * clamp((0.5f - _1511) * 0.4444444477558135986328125f, 0.0f, 1.0f)) * (0.36000001430511474609375f / ((3.1415927410125732421875f * _1702) * _1702)))) * (_1693 * _1693);
                        break;
                    }
                    case 7u:
                    {
                        float _1332 = clamp(_836, 0.0039215688593685626983642578125f, 1.0f);
                        float _1333 = isnan(1.0f) ? 1.0f : (isnan(1.0f) ? 1.0f : min(1.0f, 1.0f));
                        float _1334 = dot(_498, _903);
                        float _1335 = dot(_322, _903);
                        float _1336 = clamp(_1335, -1.0f, 1.0f);
                        float _1338 = clamp(dot(_322, _498), -1.0f, 1.0f);
                        float _1339 = abs(_1338);
                        float _1340 = mad(-0.15658299624919891357421875f, _1339, 1.57079637050628662109375f);
                        float _1342 = sqrt(1.0f - _1339);
                        float _1349 = abs(_1336);
                        float _1350 = mad(-0.15658299624919891357421875f, _1349, 1.57079637050628662109375f);
                        float _1352 = sqrt(1.0f - _1349);
                        float _1362 = cos(0.5f * abs((1.57079637050628662109375f - ((_1338 >= 0.0f) ? (_1340 * _1342) : mad(-_1340, _1342, 3.1415927410125732421875f))) - (1.57079637050628662109375f - ((_1336 >= 0.0f) ? (_1350 * _1352) : mad(-_1350, _1352, 3.1415927410125732421875f)))));
                        float3 _1364 = _903 - (_322 * _1336);
                        float3 _1366 = _498 - (_322 * _1338);
                        float _1372 = dot(_1364, _1366) * rsqrt(mad(dot(_1364, _1364), dot(_1366, _1366), 9.9999997473787516355514526367188e-05f));
                        float _1375 = sqrt(clamp(mad(0.5f, _1372, 0.5f), 0.0f, 1.0f));
                        float _1378 = _1332 * _1332;
                        float _1379 = _1378 * 0.5f;
                        float _1380 = _1378 * 2.0f;
                        float _1388 = _1378 * (1.41421353816986083984375f * _1375);
                        float _1389 = _1336 + _1338;
                        float _1390 = mad(0.1398856937885284423828125f, mad(0.997551023960113525390625f * _1375, sqrt(mad(-_1338, _1338, 1.0f)), (-0.06994284689426422119140625f) * _1338), _1389);
                        float _1402 = 1.0f - sqrt(clamp(mad(0.5f, _1334, 0.5f), 0.0f, 1.0f));
                        float _1403 = _1402 * _1402;
                        float _1416 = _1389 - 0.0350000001490116119384765625f;
                        float _1424 = 1.0f / mad(0.36000001430511474609375f, _1362, 1.190000057220458984375f / _1362);
                        float _1427 = _1375 * mad(_1424, mad(-0.800000011920928955078125f, _1372, 0.60000002384185791015625f), 1.0f);
                        float _1432 = -_1362;
                        float _1433 = mad(_1432, sqrt(clamp(mad(-_1427, _1427, 1.0f), 0.0f, 1.0f)), 1.0f);
                        float _1434 = _1433 * _1433;
                        float _1438 = 1.0f - mad(0.95347940921783447265625f, (_1434 * _1434) * _1433, 0.0465205647051334381103515625f);
                        float3 _1440 = abs(_353);
                        float _1441 = _1427 * _1424;
                        float _1456 = _1389 - 0.14000000059604644775390625f;
                        float _1464 = mad(_1432, 0.5f, 1.0f);
                        float _1465 = _1464 * _1464;
                        float _1468 = mad(0.95347940921783447265625f, (_1465 * _1465) * _1464, 0.0465205647051334381103515625f);
                        float _1469 = 1.0f - _1468;
                        float3 _1481 = (((((((exp(((-0.5f) * (_1390 * _1390)) / (_1388 * _1388)) / (2.5066282749176025390625f * _1388)) * (0.25f * _1375)) * mad(0.95347940921783447265625f, (_1403 * _1403) * _1402, 0.0465205647051334381103515625f)) * (_354 * 2.0f)) * lerp(1.0f, _1333, clamp(-_1334, 0.0f, 1.0f))).xxx + ((pow(_1440, ((0.5f * sqrt(mad(-_1441, _1441, 1.0f))) / _1362).xxx) * (((exp(((-0.5f) * (_1416 * _1416)) / (_1379 * _1379)) / (_1378 * 1.25331413745880126953125f)) * exp(mad(-3.650000095367431640625f, _1372, -3.980000019073486328125f))) * (_1438 * _1438))) * _1333)) + (pow(_1440, (0.800000011920928955078125f / _1362).xxx) * (((exp(((-0.5f) * (_1456 * _1456)) / (_1380 * _1380)) / (_1378 * 5.013256549835205078125f)) * exp(mad(17.0f, _1372, -16.7800006866455078125f))) * ((_1469 * _1469) * _1468)))) * _825;
                        float _1495 = dot(_353, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                        float3 _1506 = -mad(sqrt(_1440) * ((0.3183098733425140380859375f * lerp(clamp((dot(normalize(_498 - (_322 * dot(_498, _322))), _903) + 1.0f) * 0.25f, 0.0f, 1.0f), 1.0f - abs(_1335), 0.3300000131130218505859375f)) * _324), pow(abs(_353 / (isnan(9.9999997473787516355514526367188e-05f) ? _1495 : (isnan(_1495) ? 9.9999997473787516355514526367188e-05f : max(_1495, 9.9999997473787516355514526367188e-05f))).xxx), (1.0f - _824).xxx), _1481);
                        bool3 _3247 = isnan(_1506);
                        bool3 _3248 = isnan(0.0f.xxx);
                        float3 _3249 = min(_1506, 0.0f.xxx);
                        float3 _3250 = float3(_3247.x ? 0.0f.xxx.x : _3249.x, _3247.y ? 0.0f.xxx.y : _3249.y, _3247.z ? 0.0f.xxx.z : _3249.z);
                        _2994 = 0.0f.xxx;
                        _2995 = 0.0f.xxx;
                        _2996 = (1.0f.xxx * _884) * (-float3(_3248.x ? _1506.x : _3250.x, _3248.y ? _1506.y : _3250.y, _3248.z ? _1506.z : _3250.z));
                        break;
                    }
                    case 8u:
                    {
                        float3 _1108 = _312.xyz;
                        float3 _1109 = _1108 * _1108;
                        float _1110 = clamp(_530, 0.0f, 1.0f);
                        float _1111 = dot(_322, _903);
                        float _1112 = dot(_322, _498);
                        float _1113 = dot(_498, _903);
                        float _1115 = rsqrt(mad(2.0f, _1113, 2.0f));
                        bool _1121 = _909 > 0.0f;
                        float _1200 = 0.0f;
                        float _1201 = 0.0f;
                        if (_1121)
                        {
                            float _1126 = sqrt(mad(-_909, _909, 1.0f));
                            float _1127 = 2.0f * _1111;
                            float _1128 = -_1113;
                            float _1129 = mad(_1127, _1112, _1128);
                            float _1198 = 0.0f;
                            float _1199 = 0.0f;
                            if (_1129 >= _1126)
                            {
                                _1198 = 1.0f;
                                _1199 = abs(_1112);
                            }
                            else
                            {
                                float _1134 = -_1129;
                                float _1137 = _909 * rsqrt(mad(_1134, _1129, 1.0f));
                                float _1138 = mad(_1134, _1111, _1112);
                                float _1142 = mad(_1134, _1113, mad(2.0f * _1112, _1112, -1.0f));
                                float _1153 = _1137 * sqrt(clamp(mad(_1127 * _1112, _1113, mad(_1128, _1113, mad(-_1112, _1112, mad(-_1111, _1111, 1.0f)))), 0.0f, 1.0f));
                                float _1155 = (_1153 * 2.0f) * _1112;
                                float _1156 = mad(_1111, _1126, _1112);
                                float _1157 = mad(_1137, _1138, _1156);
                                float _1159 = mad(_1137, _1142, mad(_1113, _1126, 1.0f));
                                float _1160 = _1153 * _1159;
                                float _1161 = _1157 * _1159;
                                float _1166 = _1161 * mad(-0.5f, _1160, (0.25f * _1155) * _1157);
                                float _1176 = mad(_1157, mad(_1156, _1159 * _1159, _1161 * mad(-0.5f, mad(_1113, _1126, _1159), -0.5f)), mad(_1160, _1160, (_1155 * _1157) * mad(_1155, _1157, _1160 * (-2.0f))));
                                float _1180 = (2.0f * _1166) / mad(_1176, _1176, _1166 * _1166);
                                float _1181 = _1180 * _1176;
                                float _1183 = mad(-_1180, _1166, 1.0f);
                                float _1189 = mad(_1113, _1126, mad(_1183, _1137 * _1142, _1181 * _1155));
                                float _1191 = rsqrt(mad(2.0f, _1189, 2.0f));
                                _1198 = clamp((mad(_1111, _1126, mad(_1183, _1137 * _1138, _1181 * _1153)) + _1112) * _1191, 0.0f, 1.0f);
                                _1199 = clamp(mad(_1191, _1189, _1191), 0.0f, 1.0f);
                            }
                            _1200 = _1198;
                            _1201 = _1199;
                        }
                        else
                        {
                            _1200 = clamp((_1111 + _1112) * _1115, 0.0f, 1.0f);
                            _1201 = clamp(mad(_1115, _1113, _1115), 0.0f, 1.0f);
                        }
                        float _1204 = clamp(abs(_1112) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        float3 _1289 = 0.0f.xxx;
                        if ((_918 & 1u) == 1u)
                        {
                            _1289 = 0.0f.xxx;
                        }
                        else
                        {
                            float _1212 = _836 * _836;
                            float _1222 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _1222 = clamp(mad(_1212, _1212, (_911 * _911) / mad(_1201, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1222 = _1212 * _1212;
                            }
                            float _1236 = 0.0f;
                            float _1237 = 0.0f;
                            if (_1121)
                            {
                                float _1234 = _1222 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_1222) >> 1)), _909)) / (_1201 + 0.001000000047497451305389404296875f));
                                _1236 = _1222 / _1234;
                                _1237 = _1234;
                            }
                            else
                            {
                                _1236 = 1.0f;
                                _1237 = _1222;
                            }
                            float _1258 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _1244 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _1258 = _1236 * sqrt(_1237 / (_1237 + (((0.25f * _1244) * mad(3.0f, asfloat(532487669 + (asint(_1237) >> 1)), _1244)) / (_1201 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1258 = _1236;
                            }
                            float _1261 = mad(mad(_1200, _1222, -_1200), _1200, 1.0f);
                            float _1266 = sqrt(_1222);
                            float _1267 = 1.0f - _1266;
                            float _1273 = 1.0f - _1201;
                            float _1274 = _1273 * _1273;
                            float _1275 = _1274 * _1274;
                            _1289 = (1.0f.xxx * (_884 * _883)) * (((clamp(50.0f * _369.y, 0.0f, 1.0f) * (_1275 * _1273)).xxx + (_369 * mad(-_1275, _1273, 1.0f))) * (((_1222 / ((3.1415927410125732421875f * _1261) * _1261)) * _1258) * (0.5f / mad(_883, mad(_1204, _1267, _1266), _1204 * mad(_883, _1267, _1266)))));
                        }
                        float _1290 = _836 * _836;
                        float _1291 = _1290 * _1290;
                        float _1294 = mad(mad(-_1291, _1200, _1200), _1200, _1291);
                        float _1307 = 1.0f - _1201;
                        float _1308 = _1307 * _1307;
                        float _1309 = _1308 * _1308;
                        float3 _1321 = 1.0f.xxx * (_884 * _883);
                        _2994 = (_1321 * (_362 * 0.3183098733425140380859375f)) * lerp(1.0f, 1.0f, _1110);
                        _2995 = lerp(_1289, ((_1321 * (((0.3183098733425140380859375f / mad(4.0f, _1291, 1.0f)) * (1.0f + (((4.0f * _1291) * _1291) / (_1294 * _1294)))) * (0.25f / mad(-_883, _1204, _883 + _1204)))) * ((clamp(50.0f * _1109.y, 0.0f, 1.0f) * (_1309 * _1307)).xxx + (_1109 * mad(-_1309, _1307, 1.0f)))) * 1.0f, _1110.xxx);
                        _2996 = 0.0f.xxx;
                        break;
                    }
                    case 9u:
                    {
                        float2 _934 = (_312.yz * 2.0f) - 1.0f.xx;
                        float _936 = dot(1.0f.xx, abs(_934));
                        float3 _940 = float3(_934, 1.0f - _936);
                        float _941 = _936 - 1.0f;
                        float _942 = isnan(0.0f) ? _941 : (isnan(_941) ? 0.0f : max(_941, 0.0f));
                        float2 _943 = _940.xy;
                        bool2 _944 = bool2(_943.x >= 0.0f.xx.x, _943.y >= 0.0f.xx.y);
                        float _945 = -_942;
                        float2 _951 = _943 + float2(_944.x ? _945 : _942, _944.y ? _945 : _942);
                        float3 _953 = normalize(float3(_951.x, _951.y, _940.z));
                        float _954 = 1.0f - _530;
                        float _960 = dot(_322, _903);
                        float _961 = dot(_322, _498);
                        float _962 = dot(_498, _903);
                        float _964 = rsqrt(mad(2.0f, _962, 2.0f));
                        bool _970 = _909 > 0.0f;
                        float _1005 = 0.0f;
                        float _1006 = 0.0f;
                        if (_970)
                        {
                            float _975 = sqrt(mad(-_909, _909, 1.0f));
                            float _978 = mad(2.0f * _960, _961, -_962);
                            float _1003 = 0.0f;
                            float _1004 = 0.0f;
                            if (_978 >= _975)
                            {
                                _1003 = 1.0f;
                                _1004 = abs(_961);
                            }
                            else
                            {
                                float _983 = -_978;
                                float _986 = _909 * rsqrt(mad(_983, _978, 1.0f));
                                float _994 = mad(_962, _975, _986 * mad(_983, _962, mad(2.0f * _961, _961, -1.0f)));
                                float _996 = rsqrt(mad(2.0f, _994, 2.0f));
                                _1003 = clamp((mad(_960, _975, _986 * mad(_983, _960, _961)) + _961) * _996, 0.0f, 1.0f);
                                _1004 = clamp(mad(_996, _994, _996), 0.0f, 1.0f);
                            }
                            _1005 = _1003;
                            _1006 = _1004;
                        }
                        else
                        {
                            _1005 = clamp((_960 + _961) * _964, 0.0f, 1.0f);
                            _1006 = clamp(mad(_964, _962, _964), 0.0f, 1.0f);
                        }
                        float _1009 = clamp(abs(_961) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                        bool _1011 = (_918 & 1u) == 1u;
                        float _1012 = _1011 ? _1009 : _1006;
                        float _1014 = 1.0f - _1012;
                        float _1015 = _1014 * _1014;
                        float _1016 = _1015 * _1015;
                        float _1020 = mad(_1016, _1014, mad(-_1016, _1014, 1.0f) * (_354 * 0.07999999821186065673828125f));
                        float3 _1090 = 0.0f.xxx;
                        if (_1011)
                        {
                            _1090 = 0.0f.xxx;
                        }
                        else
                        {
                            float _1024 = _836 * _836;
                            float _1034 = 0.0f;
                            if (_911 > 0.0f)
                            {
                                _1034 = clamp(mad(_1024, _1024, (_911 * _911) / mad(_1012, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1034 = _1024 * _1024;
                            }
                            float _1048 = 0.0f;
                            float _1049 = 0.0f;
                            if (_970)
                            {
                                float _1046 = _1034 + (((0.25f * _909) * mad(3.0f, asfloat(532487669 + (asint(_1034) >> 1)), _909)) / (_1012 + 0.001000000047497451305389404296875f));
                                _1048 = _1034 / _1046;
                                _1049 = _1046;
                            }
                            else
                            {
                                _1048 = 1.0f;
                                _1049 = _1034;
                            }
                            float _1070 = 0.0f;
                            if (_862 < 1.0f)
                            {
                                float _1056 = sqrt((1.00010001659393310546875f - _862) / (1.0f + _862));
                                _1070 = _1048 * sqrt(_1049 / (_1049 + (((0.25f * _1056) * mad(3.0f, asfloat(532487669 + (asint(_1049) >> 1)), _1056)) / (_1012 + 0.001000000047497451305389404296875f))));
                            }
                            else
                            {
                                _1070 = _1048;
                            }
                            float _1071 = sqrt(_1034);
                            float _1072 = 1.0f - _1071;
                            float _1080 = mad(mad(_1005, _1034, -_1005), _1005, 1.0f);
                            _1090 = (((1.0f.xxx * (_884 * _883)) * ((_1034 / ((3.1415927410125732421875f * _1080) * _1080)) * _1070)) * (0.5f / mad(_883, mad(_1009, _1072, _1071), _1009 * mad(_883, _1072, _1071)))) * _1020;
                        }
                        float _1092 = clamp(dot(_953, _903), 0.0f, 1.0f);
                        float _1093 = lerp(12.0f, 1.0f, _1092);
                        _2994 = 0.0f.xxx;
                        _2995 = _1090;
                        _2996 = (1.0f.xxx * ((_884 * lerp(_883, _1092 * mad(0.20000000298023223876953125f * (_1093 + 1.0f), pow(clamp(dot(normalize(lerp(_953, -_322, (_954 * _259).xxx)), _903), 0.0f, 1.0f), _1093), 0.800000011920928955078125f), _954)) * (1.0f - _1020))) * (_362 * 0.3183098733425140380859375f);
                        break;
                    }
                    default:
                    {
                        _2994 = 0.0f.xxx;
                        _2995 = 0.0f.xxx;
                        _2996 = 0.0f.xxx;
                        break;
                    }
                }
                float3 _2998 = _526 * _825;
                float _3009 = 0.0f;
                if (_329)
                {
                    float _3008 = 0.0f;
                    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                    {
                        _3008 = dot(_2994 * _2998, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    }
                    else
                    {
                        _3008 = 0.0f;
                    }
                    _3009 = _3008;
                }
                else
                {
                    _3009 = 0.0f;
                }
                float3 _3011 = _526 * _824;
                float _3023 = 0.0f;
                if (_329)
                {
                    float _3022 = 0.0f;
                    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                    {
                        _3022 = _3009 + dot(_2996 * _3011, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    }
                    else
                    {
                        _3022 = _3009;
                    }
                    _3023 = _3022;
                }
                else
                {
                    _3023 = _3009;
                }
                _3026 = _3023;
                _3027 = mad(_2994, _2998, _2996 * _3011);
                _3028 = (_2995 * DeferredLightUniforms_DeferredLightUniforms_SpecularScale) * _2998;
            }
            else
            {
                _3026 = 0.0f;
                _3027 = 0.0f.xxx;
                _3028 = 0.0f.xxx;
            }
            _3029 = _3026;
            _3030 = _3027;
            _3031 = _3028;
        }
        else
        {
            _3029 = 0.0f;
            _3030 = 0.0f.xxx;
            _3031 = 0.0f.xxx;
        }
        float4 _3035 = float4(_3030, 0.0f);
        float4 _3046 = 0.0f.xxxx;
        if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
        {
            float4 _3045 = _3035;
            _3045.w = _3029;
            _3046 = _3045;
        }
        else
        {
            _3046 = _3035;
        }
        _3048 = float4(_3031, 0.0f) + _3046;
    }
    else
    {
        _3048 = 0.0f.xxxx;
    }
    out_var_SV_Target0 = _3048 * View_View_PreExposure;
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

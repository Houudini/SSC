#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float3x3 _196 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);
static float2 _197 = 0.0f.xx;
static float4 _198 = 0.0f.xxxx;
static float _199 = 0.0f;

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
    float View_View_bSubsurfacePostprocessEnabled : packoffset(c247.w);
    float4 View_View_SSProfilesTextureSizeAndInvSize : packoffset(c248);
    float View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : packoffset(c284.w);
    float4 View_View_RectLightAtlasSizeAndInvSize : packoffset(c326);
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
    float DeferredLightUniforms_DeferredLightUniforms_SourceLength : packoffset(c7.w);
    float DeferredLightUniforms_DeferredLightUniforms_RectLightBarnCosAngle : packoffset(c8);
    float DeferredLightUniforms_DeferredLightUniforms_RectLightBarnLength : packoffset(c8.y);
    float2 DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset : packoffset(c8.z);
    float2 DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale : packoffset(c9);
    float DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : packoffset(c9.z);
};

SamplerState View_SharedTrilinearClampedSampler;
Texture2D<float4> View_PreIntegratedBRDF;
SamplerState View_PreIntegratedBRDFSampler;
Texture2D<float4> View_LTCMatTexture;
SamplerState View_LTCMatSampler;
Texture2D<float4> View_LTCAmpTexture;
SamplerState View_LTCAmpSampler;
Texture2D<float4> View_SSProfilesTexture;
SamplerState View_SSProfilesTransmissionSampler;
Texture2D<float4> View_RectLightAtlasTexture;
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
    float2 _215 = in_var_TEXCOORD0.xy / in_var_TEXCOORD0.w.xx;
    float2 _220 = mad(_215, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz);
    float4 _224 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
    float _225 = _224.x;
    float _235 = -View_View_InvDeviceZToWorldZTransform.w;
    float4 _241 = SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
    float4 _244 = SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
    float4 _247 = SceneTexturesStruct_GBufferCTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
    float4 _250 = SceneTexturesStruct_GBufferDTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
    float4 _253 = SceneTexturesStruct_GBufferETexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
    uint2 _258 = uint2(_220 * View_View_BufferSizeAndInvSize.xy);
    bool _267 = (((_258.x + _258.y) + uint(View_View_TemporalAAParams.x)) % 2u) != 0u;
    float3 _269 = 0.0f.xxx;
    _269.x = _241.x;
    _269.y = _241.y;
    _269.z = _241.z;
    float _274 = _244.x;
    float _275 = _244.y;
    float _276 = _244.z;
    uint _279 = uint(mad(_244.w, 255.0f, 0.5f));
    uint _282 = ((_279 >> 0u) & 15u) << 0u;
    uint _285 = ((_279 >> 4u) & 15u) << 0u;
    float3 _287 = 0.0f.xxx;
    _287.x = _247.x;
    _287.y = _247.y;
    _287.z = _247.z;
    float4 _293 = 0.0f.xxxx;
    _293.x = _253.x;
    _293.y = _253.y;
    _293.z = _253.z;
    _293.w = _253.w;
    float4 _301 = 0.0f.xxxx;
    _301.x = _250.x;
    _301.y = _250.y;
    _301.z = _250.z;
    _301.w = _250.w;
    int _310 = int(_282);
    bool _313 = (_310 == 2) || (_310 == 3);
    bool _316 = _310 == 5;
    bool _318 = _310 == 6;
    bool _320 = _310 == 7;
    bool _324 = _310 == 9;
    bool4 _326 = ((((((_313 || (_310 == 4)) || _316) || _318) || _320) || (_310 == 8)) || _324).xxxx;
    float4 _327 = float4(_326.x ? _301.x : 0.0f.xxxx.x, _326.y ? _301.y : 0.0f.xxxx.y, _326.z ? _301.z : 0.0f.xxxx.z, _326.w ? _301.w : 0.0f.xxxx.w);
    bool4 _331 = (!((_285 & 2u) != 0u)).xxxx;
    float4 _335 = (((_285 & 4u) != 0u) ? 0.0f : 1.0f).xxxx;
    float3 _337 = normalize((_269 * 2.0f) - 1.0f.xxx);
    bool _338 = _282 == 9u;
    float _339 = _338 ? 0.0f : _274;
    float3 _342 = _339.xxx;
    float3 _343 = lerp((0.07999999821186065673828125f * _275).xxx, _287, _342);
    bool _344 = _316 || _324;
    float3 _368 = 0.0f.xxx;
    float _369 = 0.0f;
    float3 _370 = 0.0f.xxx;
    if (_344)
    {
        bool3 _355 = (View_View_bSubsurfacePostprocessEnabled != 0.0f).xxx;
        float3 _365 = 0.0f.xxx;
        float _366 = 0.0f;
        float3 _367 = 0.0f.xxx;
        if ((View_View_bSubsurfacePostprocessEnabled > 0.0f) && (View_View_bCheckerboardSubsurfaceProfileRendering > 0.0f))
        {
            float _362 = float(!_267);
            _365 = float(_267).xxx;
            _366 = _275 * _362;
            _367 = _343 * _362;
        }
        else
        {
            _365 = float3(_355.x ? 1.0f.xxx.x : _287.x, _355.y ? 1.0f.xxx.y : _287.y, _355.z ? 1.0f.xxx.z : _287.z);
            _366 = _275;
            _367 = _343;
        }
        _368 = _365;
        _369 = _366;
        _370 = _367;
    }
    else
    {
        _368 = _287;
        _369 = _275;
        _370 = _343;
    }
    float3 _377 = mad(_368 - (_368 * _339), View_View_DiffuseOverrideParameter.www, View_View_DiffuseOverrideParameter.xyz);
    float3 _384 = (_370 * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    float4 _3561 = 0.0f.xxxx;
    [branch]
    if (_282 > 0u)
    {
        float4 _393 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f);
        float _394 = _393.x;
        float _398 = mad(_394, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_394, View_View_InvDeviceZToWorldZTransform.z, _235));
        float4 _410 = mul(float4(_215 * ((View_View_ViewToClip[3u].w < 1.0f) ? _398 : 1.0f), _398, 1.0f), View_View_ScreenToTranslatedWorld);
        float3 _411 = _410.xyz;
        float3 _415 = normalize(_411 - View_View_TranslatedWorldCameraOrigin);
        float _436 = abs(DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength);
        float4 _470 = LightAttenuationTexture.SampleLevel(LightAttenuationTextureSampler, _220, 0.0f);
        float4 _471 = _470 * _470;
        float3 _472 = -_415;
        float3 _473 = DeferredLightUniforms_DeferredLightUniforms_TranslatedWorldPosition - _411;
        float _474 = dot(_473, _473);
        float3 _476 = _473 * rsqrt(_474);
        float _491 = 0.0f;
        if (true && (DeferredLightUniforms_DeferredLightUniforms_FalloffExponent == 0.0f))
        {
            float _486 = _474 * (DeferredLightUniforms_DeferredLightUniforms_InvRadius * DeferredLightUniforms_DeferredLightUniforms_InvRadius);
            float _489 = clamp(mad(-_486, _486, 1.0f), 0.0f, 1.0f);
            _491 = _489 * _489;
        }
        else
        {
            float3 _480 = _473 * DeferredLightUniforms_DeferredLightUniforms_InvRadius;
            _491 = pow(1.0f - clamp(dot(_480, _480), 0.0f, 1.0f), DeferredLightUniforms_DeferredLightUniforms_FalloffExponent);
        }
        float _494 = (dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _476) < 0.0f) ? 0.0f : _491;
        float3 _495 = DeferredLightUniforms_DeferredLightUniforms_Color * _494;
        float _3542 = 0.0f;
        float3 _3543 = 0.0f.xxx;
        float3 _3544 = 0.0f.xxx;
        [branch]
        if (_494 > 0.0f)
        {
            float _499 = _327.w;
            float _502 = View_View_ClipToView[1u].y * (mad(_225, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_225, View_View_InvDeviceZToWorldZTransform.z, _235)));
            float _521 = 0.0f;
            float _522 = 0.0f;
            float _523 = 0.0f;
            float _524 = 0.0f;
            [branch]
            if (DeferredLightUniforms_DeferredLightUniforms_ShadowedBits != 0u)
            {
                float _508 = lerp(1.0f, dot(float4(_331.x ? _293.x : _335.x, _331.y ? _293.y : _335.y, _331.z ? _293.z : _335.z, _331.w ? _293.w : _335.w), DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask), dot(DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask, 1.0f.xxxx));
                float _511 = _471.w;
                float _520 = 0.0f;
                [flatten]
                if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits > 1u) && (_436 > 0.0f))
                {
                    _520 = _436 * ((DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength < 0.0f) ? 1.0f : _502);
                }
                else
                {
                    _520 = 0.0f;
                }
                _521 = _511;
                _522 = _511 * _508;
                _523 = _471.z * _508;
                _524 = _520;
            }
            else
            {
                _521 = 1.0f;
                _522 = 1.0f;
                _523 = SceneTexturesStruct_ScreenSpaceAOTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _220, 0.0f).x;
                _524 = 0.0f;
            }
            float _531 = 0.0f;
            if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits < 2u) && (_282 == 7u))
            {
                _531 = 0.20000000298023223876953125f * _502;
            }
            else
            {
                _531 = _524;
            }
            float _532 = _338 ? 0.5f : _531;
            float _793 = 0.0f;
            float _794 = 0.0f;
            [branch]
            if (_532 > 0.0f)
            {
                float4 _543 = mul(float4(_410.xyz, 1.0f), View_View_TranslatedWorldToClip);
                float4 _550 = _543 + mul(float4(_476 * _532, 0.0f), View_View_TranslatedWorldToClip);
                float3 _554 = _543.xyz / _543.w.xxx;
                float3 _559 = (_550.xyz / _550.w.xxx) - _554;
                float _562 = _554.z;
                float3 _565 = float3(mad(_554.xy, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz), _562);
                float3 _571 = float3(_559.xy * View_View_ScreenPositionScaleBias.xy, _559.z);
                float4 _575 = _543 + mul(float4(0.0f, 0.0f, _532, 0.0f), View_View_ViewToClip);
                float _582 = abs((_575.xyz / _575.w.xxx).z - _562);
                float _583 = _582 * 0.25f;
                float _584 = mad(frac(52.98291778564453125f * frac(dot(gl_FragCoord.xy + (float2(32.66500091552734375f, 11.81499958038330078125f) * float(View_View_StateFrameIndexMod8)), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f)))) - 0.5f, 0.125f, 0.125f);
                float4 _587 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _565.xy, 0.0f);
                float _588 = _587.x;
                float3 _590 = _565 + (_571 * _584);
                float4 _593 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _590.xy, 0.0f);
                float _594 = _593.x;
                float _603 = (((abs(mad(_582, 0.25f, _590.z - _594)) < _583) && (_594 != _588)) && true) ? _584 : (-1.0f);
                float _604 = _584 + 0.125f;
                float3 _606 = _565 + (_571 * _604);
                float4 _609 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _606.xy, 0.0f);
                float _610 = _609.x;
                float _620 = (((abs(mad(_582, 0.25f, _606.z - _610)) < _583) && (_610 != _588)) && (_603 < 0.0f)) ? _604 : _603;
                float _621 = _584 + 0.25f;
                float3 _623 = _565 + (_571 * _621);
                float4 _626 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _623.xy, 0.0f);
                float _627 = _626.x;
                float _637 = (((abs(mad(_582, 0.25f, _623.z - _627)) < _583) && (_627 != _588)) && (_620 < 0.0f)) ? _621 : _620;
                float _638 = _584 + 0.375f;
                float3 _640 = _565 + (_571 * _638);
                float4 _643 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _640.xy, 0.0f);
                float _644 = _643.x;
                float _654 = (((abs(mad(_582, 0.25f, _640.z - _644)) < _583) && (_644 != _588)) && (_637 < 0.0f)) ? _638 : _637;
                float _655 = _584 + 0.5f;
                float3 _657 = _565 + (_571 * _655);
                float4 _660 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _657.xy, 0.0f);
                float _661 = _660.x;
                float _671 = (((abs(mad(_582, 0.25f, _657.z - _661)) < _583) && (_661 != _588)) && (_654 < 0.0f)) ? _655 : _654;
                float _672 = _584 + 0.625f;
                float3 _674 = _565 + (_571 * _672);
                float4 _677 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _674.xy, 0.0f);
                float _678 = _677.x;
                float _688 = (((abs(mad(_582, 0.25f, _674.z - _678)) < _583) && (_678 != _588)) && (_671 < 0.0f)) ? _672 : _671;
                float _689 = _584 + 0.75f;
                float3 _691 = _565 + (_571 * _689);
                float4 _694 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _691.xy, 0.0f);
                float _695 = _694.x;
                float _705 = (((abs(mad(_582, 0.25f, _691.z - _695)) < _583) && (_695 != _588)) && (_688 < 0.0f)) ? _689 : _688;
                float _706 = _584 + 0.875f;
                float3 _708 = _565 + (_571 * _706);
                float4 _711 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _708.xy, 0.0f);
                float _712 = _711.x;
                float _722 = (((abs(mad(_582, 0.25f, _708.z - _712)) < _583) && (_712 != _588)) && (_705 < 0.0f)) ? _706 : _705;
                bool _758 = false;
                float _759 = 0.0f;
                if (_722 > 0.0f)
                {
                    float2 _728 = (_565 + (_571 * _722)).xy;
                    bool2 _746 = bool2(0.0f.xx.x < _728.x, 0.0f.xx.y < _728.y);
                    bool2 _747 = bool2(_728.x < 1.0f.xx.x, _728.y < 1.0f.xx.y);
                    _758 = ((uint(SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _728, 0.0f).w * 3.999000072479248046875f) & 1u) != 0u) && ((((uint(mad(SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _728, 0.0f).w, 255.0f, 0.5f)) >> 0u) & 15u) << 0u) != 9u);
                    _759 = all(bool2(_746.x && _747.x, _746.y && _747.y)) ? (_722 * _532) : (-1.0f);
                }
                else
                {
                    _758 = false;
                    _759 = -1.0f;
                }
                float _791 = 0.0f;
                float _792 = 0.0f;
                if (_759 > 0.0f)
                {
                    float _763 = _758 ? DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity;
                    float _787 = 0.0f;
                    [branch]
                    if (((((_763 > 0.0f) && ((((_313 || _316) || _318) || _320) || _324)) && (_282 != 7u)) && (_282 != 9u)) && (_282 != 5u))
                    {
                        _787 = _763 * (1.0f - clamp(exp((log(1.0f - (isnan(0.9900000095367431640625f) ? _499 : (isnan(_499) ? 0.9900000095367431640625f : min(_499, 0.9900000095367431640625f)))) * 0.0500000007450580596923828125f) * _759), 0.0f, 1.0f));
                    }
                    else
                    {
                        _787 = _763;
                    }
                    float _788 = 1.0f - _787;
                    _791 = _522 * _788;
                    _792 = _523 * _788;
                }
                else
                {
                    _791 = _522;
                    _792 = _523;
                }
                _793 = _791;
                _794 = _792;
            }
            else
            {
                _793 = _522;
                _794 = _523;
            }
            float _3539 = 0.0f;
            float3 _3540 = 0.0f.xxx;
            float3 _3541 = 0.0f.xxx;
            [branch]
            if ((_794 + _793) > 0.0f)
            {
                float3x3 _799 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);
                _799[1] = DeferredLightUniforms_DeferredLightUniforms_Tangent;
                _799[2] = DeferredLightUniforms_DeferredLightUniforms_Direction;
                float3 _801 = cross(DeferredLightUniforms_DeferredLightUniforms_Tangent, DeferredLightUniforms_DeferredLightUniforms_Direction);
                _799[0] = _801;
                float2 _803 = float2(DeferredLightUniforms_DeferredLightUniforms_SourceRadius, DeferredLightUniforms_DeferredLightUniforms_SourceLength);
                float3 _864 = 0.0f.xxx;
                float2 _865 = 0.0f.xx;
                float2 _866 = 0.0f.xx;
                if (true && (DeferredLightUniforms_DeferredLightUniforms_RectLightBarnCosAngle > 0.0350000001490116119384765625f))
                {
                    float3 _810 = mul(_799, _473);
                    float _814 = _810.z;
                    float _815 = DeferredLightUniforms_DeferredLightUniforms_RectLightBarnCosAngle * DeferredLightUniforms_DeferredLightUniforms_RectLightBarnLength;
                    float _816 = isnan(_815) ? _814 : (isnan(_814) ? _815 : min(_814, _815));
                    float2 _821 = _810.xy;
                    float2 _824 = float2(int2(sign(_821)));
                    float2 _825 = abs(_821);
                    float2 _826 = ((sqrt(mad(-DeferredLightUniforms_DeferredLightUniforms_RectLightBarnCosAngle, DeferredLightUniforms_DeferredLightUniforms_RectLightBarnCosAngle, 1.0f)) * DeferredLightUniforms_DeferredLightUniforms_RectLightBarnLength) * (_816 / (isnan(_815) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? _815 : max(9.9999997473787516355514526367188e-05f, _815))))).xx;
                    float2 _827 = _803 + _826;
                    bool2 _3617 = isnan(_825);
                    bool2 _3618 = isnan(_827);
                    float2 _3619 = max(_825, _827);
                    float2 _3620 = float2(_3617.x ? _827.x : _3619.x, _3617.y ? _827.y : _3619.y);
                    float2 _829 = _824 * float2(_3618.x ? _825.x : _3620.x, _3618.y ? _825.y : _3620.y);
                    float3 _835 = float3(_829.x, _829.y, _810.z) - float3(_824 * _827, _816);
                    float2 _843 = -_803;
                    float2 _844 = ((abs(_835.xy) / (isnan(0.001000000047497451305389404296875f) ? _835.z : (isnan(_835.z) ? 0.001000000047497451305389404296875f : max(_835.z, 0.001000000047497451305389404296875f))).xx) * _816) - _826;
                    float2 _845 = -_824;
                    bool2 _3627 = isnan(0.0f.xx);
                    bool2 _3628 = isnan(_845);
                    float2 _3629 = max(0.0f.xx, _845);
                    float2 _3630 = float2(_3627.x ? _845.x : _3629.x, _3627.y ? _845.y : _3629.y);
                    float2 _848 = clamp(mad(_844, float2(_3628.x ? 0.0f.xx.x : _3630.x, _3628.y ? 0.0f.xx.y : _3630.y), _843), _843, _803);
                    bool2 _3632 = isnan(0.0f.xx);
                    bool2 _3633 = isnan(_824);
                    float2 _3634 = max(0.0f.xx, _824);
                    float2 _3635 = float2(_3632.x ? _824.x : _3634.x, _3632.y ? _824.y : _3634.y);
                    float2 _852 = clamp(mad(-_844, float2(_3633.x ? 0.0f.xx.x : _3635.x, _3633.y ? 0.0f.xx.y : _3635.y), _803), _843, _803);
                    float2 _854 = (_848 + _852) * 0.5f;
                    _864 = (_473 + ((-_801) * _854.x)) + ((-DeferredLightUniforms_DeferredLightUniforms_Tangent) * _854.y);
                    _865 = (_852 - _848) * 0.5f;
                    _866 = -_854;
                }
                else
                {
                    _864 = _473;
                    _865 = _803;
                    _866 = 0.0f.xx;
                }
                float3 _3507 = 0.0f.xxx;
                float3 _3508 = 0.0f.xxx;
                float3 _3509 = 0.0f.xxx;
                if ((_865.x != 0.0f) && (_865.y != 0.0f))
                {
                    float _874 = dot(_801, _864);
                    float _875 = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _864);
                    float _876 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _864);
                    float _877 = _874 - _865.x;
                    float _878 = _874 + _865.x;
                    float _879 = _875 - _865.y;
                    float _880 = _875 + _865.y;
                    float3 _881 = float3(_877, _879, _876);
                    float3 _882 = float3(_878, _879, _876);
                    float3 _883 = float3(_878, _880, _876);
                    float3 _884 = float3(_877, _880, _876);
                    float2 _885 = _881.xy;
                    float3 _889 = _881 * rsqrt(mad(_876, _876, dot(_885, _885)));
                    float2 _890 = _882.xy;
                    float3 _894 = _882 * rsqrt(mad(_876, _876, dot(_890, _890)));
                    float2 _895 = _883.xy;
                    float3 _899 = _883 * rsqrt(mad(_876, _876, dot(_895, _895)));
                    float2 _900 = _884.xy;
                    float3 _904 = _884 * rsqrt(mad(_876, _876, dot(_900, _900)));
                    float _905 = dot(_889, _894);
                    float _906 = dot(_894, _899);
                    float _907 = dot(_899, _904);
                    float _908 = dot(_904, _889);
                    float3 _935 = cross(_894, (_889 * (-(mad(-0.17499999701976776123046875f, _905, 1.57079994678497314453125f) * rsqrt(_905 + 1.0f)))) + (_899 * (mad(-0.17499999701976776123046875f, _906, 1.57079994678497314453125f) * rsqrt(_906 + 1.0f)))) + cross(_904, (_889 * (mad(-0.17499999701976776123046875f, _908, 1.57079994678497314453125f) * rsqrt(_908 + 1.0f))) + (_899 * (-(mad(-0.17499999701976776123046875f, _907, 1.57079994678497314453125f) * rsqrt(_907 + 1.0f)))));
                    float3 _943 = ((_801 * _935.x) + (DeferredLightUniforms_DeferredLightUniforms_Tangent * _935.y)) + (DeferredLightUniforms_DeferredLightUniforms_Direction * _935.z);
                    float _944 = dot(_943, _943);
                    float _945 = rsqrt(_944);
                    float _946 = _944 * _945;
                    float3 _947 = _943 * _945;
                    float _948 = 0.5f * _946;
                    float _950 = dot(_337, _947);
                    float _951 = sqrt(_946 * 0.15915493667125701904296875f);
                    float _961 = 0.0f;
                    if (_950 < _951)
                    {
                        float _955 = -_951;
                        float _957 = _951 + (isnan(_955) ? _950 : (isnan(_950) ? _955 : max(_950, _955)));
                        _961 = (_957 * _957) / (4.0f * _951);
                    }
                    else
                    {
                        _961 = _950;
                    }
                    float3 _966 = _947 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _947), 0.0f, 1.0f));
                    float _968 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _966);
                    float3 _970 = (_966 * _968) - _864;
                    float2 _972 = 0.0f.xx;
                    _972.x = dot(_801, _970);
                    _972.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _970);
                    bool2 _3647 = isnan(9.9999997473787516355514526367188e-05f.xx);
                    bool2 _3648 = isnan(_803);
                    float2 _3649 = max(9.9999997473787516355514526367188e-05f.xx, _803);
                    float2 _3650 = float2(_3647.x ? _803.x : _3649.x, _3647.y ? _803.y : _3649.y);
                    float2 _976 = float2(_3648.x ? 9.9999997473787516355514526367188e-05f.xx.x : _3650.x, _3648.y ? 9.9999997473787516355514526367188e-05f.xx.y : _3650.y);
                    float _979 = DeferredLightUniforms_DeferredLightUniforms_SourceRadius * DeferredLightUniforms_DeferredLightUniforms_SourceLength;
                    float _981 = rsqrt(isnan(_979) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? _979 : max(9.9999997473787516355514526367188e-05f, _979)));
                    float2 _988 = DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale * View_View_RectLightAtlasSizeAndInvSize.xy;
                    float _989 = _988.x;
                    float _990 = _988.y;
                    float _993 = log2(isnan(_990) ? _989 : (isnan(_989) ? _990 : min(_989, _990))) - 2.0f;
                    float _994 = log2(_968 * _981) + _993;
                    bool3 _998 = (DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel < 32.0f).xxx;
                    float3 _1003 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_972 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _994 : (isnan(_994) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_994, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                    float3 _1004 = float3(_998.x ? _1003.x : 1.0f.xxx.x, _998.y ? _1003.y : 1.0f.xxx.y, _998.z ? _1003.z : 1.0f.xxx.z);
                    float _1005 = isnan(0.0199999995529651641845703125f) ? _276 : (isnan(_276) ? 0.0199999995529651641845703125f : max(_276, 0.0199999995529651641845703125f));
                    float3 _3504 = 0.0f.xxx;
                    float3 _3505 = 0.0f.xxx;
                    float3 _3506 = 0.0f.xxx;
                    switch (_282)
                    {
                        case 1u:
                        {
                            float3 _3305 = _377 * 0.3183098733425140380859375f;
                            float _3306 = _948 * _961;
                            float3 _3307 = _1004 * _3306;
                            float3 _3308 = _3305 * _3307;
                            float3 _3502 = 0.0f.xxx;
                            do
                            {
                                float3 _3311 = _384 * 50.0f;
                                float3 _3312 = clamp(_3311, 0.0f.xxx, 1.0f.xxx);
                                bool _3313 = _865.x == 0.0f;
                                bool _3314 = _865.y == 0.0f;
                                bool _3315 = _3313 || _3314;
                                if (_3315)
                                {
                                    _3502 = 0.0f.xxx;
                                    break;
                                }
                                float _3318 = dot(_337, _472);
                                float _3319 = abs(_3318);
                                float _3320 = _3319 + 9.9999997473787516355514526367188e-06f;
                                float _3321 = clamp(_3320, 0.0f, 1.0f);
                                float _3322 = 1.0f - _3321;
                                float _3323 = sqrt(_3322);
                                float2 _3324 = float2(_1005, _3323);
                                float2 _3325 = _3324 * 0.984375f;
                                float2 _3326 = _3325 + 0.0078125f.xx;
                                float4 _3330 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _3326, 0.0f);
                                float4 _3334 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _3326, 0.0f);
                                float _3335 = _3330.x;
                                float _3336 = _3330.z;
                                float _3337 = _3330.y;
                                float _3338 = _3330.w;
                                float3 _3339 = float3(_3335, 0.0f, _3336);
                                float3 _3340 = float3(_3337, 0.0f, _3338);
                                float3x3 _3341 = float3x3(_3339, float3(0.0f, 1.0f, 0.0f), _3340);
                                float _3342 = _3337 * _3336;
                                float _3343 = -_3342;
                                float _3344 = mad(_3335, _3338, _3343);
                                float4 _3345 = _3344.xxxx;
                                float4 _3346 = _3330 / _3345;
                                float _3347 = _3346.w;
                                float _3348 = _3346.z;
                                float _3349 = -_3348;
                                float _3350 = _3346.y;
                                float _3351 = -_3350;
                                float _3352 = _3346.x;
                                float3 _3353 = float3(_3347, 0.0f, _3349);
                                float3 _3354 = float3(_3351, 0.0f, _3352);
                                float3x3 _3355 = float3x3(_3353, float3(0.0f, 1.0f, 0.0f), _3354);
                                float3 _3356 = _337 * _3318;
                                float3 _3357 = _472 - _3356;
                                float3 _3358 = normalize(_3357);
                                float3 _3359 = cross(_337, _3358);
                                float3x3 _3360 = float3x3(_3358, _3359, _337);
                                float3x3 _3361 = mul(_3341, _3360);
                                float3x3 _3362 = transpose(_3360);
                                float3x3 _3363 = mul(_3362, _3355);
                                float3 _3364 = _801 * _865.x;
                                float3 _3365 = _864 - _3364;
                                float3 _3366 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _3367 = _3365 - _3366;
                                float3 _3368 = mul(_3361, _3367);
                                float3 _3369 = _864 + _3364;
                                float3 _3370 = _3369 - _3366;
                                float3 _3371 = mul(_3361, _3370);
                                float3 _3372 = _3369 + _3366;
                                float3 _3373 = mul(_3361, _3372);
                                float3 _3374 = _3365 + _3366;
                                float3 _3375 = mul(_3361, _3374);
                                float3 _3376 = normalize(_3368);
                                float3 _3377 = normalize(_3371);
                                float3 _3378 = normalize(_3373);
                                float3 _3379 = normalize(_3375);
                                float _3380 = dot(_3376, _3377);
                                float _3381 = abs(_3380);
                                float _3382 = mad(0.01452060043811798095703125f, _3381, 0.4965155124664306640625f);
                                float _3383 = mad(_3382, _3381, 0.8543984889984130859375f);
                                float _3384 = 4.1616725921630859375f + _3381;
                                float _3385 = mad(_3384, _3381, 3.41759395599365234375f);
                                float _3386 = _3383 / _3385;
                                bool _3387 = _3380 > 0.0f;
                                float _3388 = -_3380;
                                float _3389 = mad(_3388, _3380, 1.0f);
                                float _3390 = rsqrt(_3389);
                                float _3391 = -_3386;
                                float _3392 = mad(0.5f, _3390, _3391);
                                float _3393 = _3387 ? _3386 : _3392;
                                float _3394 = dot(_3377, _3378);
                                float _3395 = abs(_3394);
                                float _3396 = mad(0.01452060043811798095703125f, _3395, 0.4965155124664306640625f);
                                float _3397 = mad(_3396, _3395, 0.8543984889984130859375f);
                                float _3398 = 4.1616725921630859375f + _3395;
                                float _3399 = mad(_3398, _3395, 3.41759395599365234375f);
                                float _3400 = _3397 / _3399;
                                bool _3401 = _3394 > 0.0f;
                                float _3402 = -_3394;
                                float _3403 = mad(_3402, _3394, 1.0f);
                                float _3404 = rsqrt(_3403);
                                float _3405 = -_3400;
                                float _3406 = mad(0.5f, _3404, _3405);
                                float _3407 = _3401 ? _3400 : _3406;
                                float _3408 = dot(_3378, _3379);
                                float _3409 = abs(_3408);
                                float _3410 = mad(0.01452060043811798095703125f, _3409, 0.4965155124664306640625f);
                                float _3411 = mad(_3410, _3409, 0.8543984889984130859375f);
                                float _3412 = 4.1616725921630859375f + _3409;
                                float _3413 = mad(_3412, _3409, 3.41759395599365234375f);
                                float _3414 = _3411 / _3413;
                                bool _3415 = _3408 > 0.0f;
                                float _3416 = -_3408;
                                float _3417 = mad(_3416, _3408, 1.0f);
                                float _3418 = rsqrt(_3417);
                                float _3419 = -_3414;
                                float _3420 = mad(0.5f, _3418, _3419);
                                float _3421 = _3415 ? _3414 : _3420;
                                float _3422 = dot(_3379, _3376);
                                float _3423 = abs(_3422);
                                float _3424 = mad(0.01452060043811798095703125f, _3423, 0.4965155124664306640625f);
                                float _3425 = mad(_3424, _3423, 0.8543984889984130859375f);
                                float _3426 = 4.1616725921630859375f + _3423;
                                float _3427 = mad(_3426, _3423, 3.41759395599365234375f);
                                float _3428 = _3425 / _3427;
                                bool _3429 = _3422 > 0.0f;
                                float _3430 = -_3422;
                                float _3431 = mad(_3430, _3422, 1.0f);
                                float _3432 = rsqrt(_3431);
                                float _3433 = -_3428;
                                float _3434 = mad(0.5f, _3432, _3433);
                                float _3435 = _3429 ? _3428 : _3434;
                                float _3436 = -_3393;
                                float3 _3437 = _3376 * _3436;
                                float3 _3438 = _3378 * _3407;
                                float3 _3439 = _3437 + _3438;
                                float3 _3440 = cross(_3377, _3439);
                                float3 _3441 = _3376 * _3435;
                                float _3442 = -_3421;
                                float3 _3443 = _3378 * _3442;
                                float3 _3444 = _3441 + _3443;
                                float3 _3445 = cross(_3379, _3444);
                                float3 _3446 = _3440 + _3445;
                                float _3447 = dot(_3446, _3446);
                                float _3448 = rsqrt(_3447);
                                float _3449 = _3447 * _3448;
                                float3 _3450 = _3446 * _3448;
                                float _3452 = sqrt(_3449);
                                bool _3453 = _3450.z < _3452;
                                float _3462 = 0.0f;
                                if (_3453)
                                {
                                    float _3456 = -_3452;
                                    bool _3677 = isnan(_3450.z);
                                    bool _3678 = isnan(_3456);
                                    float _3679 = max(_3450.z, _3456);
                                    float _3680 = _3677 ? _3456 : _3679;
                                    float _3457 = _3678 ? _3450.z : _3680;
                                    float _3458 = _3452 + _3457;
                                    float _3459 = _3458 * _3458;
                                    float _3460 = 4.0f * _3452;
                                    float _3461 = _3459 / _3460;
                                    _3462 = _3461;
                                }
                                else
                                {
                                    _3462 = _3450.z;
                                }
                                float _3463 = _3449 * _3462;
                                float _3464 = -_3463;
                                bool _3682 = isnan(_3464);
                                bool _3683 = isnan(0.0f);
                                float _3684 = min(_3464, 0.0f);
                                float _3685 = _3682 ? 0.0f : _3684;
                                float _3465 = _3683 ? _3464 : _3685;
                                float _3466 = -_3465;
                                float _3467 = _3334.y;
                                float3 _3468 = _3312 * _3467;
                                float _3469 = _3334.x;
                                float _3470 = _3469 - _3467;
                                float3 _3471 = _384 * _3470;
                                float3 _3472 = _3468 + _3471;
                                float3 _3473 = mul(_3363, _3450);
                                float _3474 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3473);
                                float _3475 = 0.001000000047497451305389404296875f - _3474;
                                float _3476 = clamp(_3475, 0.0f, 1.0f);
                                float3 _3477 = DeferredLightUniforms_DeferredLightUniforms_Direction * _3476;
                                float3 _3478 = _3473 + _3477;
                                float _3479 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3478);
                                float _3480 = _876 / _3479;
                                float3 _3481 = _3478 * _3480;
                                float3 _3482 = _3481 - _864;
                                float _3483 = dot(_801, _3482);
                                float2 _3484 = 0.0f.xx;
                                _3484.x = _3483;
                                float _3485 = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _3482);
                                float2 _3486 = _3484;
                                _3486.y = _3485;
                                float2 _3487 = _3486 + _866;
                                float2 _3488 = _3487 / _976;
                                float2 _3489 = mad(_3488, float2(0.5f, -0.5f), 0.5f.xx);
                                float _3490 = _3480 * _981;
                                float _3491 = log2(_3490);
                                float _3492 = _3491 + _993;
                                bool _3688 = isnan(_3492);
                                bool _3689 = isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel);
                                float _3690 = min(_3492, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel);
                                float _3691 = _3688 ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : _3690;
                                float _3493 = _3689 ? _3492 : _3691;
                                float2 _3494 = clamp(_3489, 0.0f.xx, 1.0f.xx);
                                float2 _3495 = mad(_3494, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset);
                                float4 _3497 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, _3495, _3493);
                                float3 _3498 = _3497.xyz;
                                float3 _3499 = float3(_998.x ? _3498.x : 1.0f.xxx.x, _998.y ? _3498.y : 1.0f.xxx.y, _998.z ? _3498.z : 1.0f.xxx.z);
                                float3 _3500 = _3499 * _3466;
                                float3 _3501 = _3500 * _3472;
                                _3502 = _3501;
                                break;
                            } while(false);
                            float3 _3503 = _3308 * 1.0f;
                            _3504 = _3503;
                            _3505 = _3502;
                            _3506 = 0.0f.xxx;
                            break;
                        }
                        case 10u:
                        {
                            float3 _3305 = _377 * 0.3183098733425140380859375f;
                            float _3306 = _948 * _961;
                            float3 _3307 = _1004 * _3306;
                            float3 _3308 = _3305 * _3307;
                            float3 _3502 = 0.0f.xxx;
                            do
                            {
                                float3 _3311 = _384 * 50.0f;
                                float3 _3312 = clamp(_3311, 0.0f.xxx, 1.0f.xxx);
                                bool _3313 = _865.x == 0.0f;
                                bool _3314 = _865.y == 0.0f;
                                bool _3315 = _3313 || _3314;
                                if (_3315)
                                {
                                    _3502 = 0.0f.xxx;
                                    break;
                                }
                                float _3318 = dot(_337, _472);
                                float _3319 = abs(_3318);
                                float _3320 = _3319 + 9.9999997473787516355514526367188e-06f;
                                float _3321 = clamp(_3320, 0.0f, 1.0f);
                                float _3322 = 1.0f - _3321;
                                float _3323 = sqrt(_3322);
                                float2 _3324 = float2(_1005, _3323);
                                float2 _3325 = _3324 * 0.984375f;
                                float2 _3326 = _3325 + 0.0078125f.xx;
                                float4 _3330 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _3326, 0.0f);
                                float4 _3334 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _3326, 0.0f);
                                float _3335 = _3330.x;
                                float _3336 = _3330.z;
                                float _3337 = _3330.y;
                                float _3338 = _3330.w;
                                float3 _3339 = float3(_3335, 0.0f, _3336);
                                float3 _3340 = float3(_3337, 0.0f, _3338);
                                float3x3 _3341 = float3x3(_3339, float3(0.0f, 1.0f, 0.0f), _3340);
                                float _3342 = _3337 * _3336;
                                float _3343 = -_3342;
                                float _3344 = mad(_3335, _3338, _3343);
                                float4 _3345 = _3344.xxxx;
                                float4 _3346 = _3330 / _3345;
                                float _3347 = _3346.w;
                                float _3348 = _3346.z;
                                float _3349 = -_3348;
                                float _3350 = _3346.y;
                                float _3351 = -_3350;
                                float _3352 = _3346.x;
                                float3 _3353 = float3(_3347, 0.0f, _3349);
                                float3 _3354 = float3(_3351, 0.0f, _3352);
                                float3x3 _3355 = float3x3(_3353, float3(0.0f, 1.0f, 0.0f), _3354);
                                float3 _3356 = _337 * _3318;
                                float3 _3357 = _472 - _3356;
                                float3 _3358 = normalize(_3357);
                                float3 _3359 = cross(_337, _3358);
                                float3x3 _3360 = float3x3(_3358, _3359, _337);
                                float3x3 _3361 = mul(_3341, _3360);
                                float3x3 _3362 = transpose(_3360);
                                float3x3 _3363 = mul(_3362, _3355);
                                float3 _3364 = _801 * _865.x;
                                float3 _3365 = _864 - _3364;
                                float3 _3366 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _3367 = _3365 - _3366;
                                float3 _3368 = mul(_3361, _3367);
                                float3 _3369 = _864 + _3364;
                                float3 _3370 = _3369 - _3366;
                                float3 _3371 = mul(_3361, _3370);
                                float3 _3372 = _3369 + _3366;
                                float3 _3373 = mul(_3361, _3372);
                                float3 _3374 = _3365 + _3366;
                                float3 _3375 = mul(_3361, _3374);
                                float3 _3376 = normalize(_3368);
                                float3 _3377 = normalize(_3371);
                                float3 _3378 = normalize(_3373);
                                float3 _3379 = normalize(_3375);
                                float _3380 = dot(_3376, _3377);
                                float _3381 = abs(_3380);
                                float _3382 = mad(0.01452060043811798095703125f, _3381, 0.4965155124664306640625f);
                                float _3383 = mad(_3382, _3381, 0.8543984889984130859375f);
                                float _3384 = 4.1616725921630859375f + _3381;
                                float _3385 = mad(_3384, _3381, 3.41759395599365234375f);
                                float _3386 = _3383 / _3385;
                                bool _3387 = _3380 > 0.0f;
                                float _3388 = -_3380;
                                float _3389 = mad(_3388, _3380, 1.0f);
                                float _3390 = rsqrt(_3389);
                                float _3391 = -_3386;
                                float _3392 = mad(0.5f, _3390, _3391);
                                float _3393 = _3387 ? _3386 : _3392;
                                float _3394 = dot(_3377, _3378);
                                float _3395 = abs(_3394);
                                float _3396 = mad(0.01452060043811798095703125f, _3395, 0.4965155124664306640625f);
                                float _3397 = mad(_3396, _3395, 0.8543984889984130859375f);
                                float _3398 = 4.1616725921630859375f + _3395;
                                float _3399 = mad(_3398, _3395, 3.41759395599365234375f);
                                float _3400 = _3397 / _3399;
                                bool _3401 = _3394 > 0.0f;
                                float _3402 = -_3394;
                                float _3403 = mad(_3402, _3394, 1.0f);
                                float _3404 = rsqrt(_3403);
                                float _3405 = -_3400;
                                float _3406 = mad(0.5f, _3404, _3405);
                                float _3407 = _3401 ? _3400 : _3406;
                                float _3408 = dot(_3378, _3379);
                                float _3409 = abs(_3408);
                                float _3410 = mad(0.01452060043811798095703125f, _3409, 0.4965155124664306640625f);
                                float _3411 = mad(_3410, _3409, 0.8543984889984130859375f);
                                float _3412 = 4.1616725921630859375f + _3409;
                                float _3413 = mad(_3412, _3409, 3.41759395599365234375f);
                                float _3414 = _3411 / _3413;
                                bool _3415 = _3408 > 0.0f;
                                float _3416 = -_3408;
                                float _3417 = mad(_3416, _3408, 1.0f);
                                float _3418 = rsqrt(_3417);
                                float _3419 = -_3414;
                                float _3420 = mad(0.5f, _3418, _3419);
                                float _3421 = _3415 ? _3414 : _3420;
                                float _3422 = dot(_3379, _3376);
                                float _3423 = abs(_3422);
                                float _3424 = mad(0.01452060043811798095703125f, _3423, 0.4965155124664306640625f);
                                float _3425 = mad(_3424, _3423, 0.8543984889984130859375f);
                                float _3426 = 4.1616725921630859375f + _3423;
                                float _3427 = mad(_3426, _3423, 3.41759395599365234375f);
                                float _3428 = _3425 / _3427;
                                bool _3429 = _3422 > 0.0f;
                                float _3430 = -_3422;
                                float _3431 = mad(_3430, _3422, 1.0f);
                                float _3432 = rsqrt(_3431);
                                float _3433 = -_3428;
                                float _3434 = mad(0.5f, _3432, _3433);
                                float _3435 = _3429 ? _3428 : _3434;
                                float _3436 = -_3393;
                                float3 _3437 = _3376 * _3436;
                                float3 _3438 = _3378 * _3407;
                                float3 _3439 = _3437 + _3438;
                                float3 _3440 = cross(_3377, _3439);
                                float3 _3441 = _3376 * _3435;
                                float _3442 = -_3421;
                                float3 _3443 = _3378 * _3442;
                                float3 _3444 = _3441 + _3443;
                                float3 _3445 = cross(_3379, _3444);
                                float3 _3446 = _3440 + _3445;
                                float _3447 = dot(_3446, _3446);
                                float _3448 = rsqrt(_3447);
                                float _3449 = _3447 * _3448;
                                float3 _3450 = _3446 * _3448;
                                float _3452 = sqrt(_3449);
                                bool _3453 = _3450.z < _3452;
                                float _3462 = 0.0f;
                                if (_3453)
                                {
                                    float _3456 = -_3452;
                                    bool _3677 = isnan(_3450.z);
                                    bool _3678 = isnan(_3456);
                                    float _3679 = max(_3450.z, _3456);
                                    float _3680 = _3677 ? _3456 : _3679;
                                    float _3457 = _3678 ? _3450.z : _3680;
                                    float _3458 = _3452 + _3457;
                                    float _3459 = _3458 * _3458;
                                    float _3460 = 4.0f * _3452;
                                    float _3461 = _3459 / _3460;
                                    _3462 = _3461;
                                }
                                else
                                {
                                    _3462 = _3450.z;
                                }
                                float _3463 = _3449 * _3462;
                                float _3464 = -_3463;
                                bool _3682 = isnan(_3464);
                                bool _3683 = isnan(0.0f);
                                float _3684 = min(_3464, 0.0f);
                                float _3685 = _3682 ? 0.0f : _3684;
                                float _3465 = _3683 ? _3464 : _3685;
                                float _3466 = -_3465;
                                float _3467 = _3334.y;
                                float3 _3468 = _3312 * _3467;
                                float _3469 = _3334.x;
                                float _3470 = _3469 - _3467;
                                float3 _3471 = _384 * _3470;
                                float3 _3472 = _3468 + _3471;
                                float3 _3473 = mul(_3363, _3450);
                                float _3474 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3473);
                                float _3475 = 0.001000000047497451305389404296875f - _3474;
                                float _3476 = clamp(_3475, 0.0f, 1.0f);
                                float3 _3477 = DeferredLightUniforms_DeferredLightUniforms_Direction * _3476;
                                float3 _3478 = _3473 + _3477;
                                float _3479 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3478);
                                float _3480 = _876 / _3479;
                                float3 _3481 = _3478 * _3480;
                                float3 _3482 = _3481 - _864;
                                float _3483 = dot(_801, _3482);
                                float2 _3484 = 0.0f.xx;
                                _3484.x = _3483;
                                float _3485 = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _3482);
                                float2 _3486 = _3484;
                                _3486.y = _3485;
                                float2 _3487 = _3486 + _866;
                                float2 _3488 = _3487 / _976;
                                float2 _3489 = mad(_3488, float2(0.5f, -0.5f), 0.5f.xx);
                                float _3490 = _3480 * _981;
                                float _3491 = log2(_3490);
                                float _3492 = _3491 + _993;
                                bool _3688 = isnan(_3492);
                                bool _3689 = isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel);
                                float _3690 = min(_3492, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel);
                                float _3691 = _3688 ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : _3690;
                                float _3493 = _3689 ? _3492 : _3691;
                                float2 _3494 = clamp(_3489, 0.0f.xx, 1.0f.xx);
                                float2 _3495 = mad(_3494, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset);
                                float4 _3497 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, _3495, _3493);
                                float3 _3498 = _3497.xyz;
                                float3 _3499 = float3(_998.x ? _3498.x : 1.0f.xxx.x, _998.y ? _3498.y : 1.0f.xxx.y, _998.z ? _3498.z : 1.0f.xxx.z);
                                float3 _3500 = _3499 * _3466;
                                float3 _3501 = _3500 * _3472;
                                _3502 = _3501;
                                break;
                            } while(false);
                            float3 _3503 = _3308 * 1.0f;
                            _3504 = _3503;
                            _3505 = _3502;
                            _3506 = 0.0f.xxx;
                            break;
                        }
                        case 11u:
                        {
                            float3 _3305 = _377 * 0.3183098733425140380859375f;
                            float _3306 = _948 * _961;
                            float3 _3307 = _1004 * _3306;
                            float3 _3308 = _3305 * _3307;
                            float3 _3502 = 0.0f.xxx;
                            do
                            {
                                float3 _3311 = _384 * 50.0f;
                                float3 _3312 = clamp(_3311, 0.0f.xxx, 1.0f.xxx);
                                bool _3313 = _865.x == 0.0f;
                                bool _3314 = _865.y == 0.0f;
                                bool _3315 = _3313 || _3314;
                                if (_3315)
                                {
                                    _3502 = 0.0f.xxx;
                                    break;
                                }
                                float _3318 = dot(_337, _472);
                                float _3319 = abs(_3318);
                                float _3320 = _3319 + 9.9999997473787516355514526367188e-06f;
                                float _3321 = clamp(_3320, 0.0f, 1.0f);
                                float _3322 = 1.0f - _3321;
                                float _3323 = sqrt(_3322);
                                float2 _3324 = float2(_1005, _3323);
                                float2 _3325 = _3324 * 0.984375f;
                                float2 _3326 = _3325 + 0.0078125f.xx;
                                float4 _3330 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _3326, 0.0f);
                                float4 _3334 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _3326, 0.0f);
                                float _3335 = _3330.x;
                                float _3336 = _3330.z;
                                float _3337 = _3330.y;
                                float _3338 = _3330.w;
                                float3 _3339 = float3(_3335, 0.0f, _3336);
                                float3 _3340 = float3(_3337, 0.0f, _3338);
                                float3x3 _3341 = float3x3(_3339, float3(0.0f, 1.0f, 0.0f), _3340);
                                float _3342 = _3337 * _3336;
                                float _3343 = -_3342;
                                float _3344 = mad(_3335, _3338, _3343);
                                float4 _3345 = _3344.xxxx;
                                float4 _3346 = _3330 / _3345;
                                float _3347 = _3346.w;
                                float _3348 = _3346.z;
                                float _3349 = -_3348;
                                float _3350 = _3346.y;
                                float _3351 = -_3350;
                                float _3352 = _3346.x;
                                float3 _3353 = float3(_3347, 0.0f, _3349);
                                float3 _3354 = float3(_3351, 0.0f, _3352);
                                float3x3 _3355 = float3x3(_3353, float3(0.0f, 1.0f, 0.0f), _3354);
                                float3 _3356 = _337 * _3318;
                                float3 _3357 = _472 - _3356;
                                float3 _3358 = normalize(_3357);
                                float3 _3359 = cross(_337, _3358);
                                float3x3 _3360 = float3x3(_3358, _3359, _337);
                                float3x3 _3361 = mul(_3341, _3360);
                                float3x3 _3362 = transpose(_3360);
                                float3x3 _3363 = mul(_3362, _3355);
                                float3 _3364 = _801 * _865.x;
                                float3 _3365 = _864 - _3364;
                                float3 _3366 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _3367 = _3365 - _3366;
                                float3 _3368 = mul(_3361, _3367);
                                float3 _3369 = _864 + _3364;
                                float3 _3370 = _3369 - _3366;
                                float3 _3371 = mul(_3361, _3370);
                                float3 _3372 = _3369 + _3366;
                                float3 _3373 = mul(_3361, _3372);
                                float3 _3374 = _3365 + _3366;
                                float3 _3375 = mul(_3361, _3374);
                                float3 _3376 = normalize(_3368);
                                float3 _3377 = normalize(_3371);
                                float3 _3378 = normalize(_3373);
                                float3 _3379 = normalize(_3375);
                                float _3380 = dot(_3376, _3377);
                                float _3381 = abs(_3380);
                                float _3382 = mad(0.01452060043811798095703125f, _3381, 0.4965155124664306640625f);
                                float _3383 = mad(_3382, _3381, 0.8543984889984130859375f);
                                float _3384 = 4.1616725921630859375f + _3381;
                                float _3385 = mad(_3384, _3381, 3.41759395599365234375f);
                                float _3386 = _3383 / _3385;
                                bool _3387 = _3380 > 0.0f;
                                float _3388 = -_3380;
                                float _3389 = mad(_3388, _3380, 1.0f);
                                float _3390 = rsqrt(_3389);
                                float _3391 = -_3386;
                                float _3392 = mad(0.5f, _3390, _3391);
                                float _3393 = _3387 ? _3386 : _3392;
                                float _3394 = dot(_3377, _3378);
                                float _3395 = abs(_3394);
                                float _3396 = mad(0.01452060043811798095703125f, _3395, 0.4965155124664306640625f);
                                float _3397 = mad(_3396, _3395, 0.8543984889984130859375f);
                                float _3398 = 4.1616725921630859375f + _3395;
                                float _3399 = mad(_3398, _3395, 3.41759395599365234375f);
                                float _3400 = _3397 / _3399;
                                bool _3401 = _3394 > 0.0f;
                                float _3402 = -_3394;
                                float _3403 = mad(_3402, _3394, 1.0f);
                                float _3404 = rsqrt(_3403);
                                float _3405 = -_3400;
                                float _3406 = mad(0.5f, _3404, _3405);
                                float _3407 = _3401 ? _3400 : _3406;
                                float _3408 = dot(_3378, _3379);
                                float _3409 = abs(_3408);
                                float _3410 = mad(0.01452060043811798095703125f, _3409, 0.4965155124664306640625f);
                                float _3411 = mad(_3410, _3409, 0.8543984889984130859375f);
                                float _3412 = 4.1616725921630859375f + _3409;
                                float _3413 = mad(_3412, _3409, 3.41759395599365234375f);
                                float _3414 = _3411 / _3413;
                                bool _3415 = _3408 > 0.0f;
                                float _3416 = -_3408;
                                float _3417 = mad(_3416, _3408, 1.0f);
                                float _3418 = rsqrt(_3417);
                                float _3419 = -_3414;
                                float _3420 = mad(0.5f, _3418, _3419);
                                float _3421 = _3415 ? _3414 : _3420;
                                float _3422 = dot(_3379, _3376);
                                float _3423 = abs(_3422);
                                float _3424 = mad(0.01452060043811798095703125f, _3423, 0.4965155124664306640625f);
                                float _3425 = mad(_3424, _3423, 0.8543984889984130859375f);
                                float _3426 = 4.1616725921630859375f + _3423;
                                float _3427 = mad(_3426, _3423, 3.41759395599365234375f);
                                float _3428 = _3425 / _3427;
                                bool _3429 = _3422 > 0.0f;
                                float _3430 = -_3422;
                                float _3431 = mad(_3430, _3422, 1.0f);
                                float _3432 = rsqrt(_3431);
                                float _3433 = -_3428;
                                float _3434 = mad(0.5f, _3432, _3433);
                                float _3435 = _3429 ? _3428 : _3434;
                                float _3436 = -_3393;
                                float3 _3437 = _3376 * _3436;
                                float3 _3438 = _3378 * _3407;
                                float3 _3439 = _3437 + _3438;
                                float3 _3440 = cross(_3377, _3439);
                                float3 _3441 = _3376 * _3435;
                                float _3442 = -_3421;
                                float3 _3443 = _3378 * _3442;
                                float3 _3444 = _3441 + _3443;
                                float3 _3445 = cross(_3379, _3444);
                                float3 _3446 = _3440 + _3445;
                                float _3447 = dot(_3446, _3446);
                                float _3448 = rsqrt(_3447);
                                float _3449 = _3447 * _3448;
                                float3 _3450 = _3446 * _3448;
                                float _3452 = sqrt(_3449);
                                bool _3453 = _3450.z < _3452;
                                float _3462 = 0.0f;
                                if (_3453)
                                {
                                    float _3456 = -_3452;
                                    bool _3677 = isnan(_3450.z);
                                    bool _3678 = isnan(_3456);
                                    float _3679 = max(_3450.z, _3456);
                                    float _3680 = _3677 ? _3456 : _3679;
                                    float _3457 = _3678 ? _3450.z : _3680;
                                    float _3458 = _3452 + _3457;
                                    float _3459 = _3458 * _3458;
                                    float _3460 = 4.0f * _3452;
                                    float _3461 = _3459 / _3460;
                                    _3462 = _3461;
                                }
                                else
                                {
                                    _3462 = _3450.z;
                                }
                                float _3463 = _3449 * _3462;
                                float _3464 = -_3463;
                                bool _3682 = isnan(_3464);
                                bool _3683 = isnan(0.0f);
                                float _3684 = min(_3464, 0.0f);
                                float _3685 = _3682 ? 0.0f : _3684;
                                float _3465 = _3683 ? _3464 : _3685;
                                float _3466 = -_3465;
                                float _3467 = _3334.y;
                                float3 _3468 = _3312 * _3467;
                                float _3469 = _3334.x;
                                float _3470 = _3469 - _3467;
                                float3 _3471 = _384 * _3470;
                                float3 _3472 = _3468 + _3471;
                                float3 _3473 = mul(_3363, _3450);
                                float _3474 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3473);
                                float _3475 = 0.001000000047497451305389404296875f - _3474;
                                float _3476 = clamp(_3475, 0.0f, 1.0f);
                                float3 _3477 = DeferredLightUniforms_DeferredLightUniforms_Direction * _3476;
                                float3 _3478 = _3473 + _3477;
                                float _3479 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3478);
                                float _3480 = _876 / _3479;
                                float3 _3481 = _3478 * _3480;
                                float3 _3482 = _3481 - _864;
                                float _3483 = dot(_801, _3482);
                                float2 _3484 = 0.0f.xx;
                                _3484.x = _3483;
                                float _3485 = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _3482);
                                float2 _3486 = _3484;
                                _3486.y = _3485;
                                float2 _3487 = _3486 + _866;
                                float2 _3488 = _3487 / _976;
                                float2 _3489 = mad(_3488, float2(0.5f, -0.5f), 0.5f.xx);
                                float _3490 = _3480 * _981;
                                float _3491 = log2(_3490);
                                float _3492 = _3491 + _993;
                                bool _3688 = isnan(_3492);
                                bool _3689 = isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel);
                                float _3690 = min(_3492, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel);
                                float _3691 = _3688 ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : _3690;
                                float _3493 = _3689 ? _3492 : _3691;
                                float2 _3494 = clamp(_3489, 0.0f.xx, 1.0f.xx);
                                float2 _3495 = mad(_3494, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset);
                                float4 _3497 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, _3495, _3493);
                                float3 _3498 = _3497.xyz;
                                float3 _3499 = float3(_998.x ? _3498.x : 1.0f.xxx.x, _998.y ? _3498.y : 1.0f.xxx.y, _998.z ? _3498.z : 1.0f.xxx.z);
                                float3 _3500 = _3499 * _3466;
                                float3 _3501 = _3500 * _3472;
                                _3502 = _3501;
                                break;
                            } while(false);
                            float3 _3503 = _3308 * 1.0f;
                            _3504 = _3503;
                            _3505 = _3502;
                            _3506 = 0.0f.xxx;
                            break;
                        }
                        case 2u:
                        {
                            float3 _3213 = 0.0f.xxx;
                            do
                            {
                                if ((_865.x == 0.0f) || (_865.y == 0.0f))
                                {
                                    _3213 = 0.0f.xxx;
                                    break;
                                }
                                float _3029 = dot(_337, _472);
                                float2 _3037 = (float2(_1005, sqrt(1.0f - clamp(abs(_3029) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f))) * 0.984375f) + 0.0078125f.xx;
                                float4 _3041 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _3037, 0.0f);
                                float4 _3045 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _3037, 0.0f);
                                float _3046 = _3041.x;
                                float _3047 = _3041.z;
                                float _3048 = _3041.y;
                                float _3049 = _3041.w;
                                float4 _3057 = _3041 / mad(_3046, _3049, -(_3048 * _3047)).xxxx;
                                float3 _3069 = normalize(_472 - (_337 * _3029));
                                float3x3 _3071 = float3x3(_3069, cross(_337, _3069), _337);
                                float3x3 _3072 = mul(float3x3(float3(_3046, 0.0f, _3047), float3(0.0f, 1.0f, 0.0f), float3(_3048, 0.0f, _3049)), _3071);
                                float3 _3075 = _801 * _865.x;
                                float3 _3076 = _864 - _3075;
                                float3 _3077 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _3080 = _864 + _3075;
                                float3 _3087 = normalize(mul(_3072, _3076 - _3077));
                                float3 _3088 = normalize(mul(_3072, _3080 - _3077));
                                float3 _3089 = normalize(mul(_3072, _3080 + _3077));
                                float3 _3090 = normalize(mul(_3072, _3076 + _3077));
                                float _3091 = dot(_3087, _3088);
                                float _3092 = abs(_3091);
                                float _3097 = mad(mad(0.01452060043811798095703125f, _3092, 0.4965155124664306640625f), _3092, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _3092, _3092, 3.41759395599365234375f);
                                float _3105 = dot(_3088, _3089);
                                float _3106 = abs(_3105);
                                float _3111 = mad(mad(0.01452060043811798095703125f, _3106, 0.4965155124664306640625f), _3106, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _3106, _3106, 3.41759395599365234375f);
                                float _3119 = dot(_3089, _3090);
                                float _3120 = abs(_3119);
                                float _3125 = mad(mad(0.01452060043811798095703125f, _3120, 0.4965155124664306640625f), _3120, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _3120, _3120, 3.41759395599365234375f);
                                float _3133 = dot(_3090, _3087);
                                float _3134 = abs(_3133);
                                float _3139 = mad(mad(0.01452060043811798095703125f, _3134, 0.4965155124664306640625f), _3134, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _3134, _3134, 3.41759395599365234375f);
                                float3 _3157 = cross(_3088, (_3087 * (-((_3091 > 0.0f) ? _3097 : mad(0.5f, rsqrt(mad(-_3091, _3091, 1.0f)), -_3097)))) + (_3089 * ((_3105 > 0.0f) ? _3111 : mad(0.5f, rsqrt(mad(-_3105, _3105, 1.0f)), -_3111)))) + cross(_3090, (_3087 * ((_3133 > 0.0f) ? _3139 : mad(0.5f, rsqrt(mad(-_3133, _3133, 1.0f)), -_3139))) + (_3089 * (-((_3119 > 0.0f) ? _3125 : mad(0.5f, rsqrt(mad(-_3119, _3119, 1.0f)), -_3125)))));
                                float _3158 = dot(_3157, _3157);
                                float _3159 = rsqrt(_3158);
                                float _3160 = _3158 * _3159;
                                float3 _3161 = _3157 * _3159;
                                float _3162 = _3161.z;
                                float _3163 = sqrt(_3160);
                                float _3173 = 0.0f;
                                if (_3162 < _3163)
                                {
                                    float _3167 = -_3163;
                                    float _3169 = _3163 + (isnan(_3167) ? _3162 : (isnan(_3162) ? _3167 : max(_3162, _3167)));
                                    _3173 = (_3169 * _3169) / (4.0f * _3163);
                                }
                                else
                                {
                                    _3173 = _3162;
                                }
                                float _3175 = -(_3160 * _3173);
                                float _3178 = _3045.y;
                                float3 _3184 = mul(mul(transpose(_3071), float3x3(float3(_3057.w, 0.0f, -_3057.z), float3(0.0f, 1.0f, 0.0f), float3(-_3057.y, 0.0f, _3057.x))), _3161);
                                float3 _3189 = _3184 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3184), 0.0f, 1.0f));
                                float _3191 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _3189);
                                float3 _3193 = (_3189 * _3191) - _864;
                                float2 _3195 = 0.0f.xx;
                                _3195.x = dot(_801, _3193);
                                _3195.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _3193);
                                float _3203 = log2(_3191 * _981) + _993;
                                float3 _3209 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_3195 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _3203 : (isnan(_3203) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_3203, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _3213 = (float3(_998.x ? _3209.x : 1.0f.xxx.x, _998.y ? _3209.y : 1.0f.xxx.y, _998.z ? _3209.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _3175 : (isnan(_3175) ? 0.0f : min(_3175, 0.0f))))) * ((clamp(_384 * 50.0f, 0.0f.xxx, 1.0f.xxx) * _3178) + (_384 * (_3045.x - _3178)));
                                break;
                            } while(false);
                            float3 _3215 = _327.xyz;
                            float3 _3216 = _3215 * _3215;
                            float3 _3238 = exp((-((-log(clamp(_3216, 9.9999999600419720025001879548654e-13f.xxx, 1.0f.xxx))) / (isnan(View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters) ? 9.9999999600419720025001879548654e-13f : (isnan(9.9999999600419720025001879548654e-13f) ? View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : max(9.9999999600419720025001879548654e-13f, View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters))).xxx)) * 1.0f);
                            float _3239 = _3238.y;
                            float _3240 = _3238.z;
                            bool4 _3242 = (_3239 < _3240).xxxx;
                            float4 _3243 = float4(_3240, _3239, -1.0f, 0.666666686534881591796875f);
                            float4 _3244 = float4(_3239, _3240, 0.0f, -0.3333333432674407958984375f);
                            float4 _3245 = float4(_3242.x ? _3243.x : _3244.x, _3242.y ? _3243.y : _3244.y, _3242.z ? _3243.z : _3244.z, _3242.w ? _3243.w : _3244.w);
                            float _3246 = _3238.x;
                            float _3247 = _3245.x;
                            bool4 _3249 = (_3246 < _3247).xxxx;
                            float4 _3252 = float4(_3247, _3245.yw, _3246);
                            float4 _3254 = float4(_3246, _3245.yz, _3247);
                            float4 _3255 = float4(_3249.x ? _3252.x : _3254.x, _3249.y ? _3252.y : _3254.y, _3249.z ? _3252.z : _3254.z, _3249.w ? _3252.w : _3254.w);
                            float _3256 = _3255.x;
                            float _3257 = _3255.w;
                            float _3258 = _3255.y;
                            float _3260 = _3256 - (isnan(_3258) ? _3257 : (isnan(_3257) ? _3258 : min(_3257, _3258)));
                            float _3266 = abs(((_3257 - _3258) / mad(6.0f, _3260, 1.0000000133514319600180897396058e-10f)) + _3255.z);
                            float _3269 = _3216.y;
                            float _3270 = _3216.z;
                            bool4 _3272 = (_3269 < _3270).xxxx;
                            float4 _3273 = float4(_3270, _3269, -1.0f, 0.666666686534881591796875f);
                            float4 _3274 = float4(_3269, _3270, 0.0f, -0.3333333432674407958984375f);
                            float4 _3275 = float4(_3272.x ? _3273.x : _3274.x, _3272.y ? _3273.y : _3274.y, _3272.z ? _3273.z : _3274.z, _3272.w ? _3273.w : _3274.w);
                            float _3276 = _3216.x;
                            float _3277 = _3275.x;
                            bool4 _3279 = (_3276 < _3277).xxxx;
                            float4 _3280 = float4(_3277, _199, _199, _3276);
                            float4 _3281 = float4(_3276, _199, _199, _3277);
                            _3504 = ((_377 * 0.3183098733425140380859375f) * (_1004 * (_948 * _961))) * 1.0f;
                            _3505 = _3213;
                            _3506 = (_1004 * (_948 * lerp(lerp(1.0f, pow(clamp(mad(_950, 0.666666686534881591796875f, 0.3333333432674407958984375f), 0.0f, 1.0f), 1.5f) * 1.66666662693023681640625f, _499) * 0.15915493667125701904296875f, 1.0f, pow(clamp(dot(_947, _415), 0.0f, 1.0f), 12.0f) * lerp(3.0f, 0.100000001490116119384765625f, _499)))) * lerp((((clamp(float3(abs(mad(_3266, 6.0f, -3.0f)) - 1.0f, 2.0f - abs(mad(_3266, 6.0f, -2.0f)), 2.0f - abs(mad(_3266, 6.0f, -4.0f))), 0.0f.xxx, 1.0f.xxx) - 1.0f.xxx) * (_3260 / (_3256 + 1.0000000133514319600180897396058e-10f))) + 1.0f.xxx) * float4(_3279.x ? _3280.x : _3281.x, _3279.y ? _3280.y : _3281.y, _3279.z ? _3280.z : _3281.z, _3279.w ? _3280.w : _3281.w).x, _3216, _521.xxx);
                            break;
                        }
                        case 3u:
                        {
                            float3 _3000 = 0.0f.xxx;
                            do
                            {
                                if ((_865.x == 0.0f) || (_865.y == 0.0f))
                                {
                                    _3000 = 0.0f.xxx;
                                    break;
                                }
                                float _2816 = dot(_337, _472);
                                float2 _2824 = (float2(_1005, sqrt(1.0f - clamp(abs(_2816) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f))) * 0.984375f) + 0.0078125f.xx;
                                float4 _2828 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _2824, 0.0f);
                                float4 _2832 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _2824, 0.0f);
                                float _2833 = _2828.x;
                                float _2834 = _2828.z;
                                float _2835 = _2828.y;
                                float _2836 = _2828.w;
                                float4 _2844 = _2828 / mad(_2833, _2836, -(_2835 * _2834)).xxxx;
                                float3 _2856 = normalize(_472 - (_337 * _2816));
                                float3x3 _2858 = float3x3(_2856, cross(_337, _2856), _337);
                                float3x3 _2859 = mul(float3x3(float3(_2833, 0.0f, _2834), float3(0.0f, 1.0f, 0.0f), float3(_2835, 0.0f, _2836)), _2858);
                                float3 _2862 = _801 * _865.x;
                                float3 _2863 = _864 - _2862;
                                float3 _2864 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _2867 = _864 + _2862;
                                float3 _2874 = normalize(mul(_2859, _2863 - _2864));
                                float3 _2875 = normalize(mul(_2859, _2867 - _2864));
                                float3 _2876 = normalize(mul(_2859, _2867 + _2864));
                                float3 _2877 = normalize(mul(_2859, _2863 + _2864));
                                float _2878 = dot(_2874, _2875);
                                float _2879 = abs(_2878);
                                float _2884 = mad(mad(0.01452060043811798095703125f, _2879, 0.4965155124664306640625f), _2879, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2879, _2879, 3.41759395599365234375f);
                                float _2892 = dot(_2875, _2876);
                                float _2893 = abs(_2892);
                                float _2898 = mad(mad(0.01452060043811798095703125f, _2893, 0.4965155124664306640625f), _2893, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2893, _2893, 3.41759395599365234375f);
                                float _2906 = dot(_2876, _2877);
                                float _2907 = abs(_2906);
                                float _2912 = mad(mad(0.01452060043811798095703125f, _2907, 0.4965155124664306640625f), _2907, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2907, _2907, 3.41759395599365234375f);
                                float _2920 = dot(_2877, _2874);
                                float _2921 = abs(_2920);
                                float _2926 = mad(mad(0.01452060043811798095703125f, _2921, 0.4965155124664306640625f), _2921, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2921, _2921, 3.41759395599365234375f);
                                float3 _2944 = cross(_2875, (_2874 * (-((_2878 > 0.0f) ? _2884 : mad(0.5f, rsqrt(mad(-_2878, _2878, 1.0f)), -_2884)))) + (_2876 * ((_2892 > 0.0f) ? _2898 : mad(0.5f, rsqrt(mad(-_2892, _2892, 1.0f)), -_2898)))) + cross(_2877, (_2874 * ((_2920 > 0.0f) ? _2926 : mad(0.5f, rsqrt(mad(-_2920, _2920, 1.0f)), -_2926))) + (_2876 * (-((_2906 > 0.0f) ? _2912 : mad(0.5f, rsqrt(mad(-_2906, _2906, 1.0f)), -_2912)))));
                                float _2945 = dot(_2944, _2944);
                                float _2946 = rsqrt(_2945);
                                float _2947 = _2945 * _2946;
                                float3 _2948 = _2944 * _2946;
                                float _2949 = _2948.z;
                                float _2950 = sqrt(_2947);
                                float _2960 = 0.0f;
                                if (_2949 < _2950)
                                {
                                    float _2954 = -_2950;
                                    float _2956 = _2950 + (isnan(_2954) ? _2949 : (isnan(_2949) ? _2954 : max(_2949, _2954)));
                                    _2960 = (_2956 * _2956) / (4.0f * _2950);
                                }
                                else
                                {
                                    _2960 = _2949;
                                }
                                float _2962 = -(_2947 * _2960);
                                float _2965 = _2832.y;
                                float3 _2971 = mul(mul(transpose(_2858), float3x3(float3(_2844.w, 0.0f, -_2844.z), float3(0.0f, 1.0f, 0.0f), float3(-_2844.y, 0.0f, _2844.x))), _2948);
                                float3 _2976 = _2971 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2971), 0.0f, 1.0f));
                                float _2978 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2976);
                                float3 _2980 = (_2976 * _2978) - _864;
                                float2 _2982 = 0.0f.xx;
                                _2982.x = dot(_801, _2980);
                                _2982.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _2980);
                                float _2990 = log2(_2978 * _981) + _993;
                                float3 _2996 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_2982 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _2990 : (isnan(_2990) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_2990, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _3000 = (float3(_998.x ? _2996.x : 1.0f.xxx.x, _998.y ? _2996.y : 1.0f.xxx.y, _998.z ? _2996.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _2962 : (isnan(_2962) ? 0.0f : min(_2962, 0.0f))))) * ((clamp(_384 * 50.0f, 0.0f.xxx, 1.0f.xxx) * _2965) + (_384 * (_2832.x - _2965)));
                                break;
                            } while(false);
                            float3 _3002 = _327.xyz;
                            _3504 = ((_377 * 0.3183098733425140380859375f) * (_1004 * (_948 * _961))) * 1.0f;
                            _3505 = _3000;
                            _3506 = ((_1004 * _948) * View_PreIntegratedBRDF.SampleLevel(View_PreIntegratedBRDFSampler, float2(clamp(mad(_950, 0.5f, 0.5f), 0.0f, 1.0f), 1.0f - _499), 0.0f).xyz) * (_3002 * _3002);
                            break;
                        }
                        case 4u:
                        {
                            bool _2394 = false;
                            float _2370 = _327.x;
                            float _2371 = _327.y;
                            float _2373 = dot(_337, _472);
                            float _2382 = clamp(abs(_2373) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                            float _2383 = 1.0f - _2382;
                            float _2384 = _2383 * _2383;
                            float _2385 = _2384 * _2384;
                            float3 _2576 = 0.0f.xxx;
                            do
                            {
                                _2394 = (_865.x == 0.0f) || (_865.y == 0.0f);
                                if (_2394)
                                {
                                    _2576 = 0.0f.xxx;
                                    break;
                                }
                                float2 _2400 = (float2(isnan(0.0199999995529651641845703125f) ? _2371 : (isnan(_2371) ? 0.0199999995529651641845703125f : max(_2371, 0.0199999995529651641845703125f)), sqrt(_2383)) * 0.984375f) + 0.0078125f.xx;
                                float4 _2404 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _2400, 0.0f);
                                float4 _2408 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _2400, 0.0f);
                                float _2409 = _2404.x;
                                float _2410 = _2404.z;
                                float _2411 = _2404.y;
                                float _2412 = _2404.w;
                                float4 _2420 = _2404 / mad(_2409, _2412, -(_2411 * _2410)).xxxx;
                                float3 _2432 = normalize(_472 - (_337 * _2373));
                                float3x3 _2434 = float3x3(_2432, cross(_337, _2432), _337);
                                float3x3 _2435 = mul(float3x3(float3(_2409, 0.0f, _2410), float3(0.0f, 1.0f, 0.0f), float3(_2411, 0.0f, _2412)), _2434);
                                float3 _2438 = _801 * _865.x;
                                float3 _2439 = _864 - _2438;
                                float3 _2440 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _2443 = _864 + _2438;
                                float3 _2450 = normalize(mul(_2435, _2439 - _2440));
                                float3 _2451 = normalize(mul(_2435, _2443 - _2440));
                                float3 _2452 = normalize(mul(_2435, _2443 + _2440));
                                float3 _2453 = normalize(mul(_2435, _2439 + _2440));
                                float _2454 = dot(_2450, _2451);
                                float _2455 = abs(_2454);
                                float _2460 = mad(mad(0.01452060043811798095703125f, _2455, 0.4965155124664306640625f), _2455, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2455, _2455, 3.41759395599365234375f);
                                float _2468 = dot(_2451, _2452);
                                float _2469 = abs(_2468);
                                float _2474 = mad(mad(0.01452060043811798095703125f, _2469, 0.4965155124664306640625f), _2469, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2469, _2469, 3.41759395599365234375f);
                                float _2482 = dot(_2452, _2453);
                                float _2483 = abs(_2482);
                                float _2488 = mad(mad(0.01452060043811798095703125f, _2483, 0.4965155124664306640625f), _2483, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2483, _2483, 3.41759395599365234375f);
                                float _2496 = dot(_2453, _2450);
                                float _2497 = abs(_2496);
                                float _2502 = mad(mad(0.01452060043811798095703125f, _2497, 0.4965155124664306640625f), _2497, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2497, _2497, 3.41759395599365234375f);
                                float3 _2520 = cross(_2451, (_2450 * (-((_2454 > 0.0f) ? _2460 : mad(0.5f, rsqrt(mad(-_2454, _2454, 1.0f)), -_2460)))) + (_2452 * ((_2468 > 0.0f) ? _2474 : mad(0.5f, rsqrt(mad(-_2468, _2468, 1.0f)), -_2474)))) + cross(_2453, (_2450 * ((_2496 > 0.0f) ? _2502 : mad(0.5f, rsqrt(mad(-_2496, _2496, 1.0f)), -_2502))) + (_2452 * (-((_2482 > 0.0f) ? _2488 : mad(0.5f, rsqrt(mad(-_2482, _2482, 1.0f)), -_2488)))));
                                float _2521 = dot(_2520, _2520);
                                float _2522 = rsqrt(_2521);
                                float _2523 = _2521 * _2522;
                                float3 _2524 = _2520 * _2522;
                                float _2525 = _2524.z;
                                float _2526 = sqrt(_2523);
                                float _2536 = 0.0f;
                                if (_2525 < _2526)
                                {
                                    float _2530 = -_2526;
                                    float _2532 = _2526 + (isnan(_2530) ? _2525 : (isnan(_2525) ? _2530 : max(_2525, _2530)));
                                    _2536 = (_2532 * _2532) / (4.0f * _2526);
                                }
                                else
                                {
                                    _2536 = _2525;
                                }
                                float _2538 = -(_2523 * _2536);
                                float _2541 = _2408.y;
                                float3 _2547 = mul(mul(transpose(_2434), float3x3(float3(_2420.w, 0.0f, -_2420.z), float3(0.0f, 1.0f, 0.0f), float3(-_2420.y, 0.0f, _2420.x))), _2524);
                                float3 _2552 = _2547 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2547), 0.0f, 1.0f));
                                float _2554 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2552);
                                float3 _2556 = (_2552 * _2554) - _864;
                                float2 _2558 = 0.0f.xx;
                                _2558.x = dot(_801, _2556);
                                _2558.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _2556);
                                float _2566 = log2(_2554 * _981) + _993;
                                float3 _2572 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_2558 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _2566 : (isnan(_2566) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_2566, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _2576 = (float3(_998.x ? _2572.x : 1.0f.xxx.x, _998.y ? _2572.y : 1.0f.xxx.y, _998.z ? _2572.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _2538 : (isnan(_2538) ? 0.0f : min(_2538, 0.0f))))) * ((1.0f.xxx * _2541) + (0.039999999105930328369140625f.xxx * (_2408.x - _2541)));
                                break;
                            } while(false);
                            float _2578 = 1.0f - mad(_2385, _2383, mad(-_2385, _2383, 1.0f) * 0.039999999105930328369140625f);
                            float _2583 = -(mad(mad(-0.2199999988079071044921875f, _2382, 0.62999999523162841796875f), _2382, -0.74500000476837158203125f) * clamp((_950 + _2373) * rsqrt(mad(2.0f, dot(_472, _947), 2.0f)), 0.0f, 1.0f));
                            float3 _2604 = 0.0f.xxx;
                            if (_339 > 0.0f)
                            {
                                float3 _2594 = _368 * 0.3183098733425140380859375f;
                                bool3 _3770 = isnan(_2594);
                                bool3 _3771 = isnan(9.9999997473787516355514526367188e-05f.xxx);
                                float3 _3772 = max(_2594, 9.9999997473787516355514526367188e-05f.xxx);
                                float3 _3773 = float3(_3770.x ? 9.9999997473787516355514526367188e-05f.xxx.x : _3772.x, _3770.y ? 9.9999997473787516355514526367188e-05f.xxx.y : _3772.y, _3770.z ? 9.9999997473787516355514526367188e-05f.xxx.z : _3772.z);
                                float _2598 = ((1.0f / clamp(mad(0.666666686534881591796875f, _2382, _2583), 0.001000000047497451305389404296875f, 1.0f)) + (1.0f / clamp(mad(0.666666686534881591796875f, _950, _2583), 0.001000000047497451305389404296875f, 1.0f))) - 2.0f;
                                _2604 = lerp(1.0f.xxx, exp(-((log(float3(_3771.x ? _2594.x : _3773.x, _3771.y ? _2594.y : _3773.y, _3771.z ? _2594.z : _3773.z)) * (-0.5f).xxx) * (isnan(0.0f) ? _2598 : (isnan(_2598) ? 0.0f : max(_2598, 0.0f))))), _342);
                            }
                            else
                            {
                                _2604 = 1.0f.xxx;
                            }
                            float3 _2609 = ((_1004 * (_948 * _961)) * (_377 * 0.3183098733425140380859375f)) * 1.0f;
                            float3 _2610 = _2604 * (_2578 * _2578);
                            float3 _2612 = _2370.xxx;
                            float3 _2799 = 0.0f.xxx;
                            do
                            {
                                if (_2394)
                                {
                                    _2799 = 0.0f.xxx;
                                    break;
                                }
                                float2 _2623 = (float2(_1005, sqrt(_2383)) * 0.984375f) + 0.0078125f.xx;
                                float4 _2627 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _2623, 0.0f);
                                float4 _2631 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _2623, 0.0f);
                                float _2632 = _2627.x;
                                float _2633 = _2627.z;
                                float _2634 = _2627.y;
                                float _2635 = _2627.w;
                                float4 _2643 = _2627 / mad(_2632, _2635, -(_2634 * _2633)).xxxx;
                                float3 _2655 = normalize(_472 - (_337 * _2373));
                                float3x3 _2657 = float3x3(_2655, cross(_337, _2655), _337);
                                float3x3 _2658 = mul(float3x3(float3(_2632, 0.0f, _2633), float3(0.0f, 1.0f, 0.0f), float3(_2634, 0.0f, _2635)), _2657);
                                float3 _2661 = _801 * _865.x;
                                float3 _2662 = _864 - _2661;
                                float3 _2663 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _2666 = _864 + _2661;
                                float3 _2673 = normalize(mul(_2658, _2662 - _2663));
                                float3 _2674 = normalize(mul(_2658, _2666 - _2663));
                                float3 _2675 = normalize(mul(_2658, _2666 + _2663));
                                float3 _2676 = normalize(mul(_2658, _2662 + _2663));
                                float _2677 = dot(_2673, _2674);
                                float _2678 = abs(_2677);
                                float _2683 = mad(mad(0.01452060043811798095703125f, _2678, 0.4965155124664306640625f), _2678, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2678, _2678, 3.41759395599365234375f);
                                float _2691 = dot(_2674, _2675);
                                float _2692 = abs(_2691);
                                float _2697 = mad(mad(0.01452060043811798095703125f, _2692, 0.4965155124664306640625f), _2692, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2692, _2692, 3.41759395599365234375f);
                                float _2705 = dot(_2675, _2676);
                                float _2706 = abs(_2705);
                                float _2711 = mad(mad(0.01452060043811798095703125f, _2706, 0.4965155124664306640625f), _2706, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2706, _2706, 3.41759395599365234375f);
                                float _2719 = dot(_2676, _2673);
                                float _2720 = abs(_2719);
                                float _2725 = mad(mad(0.01452060043811798095703125f, _2720, 0.4965155124664306640625f), _2720, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2720, _2720, 3.41759395599365234375f);
                                float3 _2743 = cross(_2674, (_2673 * (-((_2677 > 0.0f) ? _2683 : mad(0.5f, rsqrt(mad(-_2677, _2677, 1.0f)), -_2683)))) + (_2675 * ((_2691 > 0.0f) ? _2697 : mad(0.5f, rsqrt(mad(-_2691, _2691, 1.0f)), -_2697)))) + cross(_2676, (_2673 * ((_2719 > 0.0f) ? _2725 : mad(0.5f, rsqrt(mad(-_2719, _2719, 1.0f)), -_2725))) + (_2675 * (-((_2705 > 0.0f) ? _2711 : mad(0.5f, rsqrt(mad(-_2705, _2705, 1.0f)), -_2711)))));
                                float _2744 = dot(_2743, _2743);
                                float _2745 = rsqrt(_2744);
                                float _2746 = _2744 * _2745;
                                float3 _2747 = _2743 * _2745;
                                float _2748 = _2747.z;
                                float _2749 = sqrt(_2746);
                                float _2759 = 0.0f;
                                if (_2748 < _2749)
                                {
                                    float _2753 = -_2749;
                                    float _2755 = _2749 + (isnan(_2753) ? _2748 : (isnan(_2748) ? _2753 : max(_2748, _2753)));
                                    _2759 = (_2755 * _2755) / (4.0f * _2749);
                                }
                                else
                                {
                                    _2759 = _2748;
                                }
                                float _2761 = -(_2746 * _2759);
                                float _2764 = _2631.y;
                                float3 _2770 = mul(mul(transpose(_2657), float3x3(float3(_2643.w, 0.0f, -_2643.z), float3(0.0f, 1.0f, 0.0f), float3(-_2643.y, 0.0f, _2643.x))), _2747);
                                float3 _2775 = _2770 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2770), 0.0f, 1.0f));
                                float _2777 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2775);
                                float3 _2779 = (_2775 * _2777) - _864;
                                float2 _2781 = 0.0f.xx;
                                _2781.x = dot(_801, _2779);
                                _2781.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _2779);
                                float _2789 = log2(_2777 * _981) + _993;
                                float3 _2795 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_2781 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _2789 : (isnan(_2789) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_2789, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _2799 = (float3(_998.x ? _2795.x : 1.0f.xxx.x, _998.y ? _2795.y : 1.0f.xxx.y, _998.z ? _2795.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _2761 : (isnan(_2761) ? 0.0f : min(_2761, 0.0f))))) * ((clamp(_384 * 50.0f, 0.0f.xxx, 1.0f.xxx) * _2764) + (_384 * (_2631.x - _2764)));
                                break;
                            } while(false);
                            _3504 = lerp(_2609, _2610 * _2609, _2612);
                            _3505 = (_2576 * _2370) + lerp(_2799, _2610 * _2799, _2612);
                            _3506 = 0.0f.xxx;
                            break;
                        }
                        case 5u:
                        {
                            float3 _1963 = 0.0f.xxx;
                            bool _1966 = false;
                            float _1908 = dot(_337, _472);
                            float _1909 = dot(_472, _947);
                            float _1911 = rsqrt(mad(2.0f, _1909, 2.0f));
                            float _1913 = clamp(mad(_1911, _1909, _1911), 0.0f, 1.0f);
                            uint _1919 = uint(mad(_327.x, 255.0f, 0.5f));
                            int _1920 = int(_1919);
                            float4 _1924 = View_SSProfilesTexture.Load(int3(int3(5, _1920, 0).xy, 0));
                            float _1929 = clamp((_499 - 0.100000001490116119384765625f) * 10.0f, 0.0f, 1.0f);
                            float _1936 = clamp(_1005 * lerp(1.0f, _1924.x * 2.0f, _1929), 0.0f, 1.0f);
                            float _1943 = mad((2.0f * _1913) * _1913, _1005, 0.5f) - 1.0f;
                            float _1944 = 1.0f - clamp(abs(_1908) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                            float _1945 = _1944 * _1944;
                            float _1949 = 1.0f - _961;
                            float _1950 = _1949 * _1949;
                            float3 _2148 = 0.0f.xxx;
                            do
                            {
                                _1963 = clamp(_384 * 50.0f, 0.0f.xxx, 1.0f.xxx);
                                _1966 = (_865.x == 0.0f) || (_865.y == 0.0f);
                                if (_1966)
                                {
                                    _2148 = 0.0f.xxx;
                                    break;
                                }
                                float2 _1972 = (float2(isnan(0.0199999995529651641845703125f) ? _1936 : (isnan(_1936) ? 0.0199999995529651641845703125f : max(_1936, 0.0199999995529651641845703125f)), sqrt(_1944)) * 0.984375f) + 0.0078125f.xx;
                                float4 _1976 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _1972, 0.0f);
                                float4 _1980 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _1972, 0.0f);
                                float _1981 = _1976.x;
                                float _1982 = _1976.z;
                                float _1983 = _1976.y;
                                float _1984 = _1976.w;
                                float4 _1992 = _1976 / mad(_1981, _1984, -(_1983 * _1982)).xxxx;
                                float3 _2004 = normalize(_472 - (_337 * _1908));
                                float3x3 _2006 = float3x3(_2004, cross(_337, _2004), _337);
                                float3x3 _2007 = mul(float3x3(float3(_1981, 0.0f, _1982), float3(0.0f, 1.0f, 0.0f), float3(_1983, 0.0f, _1984)), _2006);
                                float3 _2010 = _801 * _865.x;
                                float3 _2011 = _864 - _2010;
                                float3 _2012 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _2015 = _864 + _2010;
                                float3 _2022 = normalize(mul(_2007, _2011 - _2012));
                                float3 _2023 = normalize(mul(_2007, _2015 - _2012));
                                float3 _2024 = normalize(mul(_2007, _2015 + _2012));
                                float3 _2025 = normalize(mul(_2007, _2011 + _2012));
                                float _2026 = dot(_2022, _2023);
                                float _2027 = abs(_2026);
                                float _2032 = mad(mad(0.01452060043811798095703125f, _2027, 0.4965155124664306640625f), _2027, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2027, _2027, 3.41759395599365234375f);
                                float _2040 = dot(_2023, _2024);
                                float _2041 = abs(_2040);
                                float _2046 = mad(mad(0.01452060043811798095703125f, _2041, 0.4965155124664306640625f), _2041, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2041, _2041, 3.41759395599365234375f);
                                float _2054 = dot(_2024, _2025);
                                float _2055 = abs(_2054);
                                float _2060 = mad(mad(0.01452060043811798095703125f, _2055, 0.4965155124664306640625f), _2055, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2055, _2055, 3.41759395599365234375f);
                                float _2068 = dot(_2025, _2022);
                                float _2069 = abs(_2068);
                                float _2074 = mad(mad(0.01452060043811798095703125f, _2069, 0.4965155124664306640625f), _2069, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2069, _2069, 3.41759395599365234375f);
                                float3 _2092 = cross(_2023, (_2022 * (-((_2026 > 0.0f) ? _2032 : mad(0.5f, rsqrt(mad(-_2026, _2026, 1.0f)), -_2032)))) + (_2024 * ((_2040 > 0.0f) ? _2046 : mad(0.5f, rsqrt(mad(-_2040, _2040, 1.0f)), -_2046)))) + cross(_2025, (_2022 * ((_2068 > 0.0f) ? _2074 : mad(0.5f, rsqrt(mad(-_2068, _2068, 1.0f)), -_2074))) + (_2024 * (-((_2054 > 0.0f) ? _2060 : mad(0.5f, rsqrt(mad(-_2054, _2054, 1.0f)), -_2060)))));
                                float _2093 = dot(_2092, _2092);
                                float _2094 = rsqrt(_2093);
                                float _2095 = _2093 * _2094;
                                float3 _2096 = _2092 * _2094;
                                float _2097 = _2096.z;
                                float _2098 = sqrt(_2095);
                                float _2108 = 0.0f;
                                if (_2097 < _2098)
                                {
                                    float _2102 = -_2098;
                                    float _2104 = _2098 + (isnan(_2102) ? _2097 : (isnan(_2097) ? _2102 : max(_2097, _2102)));
                                    _2108 = (_2104 * _2104) / (4.0f * _2098);
                                }
                                else
                                {
                                    _2108 = _2097;
                                }
                                float _2110 = -(_2095 * _2108);
                                float _2113 = _1980.y;
                                float3 _2119 = mul(mul(transpose(_2006), float3x3(float3(_1992.w, 0.0f, -_1992.z), float3(0.0f, 1.0f, 0.0f), float3(-_1992.y, 0.0f, _1992.x))), _2096);
                                float3 _2124 = _2119 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2119), 0.0f, 1.0f));
                                float _2126 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2124);
                                float3 _2128 = (_2124 * _2126) - _864;
                                float2 _2130 = 0.0f.xx;
                                _2130.x = dot(_801, _2128);
                                _2130.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _2128);
                                float _2138 = log2(_2126 * _981) + _993;
                                float3 _2144 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_2130 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _2138 : (isnan(_2138) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_2138, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _2148 = (float3(_998.x ? _2144.x : 1.0f.xxx.x, _998.y ? _2144.y : 1.0f.xxx.y, _998.z ? _2144.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _2110 : (isnan(_2110) ? 0.0f : min(_2110, 0.0f))))) * ((_1963 * _2113) + (_384 * (_1980.x - _2113)));
                                break;
                            } while(false);
                            float3 _2332 = 0.0f.xxx;
                            do
                            {
                                if (_1966)
                                {
                                    _2332 = 0.0f.xxx;
                                    break;
                                }
                                float2 _2156 = (float2(clamp(_1005 * lerp(1.0f, _1924.y * 2.0f, _1929), 0.0f, 1.0f), sqrt(_1944)) * 0.984375f) + 0.0078125f.xx;
                                float4 _2160 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _2156, 0.0f);
                                float4 _2164 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _2156, 0.0f);
                                float _2165 = _2160.x;
                                float _2166 = _2160.z;
                                float _2167 = _2160.y;
                                float _2168 = _2160.w;
                                float4 _2176 = _2160 / mad(_2165, _2168, -(_2167 * _2166)).xxxx;
                                float3 _2188 = normalize(_472 - (_337 * _1908));
                                float3x3 _2190 = float3x3(_2188, cross(_337, _2188), _337);
                                float3x3 _2191 = mul(float3x3(float3(_2165, 0.0f, _2166), float3(0.0f, 1.0f, 0.0f), float3(_2167, 0.0f, _2168)), _2190);
                                float3 _2194 = _801 * _865.x;
                                float3 _2195 = _864 - _2194;
                                float3 _2196 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _2199 = _864 + _2194;
                                float3 _2206 = normalize(mul(_2191, _2195 - _2196));
                                float3 _2207 = normalize(mul(_2191, _2199 - _2196));
                                float3 _2208 = normalize(mul(_2191, _2199 + _2196));
                                float3 _2209 = normalize(mul(_2191, _2195 + _2196));
                                float _2210 = dot(_2206, _2207);
                                float _2211 = abs(_2210);
                                float _2216 = mad(mad(0.01452060043811798095703125f, _2211, 0.4965155124664306640625f), _2211, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2211, _2211, 3.41759395599365234375f);
                                float _2224 = dot(_2207, _2208);
                                float _2225 = abs(_2224);
                                float _2230 = mad(mad(0.01452060043811798095703125f, _2225, 0.4965155124664306640625f), _2225, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2225, _2225, 3.41759395599365234375f);
                                float _2238 = dot(_2208, _2209);
                                float _2239 = abs(_2238);
                                float _2244 = mad(mad(0.01452060043811798095703125f, _2239, 0.4965155124664306640625f), _2239, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2239, _2239, 3.41759395599365234375f);
                                float _2252 = dot(_2209, _2206);
                                float _2253 = abs(_2252);
                                float _2258 = mad(mad(0.01452060043811798095703125f, _2253, 0.4965155124664306640625f), _2253, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _2253, _2253, 3.41759395599365234375f);
                                float3 _2276 = cross(_2207, (_2206 * (-((_2210 > 0.0f) ? _2216 : mad(0.5f, rsqrt(mad(-_2210, _2210, 1.0f)), -_2216)))) + (_2208 * ((_2224 > 0.0f) ? _2230 : mad(0.5f, rsqrt(mad(-_2224, _2224, 1.0f)), -_2230)))) + cross(_2209, (_2206 * ((_2252 > 0.0f) ? _2258 : mad(0.5f, rsqrt(mad(-_2252, _2252, 1.0f)), -_2258))) + (_2208 * (-((_2238 > 0.0f) ? _2244 : mad(0.5f, rsqrt(mad(-_2238, _2238, 1.0f)), -_2244)))));
                                float _2277 = dot(_2276, _2276);
                                float _2278 = rsqrt(_2277);
                                float _2279 = _2277 * _2278;
                                float3 _2280 = _2276 * _2278;
                                float _2281 = _2280.z;
                                float _2282 = sqrt(_2279);
                                float _2292 = 0.0f;
                                if (_2281 < _2282)
                                {
                                    float _2286 = -_2282;
                                    float _2288 = _2282 + (isnan(_2286) ? _2281 : (isnan(_2281) ? _2286 : max(_2281, _2286)));
                                    _2292 = (_2288 * _2288) / (4.0f * _2282);
                                }
                                else
                                {
                                    _2292 = _2281;
                                }
                                float _2294 = -(_2279 * _2292);
                                float _2297 = _2164.y;
                                float3 _2303 = mul(mul(transpose(_2190), float3x3(float3(_2176.w, 0.0f, -_2176.z), float3(0.0f, 1.0f, 0.0f), float3(-_2176.y, 0.0f, _2176.x))), _2280);
                                float3 _2308 = _2303 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2303), 0.0f, 1.0f));
                                float _2310 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _2308);
                                float3 _2312 = (_2308 * _2310) - _864;
                                float2 _2314 = 0.0f.xx;
                                _2314.x = dot(_801, _2312);
                                _2314.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _2312);
                                float _2322 = log2(_2310 * _981) + _993;
                                float3 _2328 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_2314 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _2322 : (isnan(_2322) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_2322, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _2332 = (float3(_998.x ? _2328.x : 1.0f.xxx.x, _998.y ? _2328.y : 1.0f.xxx.y, _998.z ? _2328.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _2294 : (isnan(_2294) ? 0.0f : min(_2294, 0.0f))))) * ((_1963 * _2297) + (_384 * (_2164.x - _2297)));
                                break;
                            } while(false);
                            float4 _2338 = View_SSProfilesTexture.Load(int3(int3(3, _1920, 0).xy, 0));
                            float _2340 = mad(_2338.z, 2.0f, -1.0f);
                            float _2360 = -_2340;
                            float _2361 = mad(_2360, dot(-_947, refract(_472, -_337, _2338.w)), 1.0f);
                            float _2362 = _2361 * _2361;
                            _3504 = ((_1004 * (_948 * _961)) * (_377 * ((0.3183098733425140380859375f * mad(_1943, (_1945 * _1945) * _1944, 1.0f)) * mad(_1943, (_1950 * _1950) * _1949, 1.0f)))) * 1.0f;
                            _3505 = lerp(_2148, _2332, _1924.z.xxx);
                            _3506 = (_1004 * View_SSProfilesTexture.SampleLevel(View_SSProfilesTransmissionSampler, float2(mad(1.0f - _521, 31.0f, 34.0f) + 0.5f, float(_1919) + 0.5f) / View_View_SSProfilesTextureSizeAndInvSize.xy, 0.0f).xyz) * (_948 * ((0.5f * mad(_2360, _2340, 1.0f)) / (isnan(_2362) ? 9.9999997473787516355514526367188e-06f : (isnan(9.9999997473787516355514526367188e-06f) ? _2362 : max(9.9999997473787516355514526367188e-06f, _2362)))));
                            break;
                        }
                        case 6u:
                        {
                            float3 _1888 = 0.0f.xxx;
                            do
                            {
                                if ((_865.x == 0.0f) || (_865.y == 0.0f))
                                {
                                    _1888 = 0.0f.xxx;
                                    break;
                                }
                                float _1704 = dot(_337, _472);
                                float2 _1712 = (float2(_1005, sqrt(1.0f - clamp(abs(_1704) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f))) * 0.984375f) + 0.0078125f.xx;
                                float4 _1716 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _1712, 0.0f);
                                float4 _1720 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _1712, 0.0f);
                                float _1721 = _1716.x;
                                float _1722 = _1716.z;
                                float _1723 = _1716.y;
                                float _1724 = _1716.w;
                                float4 _1732 = _1716 / mad(_1721, _1724, -(_1723 * _1722)).xxxx;
                                float3 _1744 = normalize(_472 - (_337 * _1704));
                                float3x3 _1746 = float3x3(_1744, cross(_337, _1744), _337);
                                float3x3 _1747 = mul(float3x3(float3(_1721, 0.0f, _1722), float3(0.0f, 1.0f, 0.0f), float3(_1723, 0.0f, _1724)), _1746);
                                float3 _1750 = _801 * _865.x;
                                float3 _1751 = _864 - _1750;
                                float3 _1752 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _1755 = _864 + _1750;
                                float3 _1762 = normalize(mul(_1747, _1751 - _1752));
                                float3 _1763 = normalize(mul(_1747, _1755 - _1752));
                                float3 _1764 = normalize(mul(_1747, _1755 + _1752));
                                float3 _1765 = normalize(mul(_1747, _1751 + _1752));
                                float _1766 = dot(_1762, _1763);
                                float _1767 = abs(_1766);
                                float _1772 = mad(mad(0.01452060043811798095703125f, _1767, 0.4965155124664306640625f), _1767, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1767, _1767, 3.41759395599365234375f);
                                float _1780 = dot(_1763, _1764);
                                float _1781 = abs(_1780);
                                float _1786 = mad(mad(0.01452060043811798095703125f, _1781, 0.4965155124664306640625f), _1781, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1781, _1781, 3.41759395599365234375f);
                                float _1794 = dot(_1764, _1765);
                                float _1795 = abs(_1794);
                                float _1800 = mad(mad(0.01452060043811798095703125f, _1795, 0.4965155124664306640625f), _1795, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1795, _1795, 3.41759395599365234375f);
                                float _1808 = dot(_1765, _1762);
                                float _1809 = abs(_1808);
                                float _1814 = mad(mad(0.01452060043811798095703125f, _1809, 0.4965155124664306640625f), _1809, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1809, _1809, 3.41759395599365234375f);
                                float3 _1832 = cross(_1763, (_1762 * (-((_1766 > 0.0f) ? _1772 : mad(0.5f, rsqrt(mad(-_1766, _1766, 1.0f)), -_1772)))) + (_1764 * ((_1780 > 0.0f) ? _1786 : mad(0.5f, rsqrt(mad(-_1780, _1780, 1.0f)), -_1786)))) + cross(_1765, (_1762 * ((_1808 > 0.0f) ? _1814 : mad(0.5f, rsqrt(mad(-_1808, _1808, 1.0f)), -_1814))) + (_1764 * (-((_1794 > 0.0f) ? _1800 : mad(0.5f, rsqrt(mad(-_1794, _1794, 1.0f)), -_1800)))));
                                float _1833 = dot(_1832, _1832);
                                float _1834 = rsqrt(_1833);
                                float _1835 = _1833 * _1834;
                                float3 _1836 = _1832 * _1834;
                                float _1837 = _1836.z;
                                float _1838 = sqrt(_1835);
                                float _1848 = 0.0f;
                                if (_1837 < _1838)
                                {
                                    float _1842 = -_1838;
                                    float _1844 = _1838 + (isnan(_1842) ? _1837 : (isnan(_1837) ? _1842 : max(_1837, _1842)));
                                    _1848 = (_1844 * _1844) / (4.0f * _1838);
                                }
                                else
                                {
                                    _1848 = _1837;
                                }
                                float _1850 = -(_1835 * _1848);
                                float _1853 = _1720.y;
                                float3 _1859 = mul(mul(transpose(_1746), float3x3(float3(_1732.w, 0.0f, -_1732.z), float3(0.0f, 1.0f, 0.0f), float3(-_1732.y, 0.0f, _1732.x))), _1836);
                                float3 _1864 = _1859 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _1859), 0.0f, 1.0f));
                                float _1866 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _1864);
                                float3 _1868 = (_1864 * _1866) - _864;
                                float2 _1870 = 0.0f.xx;
                                _1870.x = dot(_801, _1868);
                                _1870.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _1868);
                                float _1878 = log2(_1866 * _981) + _993;
                                float3 _1884 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_1870 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _1878 : (isnan(_1878) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_1878, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _1888 = (float3(_998.x ? _1884.x : 1.0f.xxx.x, _998.y ? _1884.y : 1.0f.xxx.y, _998.z ? _1884.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _1850 : (isnan(_1850) ? 0.0f : min(_1850, 0.0f))))) * ((clamp(_384 * 50.0f, 0.0f.xxx, 1.0f.xxx) * _1853) + (_384 * (_1720.x - _1853)));
                                break;
                            } while(false);
                            float3 _1890 = _327.xyz;
                            float _1897 = clamp(-dot(_472, _947), 0.0f, 1.0f);
                            float _1900 = mad(mad(_1897, 0.36000001430511474609375f, -_1897), _1897, 1.0f);
                            _3504 = ((_377 * 0.3183098733425140380859375f) * (_1004 * (_948 * _961))) * 1.0f;
                            _3505 = _1888;
                            _3506 = (_1004 * ((_948 * clamp((0.5f - _950) * 0.4444444477558135986328125f, 0.0f, 1.0f)) * (0.36000001430511474609375f / ((3.1415927410125732421875f * _1900) * _1900)))) * (_1890 * _1890);
                            break;
                        }
                        case 7u:
                        {
                            float _1513 = clamp(_1005, 0.0039215688593685626983642578125f, 1.0f);
                            float _1514 = isnan(1.0f) ? 1.0f : (isnan(1.0f) ? 1.0f : min(1.0f, 1.0f));
                            float _1515 = dot(_472, _947);
                            float _1516 = clamp(_950, -1.0f, 1.0f);
                            float _1518 = clamp(dot(_337, _472), -1.0f, 1.0f);
                            float _1519 = abs(_1518);
                            float _1520 = mad(-0.15658299624919891357421875f, _1519, 1.57079637050628662109375f);
                            float _1522 = sqrt(1.0f - _1519);
                            float _1529 = abs(_1516);
                            float _1530 = mad(-0.15658299624919891357421875f, _1529, 1.57079637050628662109375f);
                            float _1532 = sqrt(1.0f - _1529);
                            float _1542 = cos(0.5f * abs((1.57079637050628662109375f - ((_1518 >= 0.0f) ? (_1520 * _1522) : mad(-_1520, _1522, 3.1415927410125732421875f))) - (1.57079637050628662109375f - ((_1516 >= 0.0f) ? (_1530 * _1532) : mad(-_1530, _1532, 3.1415927410125732421875f)))));
                            float3 _1544 = _947 - (_337 * _1516);
                            float3 _1546 = _472 - (_337 * _1518);
                            float _1552 = dot(_1544, _1546) * rsqrt(mad(dot(_1544, _1544), dot(_1546, _1546), 9.9999997473787516355514526367188e-05f));
                            float _1555 = sqrt(clamp(mad(0.5f, _1552, 0.5f), 0.0f, 1.0f));
                            float _1558 = _1513 * _1513;
                            float _1559 = _1558 * 0.5f;
                            float _1560 = _1558 * 2.0f;
                            float _1568 = _1558 * (1.41421353816986083984375f * _1555);
                            float _1569 = _1516 + _1518;
                            float _1570 = mad(0.1398856937885284423828125f, mad(0.997551023960113525390625f * _1555, sqrt(mad(-_1518, _1518, 1.0f)), (-0.06994284689426422119140625f) * _1518), _1569);
                            float _1582 = 1.0f - sqrt(clamp(mad(0.5f, _1515, 0.5f), 0.0f, 1.0f));
                            float _1583 = _1582 * _1582;
                            float _1596 = _1569 - 0.0350000001490116119384765625f;
                            float _1604 = 1.0f / mad(0.36000001430511474609375f, _1542, 1.190000057220458984375f / _1542);
                            float _1607 = _1555 * mad(_1604, mad(-0.800000011920928955078125f, _1552, 0.60000002384185791015625f), 1.0f);
                            float _1612 = -_1542;
                            float _1613 = mad(_1612, sqrt(clamp(mad(-_1607, _1607, 1.0f), 0.0f, 1.0f)), 1.0f);
                            float _1614 = _1613 * _1613;
                            float _1618 = 1.0f - mad(0.95347940921783447265625f, (_1614 * _1614) * _1613, 0.0465205647051334381103515625f);
                            float3 _1620 = abs(_368);
                            float _1621 = _1607 * _1604;
                            float _1636 = _1569 - 0.14000000059604644775390625f;
                            float _1644 = mad(_1612, 0.5f, 1.0f);
                            float _1645 = _1644 * _1644;
                            float _1648 = mad(0.95347940921783447265625f, (_1645 * _1645) * _1644, 0.0465205647051334381103515625f);
                            float _1649 = 1.0f - _1648;
                            float3 _1661 = (((((((exp(((-0.5f) * (_1570 * _1570)) / (_1568 * _1568)) / (2.5066282749176025390625f * _1568)) * (0.25f * _1555)) * mad(0.95347940921783447265625f, (_1583 * _1583) * _1582, 0.0465205647051334381103515625f)) * (_369 * 2.0f)) * lerp(1.0f, _1514, clamp(-_1515, 0.0f, 1.0f))).xxx + ((pow(_1620, ((0.5f * sqrt(mad(-_1621, _1621, 1.0f))) / _1542).xxx) * (((exp(((-0.5f) * (_1596 * _1596)) / (_1559 * _1559)) / (_1558 * 1.25331413745880126953125f)) * exp(mad(-3.650000095367431640625f, _1552, -3.980000019073486328125f))) * (_1618 * _1618))) * _1514)) + (pow(_1620, (0.800000011920928955078125f / _1542).xxx) * (((exp(((-0.5f) * (_1636 * _1636)) / (_1560 * _1560)) / (_1558 * 5.013256549835205078125f)) * exp(mad(17.0f, _1552, -16.7800006866455078125f))) * ((_1649 * _1649) * _1648)))) * _794;
                            float _1675 = dot(_368, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                            float3 _1686 = -mad(sqrt(_1620) * ((0.3183098733425140380859375f * lerp(clamp((dot(normalize(_472 - (_337 * dot(_472, _337))), _947) + 1.0f) * 0.25f, 0.0f, 1.0f), 1.0f - abs(_950), 0.3300000131130218505859375f)) * _339), pow(abs(_368 / (isnan(9.9999997473787516355514526367188e-05f) ? _1675 : (isnan(_1675) ? 9.9999997473787516355514526367188e-05f : max(_1675, 9.9999997473787516355514526367188e-05f))).xxx), (1.0f - _793).xxx), _1661);
                            bool3 _3874 = isnan(_1686);
                            bool3 _3875 = isnan(0.0f.xxx);
                            float3 _3876 = min(_1686, 0.0f.xxx);
                            float3 _3877 = float3(_3874.x ? 0.0f.xxx.x : _3876.x, _3874.y ? 0.0f.xxx.y : _3876.y, _3874.z ? 0.0f.xxx.z : _3876.z);
                            _3504 = 0.0f.xxx;
                            _3505 = 0.0f.xxx;
                            _3506 = (_1004 * _948) * (-float3(_3875.x ? _1686.x : _3877.x, _3875.y ? _1686.y : _3877.y, _3875.z ? _1686.z : _3877.z));
                            break;
                        }
                        case 8u:
                        {
                            float3 _1266 = _327.xyz;
                            float3 _1267 = _1266 * _1266;
                            float _1268 = clamp(_499, 0.0f, 1.0f);
                            float _1269 = dot(_337, _472);
                            float _1270 = dot(_472, _947);
                            float _1272 = rsqrt(mad(2.0f, _1270, 2.0f));
                            float _1275 = clamp((_950 + _1269) * _1272, 0.0f, 1.0f);
                            float _1280 = clamp(abs(_1269) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                            float3 _1470 = 0.0f.xxx;
                            do
                            {
                                if ((_865.x == 0.0f) || (_865.y == 0.0f))
                                {
                                    _1470 = 0.0f.xxx;
                                    break;
                                }
                                float2 _1294 = (float2(_1005, sqrt(1.0f - _1280)) * 0.984375f) + 0.0078125f.xx;
                                float4 _1298 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _1294, 0.0f);
                                float4 _1302 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _1294, 0.0f);
                                float _1303 = _1298.x;
                                float _1304 = _1298.z;
                                float _1305 = _1298.y;
                                float _1306 = _1298.w;
                                float4 _1314 = _1298 / mad(_1303, _1306, -(_1305 * _1304)).xxxx;
                                float3 _1326 = normalize(_472 - (_337 * _1269));
                                float3x3 _1328 = float3x3(_1326, cross(_337, _1326), _337);
                                float3x3 _1329 = mul(float3x3(float3(_1303, 0.0f, _1304), float3(0.0f, 1.0f, 0.0f), float3(_1305, 0.0f, _1306)), _1328);
                                float3 _1332 = _801 * _865.x;
                                float3 _1333 = _864 - _1332;
                                float3 _1334 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _1337 = _864 + _1332;
                                float3 _1344 = normalize(mul(_1329, _1333 - _1334));
                                float3 _1345 = normalize(mul(_1329, _1337 - _1334));
                                float3 _1346 = normalize(mul(_1329, _1337 + _1334));
                                float3 _1347 = normalize(mul(_1329, _1333 + _1334));
                                float _1348 = dot(_1344, _1345);
                                float _1349 = abs(_1348);
                                float _1354 = mad(mad(0.01452060043811798095703125f, _1349, 0.4965155124664306640625f), _1349, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1349, _1349, 3.41759395599365234375f);
                                float _1362 = dot(_1345, _1346);
                                float _1363 = abs(_1362);
                                float _1368 = mad(mad(0.01452060043811798095703125f, _1363, 0.4965155124664306640625f), _1363, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1363, _1363, 3.41759395599365234375f);
                                float _1376 = dot(_1346, _1347);
                                float _1377 = abs(_1376);
                                float _1382 = mad(mad(0.01452060043811798095703125f, _1377, 0.4965155124664306640625f), _1377, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1377, _1377, 3.41759395599365234375f);
                                float _1390 = dot(_1347, _1344);
                                float _1391 = abs(_1390);
                                float _1396 = mad(mad(0.01452060043811798095703125f, _1391, 0.4965155124664306640625f), _1391, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1391, _1391, 3.41759395599365234375f);
                                float3 _1414 = cross(_1345, (_1344 * (-((_1348 > 0.0f) ? _1354 : mad(0.5f, rsqrt(mad(-_1348, _1348, 1.0f)), -_1354)))) + (_1346 * ((_1362 > 0.0f) ? _1368 : mad(0.5f, rsqrt(mad(-_1362, _1362, 1.0f)), -_1368)))) + cross(_1347, (_1344 * ((_1390 > 0.0f) ? _1396 : mad(0.5f, rsqrt(mad(-_1390, _1390, 1.0f)), -_1396))) + (_1346 * (-((_1376 > 0.0f) ? _1382 : mad(0.5f, rsqrt(mad(-_1376, _1376, 1.0f)), -_1382)))));
                                float _1415 = dot(_1414, _1414);
                                float _1416 = rsqrt(_1415);
                                float _1417 = _1415 * _1416;
                                float3 _1418 = _1414 * _1416;
                                float _1419 = _1418.z;
                                float _1420 = sqrt(_1417);
                                float _1430 = 0.0f;
                                if (_1419 < _1420)
                                {
                                    float _1424 = -_1420;
                                    float _1426 = _1420 + (isnan(_1424) ? _1419 : (isnan(_1419) ? _1424 : max(_1419, _1424)));
                                    _1430 = (_1426 * _1426) / (4.0f * _1420);
                                }
                                else
                                {
                                    _1430 = _1419;
                                }
                                float _1432 = -(_1417 * _1430);
                                float _1435 = _1302.y;
                                float3 _1441 = mul(mul(transpose(_1328), float3x3(float3(_1314.w, 0.0f, -_1314.z), float3(0.0f, 1.0f, 0.0f), float3(-_1314.y, 0.0f, _1314.x))), _1418);
                                float3 _1446 = _1441 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _1441), 0.0f, 1.0f));
                                float _1448 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _1446);
                                float3 _1450 = (_1446 * _1448) - _864;
                                float2 _1452 = 0.0f.xx;
                                _1452.x = dot(_801, _1450);
                                _1452.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _1450);
                                float _1460 = log2(_1448 * _981) + _993;
                                float3 _1466 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_1452 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _1460 : (isnan(_1460) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_1460, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _1470 = (float3(_998.x ? _1466.x : 1.0f.xxx.x, _998.y ? _1466.y : 1.0f.xxx.y, _998.z ? _1466.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _1432 : (isnan(_1432) ? 0.0f : min(_1432, 0.0f))))) * ((clamp(_384 * 50.0f, 0.0f.xxx, 1.0f.xxx) * _1435) + (_384 * (_1302.x - _1435)));
                                break;
                            } while(false);
                            float _1471 = _1005 * _1005;
                            float _1472 = _1471 * _1471;
                            float _1475 = mad(mad(-_1472, _1275, _1275), _1275, _1472);
                            float _1488 = 1.0f - clamp(mad(_1272, _1270, _1272), 0.0f, 1.0f);
                            float _1489 = _1488 * _1488;
                            float _1490 = _1489 * _1489;
                            float3 _1502 = _1004 * (_948 * _961);
                            _3504 = (_1502 * (_377 * 0.3183098733425140380859375f)) * lerp(1.0f, 1.0f, _1268);
                            _3505 = lerp(_1470, ((_1502 * (((0.3183098733425140380859375f / mad(4.0f, _1472, 1.0f)) * (1.0f + (((4.0f * _1472) * _1472) / (_1475 * _1475)))) * (0.25f / mad(-_961, _1280, _961 + _1280)))) * ((clamp(50.0f * _1267.y, 0.0f, 1.0f) * (_1490 * _1488)).xxx + (_1267 * mad(-_1490, _1488, 1.0f)))) * 1.0f, _1268.xxx);
                            _3506 = 0.0f.xxx;
                            break;
                        }
                        case 9u:
                        {
                            float2 _1021 = (_327.yz * 2.0f) - 1.0f.xx;
                            float _1023 = dot(1.0f.xx, abs(_1021));
                            float3 _1027 = float3(_1021, 1.0f - _1023);
                            float _1028 = _1023 - 1.0f;
                            float _1029 = isnan(0.0f) ? _1028 : (isnan(_1028) ? 0.0f : max(_1028, 0.0f));
                            float2 _1030 = _1027.xy;
                            bool2 _1031 = bool2(_1030.x >= 0.0f.xx.x, _1030.y >= 0.0f.xx.y);
                            float _1032 = -_1029;
                            float2 _1038 = _1030 + float2(_1031.x ? _1032 : _1029, _1031.y ? _1032 : _1029);
                            float3 _1040 = normalize(float3(_1038.x, _1038.y, _1027.z));
                            float _1041 = 1.0f - _499;
                            float _1047 = dot(_337, _472);
                            float _1051 = _369 * 0.07999999821186065673828125f;
                            float _1052 = 1.0f - clamp(abs(_1047) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                            float _1053 = _1052 * _1052;
                            float _1054 = _1053 * _1053;
                            float3 _1059 = _1051.xxx;
                            float3 _1248 = 0.0f.xxx;
                            do
                            {
                                if ((_865.x == 0.0f) || (_865.y == 0.0f))
                                {
                                    _1248 = 0.0f.xxx;
                                    break;
                                }
                                float2 _1072 = (float2(_1005, sqrt(_1052)) * 0.984375f) + 0.0078125f.xx;
                                float4 _1076 = View_LTCMatTexture.SampleLevel(View_LTCMatSampler, _1072, 0.0f);
                                float4 _1080 = View_LTCAmpTexture.SampleLevel(View_LTCAmpSampler, _1072, 0.0f);
                                float _1081 = _1076.x;
                                float _1082 = _1076.z;
                                float _1083 = _1076.y;
                                float _1084 = _1076.w;
                                float4 _1092 = _1076 / mad(_1081, _1084, -(_1083 * _1082)).xxxx;
                                float3 _1104 = normalize(_472 - (_337 * _1047));
                                float3x3 _1106 = float3x3(_1104, cross(_337, _1104), _337);
                                float3x3 _1107 = mul(float3x3(float3(_1081, 0.0f, _1082), float3(0.0f, 1.0f, 0.0f), float3(_1083, 0.0f, _1084)), _1106);
                                float3 _1110 = _801 * _865.x;
                                float3 _1111 = _864 - _1110;
                                float3 _1112 = DeferredLightUniforms_DeferredLightUniforms_Tangent * _865.y;
                                float3 _1115 = _864 + _1110;
                                float3 _1122 = normalize(mul(_1107, _1111 - _1112));
                                float3 _1123 = normalize(mul(_1107, _1115 - _1112));
                                float3 _1124 = normalize(mul(_1107, _1115 + _1112));
                                float3 _1125 = normalize(mul(_1107, _1111 + _1112));
                                float _1126 = dot(_1122, _1123);
                                float _1127 = abs(_1126);
                                float _1132 = mad(mad(0.01452060043811798095703125f, _1127, 0.4965155124664306640625f), _1127, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1127, _1127, 3.41759395599365234375f);
                                float _1140 = dot(_1123, _1124);
                                float _1141 = abs(_1140);
                                float _1146 = mad(mad(0.01452060043811798095703125f, _1141, 0.4965155124664306640625f), _1141, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1141, _1141, 3.41759395599365234375f);
                                float _1154 = dot(_1124, _1125);
                                float _1155 = abs(_1154);
                                float _1160 = mad(mad(0.01452060043811798095703125f, _1155, 0.4965155124664306640625f), _1155, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1155, _1155, 3.41759395599365234375f);
                                float _1168 = dot(_1125, _1122);
                                float _1169 = abs(_1168);
                                float _1174 = mad(mad(0.01452060043811798095703125f, _1169, 0.4965155124664306640625f), _1169, 0.8543984889984130859375f) / mad(4.1616725921630859375f + _1169, _1169, 3.41759395599365234375f);
                                float3 _1192 = cross(_1123, (_1122 * (-((_1126 > 0.0f) ? _1132 : mad(0.5f, rsqrt(mad(-_1126, _1126, 1.0f)), -_1132)))) + (_1124 * ((_1140 > 0.0f) ? _1146 : mad(0.5f, rsqrt(mad(-_1140, _1140, 1.0f)), -_1146)))) + cross(_1125, (_1122 * ((_1168 > 0.0f) ? _1174 : mad(0.5f, rsqrt(mad(-_1168, _1168, 1.0f)), -_1174))) + (_1124 * (-((_1154 > 0.0f) ? _1160 : mad(0.5f, rsqrt(mad(-_1154, _1154, 1.0f)), -_1160)))));
                                float _1193 = dot(_1192, _1192);
                                float _1194 = rsqrt(_1193);
                                float _1195 = _1193 * _1194;
                                float3 _1196 = _1192 * _1194;
                                float _1197 = _1196.z;
                                float _1198 = sqrt(_1195);
                                float _1208 = 0.0f;
                                if (_1197 < _1198)
                                {
                                    float _1202 = -_1198;
                                    float _1204 = _1198 + (isnan(_1202) ? _1197 : (isnan(_1197) ? _1202 : max(_1197, _1202)));
                                    _1208 = (_1204 * _1204) / (4.0f * _1198);
                                }
                                else
                                {
                                    _1208 = _1197;
                                }
                                float _1210 = -(_1195 * _1208);
                                float _1213 = _1080.y;
                                float3 _1219 = mul(mul(transpose(_1106), float3x3(float3(_1092.w, 0.0f, -_1092.z), float3(0.0f, 1.0f, 0.0f), float3(-_1092.y, 0.0f, _1092.x))), _1196);
                                float3 _1224 = _1219 + (DeferredLightUniforms_DeferredLightUniforms_Direction * clamp(0.001000000047497451305389404296875f - dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _1219), 0.0f, 1.0f));
                                float _1226 = _876 / dot(DeferredLightUniforms_DeferredLightUniforms_Direction, _1224);
                                float3 _1228 = (_1224 * _1226) - _864;
                                float2 _1230 = 0.0f.xx;
                                _1230.x = dot(_801, _1228);
                                _1230.y = dot(DeferredLightUniforms_DeferredLightUniforms_Tangent, _1228);
                                float _1238 = log2(_1226 * _981) + _993;
                                float3 _1244 = View_RectLightAtlasTexture.SampleLevel(View_SharedTrilinearClampedSampler, mad(clamp(mad((_1230 + _866) / _976, float2(0.5f, -0.5f), 0.5f.xx), 0.0f.xx, 1.0f.xx), DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVScale, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasUVOffset), isnan(DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel) ? _1238 : (isnan(_1238) ? DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel : min(_1238, DeferredLightUniforms_DeferredLightUniforms_RectLightAtlasMaxLevel))).xyz;
                                _1248 = (float3(_998.x ? _1244.x : 1.0f.xxx.x, _998.y ? _1244.y : 1.0f.xxx.y, _998.z ? _1244.z : 1.0f.xxx.z) * (-(isnan(0.0f) ? _1210 : (isnan(_1210) ? 0.0f : min(_1210, 0.0f))))) * ((clamp(_1059 * 50.0f, 0.0f.xxx, 1.0f.xxx) * _1213) + (_1059 * (_1080.x - _1213)));
                                break;
                            } while(false);
                            float _1250 = clamp(dot(_1040, _947), 0.0f, 1.0f);
                            float _1251 = lerp(12.0f, 1.0f, _1250);
                            _3504 = 0.0f.xxx;
                            _3505 = _1248;
                            _3506 = (_1004 * ((_948 * lerp(_961, _1250 * mad(0.20000000298023223876953125f * (_1251 + 1.0f), pow(clamp(dot(normalize(lerp(_1040, -_337, (_1041 * _274).xxx)), _947), 0.0f, 1.0f), _1251), 0.800000011920928955078125f), _1041)) * (1.0f - mad(_1054, _1052, mad(-_1054, _1052, 1.0f) * _1051)))) * (_377 * 0.3183098733425140380859375f);
                            break;
                        }
                        default:
                        {
                            _3504 = 0.0f.xxx;
                            _3505 = 0.0f.xxx;
                            _3506 = 0.0f.xxx;
                            break;
                        }
                    }
                    _3507 = _3504;
                    _3508 = _3505;
                    _3509 = _3506;
                }
                else
                {
                    _3507 = 0.0f.xxx;
                    _3508 = 0.0f.xxx;
                    _3509 = 0.0f.xxx;
                }
                float3 _3511 = _495 * _794;
                float _3522 = 0.0f;
                if (_344)
                {
                    float _3521 = 0.0f;
                    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                    {
                        _3521 = dot(_3507 * _3511, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    }
                    else
                    {
                        _3521 = 0.0f;
                    }
                    _3522 = _3521;
                }
                else
                {
                    _3522 = 0.0f;
                }
                float3 _3524 = _495 * _793;
                float _3536 = 0.0f;
                if (_344)
                {
                    float _3535 = 0.0f;
                    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                    {
                        _3535 = _3522 + dot(_3509 * _3524, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    }
                    else
                    {
                        _3535 = _3522;
                    }
                    _3536 = _3535;
                }
                else
                {
                    _3536 = _3522;
                }
                _3539 = _3536;
                _3540 = mad(_3507, _3511, _3509 * _3524);
                _3541 = (_3508 * DeferredLightUniforms_DeferredLightUniforms_SpecularScale) * _3511;
            }
            else
            {
                _3539 = 0.0f;
                _3540 = 0.0f.xxx;
                _3541 = 0.0f.xxx;
            }
            _3542 = _3539;
            _3543 = _3540;
            _3544 = _3541;
        }
        else
        {
            _3542 = 0.0f;
            _3543 = 0.0f.xxx;
            _3544 = 0.0f.xxx;
        }
        float4 _3548 = float4(_3543, 0.0f);
        float4 _3559 = 0.0f.xxxx;
        if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
        {
            float4 _3558 = _3548;
            _3558.w = _3542;
            _3559 = _3558;
        }
        else
        {
            _3559 = _3548;
        }
        _3561 = float4(_3544, 0.0f) + _3559;
    }
    else
    {
        _3561 = 0.0f.xxxx;
    }
    out_var_SV_Target0 = _3561 * View_View_PreExposure;
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

#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
static float4 _179 = 0.0f.xxxx;
static float _180 = 0.0f;

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
    float2 DeferredLightUniforms_DeferredLightUniforms_DistanceFadeMAD : packoffset(c1);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength : packoffset(c1.z);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : packoffset(c1.w);
    float DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity : packoffset(c2);
    uint DeferredLightUniforms_DeferredLightUniforms_ShadowedBits : packoffset(c2.z);
    float3 DeferredLightUniforms_DeferredLightUniforms_Color : packoffset(c4);
    float3 DeferredLightUniforms_DeferredLightUniforms_Direction : packoffset(c5);
    float DeferredLightUniforms_DeferredLightUniforms_SpecularScale : packoffset(c5.w);
    float DeferredLightUniforms_DeferredLightUniforms_SourceRadius : packoffset(c6.w);
    float DeferredLightUniforms_DeferredLightUniforms_SoftSourceRadius : packoffset(c7.z);
};

Texture2D<float4> View_PreIntegratedBRDF;
SamplerState View_PreIntegratedBRDFSampler;
Texture2D<float4> View_SSProfilesTexture;
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
    float4 _194 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float _195 = _194.x;
    float _205 = -View_View_InvDeviceZToWorldZTransform.w;
    float _208 = mad(_195, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_195, View_View_InvDeviceZToWorldZTransform.z, _205));
    float4 _211 = SceneTexturesStruct_GBufferFTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float4 _214 = SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float4 _217 = SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float4 _220 = SceneTexturesStruct_GBufferCTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float4 _223 = SceneTexturesStruct_GBufferDTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    float4 _226 = SceneTexturesStruct_GBufferETexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
    uint2 _231 = uint2(in_var_TEXCOORD0 * View_View_BufferSizeAndInvSize.xy);
    bool _240 = (((_231.x + _231.y) + uint(View_View_TemporalAAParams.x)) % 2u) != 0u;
    float3 _242 = 0.0f.xxx;
    _242.x = _214.x;
    _242.y = _214.y;
    _242.z = _214.z;
    float _247 = _217.x;
    float _248 = _217.y;
    float _249 = _217.z;
    uint _252 = uint(mad(_217.w, 255.0f, 0.5f));
    uint _255 = ((_252 >> 0u) & 15u) << 0u;
    uint _258 = ((_252 >> 4u) & 15u) << 0u;
    float3 _260 = 0.0f.xxx;
    _260.x = _220.x;
    _260.y = _220.y;
    _260.z = _220.z;
    float4 _266 = 0.0f.xxxx;
    _266.x = _226.x;
    _266.y = _226.y;
    _266.z = _226.z;
    _266.w = _226.w;
    float4 _274 = 0.0f.xxxx;
    _274.x = _223.x;
    _274.y = _223.y;
    _274.z = _223.z;
    _274.w = _223.w;
    int _285 = int(_255);
    bool _288 = (_285 == 2) || (_285 == 3);
    bool _291 = _285 == 5;
    bool _293 = _285 == 6;
    bool _295 = _285 == 7;
    bool _299 = _285 == 9;
    bool4 _301 = ((((((_288 || (_285 == 4)) || _291) || _293) || _295) || (_285 == 8)) || _299).xxxx;
    float4 _302 = float4(_301.x ? _274.x : 0.0f.xxxx.x, _301.y ? _274.y : 0.0f.xxxx.y, _301.z ? _274.z : 0.0f.xxxx.z, _301.w ? _274.w : 0.0f.xxxx.w);
    bool4 _306 = (!((_258 & 2u) != 0u)).xxxx;
    float4 _310 = (((_258 & 4u) != 0u) ? 0.0f : 1.0f).xxxx;
    float3 _314 = normalize((_242 * 2.0f) - 1.0f.xxx);
    bool _315 = _255 == 9u;
    float _316 = _315 ? 0.0f : _247;
    float3 _319 = _316.xxx;
    float3 _320 = lerp((0.07999999821186065673828125f * _248).xxx, _260, _319);
    bool _321 = _291 || _299;
    float3 _345 = 0.0f.xxx;
    float _346 = 0.0f;
    float3 _347 = 0.0f.xxx;
    if (_321)
    {
        bool3 _332 = (View_View_bSubsurfacePostprocessEnabled != 0.0f).xxx;
        float3 _342 = 0.0f.xxx;
        float _343 = 0.0f;
        float3 _344 = 0.0f.xxx;
        if ((View_View_bSubsurfacePostprocessEnabled > 0.0f) && (View_View_bCheckerboardSubsurfaceProfileRendering > 0.0f))
        {
            float _339 = float(!_240);
            _342 = float(_240).xxx;
            _343 = _248 * _339;
            _344 = _320 * _339;
        }
        else
        {
            _342 = float3(_332.x ? 1.0f.xxx.x : _260.x, _332.y ? 1.0f.xxx.y : _260.y, _332.z ? 1.0f.xxx.z : _260.z);
            _343 = _248;
            _344 = _320;
        }
        _345 = _342;
        _346 = _343;
        _347 = _344;
    }
    else
    {
        _345 = _260;
        _346 = _248;
        _347 = _320;
    }
    float3 _354 = mad(_345 - (_345 * _316), View_View_DiffuseOverrideParameter.www, View_View_DiffuseOverrideParameter.xyz);
    float3 _361 = (_347 * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    float3 _369 = 0.0f.xxx;
    float _370 = 0.0f;
    if ((_258 & 1u) != 0u)
    {
        _369 = normalize((_211.xyz * 2.0f) - 1.0f.xxx);
        _370 = mad(_211.w, 2.0f, -1.0f);
    }
    else
    {
        _369 = 0.0f.xxx;
        _370 = 0.0f;
    }
    uint _371 = _258 << 4u;
    float4 _3044 = 0.0f.xxxx;
    [branch]
    if (_255 > 0u)
    {
        float4 _380 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f);
        float _381 = _380.x;
        float3 _390 = normalize(in_var_TEXCOORD1);
        float _403 = abs(DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength);
        float4 _427 = LightAttenuationTexture.SampleLevel(LightAttenuationTextureSampler, in_var_TEXCOORD0, 0.0f);
        float4 _428 = _427 * _427;
        float3 _429 = -_390;
        float _430 = _302.w;
        float _433 = View_View_ClipToView[1u].y * _208;
        float _463 = 0.0f;
        float _464 = 0.0f;
        float _465 = 0.0f;
        float _466 = 0.0f;
        [branch]
        if (DeferredLightUniforms_DeferredLightUniforms_ShadowedBits != 0u)
        {
            float _439 = lerp(1.0f, dot(float4(_306.x ? _266.x : _310.x, _306.y ? _266.y : _310.y, _306.z ? _266.z : _310.z, _306.w ? _266.w : _310.w), DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask), dot(DeferredLightUniforms_DeferredLightUniforms_ShadowMapChannelMask, 1.0f.xxxx));
            float _443 = clamp(mad(_208, DeferredLightUniforms_DeferredLightUniforms_DistanceFadeMAD.x, DeferredLightUniforms_DeferredLightUniforms_DistanceFadeMAD.y), 0.0f, 1.0f);
            float _444 = _443 * _443;
            float _447 = _428.y;
            float _448 = lerp(_447, _439, _444);
            float _449 = _428.w;
            float _451 = _428.z;
            float _462 = 0.0f;
            [flatten]
            if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits > 1u) && (_403 > 0.0f))
            {
                _462 = _403 * ((DeferredLightUniforms_DeferredLightUniforms_ContactShadowLength < 0.0f) ? 1.0f : _433);
            }
            else
            {
                _462 = 0.0f;
            }
            _463 = isnan(_449) ? _447 : (isnan(_447) ? _449 : min(_447, _449));
            _464 = (isnan(_449) ? _448 : (isnan(_448) ? _449 : min(_448, _449))) * _451;
            _465 = lerp(_428.x, _439, _444) * _451;
            _466 = _462;
        }
        else
        {
            _463 = 1.0f;
            _464 = 1.0f;
            _465 = SceneTexturesStruct_ScreenSpaceAOTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, in_var_TEXCOORD0, 0.0f).x;
            _466 = 0.0f;
        }
        float _473 = 0.0f;
        if ((DeferredLightUniforms_DeferredLightUniforms_ShadowedBits < 2u) && (_255 == 7u))
        {
            _473 = 0.20000000298023223876953125f * _433;
        }
        else
        {
            _473 = _466;
        }
        float _474 = _315 ? 0.5f : _473;
        float _740 = 0.0f;
        float _741 = 0.0f;
        [branch]
        if (_474 > 0.0f)
        {
            float4 _485 = mul(float4((in_var_TEXCOORD1 * (mad(_381, View_View_InvDeviceZToWorldZTransform.x, View_View_InvDeviceZToWorldZTransform.y) + (1.0f / mad(_381, View_View_InvDeviceZToWorldZTransform.z, _205)))) + View_View_TranslatedWorldCameraOrigin, 1.0f), View_View_TranslatedWorldToClip);
            float4 _492 = _485 + mul(float4(DeferredLightUniforms_DeferredLightUniforms_Direction * _474, 0.0f), View_View_TranslatedWorldToClip);
            float3 _496 = _485.xyz / _485.w.xxx;
            float3 _501 = (_492.xyz / _492.w.xxx) - _496;
            float _508 = _496.z;
            float3 _511 = float3(mad(_496.xy, View_View_ScreenPositionScaleBias.xy, View_View_ScreenPositionScaleBias.wz), _508);
            float3 _517 = float3(_501.xy * View_View_ScreenPositionScaleBias.xy, _501.z);
            float4 _522 = _485 + mul(float4(0.0f, 0.0f, _474, 0.0f), View_View_ViewToClip);
            float _529 = abs((_522.xyz / _522.w.xxx).z - _508);
            float _530 = _529 * 0.25f;
            float _531 = mad(frac(52.98291778564453125f * frac(dot(gl_FragCoord.xy + (float2(32.66500091552734375f, 11.81499958038330078125f) * float(View_View_StateFrameIndexMod8)), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f)))) - 0.5f, 0.125f, 0.125f);
            float4 _534 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _511.xy, 0.0f);
            float _535 = _534.x;
            float3 _537 = _511 + (_517 * _531);
            float4 _540 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _537.xy, 0.0f);
            float _541 = _540.x;
            float _550 = (((abs(mad(_529, 0.25f, _537.z - _541)) < _530) && (_541 != _535)) && true) ? _531 : (-1.0f);
            float _551 = _531 + 0.125f;
            float3 _553 = _511 + (_517 * _551);
            float4 _556 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _553.xy, 0.0f);
            float _557 = _556.x;
            float _567 = (((abs(mad(_529, 0.25f, _553.z - _557)) < _530) && (_557 != _535)) && (_550 < 0.0f)) ? _551 : _550;
            float _568 = _531 + 0.25f;
            float3 _570 = _511 + (_517 * _568);
            float4 _573 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _570.xy, 0.0f);
            float _574 = _573.x;
            float _584 = (((abs(mad(_529, 0.25f, _570.z - _574)) < _530) && (_574 != _535)) && (_567 < 0.0f)) ? _568 : _567;
            float _585 = _531 + 0.375f;
            float3 _587 = _511 + (_517 * _585);
            float4 _590 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _587.xy, 0.0f);
            float _591 = _590.x;
            float _601 = (((abs(mad(_529, 0.25f, _587.z - _591)) < _530) && (_591 != _535)) && (_584 < 0.0f)) ? _585 : _584;
            float _602 = _531 + 0.5f;
            float3 _604 = _511 + (_517 * _602);
            float4 _607 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _604.xy, 0.0f);
            float _608 = _607.x;
            float _618 = (((abs(mad(_529, 0.25f, _604.z - _608)) < _530) && (_608 != _535)) && (_601 < 0.0f)) ? _602 : _601;
            float _619 = _531 + 0.625f;
            float3 _621 = _511 + (_517 * _619);
            float4 _624 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _621.xy, 0.0f);
            float _625 = _624.x;
            float _635 = (((abs(mad(_529, 0.25f, _621.z - _625)) < _530) && (_625 != _535)) && (_618 < 0.0f)) ? _619 : _618;
            float _636 = _531 + 0.75f;
            float3 _638 = _511 + (_517 * _636);
            float4 _641 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _638.xy, 0.0f);
            float _642 = _641.x;
            float _652 = (((abs(mad(_529, 0.25f, _638.z - _642)) < _530) && (_642 != _535)) && (_635 < 0.0f)) ? _636 : _635;
            float _653 = _531 + 0.875f;
            float3 _655 = _511 + (_517 * _653);
            float4 _658 = SceneTexturesStruct_SceneDepthTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _655.xy, 0.0f);
            float _659 = _658.x;
            float _669 = (((abs(mad(_529, 0.25f, _655.z - _659)) < _530) && (_659 != _535)) && (_652 < 0.0f)) ? _653 : _652;
            bool _705 = false;
            float _706 = 0.0f;
            if (_669 > 0.0f)
            {
                float2 _675 = (_511 + (_517 * _669)).xy;
                bool2 _693 = bool2(0.0f.xx.x < _675.x, 0.0f.xx.y < _675.y);
                bool2 _694 = bool2(_675.x < 1.0f.xx.x, _675.y < 1.0f.xx.y);
                _705 = ((uint(SceneTexturesStruct_GBufferATexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _675, 0.0f).w * 3.999000072479248046875f) & 1u) != 0u) && ((((uint(mad(SceneTexturesStruct_GBufferBTexture.SampleLevel(SceneTexturesStruct_PointClampSampler, _675, 0.0f).w, 255.0f, 0.5f)) >> 0u) & 15u) << 0u) != 9u);
                _706 = all(bool2(_693.x && _694.x, _693.y && _694.y)) ? (_669 * _474) : (-1.0f);
            }
            else
            {
                _705 = false;
                _706 = -1.0f;
            }
            float _738 = 0.0f;
            float _739 = 0.0f;
            if (_706 > 0.0f)
            {
                float _710 = _705 ? DeferredLightUniforms_DeferredLightUniforms_ContactShadowCastingIntensity : DeferredLightUniforms_DeferredLightUniforms_ContactShadowNonCastingIntensity;
                float _734 = 0.0f;
                [branch]
                if (((((_710 > 0.0f) && ((((_288 || _291) || _293) || _295) || _299)) && (_255 != 7u)) && (_255 != 9u)) && (_255 != 5u))
                {
                    _734 = _710 * (1.0f - clamp(exp((log(1.0f - (isnan(0.9900000095367431640625f) ? _430 : (isnan(_430) ? 0.9900000095367431640625f : min(_430, 0.9900000095367431640625f)))) * 0.0500000007450580596923828125f) * _706), 0.0f, 1.0f));
                }
                else
                {
                    _734 = _710;
                }
                float _735 = 1.0f - _734;
                _738 = _464 * _735;
                _739 = _465 * _735;
            }
            else
            {
                _738 = _464;
                _739 = _465;
            }
            _740 = _738;
            _741 = _739;
        }
        else
        {
            _740 = _464;
            _741 = _465;
        }
        float _3025 = 0.0f;
        float3 _3026 = 0.0f.xxx;
        float3 _3027 = 0.0f.xxx;
        [branch]
        if ((_741 + _740) > 0.0f)
        {
            float _748 = isnan(View_View_MinRoughness) ? _249 : (isnan(_249) ? View_View_MinRoughness : max(_249, View_View_MinRoughness));
            float _749 = dot(DeferredLightUniforms_DeferredLightUniforms_Direction, DeferredLightUniforms_DeferredLightUniforms_Direction);
            float _752 = rsqrt(_749);
            float3 _753 = DeferredLightUniforms_DeferredLightUniforms_Direction * _752;
            float _754 = dot(_314, _753);
            float _772 = 0.0f;
            if (DeferredLightUniforms_DeferredLightUniforms_SourceRadius > 0.0f)
            {
                float _761 = sqrt(clamp((DeferredLightUniforms_DeferredLightUniforms_SourceRadius * DeferredLightUniforms_DeferredLightUniforms_SourceRadius) * (1.0f / (_749 + 1.0f)), 0.0f, 1.0f));
                float _771 = 0.0f;
                if (_754 < _761)
                {
                    float _765 = -_761;
                    float _767 = _761 + (isnan(_765) ? _754 : (isnan(_754) ? _765 : max(_754, _765)));
                    _771 = (_767 * _767) / (4.0f * _761);
                }
                else
                {
                    _771 = _754;
                }
                _772 = _771;
            }
            else
            {
                _772 = _754;
            }
            float _773 = clamp(_772, 0.0f, 1.0f);
            float _774 = isnan(View_View_MinRoughness) ? _748 : (isnan(_748) ? View_View_MinRoughness : max(_748, View_View_MinRoughness));
            float _779 = clamp((DeferredLightUniforms_DeferredLightUniforms_SourceRadius * _752) * mad(-_774, _774, 1.0f), 0.0f, 1.0f);
            float _781 = clamp(DeferredLightUniforms_DeferredLightUniforms_SoftSourceRadius * _752, 0.0f, 1.0f);
            uint _788 = 0u | (asuint(clamp(mad(-(isnan(DeferredLightUniforms_DeferredLightUniforms_SourceRadius) ? 0.0f : (isnan(0.0f) ? DeferredLightUniforms_DeferredLightUniforms_SourceRadius : max(0.0f, DeferredLightUniforms_DeferredLightUniforms_SourceRadius))), 0.0500000007450580596923828125f, 1.0f), 0.0f, 1.0f)) << 1u);
            float3 _2993 = 0.0f.xxx;
            float3 _2994 = 0.0f.xxx;
            float3 _2995 = 0.0f.xxx;
            switch (_255)
            {
                case 1u:
                {
                    int _2750 = int(_371);
                    int _2751 = _2750 & 16;
                    bool _2752 = _2751 != 0;
                    float _2865 = 0.0f;
                    float _2866 = 0.0f;
                    float _2867 = 0.0f;
                    float _2868 = 0.0f;
                    float _2869 = 0.0f;
                    float _2870 = 0.0f;
                    float _2871 = 0.0f;
                    float _2872 = 0.0f;
                    float _2873 = 0.0f;
                    [branch]
                    if (_2752)
                    {
                        float3 _2846 = cross(_314, _369);
                        float3 _2847 = normalize(_2846);
                        float _2848 = dot(_314, _429);
                        float _2849 = dot(_429, _753);
                        float _2850 = mad(2.0f, _2849, 2.0f);
                        float _2851 = rsqrt(_2850);
                        float _2852 = _754 + _2848;
                        float _2853 = _2852 * _2851;
                        float _2854 = clamp(_2853, 0.0f, 1.0f);
                        float _2855 = mad(_2851, _2849, _2851);
                        float _2856 = clamp(_2855, 0.0f, 1.0f);
                        float _2857 = dot(_369, _429);
                        float _2858 = dot(_369, _753);
                        float _2859 = _2858 + _2857;
                        float _2860 = _2859 * _2851;
                        float _2861 = dot(_2847, _429);
                        float _2862 = dot(_2847, _753);
                        float _2863 = _2862 + _2861;
                        float _2864 = _2863 * _2851;
                        _2865 = _2854;
                        _2866 = _2856;
                        _2867 = _2857;
                        _2868 = _2858;
                        _2869 = _2860;
                        _2870 = _2861;
                        _2871 = _2862;
                        _2872 = _2864;
                        _2873 = _2848;
                    }
                    else
                    {
                        float _2756 = dot(_314, _429);
                        float _2757 = dot(_429, _753);
                        float _2758 = mad(2.0f, _2757, 2.0f);
                        float _2759 = rsqrt(_2758);
                        float _2760 = _754 + _2756;
                        float _2761 = _2760 * _2759;
                        float _2762 = clamp(_2761, 0.0f, 1.0f);
                        float _2763 = mad(_2759, _2757, _2759);
                        float _2764 = clamp(_2763, 0.0f, 1.0f);
                        bool _2765 = _779 > 0.0f;
                        float _2844 = 0.0f;
                        float _2845 = 0.0f;
                        if (_2765)
                        {
                            float _2768 = -_779;
                            float _2769 = mad(_2768, _779, 1.0f);
                            float _2770 = sqrt(_2769);
                            float _2771 = 2.0f * _754;
                            float _2772 = -_2757;
                            float _2773 = mad(_2771, _2756, _2772);
                            bool _2774 = _2773 >= _2770;
                            float _2842 = 0.0f;
                            float _2843 = 0.0f;
                            if (_2774)
                            {
                                float _2841 = abs(_2756);
                                _2842 = 1.0f;
                                _2843 = _2841;
                            }
                            else
                            {
                                float _2778 = -_2773;
                                float _2779 = mad(_2778, _2773, 1.0f);
                                float _2780 = rsqrt(_2779);
                                float _2781 = _779 * _2780;
                                float _2782 = mad(_2778, _754, _2756);
                                float _2783 = _2781 * _2782;
                                float _2784 = 2.0f * _2756;
                                float _2785 = mad(_2784, _2756, -1.0f);
                                float _2786 = mad(_2778, _2757, _2785);
                                float _2787 = _2781 * _2786;
                                float _2788 = -_754;
                                float _2789 = mad(_2788, _754, 1.0f);
                                float _2790 = -_2756;
                                float _2791 = mad(_2790, _2756, _2789);
                                float _2792 = mad(_2772, _2757, _2791);
                                float _2793 = _2771 * _2756;
                                float _2794 = mad(_2793, _2757, _2792);
                                float _2795 = clamp(_2794, 0.0f, 1.0f);
                                float _2796 = sqrt(_2795);
                                float _2797 = _2781 * _2796;
                                float _2798 = _2797 * 2.0f;
                                float _2799 = _2798 * _2756;
                                float _2800 = mad(_754, _2770, _2756);
                                float _2801 = mad(_2781, _2782, _2800);
                                float _2802 = mad(_2757, _2770, 1.0f);
                                float _2803 = mad(_2781, _2786, _2802);
                                float _2804 = _2797 * _2803;
                                float _2805 = _2801 * _2803;
                                float _2806 = _2799 * _2801;
                                float _2807 = 0.25f * _2799;
                                float _2808 = _2807 * _2801;
                                float _2809 = mad(-0.5f, _2804, _2808);
                                float _2810 = _2805 * _2809;
                                float _2811 = _2804 * (-2.0f);
                                float _2812 = mad(_2799, _2801, _2811);
                                float _2813 = _2806 * _2812;
                                float _2814 = mad(_2804, _2804, _2813);
                                float _2815 = _2803 * _2803;
                                float _2816 = mad(_2757, _2770, _2803);
                                float _2817 = mad(-0.5f, _2816, -0.5f);
                                float _2818 = _2805 * _2817;
                                float _2819 = mad(_2800, _2815, _2818);
                                float _2820 = mad(_2801, _2819, _2814);
                                float _2821 = 2.0f * _2810;
                                float _2822 = _2810 * _2810;
                                float _2823 = mad(_2820, _2820, _2822);
                                float _2824 = _2821 / _2823;
                                float _2825 = _2824 * _2820;
                                float _2826 = -_2824;
                                float _2827 = mad(_2826, _2810, 1.0f);
                                float _2828 = _2825 * _2797;
                                float _2829 = mad(_2827, _2783, _2828);
                                float _2830 = _2825 * _2799;
                                float _2831 = mad(_2827, _2787, _2830);
                                float _2832 = mad(_754, _2770, _2829);
                                float _2833 = mad(_2757, _2770, _2831);
                                float _2834 = mad(2.0f, _2833, 2.0f);
                                float _2835 = rsqrt(_2834);
                                float _2836 = _2832 + _2756;
                                float _2837 = _2836 * _2835;
                                float _2838 = clamp(_2837, 0.0f, 1.0f);
                                float _2839 = mad(_2835, _2833, _2835);
                                float _2840 = clamp(_2839, 0.0f, 1.0f);
                                _2842 = _2838;
                                _2843 = _2840;
                            }
                            _2844 = _2842;
                            _2845 = _2843;
                        }
                        else
                        {
                            _2844 = _2762;
                            _2845 = _2764;
                        }
                        _2865 = _2844;
                        _2866 = _2845;
                        _2867 = 0.0f;
                        _2868 = 0.0f;
                        _2869 = 0.0f;
                        _2870 = 0.0f;
                        _2871 = 0.0f;
                        _2872 = 0.0f;
                        _2873 = _2756;
                    }
                    float _2874 = abs(_2873);
                    float _2875 = _2874 + 9.9999997473787516355514526367188e-06f;
                    float _2876 = clamp(_2875, 0.0f, 1.0f);
                    float3 _2877 = _354 * 0.3183098733425140380859375f;
                    float3 _2878 = 1.0f.xxx * _773;
                    float3 _2879 = _2877 * _2878;
                    float3 _2991 = 0.0f.xxx;
                    [branch]
                    if (_2752)
                    {
                        float _2945 = _748 * _748;
                        float _2946 = 1.0f + _370;
                        float _2947 = _2945 * _2946;
                        bool _3131 = isnan(_2947);
                        bool _3132 = isnan(0.001000000047497451305389404296875f);
                        float _3133 = max(_2947, 0.001000000047497451305389404296875f);
                        float _3134 = _3131 ? 0.001000000047497451305389404296875f : _3133;
                        float _2948 = _3132 ? _2947 : _3134;
                        float _2949 = 1.0f - _370;
                        float _2950 = _2945 * _2949;
                        bool _3136 = isnan(_2950);
                        bool _3137 = isnan(0.001000000047497451305389404296875f);
                        float _3138 = max(_2950, 0.001000000047497451305389404296875f);
                        float _3139 = _3136 ? 0.001000000047497451305389404296875f : _3138;
                        float _2951 = _3137 ? _2950 : _3139;
                        float _2952 = _2948 * _2951;
                        float _2953 = _2951 * _2869;
                        float _2954 = _2948 * _2872;
                        float _2955 = _2952 * _2865;
                        float3 _2956 = float3(_2953, _2954, _2955);
                        float _2957 = dot(_2956, _2956);
                        float _2958 = 0.3183098733425140380859375f * _2952;
                        float _2959 = _2952 / _2957;
                        float _2960 = _2959 * _2959;
                        float _2961 = _2958 * _2960;
                        float3 _2962 = _2961.xxx;
                        float _2963 = _2948 * _2867;
                        float _2964 = _2951 * _2870;
                        float3 _2965 = float3(_2963, _2964, _2876);
                        float _2966 = length(_2965);
                        float _2967 = _2948 * _2868;
                        float _2968 = _2951 * _2871;
                        float3 _2969 = float3(_2967, _2968, _773);
                        float _2970 = length(_2969);
                        float _2971 = _2876 * _2970;
                        float _2972 = mad(_773, _2966, _2971);
                        float _2973 = 0.5f / _2972;
                        float3 _2974 = _2973.xxx;
                        float _2975 = 1.0f - _2866;
                        float _2976 = _2975 * _2975;
                        float _2977 = _2976 * _2976;
                        float _2978 = _2977 * _2975;
                        float _2979 = _361.y;
                        float _2980 = 50.0f * _2979;
                        float _2981 = clamp(_2980, 0.0f, 1.0f);
                        float _2982 = _2981 * _2978;
                        float3 _2983 = _2982.xxx;
                        float _2984 = -_2977;
                        float _2985 = mad(_2984, _2975, 1.0f);
                        float3 _2986 = _361 * _2985;
                        float3 _2987 = _2983 + _2986;
                        float3 _2988 = _2962 * _2974;
                        float3 _2989 = _2988 * _2987;
                        float3 _2990 = _2878 * _2989;
                        _2991 = _2990;
                    }
                    else
                    {
                        uint _2883 = _788 & 1u;
                        bool _2884 = _2883 == 1u;
                        float3 _2944 = 0.0f.xxx;
                        if (_2884)
                        {
                            _2944 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2888 = _748 * _748;
                            float _2889 = _2888 * _2888;
                            bool _2890 = _781 > 0.0f;
                            float _2898 = 0.0f;
                            if (_2890)
                            {
                                float _2893 = _781 * _781;
                                float _2894 = mad(_2866, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                float _2895 = _2893 / _2894;
                                float _2896 = mad(_2888, _2888, _2895);
                                float _2897 = clamp(_2896, 0.0f, 1.0f);
                                _2898 = _2897;
                            }
                            else
                            {
                                _2898 = _2889;
                            }
                            bool _2899 = _779 > 0.0f;
                            float _2913 = 0.0f;
                            if (_2899)
                            {
                                float _2902 = 0.25f * _779;
                                int _2903 = asint(_2898);
                                int _2904 = _2903 >> 1;
                                int _2905 = 532487669 + _2904;
                                float _2906 = asfloat(_2905);
                                float _2907 = mad(3.0f, _2906, _779);
                                float _2908 = _2902 * _2907;
                                float _2909 = _2866 + 0.001000000047497451305389404296875f;
                                float _2910 = _2908 / _2909;
                                float _2911 = _2898 + _2910;
                                float _2912 = _2898 / _2911;
                                _2913 = _2912;
                            }
                            else
                            {
                                _2913 = 1.0f;
                            }
                            float _2914 = -_2865;
                            float _2915 = mad(_2865, _2898, _2914);
                            float _2916 = mad(_2915, _2865, 1.0f);
                            float _2917 = 3.1415927410125732421875f * _2916;
                            float _2918 = _2917 * _2916;
                            float _2919 = _2898 / _2918;
                            float _2920 = _2919 * _2913;
                            float _2921 = sqrt(_2898);
                            float _2922 = 1.0f - _2921;
                            float _2923 = mad(_2876, _2922, _2921);
                            float _2924 = mad(_773, _2922, _2921);
                            float _2925 = _2876 * _2924;
                            float _2926 = mad(_773, _2923, _2925);
                            float _2927 = 0.5f / _2926;
                            float _2928 = 1.0f - _2866;
                            float _2929 = _2928 * _2928;
                            float _2930 = _2929 * _2929;
                            float _2931 = _2930 * _2928;
                            float _2932 = _361.y;
                            float _2933 = 50.0f * _2932;
                            float _2934 = clamp(_2933, 0.0f, 1.0f);
                            float _2935 = _2934 * _2931;
                            float3 _2936 = _2935.xxx;
                            float _2937 = -_2930;
                            float _2938 = mad(_2937, _2928, 1.0f);
                            float3 _2939 = _361 * _2938;
                            float3 _2940 = _2936 + _2939;
                            float _2941 = _2920 * _2927;
                            float3 _2942 = _2940 * _2941;
                            float3 _2943 = _2878 * _2942;
                            _2944 = _2943;
                        }
                        _2991 = _2944;
                    }
                    float3 _2992 = _2879 * 1.0f;
                    _2993 = _2992;
                    _2994 = _2991;
                    _2995 = 0.0f.xxx;
                    break;
                }
                case 10u:
                {
                    int _2750 = int(_371);
                    int _2751 = _2750 & 16;
                    bool _2752 = _2751 != 0;
                    float _2865 = 0.0f;
                    float _2866 = 0.0f;
                    float _2867 = 0.0f;
                    float _2868 = 0.0f;
                    float _2869 = 0.0f;
                    float _2870 = 0.0f;
                    float _2871 = 0.0f;
                    float _2872 = 0.0f;
                    float _2873 = 0.0f;
                    [branch]
                    if (_2752)
                    {
                        float3 _2846 = cross(_314, _369);
                        float3 _2847 = normalize(_2846);
                        float _2848 = dot(_314, _429);
                        float _2849 = dot(_429, _753);
                        float _2850 = mad(2.0f, _2849, 2.0f);
                        float _2851 = rsqrt(_2850);
                        float _2852 = _754 + _2848;
                        float _2853 = _2852 * _2851;
                        float _2854 = clamp(_2853, 0.0f, 1.0f);
                        float _2855 = mad(_2851, _2849, _2851);
                        float _2856 = clamp(_2855, 0.0f, 1.0f);
                        float _2857 = dot(_369, _429);
                        float _2858 = dot(_369, _753);
                        float _2859 = _2858 + _2857;
                        float _2860 = _2859 * _2851;
                        float _2861 = dot(_2847, _429);
                        float _2862 = dot(_2847, _753);
                        float _2863 = _2862 + _2861;
                        float _2864 = _2863 * _2851;
                        _2865 = _2854;
                        _2866 = _2856;
                        _2867 = _2857;
                        _2868 = _2858;
                        _2869 = _2860;
                        _2870 = _2861;
                        _2871 = _2862;
                        _2872 = _2864;
                        _2873 = _2848;
                    }
                    else
                    {
                        float _2756 = dot(_314, _429);
                        float _2757 = dot(_429, _753);
                        float _2758 = mad(2.0f, _2757, 2.0f);
                        float _2759 = rsqrt(_2758);
                        float _2760 = _754 + _2756;
                        float _2761 = _2760 * _2759;
                        float _2762 = clamp(_2761, 0.0f, 1.0f);
                        float _2763 = mad(_2759, _2757, _2759);
                        float _2764 = clamp(_2763, 0.0f, 1.0f);
                        bool _2765 = _779 > 0.0f;
                        float _2844 = 0.0f;
                        float _2845 = 0.0f;
                        if (_2765)
                        {
                            float _2768 = -_779;
                            float _2769 = mad(_2768, _779, 1.0f);
                            float _2770 = sqrt(_2769);
                            float _2771 = 2.0f * _754;
                            float _2772 = -_2757;
                            float _2773 = mad(_2771, _2756, _2772);
                            bool _2774 = _2773 >= _2770;
                            float _2842 = 0.0f;
                            float _2843 = 0.0f;
                            if (_2774)
                            {
                                float _2841 = abs(_2756);
                                _2842 = 1.0f;
                                _2843 = _2841;
                            }
                            else
                            {
                                float _2778 = -_2773;
                                float _2779 = mad(_2778, _2773, 1.0f);
                                float _2780 = rsqrt(_2779);
                                float _2781 = _779 * _2780;
                                float _2782 = mad(_2778, _754, _2756);
                                float _2783 = _2781 * _2782;
                                float _2784 = 2.0f * _2756;
                                float _2785 = mad(_2784, _2756, -1.0f);
                                float _2786 = mad(_2778, _2757, _2785);
                                float _2787 = _2781 * _2786;
                                float _2788 = -_754;
                                float _2789 = mad(_2788, _754, 1.0f);
                                float _2790 = -_2756;
                                float _2791 = mad(_2790, _2756, _2789);
                                float _2792 = mad(_2772, _2757, _2791);
                                float _2793 = _2771 * _2756;
                                float _2794 = mad(_2793, _2757, _2792);
                                float _2795 = clamp(_2794, 0.0f, 1.0f);
                                float _2796 = sqrt(_2795);
                                float _2797 = _2781 * _2796;
                                float _2798 = _2797 * 2.0f;
                                float _2799 = _2798 * _2756;
                                float _2800 = mad(_754, _2770, _2756);
                                float _2801 = mad(_2781, _2782, _2800);
                                float _2802 = mad(_2757, _2770, 1.0f);
                                float _2803 = mad(_2781, _2786, _2802);
                                float _2804 = _2797 * _2803;
                                float _2805 = _2801 * _2803;
                                float _2806 = _2799 * _2801;
                                float _2807 = 0.25f * _2799;
                                float _2808 = _2807 * _2801;
                                float _2809 = mad(-0.5f, _2804, _2808);
                                float _2810 = _2805 * _2809;
                                float _2811 = _2804 * (-2.0f);
                                float _2812 = mad(_2799, _2801, _2811);
                                float _2813 = _2806 * _2812;
                                float _2814 = mad(_2804, _2804, _2813);
                                float _2815 = _2803 * _2803;
                                float _2816 = mad(_2757, _2770, _2803);
                                float _2817 = mad(-0.5f, _2816, -0.5f);
                                float _2818 = _2805 * _2817;
                                float _2819 = mad(_2800, _2815, _2818);
                                float _2820 = mad(_2801, _2819, _2814);
                                float _2821 = 2.0f * _2810;
                                float _2822 = _2810 * _2810;
                                float _2823 = mad(_2820, _2820, _2822);
                                float _2824 = _2821 / _2823;
                                float _2825 = _2824 * _2820;
                                float _2826 = -_2824;
                                float _2827 = mad(_2826, _2810, 1.0f);
                                float _2828 = _2825 * _2797;
                                float _2829 = mad(_2827, _2783, _2828);
                                float _2830 = _2825 * _2799;
                                float _2831 = mad(_2827, _2787, _2830);
                                float _2832 = mad(_754, _2770, _2829);
                                float _2833 = mad(_2757, _2770, _2831);
                                float _2834 = mad(2.0f, _2833, 2.0f);
                                float _2835 = rsqrt(_2834);
                                float _2836 = _2832 + _2756;
                                float _2837 = _2836 * _2835;
                                float _2838 = clamp(_2837, 0.0f, 1.0f);
                                float _2839 = mad(_2835, _2833, _2835);
                                float _2840 = clamp(_2839, 0.0f, 1.0f);
                                _2842 = _2838;
                                _2843 = _2840;
                            }
                            _2844 = _2842;
                            _2845 = _2843;
                        }
                        else
                        {
                            _2844 = _2762;
                            _2845 = _2764;
                        }
                        _2865 = _2844;
                        _2866 = _2845;
                        _2867 = 0.0f;
                        _2868 = 0.0f;
                        _2869 = 0.0f;
                        _2870 = 0.0f;
                        _2871 = 0.0f;
                        _2872 = 0.0f;
                        _2873 = _2756;
                    }
                    float _2874 = abs(_2873);
                    float _2875 = _2874 + 9.9999997473787516355514526367188e-06f;
                    float _2876 = clamp(_2875, 0.0f, 1.0f);
                    float3 _2877 = _354 * 0.3183098733425140380859375f;
                    float3 _2878 = 1.0f.xxx * _773;
                    float3 _2879 = _2877 * _2878;
                    float3 _2991 = 0.0f.xxx;
                    [branch]
                    if (_2752)
                    {
                        float _2945 = _748 * _748;
                        float _2946 = 1.0f + _370;
                        float _2947 = _2945 * _2946;
                        bool _3131 = isnan(_2947);
                        bool _3132 = isnan(0.001000000047497451305389404296875f);
                        float _3133 = max(_2947, 0.001000000047497451305389404296875f);
                        float _3134 = _3131 ? 0.001000000047497451305389404296875f : _3133;
                        float _2948 = _3132 ? _2947 : _3134;
                        float _2949 = 1.0f - _370;
                        float _2950 = _2945 * _2949;
                        bool _3136 = isnan(_2950);
                        bool _3137 = isnan(0.001000000047497451305389404296875f);
                        float _3138 = max(_2950, 0.001000000047497451305389404296875f);
                        float _3139 = _3136 ? 0.001000000047497451305389404296875f : _3138;
                        float _2951 = _3137 ? _2950 : _3139;
                        float _2952 = _2948 * _2951;
                        float _2953 = _2951 * _2869;
                        float _2954 = _2948 * _2872;
                        float _2955 = _2952 * _2865;
                        float3 _2956 = float3(_2953, _2954, _2955);
                        float _2957 = dot(_2956, _2956);
                        float _2958 = 0.3183098733425140380859375f * _2952;
                        float _2959 = _2952 / _2957;
                        float _2960 = _2959 * _2959;
                        float _2961 = _2958 * _2960;
                        float3 _2962 = _2961.xxx;
                        float _2963 = _2948 * _2867;
                        float _2964 = _2951 * _2870;
                        float3 _2965 = float3(_2963, _2964, _2876);
                        float _2966 = length(_2965);
                        float _2967 = _2948 * _2868;
                        float _2968 = _2951 * _2871;
                        float3 _2969 = float3(_2967, _2968, _773);
                        float _2970 = length(_2969);
                        float _2971 = _2876 * _2970;
                        float _2972 = mad(_773, _2966, _2971);
                        float _2973 = 0.5f / _2972;
                        float3 _2974 = _2973.xxx;
                        float _2975 = 1.0f - _2866;
                        float _2976 = _2975 * _2975;
                        float _2977 = _2976 * _2976;
                        float _2978 = _2977 * _2975;
                        float _2979 = _361.y;
                        float _2980 = 50.0f * _2979;
                        float _2981 = clamp(_2980, 0.0f, 1.0f);
                        float _2982 = _2981 * _2978;
                        float3 _2983 = _2982.xxx;
                        float _2984 = -_2977;
                        float _2985 = mad(_2984, _2975, 1.0f);
                        float3 _2986 = _361 * _2985;
                        float3 _2987 = _2983 + _2986;
                        float3 _2988 = _2962 * _2974;
                        float3 _2989 = _2988 * _2987;
                        float3 _2990 = _2878 * _2989;
                        _2991 = _2990;
                    }
                    else
                    {
                        uint _2883 = _788 & 1u;
                        bool _2884 = _2883 == 1u;
                        float3 _2944 = 0.0f.xxx;
                        if (_2884)
                        {
                            _2944 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2888 = _748 * _748;
                            float _2889 = _2888 * _2888;
                            bool _2890 = _781 > 0.0f;
                            float _2898 = 0.0f;
                            if (_2890)
                            {
                                float _2893 = _781 * _781;
                                float _2894 = mad(_2866, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                float _2895 = _2893 / _2894;
                                float _2896 = mad(_2888, _2888, _2895);
                                float _2897 = clamp(_2896, 0.0f, 1.0f);
                                _2898 = _2897;
                            }
                            else
                            {
                                _2898 = _2889;
                            }
                            bool _2899 = _779 > 0.0f;
                            float _2913 = 0.0f;
                            if (_2899)
                            {
                                float _2902 = 0.25f * _779;
                                int _2903 = asint(_2898);
                                int _2904 = _2903 >> 1;
                                int _2905 = 532487669 + _2904;
                                float _2906 = asfloat(_2905);
                                float _2907 = mad(3.0f, _2906, _779);
                                float _2908 = _2902 * _2907;
                                float _2909 = _2866 + 0.001000000047497451305389404296875f;
                                float _2910 = _2908 / _2909;
                                float _2911 = _2898 + _2910;
                                float _2912 = _2898 / _2911;
                                _2913 = _2912;
                            }
                            else
                            {
                                _2913 = 1.0f;
                            }
                            float _2914 = -_2865;
                            float _2915 = mad(_2865, _2898, _2914);
                            float _2916 = mad(_2915, _2865, 1.0f);
                            float _2917 = 3.1415927410125732421875f * _2916;
                            float _2918 = _2917 * _2916;
                            float _2919 = _2898 / _2918;
                            float _2920 = _2919 * _2913;
                            float _2921 = sqrt(_2898);
                            float _2922 = 1.0f - _2921;
                            float _2923 = mad(_2876, _2922, _2921);
                            float _2924 = mad(_773, _2922, _2921);
                            float _2925 = _2876 * _2924;
                            float _2926 = mad(_773, _2923, _2925);
                            float _2927 = 0.5f / _2926;
                            float _2928 = 1.0f - _2866;
                            float _2929 = _2928 * _2928;
                            float _2930 = _2929 * _2929;
                            float _2931 = _2930 * _2928;
                            float _2932 = _361.y;
                            float _2933 = 50.0f * _2932;
                            float _2934 = clamp(_2933, 0.0f, 1.0f);
                            float _2935 = _2934 * _2931;
                            float3 _2936 = _2935.xxx;
                            float _2937 = -_2930;
                            float _2938 = mad(_2937, _2928, 1.0f);
                            float3 _2939 = _361 * _2938;
                            float3 _2940 = _2936 + _2939;
                            float _2941 = _2920 * _2927;
                            float3 _2942 = _2940 * _2941;
                            float3 _2943 = _2878 * _2942;
                            _2944 = _2943;
                        }
                        _2991 = _2944;
                    }
                    float3 _2992 = _2879 * 1.0f;
                    _2993 = _2992;
                    _2994 = _2991;
                    _2995 = 0.0f.xxx;
                    break;
                }
                case 11u:
                {
                    int _2750 = int(_371);
                    int _2751 = _2750 & 16;
                    bool _2752 = _2751 != 0;
                    float _2865 = 0.0f;
                    float _2866 = 0.0f;
                    float _2867 = 0.0f;
                    float _2868 = 0.0f;
                    float _2869 = 0.0f;
                    float _2870 = 0.0f;
                    float _2871 = 0.0f;
                    float _2872 = 0.0f;
                    float _2873 = 0.0f;
                    [branch]
                    if (_2752)
                    {
                        float3 _2846 = cross(_314, _369);
                        float3 _2847 = normalize(_2846);
                        float _2848 = dot(_314, _429);
                        float _2849 = dot(_429, _753);
                        float _2850 = mad(2.0f, _2849, 2.0f);
                        float _2851 = rsqrt(_2850);
                        float _2852 = _754 + _2848;
                        float _2853 = _2852 * _2851;
                        float _2854 = clamp(_2853, 0.0f, 1.0f);
                        float _2855 = mad(_2851, _2849, _2851);
                        float _2856 = clamp(_2855, 0.0f, 1.0f);
                        float _2857 = dot(_369, _429);
                        float _2858 = dot(_369, _753);
                        float _2859 = _2858 + _2857;
                        float _2860 = _2859 * _2851;
                        float _2861 = dot(_2847, _429);
                        float _2862 = dot(_2847, _753);
                        float _2863 = _2862 + _2861;
                        float _2864 = _2863 * _2851;
                        _2865 = _2854;
                        _2866 = _2856;
                        _2867 = _2857;
                        _2868 = _2858;
                        _2869 = _2860;
                        _2870 = _2861;
                        _2871 = _2862;
                        _2872 = _2864;
                        _2873 = _2848;
                    }
                    else
                    {
                        float _2756 = dot(_314, _429);
                        float _2757 = dot(_429, _753);
                        float _2758 = mad(2.0f, _2757, 2.0f);
                        float _2759 = rsqrt(_2758);
                        float _2760 = _754 + _2756;
                        float _2761 = _2760 * _2759;
                        float _2762 = clamp(_2761, 0.0f, 1.0f);
                        float _2763 = mad(_2759, _2757, _2759);
                        float _2764 = clamp(_2763, 0.0f, 1.0f);
                        bool _2765 = _779 > 0.0f;
                        float _2844 = 0.0f;
                        float _2845 = 0.0f;
                        if (_2765)
                        {
                            float _2768 = -_779;
                            float _2769 = mad(_2768, _779, 1.0f);
                            float _2770 = sqrt(_2769);
                            float _2771 = 2.0f * _754;
                            float _2772 = -_2757;
                            float _2773 = mad(_2771, _2756, _2772);
                            bool _2774 = _2773 >= _2770;
                            float _2842 = 0.0f;
                            float _2843 = 0.0f;
                            if (_2774)
                            {
                                float _2841 = abs(_2756);
                                _2842 = 1.0f;
                                _2843 = _2841;
                            }
                            else
                            {
                                float _2778 = -_2773;
                                float _2779 = mad(_2778, _2773, 1.0f);
                                float _2780 = rsqrt(_2779);
                                float _2781 = _779 * _2780;
                                float _2782 = mad(_2778, _754, _2756);
                                float _2783 = _2781 * _2782;
                                float _2784 = 2.0f * _2756;
                                float _2785 = mad(_2784, _2756, -1.0f);
                                float _2786 = mad(_2778, _2757, _2785);
                                float _2787 = _2781 * _2786;
                                float _2788 = -_754;
                                float _2789 = mad(_2788, _754, 1.0f);
                                float _2790 = -_2756;
                                float _2791 = mad(_2790, _2756, _2789);
                                float _2792 = mad(_2772, _2757, _2791);
                                float _2793 = _2771 * _2756;
                                float _2794 = mad(_2793, _2757, _2792);
                                float _2795 = clamp(_2794, 0.0f, 1.0f);
                                float _2796 = sqrt(_2795);
                                float _2797 = _2781 * _2796;
                                float _2798 = _2797 * 2.0f;
                                float _2799 = _2798 * _2756;
                                float _2800 = mad(_754, _2770, _2756);
                                float _2801 = mad(_2781, _2782, _2800);
                                float _2802 = mad(_2757, _2770, 1.0f);
                                float _2803 = mad(_2781, _2786, _2802);
                                float _2804 = _2797 * _2803;
                                float _2805 = _2801 * _2803;
                                float _2806 = _2799 * _2801;
                                float _2807 = 0.25f * _2799;
                                float _2808 = _2807 * _2801;
                                float _2809 = mad(-0.5f, _2804, _2808);
                                float _2810 = _2805 * _2809;
                                float _2811 = _2804 * (-2.0f);
                                float _2812 = mad(_2799, _2801, _2811);
                                float _2813 = _2806 * _2812;
                                float _2814 = mad(_2804, _2804, _2813);
                                float _2815 = _2803 * _2803;
                                float _2816 = mad(_2757, _2770, _2803);
                                float _2817 = mad(-0.5f, _2816, -0.5f);
                                float _2818 = _2805 * _2817;
                                float _2819 = mad(_2800, _2815, _2818);
                                float _2820 = mad(_2801, _2819, _2814);
                                float _2821 = 2.0f * _2810;
                                float _2822 = _2810 * _2810;
                                float _2823 = mad(_2820, _2820, _2822);
                                float _2824 = _2821 / _2823;
                                float _2825 = _2824 * _2820;
                                float _2826 = -_2824;
                                float _2827 = mad(_2826, _2810, 1.0f);
                                float _2828 = _2825 * _2797;
                                float _2829 = mad(_2827, _2783, _2828);
                                float _2830 = _2825 * _2799;
                                float _2831 = mad(_2827, _2787, _2830);
                                float _2832 = mad(_754, _2770, _2829);
                                float _2833 = mad(_2757, _2770, _2831);
                                float _2834 = mad(2.0f, _2833, 2.0f);
                                float _2835 = rsqrt(_2834);
                                float _2836 = _2832 + _2756;
                                float _2837 = _2836 * _2835;
                                float _2838 = clamp(_2837, 0.0f, 1.0f);
                                float _2839 = mad(_2835, _2833, _2835);
                                float _2840 = clamp(_2839, 0.0f, 1.0f);
                                _2842 = _2838;
                                _2843 = _2840;
                            }
                            _2844 = _2842;
                            _2845 = _2843;
                        }
                        else
                        {
                            _2844 = _2762;
                            _2845 = _2764;
                        }
                        _2865 = _2844;
                        _2866 = _2845;
                        _2867 = 0.0f;
                        _2868 = 0.0f;
                        _2869 = 0.0f;
                        _2870 = 0.0f;
                        _2871 = 0.0f;
                        _2872 = 0.0f;
                        _2873 = _2756;
                    }
                    float _2874 = abs(_2873);
                    float _2875 = _2874 + 9.9999997473787516355514526367188e-06f;
                    float _2876 = clamp(_2875, 0.0f, 1.0f);
                    float3 _2877 = _354 * 0.3183098733425140380859375f;
                    float3 _2878 = 1.0f.xxx * _773;
                    float3 _2879 = _2877 * _2878;
                    float3 _2991 = 0.0f.xxx;
                    [branch]
                    if (_2752)
                    {
                        float _2945 = _748 * _748;
                        float _2946 = 1.0f + _370;
                        float _2947 = _2945 * _2946;
                        bool _3131 = isnan(_2947);
                        bool _3132 = isnan(0.001000000047497451305389404296875f);
                        float _3133 = max(_2947, 0.001000000047497451305389404296875f);
                        float _3134 = _3131 ? 0.001000000047497451305389404296875f : _3133;
                        float _2948 = _3132 ? _2947 : _3134;
                        float _2949 = 1.0f - _370;
                        float _2950 = _2945 * _2949;
                        bool _3136 = isnan(_2950);
                        bool _3137 = isnan(0.001000000047497451305389404296875f);
                        float _3138 = max(_2950, 0.001000000047497451305389404296875f);
                        float _3139 = _3136 ? 0.001000000047497451305389404296875f : _3138;
                        float _2951 = _3137 ? _2950 : _3139;
                        float _2952 = _2948 * _2951;
                        float _2953 = _2951 * _2869;
                        float _2954 = _2948 * _2872;
                        float _2955 = _2952 * _2865;
                        float3 _2956 = float3(_2953, _2954, _2955);
                        float _2957 = dot(_2956, _2956);
                        float _2958 = 0.3183098733425140380859375f * _2952;
                        float _2959 = _2952 / _2957;
                        float _2960 = _2959 * _2959;
                        float _2961 = _2958 * _2960;
                        float3 _2962 = _2961.xxx;
                        float _2963 = _2948 * _2867;
                        float _2964 = _2951 * _2870;
                        float3 _2965 = float3(_2963, _2964, _2876);
                        float _2966 = length(_2965);
                        float _2967 = _2948 * _2868;
                        float _2968 = _2951 * _2871;
                        float3 _2969 = float3(_2967, _2968, _773);
                        float _2970 = length(_2969);
                        float _2971 = _2876 * _2970;
                        float _2972 = mad(_773, _2966, _2971);
                        float _2973 = 0.5f / _2972;
                        float3 _2974 = _2973.xxx;
                        float _2975 = 1.0f - _2866;
                        float _2976 = _2975 * _2975;
                        float _2977 = _2976 * _2976;
                        float _2978 = _2977 * _2975;
                        float _2979 = _361.y;
                        float _2980 = 50.0f * _2979;
                        float _2981 = clamp(_2980, 0.0f, 1.0f);
                        float _2982 = _2981 * _2978;
                        float3 _2983 = _2982.xxx;
                        float _2984 = -_2977;
                        float _2985 = mad(_2984, _2975, 1.0f);
                        float3 _2986 = _361 * _2985;
                        float3 _2987 = _2983 + _2986;
                        float3 _2988 = _2962 * _2974;
                        float3 _2989 = _2988 * _2987;
                        float3 _2990 = _2878 * _2989;
                        _2991 = _2990;
                    }
                    else
                    {
                        uint _2883 = _788 & 1u;
                        bool _2884 = _2883 == 1u;
                        float3 _2944 = 0.0f.xxx;
                        if (_2884)
                        {
                            _2944 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2888 = _748 * _748;
                            float _2889 = _2888 * _2888;
                            bool _2890 = _781 > 0.0f;
                            float _2898 = 0.0f;
                            if (_2890)
                            {
                                float _2893 = _781 * _781;
                                float _2894 = mad(_2866, 3.599999904632568359375f, 0.4000000059604644775390625f);
                                float _2895 = _2893 / _2894;
                                float _2896 = mad(_2888, _2888, _2895);
                                float _2897 = clamp(_2896, 0.0f, 1.0f);
                                _2898 = _2897;
                            }
                            else
                            {
                                _2898 = _2889;
                            }
                            bool _2899 = _779 > 0.0f;
                            float _2913 = 0.0f;
                            if (_2899)
                            {
                                float _2902 = 0.25f * _779;
                                int _2903 = asint(_2898);
                                int _2904 = _2903 >> 1;
                                int _2905 = 532487669 + _2904;
                                float _2906 = asfloat(_2905);
                                float _2907 = mad(3.0f, _2906, _779);
                                float _2908 = _2902 * _2907;
                                float _2909 = _2866 + 0.001000000047497451305389404296875f;
                                float _2910 = _2908 / _2909;
                                float _2911 = _2898 + _2910;
                                float _2912 = _2898 / _2911;
                                _2913 = _2912;
                            }
                            else
                            {
                                _2913 = 1.0f;
                            }
                            float _2914 = -_2865;
                            float _2915 = mad(_2865, _2898, _2914);
                            float _2916 = mad(_2915, _2865, 1.0f);
                            float _2917 = 3.1415927410125732421875f * _2916;
                            float _2918 = _2917 * _2916;
                            float _2919 = _2898 / _2918;
                            float _2920 = _2919 * _2913;
                            float _2921 = sqrt(_2898);
                            float _2922 = 1.0f - _2921;
                            float _2923 = mad(_2876, _2922, _2921);
                            float _2924 = mad(_773, _2922, _2921);
                            float _2925 = _2876 * _2924;
                            float _2926 = mad(_773, _2923, _2925);
                            float _2927 = 0.5f / _2926;
                            float _2928 = 1.0f - _2866;
                            float _2929 = _2928 * _2928;
                            float _2930 = _2929 * _2929;
                            float _2931 = _2930 * _2928;
                            float _2932 = _361.y;
                            float _2933 = 50.0f * _2932;
                            float _2934 = clamp(_2933, 0.0f, 1.0f);
                            float _2935 = _2934 * _2931;
                            float3 _2936 = _2935.xxx;
                            float _2937 = -_2930;
                            float _2938 = mad(_2937, _2928, 1.0f);
                            float3 _2939 = _361 * _2938;
                            float3 _2940 = _2936 + _2939;
                            float _2941 = _2920 * _2927;
                            float3 _2942 = _2940 * _2941;
                            float3 _2943 = _2878 * _2942;
                            _2944 = _2943;
                        }
                        _2991 = _2944;
                    }
                    float3 _2992 = _2879 * 1.0f;
                    _2993 = _2992;
                    _2994 = _2991;
                    _2995 = 0.0f.xxx;
                    break;
                }
                case 2u:
                {
                    bool _2420 = (int(_371) & 16) != 0;
                    float _2533 = 0.0f;
                    float _2534 = 0.0f;
                    float _2535 = 0.0f;
                    float _2536 = 0.0f;
                    float _2537 = 0.0f;
                    float _2538 = 0.0f;
                    float _2539 = 0.0f;
                    float _2540 = 0.0f;
                    float _2541 = 0.0f;
                    [branch]
                    if (_2420)
                    {
                        float3 _2515 = normalize(cross(_314, _369));
                        float _2516 = dot(_314, _429);
                        float _2517 = dot(_429, _753);
                        float _2519 = rsqrt(mad(2.0f, _2517, 2.0f));
                        float _2525 = dot(_369, _429);
                        float _2526 = dot(_369, _753);
                        float _2529 = dot(_2515, _429);
                        float _2530 = dot(_2515, _753);
                        _2533 = clamp((_754 + _2516) * _2519, 0.0f, 1.0f);
                        _2534 = clamp(mad(_2519, _2517, _2519), 0.0f, 1.0f);
                        _2535 = _2525;
                        _2536 = _2526;
                        _2537 = (_2526 + _2525) * _2519;
                        _2538 = _2529;
                        _2539 = _2530;
                        _2540 = (_2530 + _2529) * _2519;
                        _2541 = _2516;
                    }
                    else
                    {
                        float _2424 = dot(_314, _429);
                        float _2425 = dot(_429, _753);
                        float _2427 = rsqrt(mad(2.0f, _2425, 2.0f));
                        float _2512 = 0.0f;
                        float _2513 = 0.0f;
                        if (_779 > 0.0f)
                        {
                            float _2438 = sqrt(mad(-_779, _779, 1.0f));
                            float _2439 = 2.0f * _754;
                            float _2440 = -_2425;
                            float _2441 = mad(_2439, _2424, _2440);
                            float _2510 = 0.0f;
                            float _2511 = 0.0f;
                            if (_2441 >= _2438)
                            {
                                _2510 = 1.0f;
                                _2511 = abs(_2424);
                            }
                            else
                            {
                                float _2446 = -_2441;
                                float _2449 = _779 * rsqrt(mad(_2446, _2441, 1.0f));
                                float _2450 = mad(_2446, _754, _2424);
                                float _2454 = mad(_2446, _2425, mad(2.0f * _2424, _2424, -1.0f));
                                float _2465 = _2449 * sqrt(clamp(mad(_2439 * _2424, _2425, mad(_2440, _2425, mad(-_2424, _2424, mad(-_754, _754, 1.0f)))), 0.0f, 1.0f));
                                float _2467 = (_2465 * 2.0f) * _2424;
                                float _2468 = mad(_754, _2438, _2424);
                                float _2469 = mad(_2449, _2450, _2468);
                                float _2471 = mad(_2449, _2454, mad(_2425, _2438, 1.0f));
                                float _2472 = _2465 * _2471;
                                float _2473 = _2469 * _2471;
                                float _2478 = _2473 * mad(-0.5f, _2472, (0.25f * _2467) * _2469);
                                float _2488 = mad(_2469, mad(_2468, _2471 * _2471, _2473 * mad(-0.5f, mad(_2425, _2438, _2471), -0.5f)), mad(_2472, _2472, (_2467 * _2469) * mad(_2467, _2469, _2472 * (-2.0f))));
                                float _2492 = (2.0f * _2478) / mad(_2488, _2488, _2478 * _2478);
                                float _2493 = _2492 * _2488;
                                float _2495 = mad(-_2492, _2478, 1.0f);
                                float _2501 = mad(_2425, _2438, mad(_2495, _2449 * _2454, _2493 * _2467));
                                float _2503 = rsqrt(mad(2.0f, _2501, 2.0f));
                                _2510 = clamp((mad(_754, _2438, mad(_2495, _2449 * _2450, _2493 * _2465)) + _2424) * _2503, 0.0f, 1.0f);
                                _2511 = clamp(mad(_2503, _2501, _2503), 0.0f, 1.0f);
                            }
                            _2512 = _2510;
                            _2513 = _2511;
                        }
                        else
                        {
                            _2512 = clamp((_754 + _2424) * _2427, 0.0f, 1.0f);
                            _2513 = clamp(mad(_2427, _2425, _2427), 0.0f, 1.0f);
                        }
                        _2533 = _2512;
                        _2534 = _2513;
                        _2535 = 0.0f;
                        _2536 = 0.0f;
                        _2537 = 0.0f;
                        _2538 = 0.0f;
                        _2539 = 0.0f;
                        _2540 = 0.0f;
                        _2541 = _2424;
                    }
                    float _2544 = clamp(abs(_2541) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    float3 _2546 = 1.0f.xxx * _773;
                    float3 _2659 = 0.0f.xxx;
                    [branch]
                    if (_2420)
                    {
                        float _2613 = _748 * _748;
                        float _2615 = _2613 * (1.0f + _370);
                        float _2616 = isnan(0.001000000047497451305389404296875f) ? _2615 : (isnan(_2615) ? 0.001000000047497451305389404296875f : max(_2615, 0.001000000047497451305389404296875f));
                        float _2618 = _2613 * (1.0f - _370);
                        float _2619 = isnan(0.001000000047497451305389404296875f) ? _2618 : (isnan(_2618) ? 0.001000000047497451305389404296875f : max(_2618, 0.001000000047497451305389404296875f));
                        float _2620 = _2616 * _2619;
                        float3 _2624 = float3(_2619 * _2537, _2616 * _2540, _2620 * _2533);
                        float _2627 = _2620 / dot(_2624, _2624);
                        float _2643 = 1.0f - _2534;
                        float _2644 = _2643 * _2643;
                        float _2645 = _2644 * _2644;
                        _2659 = _2546 * ((((0.3183098733425140380859375f * _2620) * (_2627 * _2627)).xxx * (0.5f / mad(_773, length(float3(_2616 * _2535, _2619 * _2538, _2544)), _2544 * length(float3(_2616 * _2536, _2619 * _2539, _773)))).xxx) * ((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_2645 * _2643)).xxx + (_361 * mad(-_2645, _2643, 1.0f))));
                    }
                    else
                    {
                        float3 _2612 = 0.0f.xxx;
                        if ((_788 & 1u) == 1u)
                        {
                            _2612 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2556 = _748 * _748;
                            float _2566 = 0.0f;
                            if (_781 > 0.0f)
                            {
                                _2566 = clamp(mad(_2556, _2556, (_781 * _781) / mad(_2534, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2566 = _2556 * _2556;
                            }
                            float _2581 = 0.0f;
                            if (_779 > 0.0f)
                            {
                                _2581 = _2566 / (_2566 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_2566) >> 1)), _779)) / (_2534 + 0.001000000047497451305389404296875f)));
                            }
                            else
                            {
                                _2581 = 1.0f;
                            }
                            float _2584 = mad(mad(_2533, _2566, -_2533), _2533, 1.0f);
                            float _2589 = sqrt(_2566);
                            float _2590 = 1.0f - _2589;
                            float _2596 = 1.0f - _2534;
                            float _2597 = _2596 * _2596;
                            float _2598 = _2597 * _2597;
                            _2612 = _2546 * (((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_2598 * _2596)).xxx + (_361 * mad(-_2598, _2596, 1.0f))) * (((_2566 / ((3.1415927410125732421875f * _2584) * _2584)) * _2581) * (0.5f / mad(_773, mad(_2544, _2590, _2589), _2544 * mad(_773, _2590, _2589)))));
                        }
                        _2659 = _2612;
                    }
                    float3 _2661 = _302.xyz;
                    float3 _2662 = _2661 * _2661;
                    float3 _2684 = exp((-((-log(clamp(_2662, 9.9999999600419720025001879548654e-13f.xxx, 1.0f.xxx))) / (isnan(View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters) ? 9.9999999600419720025001879548654e-13f : (isnan(9.9999999600419720025001879548654e-13f) ? View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters : max(9.9999999600419720025001879548654e-13f, View_View_SubSurfaceColorAsTransmittanceAtDistanceInMeters))).xxx)) * 1.0f);
                    float _2685 = _2684.y;
                    float _2686 = _2684.z;
                    bool4 _2688 = (_2685 < _2686).xxxx;
                    float4 _2689 = float4(_2686, _2685, -1.0f, 0.666666686534881591796875f);
                    float4 _2690 = float4(_2685, _2686, 0.0f, -0.3333333432674407958984375f);
                    float4 _2691 = float4(_2688.x ? _2689.x : _2690.x, _2688.y ? _2689.y : _2690.y, _2688.z ? _2689.z : _2690.z, _2688.w ? _2689.w : _2690.w);
                    float _2692 = _2684.x;
                    float _2693 = _2691.x;
                    bool4 _2695 = (_2692 < _2693).xxxx;
                    float4 _2698 = float4(_2693, _2691.yw, _2692);
                    float4 _2700 = float4(_2692, _2691.yz, _2693);
                    float4 _2701 = float4(_2695.x ? _2698.x : _2700.x, _2695.y ? _2698.y : _2700.y, _2695.z ? _2698.z : _2700.z, _2695.w ? _2698.w : _2700.w);
                    float _2702 = _2701.x;
                    float _2703 = _2701.w;
                    float _2704 = _2701.y;
                    float _2706 = _2702 - (isnan(_2704) ? _2703 : (isnan(_2703) ? _2704 : min(_2703, _2704)));
                    float _2712 = abs(((_2703 - _2704) / mad(6.0f, _2706, 1.0000000133514319600180897396058e-10f)) + _2701.z);
                    float _2715 = _2662.y;
                    float _2716 = _2662.z;
                    bool4 _2718 = (_2715 < _2716).xxxx;
                    float4 _2719 = float4(_2716, _2715, -1.0f, 0.666666686534881591796875f);
                    float4 _2720 = float4(_2715, _2716, 0.0f, -0.3333333432674407958984375f);
                    float4 _2721 = float4(_2718.x ? _2719.x : _2720.x, _2718.y ? _2719.y : _2720.y, _2718.z ? _2719.z : _2720.z, _2718.w ? _2719.w : _2720.w);
                    float _2722 = _2662.x;
                    float _2723 = _2721.x;
                    bool4 _2725 = (_2722 < _2723).xxxx;
                    float4 _2726 = float4(_2723, _180, _180, _2722);
                    float4 _2727 = float4(_2722, _180, _180, _2723);
                    _2993 = ((_354 * 0.3183098733425140380859375f) * _2546) * 1.0f;
                    _2994 = _2659;
                    _2995 = (1.0f.xxx * lerp(lerp(1.0f, pow(clamp(mad(_754, 0.666666686534881591796875f, 0.3333333432674407958984375f), 0.0f, 1.0f), 1.5f) * 1.66666662693023681640625f, _430) * 0.15915493667125701904296875f, 1.0f, pow(clamp(dot(_753, _390), 0.0f, 1.0f), 12.0f) * lerp(3.0f, 0.100000001490116119384765625f, _430))) * lerp((((clamp(float3(abs(mad(_2712, 6.0f, -3.0f)) - 1.0f, 2.0f - abs(mad(_2712, 6.0f, -2.0f)), 2.0f - abs(mad(_2712, 6.0f, -4.0f))), 0.0f.xxx, 1.0f.xxx) - 1.0f.xxx) * (_2706 / (_2702 + 1.0000000133514319600180897396058e-10f))) + 1.0f.xxx) * float4(_2725.x ? _2726.x : _2727.x, _2725.y ? _2726.y : _2727.y, _2725.z ? _2726.z : _2727.z, _2725.w ? _2726.w : _2727.w).x, _2662, _463.xxx);
                    break;
                }
                case 3u:
                {
                    bool _2165 = (int(_371) & 16) != 0;
                    float _2278 = 0.0f;
                    float _2279 = 0.0f;
                    float _2280 = 0.0f;
                    float _2281 = 0.0f;
                    float _2282 = 0.0f;
                    float _2283 = 0.0f;
                    float _2284 = 0.0f;
                    float _2285 = 0.0f;
                    float _2286 = 0.0f;
                    [branch]
                    if (_2165)
                    {
                        float3 _2260 = normalize(cross(_314, _369));
                        float _2261 = dot(_314, _429);
                        float _2262 = dot(_429, _753);
                        float _2264 = rsqrt(mad(2.0f, _2262, 2.0f));
                        float _2270 = dot(_369, _429);
                        float _2271 = dot(_369, _753);
                        float _2274 = dot(_2260, _429);
                        float _2275 = dot(_2260, _753);
                        _2278 = clamp((_754 + _2261) * _2264, 0.0f, 1.0f);
                        _2279 = clamp(mad(_2264, _2262, _2264), 0.0f, 1.0f);
                        _2280 = _2270;
                        _2281 = _2271;
                        _2282 = (_2271 + _2270) * _2264;
                        _2283 = _2274;
                        _2284 = _2275;
                        _2285 = (_2275 + _2274) * _2264;
                        _2286 = _2261;
                    }
                    else
                    {
                        float _2169 = dot(_314, _429);
                        float _2170 = dot(_429, _753);
                        float _2172 = rsqrt(mad(2.0f, _2170, 2.0f));
                        float _2257 = 0.0f;
                        float _2258 = 0.0f;
                        if (_779 > 0.0f)
                        {
                            float _2183 = sqrt(mad(-_779, _779, 1.0f));
                            float _2184 = 2.0f * _754;
                            float _2185 = -_2170;
                            float _2186 = mad(_2184, _2169, _2185);
                            float _2255 = 0.0f;
                            float _2256 = 0.0f;
                            if (_2186 >= _2183)
                            {
                                _2255 = 1.0f;
                                _2256 = abs(_2169);
                            }
                            else
                            {
                                float _2191 = -_2186;
                                float _2194 = _779 * rsqrt(mad(_2191, _2186, 1.0f));
                                float _2195 = mad(_2191, _754, _2169);
                                float _2199 = mad(_2191, _2170, mad(2.0f * _2169, _2169, -1.0f));
                                float _2210 = _2194 * sqrt(clamp(mad(_2184 * _2169, _2170, mad(_2185, _2170, mad(-_2169, _2169, mad(-_754, _754, 1.0f)))), 0.0f, 1.0f));
                                float _2212 = (_2210 * 2.0f) * _2169;
                                float _2213 = mad(_754, _2183, _2169);
                                float _2214 = mad(_2194, _2195, _2213);
                                float _2216 = mad(_2194, _2199, mad(_2170, _2183, 1.0f));
                                float _2217 = _2210 * _2216;
                                float _2218 = _2214 * _2216;
                                float _2223 = _2218 * mad(-0.5f, _2217, (0.25f * _2212) * _2214);
                                float _2233 = mad(_2214, mad(_2213, _2216 * _2216, _2218 * mad(-0.5f, mad(_2170, _2183, _2216), -0.5f)), mad(_2217, _2217, (_2212 * _2214) * mad(_2212, _2214, _2217 * (-2.0f))));
                                float _2237 = (2.0f * _2223) / mad(_2233, _2233, _2223 * _2223);
                                float _2238 = _2237 * _2233;
                                float _2240 = mad(-_2237, _2223, 1.0f);
                                float _2246 = mad(_2170, _2183, mad(_2240, _2194 * _2199, _2238 * _2212));
                                float _2248 = rsqrt(mad(2.0f, _2246, 2.0f));
                                _2255 = clamp((mad(_754, _2183, mad(_2240, _2194 * _2195, _2238 * _2210)) + _2169) * _2248, 0.0f, 1.0f);
                                _2256 = clamp(mad(_2248, _2246, _2248), 0.0f, 1.0f);
                            }
                            _2257 = _2255;
                            _2258 = _2256;
                        }
                        else
                        {
                            _2257 = clamp((_754 + _2169) * _2172, 0.0f, 1.0f);
                            _2258 = clamp(mad(_2172, _2170, _2172), 0.0f, 1.0f);
                        }
                        _2278 = _2257;
                        _2279 = _2258;
                        _2280 = 0.0f;
                        _2281 = 0.0f;
                        _2282 = 0.0f;
                        _2283 = 0.0f;
                        _2284 = 0.0f;
                        _2285 = 0.0f;
                        _2286 = _2169;
                    }
                    float _2289 = clamp(abs(_2286) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    float3 _2291 = 1.0f.xxx * _773;
                    float3 _2404 = 0.0f.xxx;
                    [branch]
                    if (_2165)
                    {
                        float _2358 = _748 * _748;
                        float _2360 = _2358 * (1.0f + _370);
                        float _2361 = isnan(0.001000000047497451305389404296875f) ? _2360 : (isnan(_2360) ? 0.001000000047497451305389404296875f : max(_2360, 0.001000000047497451305389404296875f));
                        float _2363 = _2358 * (1.0f - _370);
                        float _2364 = isnan(0.001000000047497451305389404296875f) ? _2363 : (isnan(_2363) ? 0.001000000047497451305389404296875f : max(_2363, 0.001000000047497451305389404296875f));
                        float _2365 = _2361 * _2364;
                        float3 _2369 = float3(_2364 * _2282, _2361 * _2285, _2365 * _2278);
                        float _2372 = _2365 / dot(_2369, _2369);
                        float _2388 = 1.0f - _2279;
                        float _2389 = _2388 * _2388;
                        float _2390 = _2389 * _2389;
                        _2404 = _2291 * ((((0.3183098733425140380859375f * _2365) * (_2372 * _2372)).xxx * (0.5f / mad(_773, length(float3(_2361 * _2280, _2364 * _2283, _2289)), _2289 * length(float3(_2361 * _2281, _2364 * _2284, _773)))).xxx) * ((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_2390 * _2388)).xxx + (_361 * mad(-_2390, _2388, 1.0f))));
                    }
                    else
                    {
                        float3 _2357 = 0.0f.xxx;
                        if ((_788 & 1u) == 1u)
                        {
                            _2357 = 0.0f.xxx;
                        }
                        else
                        {
                            float _2301 = _748 * _748;
                            float _2311 = 0.0f;
                            if (_781 > 0.0f)
                            {
                                _2311 = clamp(mad(_2301, _2301, (_781 * _781) / mad(_2279, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2311 = _2301 * _2301;
                            }
                            float _2326 = 0.0f;
                            if (_779 > 0.0f)
                            {
                                _2326 = _2311 / (_2311 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_2311) >> 1)), _779)) / (_2279 + 0.001000000047497451305389404296875f)));
                            }
                            else
                            {
                                _2326 = 1.0f;
                            }
                            float _2329 = mad(mad(_2278, _2311, -_2278), _2278, 1.0f);
                            float _2334 = sqrt(_2311);
                            float _2335 = 1.0f - _2334;
                            float _2341 = 1.0f - _2279;
                            float _2342 = _2341 * _2341;
                            float _2343 = _2342 * _2342;
                            _2357 = _2291 * (((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_2343 * _2341)).xxx + (_361 * mad(-_2343, _2341, 1.0f))) * (((_2311 / ((3.1415927410125732421875f * _2329) * _2329)) * _2326) * (0.5f / mad(_773, mad(_2289, _2335, _2334), _2289 * mad(_773, _2335, _2334)))));
                        }
                        _2404 = _2357;
                    }
                    float3 _2406 = _302.xyz;
                    _2993 = ((_354 * 0.3183098733425140380859375f) * _2291) * 1.0f;
                    _2994 = _2404;
                    _2995 = View_PreIntegratedBRDF.SampleLevel(View_PreIntegratedBRDFSampler, float2(clamp(mad(_754, 0.5f, 0.5f), 0.0f, 1.0f), 1.0f - _430), 0.0f).xyz * (_2406 * _2406);
                    break;
                }
                case 4u:
                {
                    float _1821 = _302.x;
                    float _1822 = _302.y;
                    float _1823 = isnan(0.0199999995529651641845703125f) ? _1822 : (isnan(_1822) ? 0.0199999995529651641845703125f : max(_1822, 0.0199999995529651641845703125f));
                    bool _1826 = (int(_371) & 16) != 0;
                    float _1827 = dot(_314, _429);
                    float _1828 = dot(_429, _753);
                    float _1830 = rsqrt(mad(2.0f, _1828, 2.0f));
                    float _1833 = clamp((_754 + _1827) * _1830, 0.0f, 1.0f);
                    float _1835 = clamp(mad(_1830, _1828, _1830), 0.0f, 1.0f);
                    float _1837 = mad(-_748, _748, 1.0f);
                    float _1838 = _1823 * _1823;
                    float _1845 = clamp(_779 * ((_1837 > 0.0f) ? (mad(-_1823, _1823, 1.0f) / _1837) : 0.0f), 0.0f, 1.0f);
                    bool _1846 = _1845 > 0.0f;
                    float _1926 = 0.0f;
                    float _1927 = 0.0f;
                    float _1928 = 0.0f;
                    if (_1846)
                    {
                        float _1851 = sqrt(mad(-_1845, _1845, 1.0f));
                        float _1852 = 2.0f * _754;
                        float _1853 = -_1828;
                        float _1854 = mad(_1852, _1827, _1853);
                        float _1923 = 0.0f;
                        float _1924 = 0.0f;
                        float _1925 = 0.0f;
                        if (_1854 >= _1851)
                        {
                            _1923 = _754;
                            _1924 = 1.0f;
                            _1925 = abs(_1827);
                        }
                        else
                        {
                            float _1859 = -_1854;
                            float _1862 = _1845 * rsqrt(mad(_1859, _1854, 1.0f));
                            float _1863 = mad(_1859, _754, _1827);
                            float _1867 = mad(_1859, _1828, mad(2.0f * _1827, _1827, -1.0f));
                            float _1878 = _1862 * sqrt(clamp(mad(_1852 * _1827, _1828, mad(_1853, _1828, mad(-_1827, _1827, mad(-_754, _754, 1.0f)))), 0.0f, 1.0f));
                            float _1880 = (_1878 * 2.0f) * _1827;
                            float _1881 = mad(_754, _1851, _1827);
                            float _1882 = mad(_1862, _1863, _1881);
                            float _1884 = mad(_1862, _1867, mad(_1828, _1851, 1.0f));
                            float _1885 = _1878 * _1884;
                            float _1886 = _1882 * _1884;
                            float _1891 = _1886 * mad(-0.5f, _1885, (0.25f * _1880) * _1882);
                            float _1901 = mad(_1882, mad(_1881, _1884 * _1884, _1886 * mad(-0.5f, mad(_1828, _1851, _1884), -0.5f)), mad(_1885, _1885, (_1880 * _1882) * mad(_1880, _1882, _1885 * (-2.0f))));
                            float _1905 = (2.0f * _1891) / mad(_1901, _1901, _1891 * _1891);
                            float _1906 = _1905 * _1901;
                            float _1908 = mad(-_1905, _1891, 1.0f);
                            float _1913 = mad(_754, _1851, mad(_1908, _1862 * _1863, _1906 * _1878));
                            float _1914 = mad(_1828, _1851, mad(_1908, _1862 * _1867, _1906 * _1880));
                            float _1916 = rsqrt(mad(2.0f, _1914, 2.0f));
                            _1923 = _1913;
                            _1924 = clamp((_1913 + _1827) * _1916, 0.0f, 1.0f);
                            _1925 = clamp(mad(_1916, _1914, _1916), 0.0f, 1.0f);
                        }
                        _1926 = _1923;
                        _1927 = _1924;
                        _1928 = _1925;
                    }
                    else
                    {
                        _1926 = _754;
                        _1927 = _1833;
                        _1928 = _1835;
                    }
                    float _1931 = clamp(abs(_1827) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    bool _1933 = (_788 & 1u) == 1u;
                    float _1934 = _1933 ? _1931 : _1928;
                    float _1935 = 1.0f - _1934;
                    float _1936 = _1935 * _1935;
                    float _1937 = _1936 * _1936;
                    float _1941 = mad(_1937, _1935, mad(-_1937, _1935, 1.0f) * 0.039999999105930328369140625f);
                    float3 _1988 = 0.0f.xxx;
                    if (_1933)
                    {
                        _1988 = 0.0f.xxx;
                    }
                    else
                    {
                        float _1954 = 0.0f;
                        if (_781 > 0.0f)
                        {
                            _1954 = clamp(mad(_1838, _1838, (_781 * _781) / mad(_1934, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                        }
                        else
                        {
                            _1954 = _1838 * _1838;
                        }
                        float _1968 = 0.0f;
                        if (_1846)
                        {
                            _1968 = _1954 / (_1954 + (((0.25f * _1845) * mad(3.0f, asfloat(532487669 + (asint(_1954) >> 1)), _1845)) / (_1934 + 0.001000000047497451305389404296875f)));
                        }
                        else
                        {
                            _1968 = 1.0f;
                        }
                        float _1969 = sqrt(_1954);
                        float _1970 = 1.0f - _1969;
                        float _1978 = mad(mad(_1927, _1954, -_1927), _1927, 1.0f);
                        _1988 = (1.0f.xxx * _1821) * (_773 * ((((_1954 / ((3.1415927410125732421875f * _1978) * _1978)) * _1968) * (0.5f / mad(_773, mad(_1931, _1970, _1969), _1931 * mad(_773, _1970, _1969)))) * _1941));
                    }
                    float _1989 = _748 * _748;
                    float _1990 = 1.0f - _1941;
                    float _2004 = 0.0f;
                    float _2005 = 0.0f;
                    float _2006 = 0.0f;
                    float _2007 = 0.0f;
                    float _2008 = 0.0f;
                    float _2009 = 0.0f;
                    if (_1826)
                    {
                        float3 _1995 = normalize(cross(_314, _369));
                        float _1996 = dot(_369, _429);
                        float _1997 = dot(_369, _753);
                        float _2000 = dot(_1995, _429);
                        float _2001 = dot(_1995, _753);
                        _2004 = _1996;
                        _2005 = _1997;
                        _2006 = (_1997 + _1996) * _1830;
                        _2007 = _2000;
                        _2008 = _2001;
                        _2009 = (_2001 + _2000) * _1830;
                    }
                    else
                    {
                        _2004 = 0.0f;
                        _2005 = 0.0f;
                        _2006 = 0.0f;
                        _2007 = 0.0f;
                        _2008 = 0.0f;
                        _2009 = 0.0f;
                    }
                    float _2012 = _1826 ? _1833 : _1927;
                    float _2013 = _1826 ? _1835 : _1934;
                    float _2015 = mad(mad(-0.2199999988079071044921875f, _2013, 0.62999999523162841796875f), _2013, -0.74500000476837158203125f);
                    float _2017 = -(_2015 * _2012);
                    float _2019 = clamp(mad(0.666666686534881591796875f, _1826 ? _1827 : _1931, _2017), 0.001000000047497451305389404296875f, 1.0f);
                    float _2021 = clamp(mad(0.666666686534881591796875f, _1826 ? _754 : _1926, _2017), 0.001000000047497451305389404296875f, 1.0f);
                    float3 _2042 = 0.0f.xxx;
                    if (_316 > 0.0f)
                    {
                        float3 _2032 = _345 * 0.3183098733425140380859375f;
                        bool3 _3263 = isnan(_2032);
                        bool3 _3264 = isnan(9.9999997473787516355514526367188e-05f.xxx);
                        float3 _3265 = max(_2032, 9.9999997473787516355514526367188e-05f.xxx);
                        float3 _3266 = float3(_3263.x ? 9.9999997473787516355514526367188e-05f.xxx.x : _3265.x, _3263.y ? 9.9999997473787516355514526367188e-05f.xxx.y : _3265.y, _3263.z ? 9.9999997473787516355514526367188e-05f.xxx.z : _3265.z);
                        float _2036 = ((1.0f / _2019) + (1.0f / _2021)) - 2.0f;
                        _2042 = lerp(1.0f.xxx, exp(-((log(float3(_3264.x ? _2032.x : _3266.x, _3264.y ? _2032.y : _3266.y, _3264.z ? _2032.z : _3266.z)) * (-0.5f).xxx) * (isnan(0.0f) ? _2036 : (isnan(_2036) ? 0.0f : max(_2036, 0.0f))))), _319);
                    }
                    else
                    {
                        _2042 = 1.0f.xxx;
                    }
                    float3 _2046 = ((1.0f.xxx * _773) * (_354 * 0.3183098733425140380859375f)) * 1.0f;
                    float3 _2047 = _2042 * (_1990 * _1990);
                    float3 _2049 = _1821.xxx;
                    float3 _2162 = 0.0f.xxx;
                    if ((!_1826) && _1933)
                    {
                        _2162 = _1988 + lerp(0.0f.xxx, 0.0f.xxx, _2049);
                    }
                    else
                    {
                        float _2056 = _1989 * _1989;
                        float _2100 = 0.0f;
                        float _2101 = 0.0f;
                        [branch]
                        if (_1826)
                        {
                            float _2074 = _1989 * (1.0f + _370);
                            float _2075 = isnan(0.001000000047497451305389404296875f) ? _2074 : (isnan(_2074) ? 0.001000000047497451305389404296875f : max(_2074, 0.001000000047497451305389404296875f));
                            float _2077 = _1989 * (1.0f - _370);
                            float _2078 = isnan(0.001000000047497451305389404296875f) ? _2077 : (isnan(_2077) ? 0.001000000047497451305389404296875f : max(_2077, 0.001000000047497451305389404296875f));
                            float _2079 = _2075 * _2078;
                            float3 _2083 = float3(_2078 * _2006, _2075 * _2009, _2079 * _2012);
                            float _2086 = _2079 / dot(_2083, _2083);
                            _2100 = 0.5f / mad(_2021, length(float3(_2075 * _2004, _2078 * _2007, _2019)), _2019 * length(float3(_2075 * _2005, _2078 * _2008, _2021)));
                            _2101 = (0.3183098733425140380859375f * _2079) * (_2086 * _2086);
                        }
                        else
                        {
                            float _2060 = sqrt(_2056);
                            float _2061 = 1.0f - _2060;
                            float _2069 = mad(mad(_2012, _2056, -_2012), _2012, 1.0f);
                            _2100 = 0.5f / mad(_773, mad(_2019, _2061, _2060), _2019 * mad(_773, _2061, _2060));
                            _2101 = _2056 / ((3.1415927410125732421875f * _2069) * _2069);
                        }
                        float _2102 = 1.0f - (_1933 ? _2019 : clamp(mad(0.666666686534881591796875f, _2013, -_2015), 0.0f, 1.0f));
                        float _2103 = _2102 * _2102;
                        float _2104 = _2103 * _2103;
                        float _2108 = clamp(50.0f * _361.y, 0.0f, 1.0f);
                        float _2115 = 1.0f - _2013;
                        float _2116 = _2115 * _2115;
                        float _2117 = _2116 * _2116;
                        float _2152 = 0.0f;
                        [branch]
                        if (_1826)
                        {
                            _2152 = 1.0f;
                        }
                        else
                        {
                            float _2136 = 0.0f;
                            if (_781 > 0.0f)
                            {
                                _2136 = clamp(mad(_1989, _1989, (_781 * _781) / mad(_2013, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _2136 = _2056;
                            }
                            float _2151 = 0.0f;
                            if (_779 > 0.0f)
                            {
                                _2151 = _2136 / (_2136 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_2136) >> 1)), _779)) / (_2013 + 0.001000000047497451305389404296875f)));
                            }
                            else
                            {
                                _2151 = 1.0f;
                            }
                            _2152 = _2151;
                        }
                        _2162 = mad(1.0f.xxx * (((_2152 * _773) * _2101) * _2100), lerp((_2108 * (_2117 * _2115)).xxx + (_361 * mad(-_2117, _2115, 1.0f)), _2047 * ((_2108 * (_2104 * _2102)).xxx + (_361 * mad(-_2104, _2102, 1.0f))), _2049), _1988);
                    }
                    _2993 = lerp(_2046, _2047 * _2046, _2049);
                    _2994 = _2162;
                    _2995 = 0.0f.xxx;
                    break;
                }
                case 5u:
                {
                    float _1588 = dot(_314, _429);
                    float _1589 = dot(_429, _753);
                    float _1591 = rsqrt(mad(2.0f, _1589, 2.0f));
                    bool _1597 = _779 > 0.0f;
                    float _1676 = 0.0f;
                    float _1677 = 0.0f;
                    if (_1597)
                    {
                        float _1602 = sqrt(mad(-_779, _779, 1.0f));
                        float _1603 = 2.0f * _754;
                        float _1604 = -_1589;
                        float _1605 = mad(_1603, _1588, _1604);
                        float _1674 = 0.0f;
                        float _1675 = 0.0f;
                        if (_1605 >= _1602)
                        {
                            _1674 = 1.0f;
                            _1675 = abs(_1588);
                        }
                        else
                        {
                            float _1610 = -_1605;
                            float _1613 = _779 * rsqrt(mad(_1610, _1605, 1.0f));
                            float _1614 = mad(_1610, _754, _1588);
                            float _1618 = mad(_1610, _1589, mad(2.0f * _1588, _1588, -1.0f));
                            float _1629 = _1613 * sqrt(clamp(mad(_1603 * _1588, _1589, mad(_1604, _1589, mad(-_1588, _1588, mad(-_754, _754, 1.0f)))), 0.0f, 1.0f));
                            float _1631 = (_1629 * 2.0f) * _1588;
                            float _1632 = mad(_754, _1602, _1588);
                            float _1633 = mad(_1613, _1614, _1632);
                            float _1635 = mad(_1613, _1618, mad(_1589, _1602, 1.0f));
                            float _1636 = _1629 * _1635;
                            float _1637 = _1633 * _1635;
                            float _1642 = _1637 * mad(-0.5f, _1636, (0.25f * _1631) * _1633);
                            float _1652 = mad(_1633, mad(_1632, _1635 * _1635, _1637 * mad(-0.5f, mad(_1589, _1602, _1635), -0.5f)), mad(_1636, _1636, (_1631 * _1633) * mad(_1631, _1633, _1636 * (-2.0f))));
                            float _1656 = (2.0f * _1642) / mad(_1652, _1652, _1642 * _1642);
                            float _1657 = _1656 * _1652;
                            float _1659 = mad(-_1656, _1642, 1.0f);
                            float _1665 = mad(_1589, _1602, mad(_1659, _1613 * _1618, _1657 * _1631));
                            float _1667 = rsqrt(mad(2.0f, _1665, 2.0f));
                            _1674 = clamp((mad(_754, _1602, mad(_1659, _1613 * _1614, _1657 * _1629)) + _1588) * _1667, 0.0f, 1.0f);
                            _1675 = clamp(mad(_1667, _1665, _1667), 0.0f, 1.0f);
                        }
                        _1676 = _1674;
                        _1677 = _1675;
                    }
                    else
                    {
                        _1676 = clamp((_754 + _1588) * _1591, 0.0f, 1.0f);
                        _1677 = clamp(mad(_1591, _1589, _1591), 0.0f, 1.0f);
                    }
                    float _1680 = clamp(abs(_1588) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    float4 _1688 = View_SSProfilesTexture.Load(int3(int3(5, int(uint(mad(_302.x, 255.0f, 0.5f))), 0).xy, 0));
                    float _1693 = clamp((_430 - 0.100000001490116119384765625f) * 10.0f, 0.0f, 1.0f);
                    float _1698 = _1688.z;
                    float _1700 = clamp(_748 * lerp(1.0f, _1688.x * 2.0f, _1693), 0.0f, 1.0f);
                    float _1701 = isnan(0.0199999995529651641845703125f) ? _1700 : (isnan(_1700) ? 0.0199999995529651641845703125f : max(_1700, 0.0199999995529651641845703125f));
                    float _1703 = clamp(_748 * lerp(1.0f, _1688.y * 2.0f, _1693), 0.0f, 1.0f);
                    float _1704 = lerp(_1701, _1703, _1698);
                    float _1708 = mad((2.0f * _1677) * _1677, _748, 0.5f) - 1.0f;
                    float _1709 = 1.0f - _1680;
                    float _1710 = _1709 * _1709;
                    float _1714 = 1.0f - _773;
                    float _1715 = _1714 * _1714;
                    float3 _1722 = 1.0f.xxx * _773;
                    float3 _1819 = 0.0f.xxx;
                    if ((_788 & 1u) == 1u)
                    {
                        _1819 = lerp(0.0f.xxx, 0.0f.xxx, _1698.xxx);
                    }
                    else
                    {
                        float _1729 = _1704 * _1704;
                        float _1731 = _1701 * _1701;
                        float _1733 = _1703 * _1703;
                        bool _1735 = _781 > 0.0f;
                        float _1743 = 0.0f;
                        if (_1735)
                        {
                            _1743 = clamp(mad(_1731, _1731, (_781 * _781) / mad(_1677, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                        }
                        else
                        {
                            _1743 = _1731 * _1731;
                        }
                        float _1757 = 0.0f;
                        if (_1597)
                        {
                            _1757 = _1743 / (_1743 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_1743) >> 1)), _779)) / (_1677 + 0.001000000047497451305389404296875f)));
                        }
                        else
                        {
                            _1757 = 1.0f;
                        }
                        float _1765 = 0.0f;
                        if (_1735)
                        {
                            _1765 = clamp(mad(_1733, _1733, (_781 * _781) / mad(_1677, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                        }
                        else
                        {
                            _1765 = _1733 * _1733;
                        }
                        float _1779 = 0.0f;
                        if (_1597)
                        {
                            _1779 = _1765 / (_1765 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_1765) >> 1)), _779)) / (_1677 + 0.001000000047497451305389404296875f)));
                        }
                        else
                        {
                            _1779 = 1.0f;
                        }
                        float _1780 = -_1676;
                        float _1782 = mad(mad(_1676, _1743, _1780), _1676, 1.0f);
                        float _1788 = mad(mad(_1676, _1765, _1780), _1676, 1.0f);
                        float _1794 = sqrt(_1729 * _1729);
                        float _1795 = 1.0f - _1794;
                        float _1801 = 1.0f - _1677;
                        float _1802 = _1801 * _1801;
                        float _1803 = _1802 * _1802;
                        _1819 = _1722 * (((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_1803 * _1801)).xxx + (_361 * mad(-_1803, _1801, 1.0f))) * (lerp((_1743 / ((3.1415927410125732421875f * _1782) * _1782)) * _1757, (_1765 / ((3.1415927410125732421875f * _1788) * _1788)) * _1779, _1698) * (0.5f / mad(_773, mad(_1680, _1795, _1794), _1680 * mad(_773, _1795, _1794)))));
                    }
                    _2993 = (_1722 * (_354 * ((0.3183098733425140380859375f * mad(_1708, (_1710 * _1710) * _1709, 1.0f)) * mad(_1708, (_1715 * _1715) * _1714, 1.0f)))) * 1.0f;
                    _2994 = _1819;
                    _2995 = 0.0f.xxx;
                    break;
                }
                case 6u:
                {
                    bool _1330 = (int(_371) & 16) != 0;
                    float _1443 = 0.0f;
                    float _1444 = 0.0f;
                    float _1445 = 0.0f;
                    float _1446 = 0.0f;
                    float _1447 = 0.0f;
                    float _1448 = 0.0f;
                    float _1449 = 0.0f;
                    float _1450 = 0.0f;
                    float _1451 = 0.0f;
                    [branch]
                    if (_1330)
                    {
                        float3 _1425 = normalize(cross(_314, _369));
                        float _1426 = dot(_314, _429);
                        float _1427 = dot(_429, _753);
                        float _1429 = rsqrt(mad(2.0f, _1427, 2.0f));
                        float _1435 = dot(_369, _429);
                        float _1436 = dot(_369, _753);
                        float _1439 = dot(_1425, _429);
                        float _1440 = dot(_1425, _753);
                        _1443 = clamp((_754 + _1426) * _1429, 0.0f, 1.0f);
                        _1444 = clamp(mad(_1429, _1427, _1429), 0.0f, 1.0f);
                        _1445 = _1435;
                        _1446 = _1436;
                        _1447 = (_1436 + _1435) * _1429;
                        _1448 = _1439;
                        _1449 = _1440;
                        _1450 = (_1440 + _1439) * _1429;
                        _1451 = _1426;
                    }
                    else
                    {
                        float _1334 = dot(_314, _429);
                        float _1335 = dot(_429, _753);
                        float _1337 = rsqrt(mad(2.0f, _1335, 2.0f));
                        float _1422 = 0.0f;
                        float _1423 = 0.0f;
                        if (_779 > 0.0f)
                        {
                            float _1348 = sqrt(mad(-_779, _779, 1.0f));
                            float _1349 = 2.0f * _754;
                            float _1350 = -_1335;
                            float _1351 = mad(_1349, _1334, _1350);
                            float _1420 = 0.0f;
                            float _1421 = 0.0f;
                            if (_1351 >= _1348)
                            {
                                _1420 = 1.0f;
                                _1421 = abs(_1334);
                            }
                            else
                            {
                                float _1356 = -_1351;
                                float _1359 = _779 * rsqrt(mad(_1356, _1351, 1.0f));
                                float _1360 = mad(_1356, _754, _1334);
                                float _1364 = mad(_1356, _1335, mad(2.0f * _1334, _1334, -1.0f));
                                float _1375 = _1359 * sqrt(clamp(mad(_1349 * _1334, _1335, mad(_1350, _1335, mad(-_1334, _1334, mad(-_754, _754, 1.0f)))), 0.0f, 1.0f));
                                float _1377 = (_1375 * 2.0f) * _1334;
                                float _1378 = mad(_754, _1348, _1334);
                                float _1379 = mad(_1359, _1360, _1378);
                                float _1381 = mad(_1359, _1364, mad(_1335, _1348, 1.0f));
                                float _1382 = _1375 * _1381;
                                float _1383 = _1379 * _1381;
                                float _1388 = _1383 * mad(-0.5f, _1382, (0.25f * _1377) * _1379);
                                float _1398 = mad(_1379, mad(_1378, _1381 * _1381, _1383 * mad(-0.5f, mad(_1335, _1348, _1381), -0.5f)), mad(_1382, _1382, (_1377 * _1379) * mad(_1377, _1379, _1382 * (-2.0f))));
                                float _1402 = (2.0f * _1388) / mad(_1398, _1398, _1388 * _1388);
                                float _1403 = _1402 * _1398;
                                float _1405 = mad(-_1402, _1388, 1.0f);
                                float _1411 = mad(_1335, _1348, mad(_1405, _1359 * _1364, _1403 * _1377));
                                float _1413 = rsqrt(mad(2.0f, _1411, 2.0f));
                                _1420 = clamp((mad(_754, _1348, mad(_1405, _1359 * _1360, _1403 * _1375)) + _1334) * _1413, 0.0f, 1.0f);
                                _1421 = clamp(mad(_1413, _1411, _1413), 0.0f, 1.0f);
                            }
                            _1422 = _1420;
                            _1423 = _1421;
                        }
                        else
                        {
                            _1422 = clamp((_754 + _1334) * _1337, 0.0f, 1.0f);
                            _1423 = clamp(mad(_1337, _1335, _1337), 0.0f, 1.0f);
                        }
                        _1443 = _1422;
                        _1444 = _1423;
                        _1445 = 0.0f;
                        _1446 = 0.0f;
                        _1447 = 0.0f;
                        _1448 = 0.0f;
                        _1449 = 0.0f;
                        _1450 = 0.0f;
                        _1451 = _1334;
                    }
                    float _1454 = clamp(abs(_1451) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    float3 _1456 = 1.0f.xxx * _773;
                    float3 _1569 = 0.0f.xxx;
                    [branch]
                    if (_1330)
                    {
                        float _1523 = _748 * _748;
                        float _1525 = _1523 * (1.0f + _370);
                        float _1526 = isnan(0.001000000047497451305389404296875f) ? _1525 : (isnan(_1525) ? 0.001000000047497451305389404296875f : max(_1525, 0.001000000047497451305389404296875f));
                        float _1528 = _1523 * (1.0f - _370);
                        float _1529 = isnan(0.001000000047497451305389404296875f) ? _1528 : (isnan(_1528) ? 0.001000000047497451305389404296875f : max(_1528, 0.001000000047497451305389404296875f));
                        float _1530 = _1526 * _1529;
                        float3 _1534 = float3(_1529 * _1447, _1526 * _1450, _1530 * _1443);
                        float _1537 = _1530 / dot(_1534, _1534);
                        float _1553 = 1.0f - _1444;
                        float _1554 = _1553 * _1553;
                        float _1555 = _1554 * _1554;
                        _1569 = _1456 * ((((0.3183098733425140380859375f * _1530) * (_1537 * _1537)).xxx * (0.5f / mad(_773, length(float3(_1526 * _1445, _1529 * _1448, _1454)), _1454 * length(float3(_1526 * _1446, _1529 * _1449, _773)))).xxx) * ((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_1555 * _1553)).xxx + (_361 * mad(-_1555, _1553, 1.0f))));
                    }
                    else
                    {
                        float3 _1522 = 0.0f.xxx;
                        if ((_788 & 1u) == 1u)
                        {
                            _1522 = 0.0f.xxx;
                        }
                        else
                        {
                            float _1466 = _748 * _748;
                            float _1476 = 0.0f;
                            if (_781 > 0.0f)
                            {
                                _1476 = clamp(mad(_1466, _1466, (_781 * _781) / mad(_1444, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                            }
                            else
                            {
                                _1476 = _1466 * _1466;
                            }
                            float _1491 = 0.0f;
                            if (_779 > 0.0f)
                            {
                                _1491 = _1476 / (_1476 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_1476) >> 1)), _779)) / (_1444 + 0.001000000047497451305389404296875f)));
                            }
                            else
                            {
                                _1491 = 1.0f;
                            }
                            float _1494 = mad(mad(_1443, _1476, -_1443), _1443, 1.0f);
                            float _1499 = sqrt(_1476);
                            float _1500 = 1.0f - _1499;
                            float _1506 = 1.0f - _1444;
                            float _1507 = _1506 * _1506;
                            float _1508 = _1507 * _1507;
                            _1522 = _1456 * (((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_1508 * _1506)).xxx + (_361 * mad(-_1508, _1506, 1.0f))) * (((_1476 / ((3.1415927410125732421875f * _1494) * _1494)) * _1491) * (0.5f / mad(_773, mad(_1454, _1500, _1499), _1454 * mad(_773, _1500, _1499)))));
                        }
                        _1569 = _1522;
                    }
                    float3 _1571 = _302.xyz;
                    float _1578 = clamp(-dot(_429, _753), 0.0f, 1.0f);
                    float _1581 = mad(mad(_1578, 0.36000001430511474609375f, -_1578), _1578, 1.0f);
                    _2993 = ((_354 * 0.3183098733425140380859375f) * _1456) * 1.0f;
                    _2994 = _1569;
                    _2995 = (1.0f.xxx * (clamp((0.5f - _754) * 0.4444444477558135986328125f, 0.0f, 1.0f) * (0.36000001430511474609375f / ((3.1415927410125732421875f * _1581) * _1581)))) * (_1571 * _1571);
                    break;
                }
                case 7u:
                {
                    float _1152 = clamp(_748, 0.0039215688593685626983642578125f, 1.0f);
                    float _1153 = isnan(1.0f) ? 1.0f : (isnan(1.0f) ? 1.0f : min(1.0f, 1.0f));
                    float _1154 = dot(_429, _753);
                    float _1155 = clamp(_754, -1.0f, 1.0f);
                    float _1157 = clamp(dot(_314, _429), -1.0f, 1.0f);
                    float _1158 = abs(_1157);
                    float _1159 = mad(-0.15658299624919891357421875f, _1158, 1.57079637050628662109375f);
                    float _1161 = sqrt(1.0f - _1158);
                    float _1168 = abs(_1155);
                    float _1169 = mad(-0.15658299624919891357421875f, _1168, 1.57079637050628662109375f);
                    float _1171 = sqrt(1.0f - _1168);
                    float _1181 = cos(0.5f * abs((1.57079637050628662109375f - ((_1157 >= 0.0f) ? (_1159 * _1161) : mad(-_1159, _1161, 3.1415927410125732421875f))) - (1.57079637050628662109375f - ((_1155 >= 0.0f) ? (_1169 * _1171) : mad(-_1169, _1171, 3.1415927410125732421875f)))));
                    float3 _1183 = _753 - (_314 * _1155);
                    float3 _1185 = _429 - (_314 * _1157);
                    float _1191 = dot(_1183, _1185) * rsqrt(mad(dot(_1183, _1183), dot(_1185, _1185), 9.9999997473787516355514526367188e-05f));
                    float _1194 = sqrt(clamp(mad(0.5f, _1191, 0.5f), 0.0f, 1.0f));
                    float _1197 = _1152 * _1152;
                    float _1198 = _1197 * 0.5f;
                    float _1199 = _1197 * 2.0f;
                    float _1207 = _1197 * (1.41421353816986083984375f * _1194);
                    float _1208 = _1155 + _1157;
                    float _1209 = mad(0.1398856937885284423828125f, mad(0.997551023960113525390625f * _1194, sqrt(mad(-_1157, _1157, 1.0f)), (-0.06994284689426422119140625f) * _1157), _1208);
                    float _1221 = 1.0f - sqrt(clamp(mad(0.5f, _1154, 0.5f), 0.0f, 1.0f));
                    float _1222 = _1221 * _1221;
                    float _1235 = _1208 - 0.0350000001490116119384765625f;
                    float _1243 = 1.0f / mad(0.36000001430511474609375f, _1181, 1.190000057220458984375f / _1181);
                    float _1246 = _1194 * mad(_1243, mad(-0.800000011920928955078125f, _1191, 0.60000002384185791015625f), 1.0f);
                    float _1251 = -_1181;
                    float _1252 = mad(_1251, sqrt(clamp(mad(-_1246, _1246, 1.0f), 0.0f, 1.0f)), 1.0f);
                    float _1253 = _1252 * _1252;
                    float _1257 = 1.0f - mad(0.95347940921783447265625f, (_1253 * _1253) * _1252, 0.0465205647051334381103515625f);
                    float3 _1259 = abs(_345);
                    float _1260 = _1246 * _1243;
                    float _1275 = _1208 - 0.14000000059604644775390625f;
                    float _1283 = mad(_1251, 0.5f, 1.0f);
                    float _1284 = _1283 * _1283;
                    float _1287 = mad(0.95347940921783447265625f, (_1284 * _1284) * _1283, 0.0465205647051334381103515625f);
                    float _1288 = 1.0f - _1287;
                    float3 _1300 = (((((((exp(((-0.5f) * (_1209 * _1209)) / (_1207 * _1207)) / (2.5066282749176025390625f * _1207)) * (0.25f * _1194)) * mad(0.95347940921783447265625f, (_1222 * _1222) * _1221, 0.0465205647051334381103515625f)) * (_346 * 2.0f)) * lerp(1.0f, _1153, clamp(-_1154, 0.0f, 1.0f))).xxx + ((pow(_1259, ((0.5f * sqrt(mad(-_1260, _1260, 1.0f))) / _1181).xxx) * (((exp(((-0.5f) * (_1235 * _1235)) / (_1198 * _1198)) / (_1197 * 1.25331413745880126953125f)) * exp(mad(-3.650000095367431640625f, _1191, -3.980000019073486328125f))) * (_1257 * _1257))) * _1153)) + (pow(_1259, (0.800000011920928955078125f / _1181).xxx) * (((exp(((-0.5f) * (_1275 * _1275)) / (_1199 * _1199)) / (_1197 * 5.013256549835205078125f)) * exp(mad(17.0f, _1191, -16.7800006866455078125f))) * ((_1288 * _1288) * _1287)))) * _741;
                    float _1314 = dot(_345, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                    float3 _1325 = -mad(sqrt(_1259) * ((0.3183098733425140380859375f * lerp(clamp((dot(normalize(_429 - (_314 * dot(_429, _314))), _753) + 1.0f) * 0.25f, 0.0f, 1.0f), 1.0f - abs(_754), 0.3300000131130218505859375f)) * _316), pow(abs(_345 / (isnan(9.9999997473787516355514526367188e-05f) ? _1314 : (isnan(_1314) ? 9.9999997473787516355514526367188e-05f : max(_1314, 9.9999997473787516355514526367188e-05f))).xxx), (1.0f - _740).xxx), _1300);
                    bool3 _3340 = isnan(_1325);
                    bool3 _3341 = isnan(0.0f.xxx);
                    float3 _3342 = min(_1325, 0.0f.xxx);
                    float3 _3343 = float3(_3340.x ? 0.0f.xxx.x : _3342.x, _3340.y ? 0.0f.xxx.y : _3342.y, _3340.z ? 0.0f.xxx.z : _3342.z);
                    _2993 = 0.0f.xxx;
                    _2994 = 0.0f.xxx;
                    _2995 = -float3(_3341.x ? _1325.x : _3343.x, _3341.y ? _1325.y : _3343.y, _3341.z ? _1325.z : _3343.z);
                    break;
                }
                case 8u:
                {
                    float3 _953 = _302.xyz;
                    float3 _954 = _953 * _953;
                    float _955 = clamp(_430, 0.0f, 1.0f);
                    float _956 = dot(_314, _429);
                    float _957 = dot(_429, _753);
                    float _959 = rsqrt(mad(2.0f, _957, 2.0f));
                    bool _965 = _779 > 0.0f;
                    float _1044 = 0.0f;
                    float _1045 = 0.0f;
                    if (_965)
                    {
                        float _970 = sqrt(mad(-_779, _779, 1.0f));
                        float _971 = 2.0f * _754;
                        float _972 = -_957;
                        float _973 = mad(_971, _956, _972);
                        float _1042 = 0.0f;
                        float _1043 = 0.0f;
                        if (_973 >= _970)
                        {
                            _1042 = 1.0f;
                            _1043 = abs(_956);
                        }
                        else
                        {
                            float _978 = -_973;
                            float _981 = _779 * rsqrt(mad(_978, _973, 1.0f));
                            float _982 = mad(_978, _754, _956);
                            float _986 = mad(_978, _957, mad(2.0f * _956, _956, -1.0f));
                            float _997 = _981 * sqrt(clamp(mad(_971 * _956, _957, mad(_972, _957, mad(-_956, _956, mad(-_754, _754, 1.0f)))), 0.0f, 1.0f));
                            float _999 = (_997 * 2.0f) * _956;
                            float _1000 = mad(_754, _970, _956);
                            float _1001 = mad(_981, _982, _1000);
                            float _1003 = mad(_981, _986, mad(_957, _970, 1.0f));
                            float _1004 = _997 * _1003;
                            float _1005 = _1001 * _1003;
                            float _1010 = _1005 * mad(-0.5f, _1004, (0.25f * _999) * _1001);
                            float _1020 = mad(_1001, mad(_1000, _1003 * _1003, _1005 * mad(-0.5f, mad(_957, _970, _1003), -0.5f)), mad(_1004, _1004, (_999 * _1001) * mad(_999, _1001, _1004 * (-2.0f))));
                            float _1024 = (2.0f * _1010) / mad(_1020, _1020, _1010 * _1010);
                            float _1025 = _1024 * _1020;
                            float _1027 = mad(-_1024, _1010, 1.0f);
                            float _1033 = mad(_957, _970, mad(_1027, _981 * _986, _1025 * _999));
                            float _1035 = rsqrt(mad(2.0f, _1033, 2.0f));
                            _1042 = clamp((mad(_754, _970, mad(_1027, _981 * _982, _1025 * _997)) + _956) * _1035, 0.0f, 1.0f);
                            _1043 = clamp(mad(_1035, _1033, _1035), 0.0f, 1.0f);
                        }
                        _1044 = _1042;
                        _1045 = _1043;
                    }
                    else
                    {
                        _1044 = clamp((_754 + _956) * _959, 0.0f, 1.0f);
                        _1045 = clamp(mad(_959, _957, _959), 0.0f, 1.0f);
                    }
                    float _1048 = clamp(abs(_956) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    float3 _1110 = 0.0f.xxx;
                    if ((_788 & 1u) == 1u)
                    {
                        _1110 = 0.0f.xxx;
                    }
                    else
                    {
                        float _1055 = _748 * _748;
                        float _1065 = 0.0f;
                        if (_781 > 0.0f)
                        {
                            _1065 = clamp(mad(_1055, _1055, (_781 * _781) / mad(_1045, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                        }
                        else
                        {
                            _1065 = _1055 * _1055;
                        }
                        float _1079 = 0.0f;
                        if (_965)
                        {
                            _1079 = _1065 / (_1065 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_1065) >> 1)), _779)) / (_1045 + 0.001000000047497451305389404296875f)));
                        }
                        else
                        {
                            _1079 = 1.0f;
                        }
                        float _1082 = mad(mad(_1044, _1065, -_1044), _1044, 1.0f);
                        float _1087 = sqrt(_1065);
                        float _1088 = 1.0f - _1087;
                        float _1094 = 1.0f - _1045;
                        float _1095 = _1094 * _1094;
                        float _1096 = _1095 * _1095;
                        _1110 = (1.0f.xxx * _773) * (((clamp(50.0f * _361.y, 0.0f, 1.0f) * (_1096 * _1094)).xxx + (_361 * mad(-_1096, _1094, 1.0f))) * (((_1065 / ((3.1415927410125732421875f * _1082) * _1082)) * _1079) * (0.5f / mad(_773, mad(_1048, _1088, _1087), _1048 * mad(_773, _1088, _1087)))));
                    }
                    float _1111 = _748 * _748;
                    float _1112 = _1111 * _1111;
                    float _1115 = mad(mad(-_1112, _1044, _1044), _1044, _1112);
                    float _1128 = 1.0f - _1045;
                    float _1129 = _1128 * _1128;
                    float _1130 = _1129 * _1129;
                    float3 _1141 = 1.0f.xxx * _773;
                    _2993 = (_1141 * (_354 * 0.3183098733425140380859375f)) * lerp(1.0f, 1.0f, _955);
                    _2994 = lerp(_1110, ((_1141 * (((0.3183098733425140380859375f / mad(4.0f, _1112, 1.0f)) * (1.0f + (((4.0f * _1112) * _1112) / (_1115 * _1115)))) * (0.25f / mad(-_773, _1048, _773 + _1048)))) * ((clamp(50.0f * _954.y, 0.0f, 1.0f) * (_1130 * _1128)).xxx + (_954 * mad(-_1130, _1128, 1.0f)))) * 1.0f, _955.xxx);
                    _2995 = 0.0f.xxx;
                    break;
                }
                case 9u:
                {
                    float2 _804 = (_302.yz * 2.0f) - 1.0f.xx;
                    float _806 = dot(1.0f.xx, abs(_804));
                    float3 _810 = float3(_804, 1.0f - _806);
                    float _811 = _806 - 1.0f;
                    float _812 = isnan(0.0f) ? _811 : (isnan(_811) ? 0.0f : max(_811, 0.0f));
                    float2 _813 = _810.xy;
                    bool2 _814 = bool2(_813.x >= 0.0f.xx.x, _813.y >= 0.0f.xx.y);
                    float _815 = -_812;
                    float2 _821 = _813 + float2(_814.x ? _815 : _812, _814.y ? _815 : _812);
                    float3 _823 = normalize(float3(_821.x, _821.y, _810.z));
                    float _824 = 1.0f - _430;
                    float _830 = dot(_314, _429);
                    float _831 = dot(_429, _753);
                    float _833 = rsqrt(mad(2.0f, _831, 2.0f));
                    bool _839 = _779 > 0.0f;
                    float _874 = 0.0f;
                    float _875 = 0.0f;
                    if (_839)
                    {
                        float _844 = sqrt(mad(-_779, _779, 1.0f));
                        float _847 = mad(2.0f * _754, _830, -_831);
                        float _872 = 0.0f;
                        float _873 = 0.0f;
                        if (_847 >= _844)
                        {
                            _872 = 1.0f;
                            _873 = abs(_830);
                        }
                        else
                        {
                            float _852 = -_847;
                            float _855 = _779 * rsqrt(mad(_852, _847, 1.0f));
                            float _863 = mad(_831, _844, _855 * mad(_852, _831, mad(2.0f * _830, _830, -1.0f)));
                            float _865 = rsqrt(mad(2.0f, _863, 2.0f));
                            _872 = clamp((mad(_754, _844, _855 * mad(_852, _754, _830)) + _830) * _865, 0.0f, 1.0f);
                            _873 = clamp(mad(_865, _863, _865), 0.0f, 1.0f);
                        }
                        _874 = _872;
                        _875 = _873;
                    }
                    else
                    {
                        _874 = clamp((_754 + _830) * _833, 0.0f, 1.0f);
                        _875 = clamp(mad(_833, _831, _833), 0.0f, 1.0f);
                    }
                    float _878 = clamp(abs(_830) + 9.9999997473787516355514526367188e-06f, 0.0f, 1.0f);
                    bool _880 = (_788 & 1u) == 1u;
                    float _881 = _880 ? _878 : _875;
                    float _883 = 1.0f - _881;
                    float _884 = _883 * _883;
                    float _885 = _884 * _884;
                    float _889 = mad(_885, _883, mad(-_885, _883, 1.0f) * (_346 * 0.07999999821186065673828125f));
                    float3 _936 = 0.0f.xxx;
                    if (_880)
                    {
                        _936 = 0.0f.xxx;
                    }
                    else
                    {
                        float _893 = _748 * _748;
                        float _903 = 0.0f;
                        if (_781 > 0.0f)
                        {
                            _903 = clamp(mad(_893, _893, (_781 * _781) / mad(_881, 3.599999904632568359375f, 0.4000000059604644775390625f)), 0.0f, 1.0f);
                        }
                        else
                        {
                            _903 = _893 * _893;
                        }
                        float _917 = 0.0f;
                        if (_839)
                        {
                            _917 = _903 / (_903 + (((0.25f * _779) * mad(3.0f, asfloat(532487669 + (asint(_903) >> 1)), _779)) / (_881 + 0.001000000047497451305389404296875f)));
                        }
                        else
                        {
                            _917 = 1.0f;
                        }
                        float _918 = sqrt(_903);
                        float _919 = 1.0f - _918;
                        float _927 = mad(mad(_874, _903, -_874), _874, 1.0f);
                        _936 = (((1.0f.xxx * _773) * ((_903 / ((3.1415927410125732421875f * _927) * _927)) * _917)) * (0.5f / mad(_773, mad(_878, _919, _918), _878 * mad(_773, _919, _918)))) * _889;
                    }
                    float _938 = clamp(dot(_823, _753), 0.0f, 1.0f);
                    float _939 = lerp(12.0f, 1.0f, _938);
                    _2993 = 0.0f.xxx;
                    _2994 = _936;
                    _2995 = (1.0f.xxx * (lerp(_773, _938 * mad(0.20000000298023223876953125f * (_939 + 1.0f), pow(clamp(dot(normalize(lerp(_823, -_314, (_824 * _247).xxx)), _753), 0.0f, 1.0f), _939), 0.800000011920928955078125f), _824) * (1.0f - _889))) * (_354 * 0.3183098733425140380859375f);
                    break;
                }
                default:
                {
                    _2993 = 0.0f.xxx;
                    _2994 = 0.0f.xxx;
                    _2995 = 0.0f.xxx;
                    break;
                }
            }
            float3 _2997 = DeferredLightUniforms_DeferredLightUniforms_Color * _741;
            float _3008 = 0.0f;
            if (_321)
            {
                float _3007 = 0.0f;
                if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                {
                    _3007 = dot(_2993 * _2997, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                }
                else
                {
                    _3007 = 0.0f;
                }
                _3008 = _3007;
            }
            else
            {
                _3008 = 0.0f;
            }
            float3 _3010 = DeferredLightUniforms_DeferredLightUniforms_Color * _740;
            float _3022 = 0.0f;
            if (_321)
            {
                float _3021 = 0.0f;
                if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
                {
                    _3021 = _3008 + dot(_2995 * _3010, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
                }
                else
                {
                    _3021 = _3008;
                }
                _3022 = _3021;
            }
            else
            {
                _3022 = _3008;
            }
            _3025 = _3022;
            _3026 = mad(_2993, _2997, _2995 * _3010);
            _3027 = (_2994 * DeferredLightUniforms_DeferredLightUniforms_SpecularScale) * _2997;
        }
        else
        {
            _3025 = 0.0f;
            _3026 = 0.0f.xxx;
            _3027 = 0.0f.xxx;
        }
        float4 _3031 = float4(_3026, 0.0f);
        float4 _3042 = 0.0f.xxxx;
        if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
        {
            float4 _3041 = _3031;
            _3041.w = _3025;
            _3042 = _3041;
        }
        else
        {
            _3042 = _3031;
        }
        _3044 = float4(_3027, 0.0f) + _3042;
    }
    else
    {
        _3044 = 0.0f.xxxx;
    }
    out_var_SV_Target0 = _3044 * View_View_PreExposure;
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

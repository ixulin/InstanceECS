Shader "InstanceShader"
{
    Properties
    {
        [NoScaleOffset] _MainTex("MainTex", 2D) = "white" {}
        [NoScaleOffset]_AnimTex("AnimTex", 2D) = "white" {}
        _BaseColor("BaseColor", Color) = (0.9716981, 0.9563668, 0.1420879, 0)
        _Metalic("Metalic", Float) = 0
        _PixelCountPerFrame("PixelCountPerFrame", Int) = 0
        _AnimOffset("AnimOffset", Float) = 0
        _AnimationType("AnimationType", Int) = 0
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

    }
        SubShader
    {
        Tags
        {
            "RenderPipeline" = "UniversalPipeline"
            "RenderType" = "Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue" = "Geometry"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma multi_compile_instancing
    #pragma multi_compile_fog
    #pragma multi_compile _ DOTS_INSTANCING_ON
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
    #pragma multi_compile _ LIGHTMAP_ON
    #pragma multi_compile _ DIRLIGHTMAP_COMBINED
    #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
    #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
    #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
    #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
    #pragma multi_compile _ _SHADOWS_SOFT
    #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
    #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_POSITION_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TANGENT_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_VIEWDIRECTION_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 viewDirectionWS;
        #endif
        #if defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float2 lightmapUV;
        #endif
        #endif
        #if !defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 sh;
        #endif
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 fogFactorAndVertexLight;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 shadowCoord;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 WorldSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp3 : TEXCOORD3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp4 : TEXCOORD4;
        #endif
        #if defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float2 interp5 : TEXCOORD5;
        #endif
        #endif
        #if !defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp6 : TEXCOORD6;
        #endif
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp7 : TEXCOORD7;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp8 : TEXCOORD8;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.positionWS;
        output.interp1.xyz = input.normalWS;
        output.interp2.xyzw = input.tangentWS;
        output.interp3.xyzw = input.texCoord0;
        output.interp4.xyz = input.viewDirectionWS;
        #if defined(LIGHTMAP_ON)
        output.interp5.xy = input.lightmapUV;
        #endif
        #if !defined(LIGHTMAP_ON)
        output.interp6.xyz = input.sh;
        #endif
        output.interp7.xyzw = input.fogFactorAndVertexLight;
        output.interp8.xyzw = input.shadowCoord;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.positionWS = input.interp0.xyz;
        output.normalWS = input.interp1.xyz;
        output.tangentWS = input.interp2.xyzw;
        output.texCoord0 = input.interp3.xyzw;
        output.viewDirectionWS = input.interp4.xyz;
        #if defined(LIGHTMAP_ON)
        output.lightmapUV = input.interp5.xy;
        #endif
        #if !defined(LIGHTMAP_ON)
        output.sh = input.interp6.xyz;
        #endif
        output.fogFactorAndVertexLight = input.interp7.xyzw;
        output.shadowCoord = input.interp8.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
    float3 NormalWS;
    float3 Emission;
    float Metallic;
    float Smoothness;
    float Occlusion;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float _Property_c7c1fc10840d40cc92843a78400917a1_Out_0 = _Metalic;
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    surface.NormalWS = IN.WorldSpaceNormal;
    surface.Emission = float3(0, 0, 0);
    surface.Metallic = _Property_c7c1fc10840d40cc92843a78400917a1_Out_0;
    surface.Smoothness = 0.5;
    surface.Occlusion = 1;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float3 unnormalizedNormalWS = input.normalWS;
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.uv0 = input.texCoord0;
    #endif

    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
    #else
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
    #endif
    #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

        return output;
    }

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "GBuffer"
    Tags
    {
        "LightMode" = "UniversalGBuffer"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma multi_compile_instancing
    #pragma multi_compile_fog
    #pragma multi_compile _ DOTS_INSTANCING_ON
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
    #pragma multi_compile _ DIRLIGHTMAP_COMBINED
    #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
    #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
    #pragma multi_compile _ _SHADOWS_SOFT
    #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
    #pragma multi_compile _ _GBUFFER_NORMALS_OCT
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_POSITION_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TANGENT_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_VIEWDIRECTION_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_GBUFFER
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 viewDirectionWS;
        #endif
        #if defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float2 lightmapUV;
        #endif
        #endif
        #if !defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 sh;
        #endif
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 fogFactorAndVertexLight;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 shadowCoord;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 WorldSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp3 : TEXCOORD3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp4 : TEXCOORD4;
        #endif
        #if defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float2 interp5 : TEXCOORD5;
        #endif
        #endif
        #if !defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp6 : TEXCOORD6;
        #endif
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp7 : TEXCOORD7;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp8 : TEXCOORD8;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.positionWS;
        output.interp1.xyz = input.normalWS;
        output.interp2.xyzw = input.tangentWS;
        output.interp3.xyzw = input.texCoord0;
        output.interp4.xyz = input.viewDirectionWS;
        #if defined(LIGHTMAP_ON)
        output.interp5.xy = input.lightmapUV;
        #endif
        #if !defined(LIGHTMAP_ON)
        output.interp6.xyz = input.sh;
        #endif
        output.interp7.xyzw = input.fogFactorAndVertexLight;
        output.interp8.xyzw = input.shadowCoord;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.positionWS = input.interp0.xyz;
        output.normalWS = input.interp1.xyz;
        output.tangentWS = input.interp2.xyzw;
        output.texCoord0 = input.interp3.xyzw;
        output.viewDirectionWS = input.interp4.xyz;
        #if defined(LIGHTMAP_ON)
        output.lightmapUV = input.interp5.xy;
        #endif
        #if !defined(LIGHTMAP_ON)
        output.sh = input.interp6.xyz;
        #endif
        output.fogFactorAndVertexLight = input.interp7.xyzw;
        output.shadowCoord = input.interp8.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
    float3 NormalWS;
    float3 Emission;
    float Metallic;
    float Smoothness;
    float Occlusion;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float _Property_c7c1fc10840d40cc92843a78400917a1_Out_0 = _Metalic;
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    surface.NormalWS = IN.WorldSpaceNormal;
    surface.Emission = float3(0, 0, 0);
    surface.Metallic = _Property_c7c1fc10840d40cc92843a78400917a1_Out_0;
    surface.Smoothness = 0.5;
    surface.Occlusion = 1;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float3 unnormalizedNormalWS = input.normalWS;
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.uv0 = input.texCoord0;
    #endif

    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
    #else
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
    #endif
    #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

        return output;
    }

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "ShadowCaster"
    Tags
    {
        "LightMode" = "ShadowCaster"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On
    ColorMask 0

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.normalWS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.normalWS = input.interp0.xyz;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

    // Graph Vertex
    struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "DepthOnly"
    Tags
    {
        "LightMode" = "DepthOnly"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On
    ColorMask 0

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

    // Graph Vertex
    struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "DepthNormals"
    Tags
    {
        "LightMode" = "DepthNormals"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TANGENT_WS
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentWS;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 WorldSpaceNormal;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp1 : TEXCOORD1;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.normalWS;
        output.interp1.xyzw = input.tangentWS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.normalWS = input.interp0.xyz;
        output.tangentWS = input.interp1.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

    // Graph Vertex
    struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 NormalWS;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    surface.NormalWS = IN.WorldSpaceNormal;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float3 unnormalizedNormalWS = input.normalWS;
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
    #endif



    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
    #else
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
    #endif
    #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

        return output;
    }

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "Meta"
    Tags
    {
        "LightMode" = "Meta"
    }

        // Render State
        Cull Off

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp0 : TEXCOORD0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyzw = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.texCoord0 = input.interp0.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
    float3 Emission;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    surface.Emission = float3(0, 0, 0);
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv0 = input.texCoord0;
#endif

#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

    ENDHLSL
}
Pass
{
        // Name: <None>
        Tags
        {
            "LightMode" = "Universal2D"
        }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 4.5
    #pragma exclude_renderers gles gles3 glcore
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp0 : TEXCOORD0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyzw = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.texCoord0 = input.interp0.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv0 = input.texCoord0;
#endif

#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

    ENDHLSL
}
    }
        SubShader
    {
        Tags
        {
            "RenderPipeline" = "UniversalPipeline"
            "RenderType" = "Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue" = "Geometry"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 2.0
    #pragma only_renderers gles gles3 glcore d3d11
    #pragma multi_compile_instancing
    #pragma multi_compile_fog
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
    #pragma multi_compile _ LIGHTMAP_ON
    #pragma multi_compile _ DIRLIGHTMAP_COMBINED
    #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
    #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
    #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
    #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
    #pragma multi_compile _ _SHADOWS_SOFT
    #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
    #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_POSITION_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TANGENT_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_VIEWDIRECTION_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 viewDirectionWS;
        #endif
        #if defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float2 lightmapUV;
        #endif
        #endif
        #if !defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 sh;
        #endif
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 fogFactorAndVertexLight;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 shadowCoord;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 WorldSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp3 : TEXCOORD3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp4 : TEXCOORD4;
        #endif
        #if defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float2 interp5 : TEXCOORD5;
        #endif
        #endif
        #if !defined(LIGHTMAP_ON)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp6 : TEXCOORD6;
        #endif
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp7 : TEXCOORD7;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp8 : TEXCOORD8;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.positionWS;
        output.interp1.xyz = input.normalWS;
        output.interp2.xyzw = input.tangentWS;
        output.interp3.xyzw = input.texCoord0;
        output.interp4.xyz = input.viewDirectionWS;
        #if defined(LIGHTMAP_ON)
        output.interp5.xy = input.lightmapUV;
        #endif
        #if !defined(LIGHTMAP_ON)
        output.interp6.xyz = input.sh;
        #endif
        output.interp7.xyzw = input.fogFactorAndVertexLight;
        output.interp8.xyzw = input.shadowCoord;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.positionWS = input.interp0.xyz;
        output.normalWS = input.interp1.xyz;
        output.tangentWS = input.interp2.xyzw;
        output.texCoord0 = input.interp3.xyzw;
        output.viewDirectionWS = input.interp4.xyz;
        #if defined(LIGHTMAP_ON)
        output.lightmapUV = input.interp5.xy;
        #endif
        #if !defined(LIGHTMAP_ON)
        output.sh = input.interp6.xyz;
        #endif
        output.fogFactorAndVertexLight = input.interp7.xyzw;
        output.shadowCoord = input.interp8.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
    float3 NormalWS;
    float3 Emission;
    float Metallic;
    float Smoothness;
    float Occlusion;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float _Property_c7c1fc10840d40cc92843a78400917a1_Out_0 = _Metalic;
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    surface.NormalWS = IN.WorldSpaceNormal;
    surface.Emission = float3(0, 0, 0);
    surface.Metallic = _Property_c7c1fc10840d40cc92843a78400917a1_Out_0;
    surface.Smoothness = 0.5;
    surface.Occlusion = 1;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float3 unnormalizedNormalWS = input.normalWS;
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.uv0 = input.texCoord0;
    #endif

    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
    #else
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
    #endif
    #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

        return output;
    }

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "ShadowCaster"
    Tags
    {
        "LightMode" = "ShadowCaster"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On
    ColorMask 0

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 2.0
    #pragma only_renderers gles gles3 glcore d3d11
    #pragma multi_compile_instancing
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.normalWS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.normalWS = input.interp0.xyz;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

    // Graph Vertex
    struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "DepthOnly"
    Tags
    {
        "LightMode" = "DepthOnly"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On
    ColorMask 0

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 2.0
    #pragma only_renderers gles gles3 glcore d3d11
    #pragma multi_compile_instancing
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

    // Graph Vertex
    struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "DepthNormals"
    Tags
    {
        "LightMode" = "DepthNormals"
    }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 2.0
    #pragma only_renderers gles gles3 glcore d3d11
    #pragma multi_compile_instancing
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_NORMAL_WS
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TANGENT_WS
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalWS;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentWS;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 WorldSpaceNormal;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 interp0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp1 : TEXCOORD1;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyz = input.normalWS;
        output.interp1.xyzw = input.tangentWS;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.normalWS = input.interp0.xyz;
        output.tangentWS = input.interp1.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

    // Graph Vertex
    struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 NormalWS;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    surface.NormalWS = IN.WorldSpaceNormal;
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float3 unnormalizedNormalWS = input.normalWS;
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
    #endif



    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
    #endif



    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
    #else
    #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
    #endif
    #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

        return output;
    }

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

    ENDHLSL
}
Pass
{
    Name "Meta"
    Tags
    {
        "LightMode" = "Meta"
    }

        // Render State
        Cull Off

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 2.0
    #pragma only_renderers gles gles3 glcore d3d11
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv1 : TEXCOORD1;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp0 : TEXCOORD0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyzw = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.texCoord0 = input.interp0.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
    float3 Emission;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    surface.Emission = float3(0, 0, 0);
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv0 = input.texCoord0;
#endif

#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

    ENDHLSL
}
Pass
{
        // Name: <None>
        Tags
        {
            "LightMode" = "Universal2D"
        }

        // Render State
        Cull Back
    Blend One Zero
    ZTest LEqual
    ZWrite On

        // Debug
        // <None>

        // --------------------------------------------------
        // Pass

        HLSLPROGRAM

        // Pragmas
        #pragma target 2.0
    #pragma only_renderers gles gles3 glcore d3d11
    #pragma multi_compile_instancing
    #pragma vertex vert
    #pragma fragment frag

        // DotsInstancingOptions: <None>


        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

    #if defined(_RECEIVE_SHADOWS_OFF)
        #define KEYWORD_PERMUTATION_0
    #else
        #define KEYWORD_PERMUTATION_1
    #endif


        // Defines
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMALMAP 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define _NORMAL_DROPOFF_WS 1
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_NORMAL
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TANGENT
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD0
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD2
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define ATTRIBUTES_NEED_TEXCOORD3
    #endif

    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    #define VARYINGS_NEED_TEXCOORD0
    #endif

        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

        // --------------------------------------------------
        // Structs and Packing

        struct Attributes
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 positionOS : POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 normalOS : NORMAL;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 tangentOS : TANGENT;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0 : TEXCOORD0;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2 : TEXCOORD2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3 : TEXCOORD3;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : INSTANCEID_SEMANTIC;
        #endif
        #endif
    };
    struct Varyings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 texCoord0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };
    struct SurfaceDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv0;
        #endif
    };
    struct VertexDescriptionInputs
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceNormal;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpaceTangent;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 ObjectSpacePosition;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv2;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 uv3;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 TimeParameters;
        #endif
    };
    struct PackedVaryings
    {
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 positionCS : SV_POSITION;
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float4 interp0 : TEXCOORD0;
        #endif
        #if UNITY_ANY_INSTANCING_ENABLED
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint instanceID : CUSTOM_INSTANCE_ID;
        #endif
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        #endif
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        #endif
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
        #endif
        #endif
    };

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    PackedVaryings PackVaryings(Varyings input)
    {
        PackedVaryings output;
        output.positionCS = input.positionCS;
        output.interp0.xyzw = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    Varyings UnpackVaryings(PackedVaryings input)
    {
        Varyings output;
        output.positionCS = input.positionCS;
        output.texCoord0 = input.interp0.xyzw;
        #if UNITY_ANY_INSTANCING_ENABLED
        output.instanceID = input.instanceID;
        #endif
        #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        #endif
        #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        output.cullFace = input.cullFace;
        #endif
        return output;
    }
    #endif

    // --------------------------------------------------
    // Graph

    // Graph Properties
    CBUFFER_START(UnityPerMaterial)
float4 _MainTex_TexelSize;
float4 _AnimTex_TexelSize;
float _Metalic;
float _PixelCountPerFrame;
// Hybrid instanced properties
float4 _BaseColor;
float _AnimOffset;
float _AnimationType;
CBUFFER_END
#if defined(UNITY_DOTS_INSTANCING_ENABLED)
// DOTS instancing definitions
UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimOffset)
    UNITY_DOTS_INSTANCED_PROP(float, _AnimationType)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)
// DOTS instancing usage macros
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) UNITY_ACCESS_DOTS_INSTANCED_PROP_FROM_MACRO(type, Metadata_##var)
#else
#define UNITY_ACCESS_HYBRID_INSTANCED_PROP(var, type) var
#endif

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D(_AnimTex);
SAMPLER(sampler_AnimTex);

// Graph Functions

// 304ec601b02570c1fb4fa318cf838fac
#include "Assets/AnimationInstance/Shaders/InstanceShader.hlsl"

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}

// Graph Vertex
struct VertexDescription
{
    float3 Position;
    float3 Normal;
    float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
    VertexDescription description = (VertexDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0 = IN.uv2;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _UV_a8ec3d480fd841109927c1787d88efb3_Out_0 = IN.uv3;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3;
    float4 _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6;
    GetMatrix_float((float4(IN.ObjectSpacePosition, 1.0)), (float4(IN.ObjectSpaceNormal, 1.0)), _UV_28b07e802f4b4f8cbe8771e149d51b1a_Out_0, _UV_a8ec3d480fd841109927c1787d88efb3_Out_0, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, IN.TimeParameters.x, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3, _GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6);
    #endif
    description.Position = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animPosition_3.xyz);
    description.Normal = (_GetMatrixCustomFunction_6bc950b703ab401bacf10e6c5988a36d_animNormal_6.xyz);
    description.Tangent = IN.ObjectSpaceTangent;
    return description;
}

// Graph Pixel
struct SurfaceDescription
{
    float3 BaseColor;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
    SurfaceDescription surface = (SurfaceDescription)0;
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Property_406fea2569ba456fbcf9100fc04a695a_Out_0 = UNITY_ACCESS_HYBRID_INSTANCED_PROP(_BaseColor, float4);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    UnityTexture2D _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0 = SAMPLE_TEXTURE2D(_Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.tex, _Property_485cfeeba1a04e39b2e257cfd2ce71ff_Out_0.samplerstate, IN.uv0.xy);
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_R_4 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.r;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_G_5 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.g;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_B_6 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.b;
    float _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_A_7 = _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0.a;
    #endif
    #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
    float4 _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2;
    Unity_Multiply_float(_Property_406fea2569ba456fbcf9100fc04a695a_Out_0, _SampleTexture2D_66d59d8cc0df4d0c97977ba947d9b4c0_RGBA_0, _Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2);
    #endif
    surface.BaseColor = (_Multiply_3da6d697a3be48e49e9575c8341e16e0_Out_2.xyz);
    return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
    VertexDescriptionInputs output;
    ZERO_INITIALIZE(VertexDescriptionInputs, output);

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceNormal = input.normalOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpaceTangent = input.tangentOS.xyz;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.ObjectSpacePosition = input.positionOS;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv2 = input.uv2;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv3 = input.uv3;
#endif

#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.TimeParameters = _TimeParameters.xyz;
#endif


    return output;
}
    SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
    SurfaceDescriptionInputs output;
    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
output.uv0 = input.texCoord0;
#endif

#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

    return output;
}

    // --------------------------------------------------
    // Main

    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

    ENDHLSL
}
    }
        CustomEditor "AnimationInstance.Editor.InstanceShaderGui"
        FallBack "Hidden/Shader Graph/FallbackError"
}
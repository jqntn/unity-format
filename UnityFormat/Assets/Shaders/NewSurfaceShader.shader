Shader "Custom/NewSurfaceShader"
{
  Properties{
    [MainTexture] _MainTex("Albedo (RGB)", 2D) = "white" {} //
    _Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)           //
    _Smoothness("Smoothness", Range(0.0, 1.0)) = 0.0        //
    _Metallic("Metallic", Range(0.0, 1.0)) = 0.0            //
  }

  SubShader
  {
    Tags{ "RenderType" = "Opaque" }

    Tags{ "Queue" = "Geometry" }

    Pass
    {
      HLSLPROGRAM

#pragma vertex vert
#pragma fragment frag

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

      TEXTURE2D(_MainTex);
      SAMPLER(sampler_MainTex);

      CBUFFER_START(UnityPerMaterial)
      float4 _MainTex_ST;
      half4 _Color;
      half _Smoothness;
      half _Metallic;
      CBUFFER_END

      struct appdata
      {
        float3 vertex : POSITION;
        float2 uv : TEXCOORD0;
      };

      struct v2f
      {
        float4 pos : SV_POSITION;
        float2 uv : TEXCOORD0;
      };

      v2f vert(appdata v)
      {
        v2f o;
        o.pos = TransformObjectToHClip(v.vertex.xyz);
        o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        return o;
      }

      half4 frag(v2f i)
        : SV_Target
      {
        half4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv);
        return color;
      }

      ENDHLSL
    }
  }
}
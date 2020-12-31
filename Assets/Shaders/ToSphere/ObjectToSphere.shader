Shader "Custom/ObjectToSphere"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _Intensity("Intensity", Range(0.0, 1.0)) = 0.0
        _SphereSize("Size", Range(0.0, 2.0)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float _Intensity;
            float _SphereSize;

            v2f vert (appdata IN)
            {
                v2f o;

                float3 spherePos = normalize(IN.vertex.xyz) * _SphereSize;
                float4 finalPos = float4(lerp(IN.vertex.xyz, spherePos, _Intensity), 1.0);

                o.position = UnityObjectToClipPos(finalPos);
                o.uv = IN.uv;
                return o;
            }

            fixed4 frag(v2f IN) : SV_TARGET
            {
                return tex2D(_MainTex, IN.uv);
            }

            ENDCG
        }
    }
}

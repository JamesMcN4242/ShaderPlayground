﻿// Following along with tutorial by Morgan James found here: https://www.youtube.com/watch?v=fp89rfT4tqI&ab_channel=MorganJames
// Very good tutorial for a refresher on all the parts of a shader

Shader "Custom/OutlineDistort"
{
    Properties
    {
        _DistortColor("Distort Colour", Color) = (1,1,1,1)
        _BumpAmt("Distortion", Range(0, 128)) = 10
        _DistortTex("Distort Texture", 2D) = "white" {}
        _BumpMap("Bump Map", 2D) = "white" {}
        _OutlineWidth("Outline Width", Range(1.0, 10.0)) = 1.5
    }

    SubShader
    { 
            Tags
            {
                "Queue" = "Transparent"
            }

            GrabPass{}

            Pass
            {
                Name "OUTLINE DISTORT"

                ZWrite Off

                CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"

                struct appdata
                {
                    float4 vertex : POSITION;
                    float2 texcoord : TEXCOORD0;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    float4 uvgrab : TEXCOORD0;
                    float2 uvbump : TEXCOORD1;
                    float2 uvmain : TEXCOORD2;
                };

                float _BumpAmt;
                float4 _BumpMap_ST;
                float4 _DistortTex_ST;

                fixed4 _DistortColor;
                sampler2D _GrabTexture;
                float4 _GrabTexture_TexelSize;
                sampler2D _BumpMap;
                sampler2D _DistortTex;
                float _OutlineWidth;

                v2f vert(appdata IN)
                {
                    IN.vertex.xyz *= _OutlineWidth;
                    v2f OUT;
                    OUT.vertex = UnityObjectToClipPos(IN.vertex);

#if UNITY_UV_STARTS_AT_TOP
                    float scale = -1.0;
#else
                    float scale = 1.0;
#endif

                    OUT.uvgrab.xy = (float2(OUT.vertex.x, OUT.vertex.y * scale) + OUT.vertex.w) * 0.5;
                    OUT.uvgrab.zw = OUT.vertex.zw;

                    OUT.uvbump = TRANSFORM_TEX(IN.texcoord, _BumpMap);
                    OUT.uvmain = TRANSFORM_TEX(IN.texcoord, _DistortTex);

                    return OUT;
                }

                half4 frag(v2f IN) : SV_Target
                {
                    half2 bump = UnpackNormal(tex2D(_BumpMap, IN.uvbump)).rg;
                    float2 offset = bump * _BumpAmt * _GrabTexture_TexelSize.xy;
                    IN.uvgrab.xy = offset * IN.uvgrab.z + IN.uvgrab.xy;

                    half4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.uvgrab));
                    half4 tint = tex2D(_DistortTex, IN.uvmain) * _DistortColor;

                    return col * tint;
                }

                ENDCG
            }    
}

    FallBack "Diffuse"
}

// Following along with tutorial by Morgan James found here: https://www.youtube.com/watch?v=fp89rfT4tqI&ab_channel=MorganJames
// Very good tutorial for a refresher on all the parts of a shader

Shader "Custom/OutlineShader"
{
    Properties
    {
        [Header(Main Object Rendering)]
        _MainTex("Main Texture", 2D) = "white" {}
        _Color("Colour", Color) = (1, 1, 1, 1)

        [Header(Outline Rendering)]
        _OutlineTex("Outline Texture", 2D) = "white" {}
        _OutlineColor("Outline Colour", Color) = (1, 1, 1, 1)
        _OutlineWidth("Outline Width", Range(1.0, 10.0)) = 1.5
    }

    SubShader
    { 
            Tags
            {
                "Queue" = "Transparent"
            }

            //Render the outline of the object
            Pass
            {
                Name "OUTLINE"

                ZWrite Off

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
                    float4 pos : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                sampler2D _OutlineTex;
                float4 _OutlineColor;
                float _OutlineWidth;

                v2f vert(appdata IN)
                {
                    IN.vertex.xyz *= _OutlineWidth;
                    v2f OUT;

                    OUT.pos = UnityObjectToClipPos(IN.vertex);
                    OUT.uv = IN.uv;

                    return OUT;
                }

                fixed4 frag(v2f IN) : SV_Target
                {
                    float4 texCol = tex2D(_OutlineTex, IN.uv);
                    return texCol * _OutlineColor;
                }

                ENDCG
            }

            //Render the main object in a pass
            Pass
            {
                Name "OBJECT"
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
                    float4 pos : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                sampler2D _MainTex;
                float4 _Color;

                v2f vert(appdata IN)
                {
                    v2f OUT;
                    
                    OUT.pos = UnityObjectToClipPos(IN.vertex);
                    OUT.uv = IN.uv;

                    return OUT;
                }

                fixed4 frag(v2f IN) : SV_Target
                {
                    float4 texCol = tex2D(_MainTex, IN.uv);
                    return texCol * _Color;
                }

                ENDCG
            }
    
}

    FallBack "Diffuse"
}

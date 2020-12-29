// Following along with tutorial by Morgan James found here: https://www.youtube.com/watch?v=fp89rfT4tqI&ab_channel=MorganJames
// Very good tutorial for a refresher on all the parts of a shader

Shader "Custom/ApplyTexture"
{
    Properties
    {
        [Header(Main Object Rendering)]
        _MainTex("Main Texture", 2D) = "white" {}
        _Color("Colour", Color) = (1, 1, 1, 1)
    }

    SubShader
    { 
            Tags
            {
                "Queue" = "Transparent"
            }

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

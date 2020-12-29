// Following along with tutorial by Morgan James found here: https://www.youtube.com/watch?v=fp89rfT4tqI&ab_channel=MorganJames
// Very good tutorial for a refresher on all the parts of a shader

Shader "Custom/FinalOutline"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _Color("Colour", Color) = (1, 1, 1, 1)

        _OutlineWidth("Outline Width", Range(1.0, 10.0)) = 1.5

        _BlurRadius("Blur Radius", Range(0.0, 20.0)) = 1
        _Intensity("Blur Intensity", Range(0.0, 1.0)) = 0.01

        _DistortColor("Distort Colour", Color) = (1,1,1,1)
        _BumpAmt("Distortion", Range(0, 128)) = 10
        _DistortTex("Distort Texture", 2D) = "white" {}
        _BumpMap("Bump Map", 2D) = "white" {}
    }

    SubShader
    { 
            Tags
            {
                "Queue" = "Transparent"
            }

            GrabPass{}
            UsePass "Custom/OutlineDistort/OUTLINE DISTORT"

            GrabPass{}
            UsePass "Custom/OutlineBlur/OUTLINE HORIZONTAL BLUR"
            GrabPass{}
            UsePass "Custom/OutlineBlur/OUTLINE VERTICAL BLUR"

            UsePass "Custom/OutlineShader/OBJECT"
    }
}

// ----------------------------------------------------------------------------
// Glow 11
// Copyright ﾂｩ 2013 Sven Herrmann
// ----------------------------------------------------------------------------
Shader "Hidden/Glow 11/Advanced Blur" {
    Properties {
        _MainTex ("", 2D) = "" {}
    }

    CGINCLUDE
    #pragma only_renderers opengl d3d9 d3d11
    ENDCG 

    Subshader {
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 1
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 1
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 2
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 2
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 3
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 3
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 4
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 4
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 5
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 5
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 6
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 6
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 7
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 7
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 8
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 8
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 9
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 9
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 10
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 10
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 11
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 11
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 12
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 12
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 13
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 13
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 14
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 14
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        } 
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 15
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 15
          #pragma target 3.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }   
    }
    
    
    Subshader {
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 1
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 1
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 2
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 2
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 3
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 3
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #define RADIUS 4
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 4
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 5
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 5
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 6
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragX
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
          CGPROGRAM
          #define RADIUS 6
          #pragma target 2.0
          #include "../../AdvancedBlur.cginc"
          #pragma vertex vert
          #pragma fragment fragY
          ENDCG
        }
        
    }
        
    Fallback off
   
}

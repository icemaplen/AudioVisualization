// ----------------------------------------------------------------------------
// Glow 11
// Copyright © 2013 Sven Herrmann
// ----------------------------------------------------------------------------
Shader "Hidden/Glow 11/GlowObjects" {
    Properties {
    	_TintColor ("Tint Color", Color) = (1,1,1,1)
        _GlowStrength ("Glow Strength", Float) = 1.0
        _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    }

Subshader {
    Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
    Pass {
        Lighting Off  Fog { Mode off } 
        Name "OpaqueGlow"
        CGPROGRAM            
            #include "../../Glow11GlowObjectsCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest            
            #pragma vertex vert
            #pragma fragment fragGlow
            #pragma multi_compile GLOW11_GLOW_MAINTEX GLOW11_GLOW_MAINCOLOR GLOW11_GLOW_GLOWTEX GLOW11_GLOW_ILLUMTEX GLOW11_GLOW_GLOWCOLOR GLOW11_GLOW_VERTEXCOLOR
            #pragma multi_compile NO_MULTIPLY GLOW11_MULTIPLY_GLOWCOLOR GLOW11_MULTIPLY_VERT GLOW11_MULTIPLY_VERT_ALPHA GLOW11_MULTIPLY_ILLUMTEX_ALPHA GLOW11_MULTIPLY_MAINTEX_ALPHA
        ENDCG    
    }
    
}

Subshader {
    Tags { "RenderEffect"="Glow11Transparent" "RenderType"="Glow11Transparent" "Queue"="Transparent" }
    Pass {    
        Cull Off Lighting Off ZWrite Off ZTest LEqual Fog { Mode off } 
        Blend SrcAlpha OneMinusSrcAlpha
        CGPROGRAM
            #define ALPHA 1
            #include "../../Glow11GlowObjectsCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma vertex vert
            #pragma fragment fragGlow
            #pragma multi_compile GLOW11_GLOW_MAINTEX GLOW11_GLOW_MAINCOLOR GLOW11_GLOW_GLOWTEX GLOW11_GLOW_ILLUMTEX GLOW11_GLOW_GLOWCOLOR GLOW11_GLOW_VERTEXCOLOR
            #pragma multi_compile NO_MULTIPLY GLOW11_MULTIPLY_GLOWCOLOR GLOW11_MULTIPLY_VERT GLOW11_MULTIPLY_VERT_ALPHA GLOW11_MULTIPLY_ILLUMTEX_ALPHA GLOW11_MULTIPLY_MAINTEX_ALPHA
        ENDCG            
    }
}

Subshader {
    Tags { "RenderEffect"="Glow11TransparentCutout" "RenderType"="Glow11TransparentCutout" "Queue"="AlphaTest"}
    Pass {
        Lighting Off ZTest LEqual Fog { Mode off } 
        AlphaTest Greater [_Cutoff]
        CGPROGRAM    
            #define ALPHA 1        
            #include "../../Glow11GlowObjectsCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest            
            #pragma vertex vert
            #pragma fragment fragGlow            
            #pragma multi_compile GLOW11_GLOW_MAINTEX GLOW11_GLOW_MAINCOLOR GLOW11_GLOW_GLOWTEX GLOW11_GLOW_ILLUMTEX GLOW11_GLOW_GLOWCOLOR GLOW11_GLOW_VERTEXCOLOR
            #pragma multi_compile NO_MULTIPLY GLOW11_MULTIPLY_GLOWCOLOR GLOW11_MULTIPLY_VERT GLOW11_MULTIPLY_VERT_ALPHA GLOW11_MULTIPLY_ILLUMTEX_ALPHA GLOW11_MULTIPLY_MAINTEX_ALPHA
        ENDCG    
    }
}


Subshader {
    Tags { "RenderType"="Opaque" }
    Pass {
        Lighting Off Fog { Mode off } 
    }
}   

Subshader {
    Tags { "RenderType"="TreeOpaque" }
    Pass {
        Lighting Off Fog { Mode off } 
    }
}  
 
Subshader {
    Tags { "RenderType"="TransparentCutout" "Queue"="AlphaTest"}
    Pass {
    	Cull Off
    	Lighting Off Fog { Mode off } 
    	AlphaTest Greater [_Cutoff]
        SetTexture [_MainTex] {
            constantColor (0,0,0,0)
            combine constant, texture
        }
    }    
}   

Subshader {
    Tags { "RenderType"="TreeTransparentCutout" "Queue"="AlphaTest"}
    Pass {
    	Cull Off
    	Lighting Off Fog { Mode off } 
    	AlphaTest Greater [_Cutoff]
        SetTexture [_MainTex] {
            constantColor (0,0,0,0)
            combine constant, texture
        }
    }    
}   


Subshader {
    Tags { "RenderType"="Transparent" "Queue"="Transparent"}
    Pass {
    	Lighting Off Fog { Mode off } ZWrite Off
    	Blend SrcAlpha OneMinusSrcAlpha
    	Color [_Color]
        SetTexture [_MainTex] {
            constantColor (0,0,0,0)
            combine constant, previous * texture
        }
    }    
}   


 
Fallback off
   
}
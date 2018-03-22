// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// ----------------------------------------------------------------------------
// Glow 11
// Copyright © 2013 Sven Herrmann
// ----------------------------------------------------------------------------
#include "UnityCG.cginc"

struct appdata_color {
    float4 vertex : POSITION;
    float2 texcoord : TEXCOORD0;
    
    #if GLOW11_GLOW_VERTEXCOLOR || GLOW11_MULTIPLY_VERT || GLOW11_MULTIPLY_VERT_ALPHA
        float4 color : COLOR;
    #endif
};
            
 
struct v2f {
    float4 pos : POSITION;
    
    
    float4 color : COLOR;
    
    #if GLOW11_GLOW_MAINTEX || ALPHA || GLOW11_MULTIPLY_MAINTEX_ALPHA
        float2 uv : TEXCOORD0;
    #endif

    #if GLOW11_GLOW_GLOWTEX
        float2 uvGlow : TEXCOORD1;
    #endif
    
    #if GLOW11_GLOW_ILLUMTEX || GLOW11_MULTIPLY_ILLUMTEX_ALPHA
        float2 uvIllum : TEXCOORD2;
    #endif
};

struct PixelOutput {
    float4 color : COLOR0;
};

#if GLOW11_GLOW_MAINTEX || ALPHA || GLOW11_MULTIPLY_MAINTEX_ALPHA
    sampler2D _MainTex;
    float4 _MainTex_ST;
#endif
    
#if GLOW11_GLOW_GLOWTEX
    sampler2D _GlowTex;
    float4 _GlowTex_ST;
#endif        

#if GLOW11_GLOW_ILLUMTEX || GLOW11_MULTIPLY_ILLUMTEX_ALPHA
sampler2D _Illum;
float4 _Illum_ST;
#endif        

float _GlowStrength;

#if GLOW11_GLOW_GLOWCOLOR || GLOW11_MULTIPLY_GLOWCOLOR
fixed4 _GlowColor;
#endif

#if GLOW11_GLOW_MAINCOLOR
fixed4 _Color;
#endif


v2f vert( appdata_color v )
{
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex);
    
    #if GLOW11_GLOW_MAINTEX || ALPHA
        o.uv = TRANSFORM_TEX(v.texcoord, _MainTex).xy;
    #endif            
        
    #if GLOW11_GLOW_GLOWTEX
           o.uvGlow = TRANSFORM_TEX(v.texcoord, _GlowTex).xy;
    #endif
    
    #if GLOW11_GLOW_ILLUMTEX || GLOW11_MULTIPLY_ILLUMTEX_ALPHA
        o.uvIllum = TRANSFORM_TEX(v.texcoord, _Illum).xy;
    #endif
    
    #if GLOW11_GLOW_VERTEXCOLOR || GLOW11_MULTIPLY_VERT || GLOW11_MULTIPLY_VERT_ALPHA
           o.color = v.color;
    #endif
                      
    return o;
}    
             
PixelOutput fragGlow(v2f pixelData)
{
    PixelOutput o;

    #if GLOW11_GLOW_MAINTEX
        o.color = tex2D(_MainTex, pixelData.uv);
    #elif GLOW11_GLOW_MAINCOLOR
        o.color = _Color;
    #elif GLOW11_GLOW_GLOWTEX
        o.color = tex2D(_GlowTex, pixelData.uvGlow);
    #elif GLOW11_GLOW_ILLUMTEX
        o.color = tex2D(_Illum, pixelData.uvIllum);
    #elif GLOW11_GLOW_GLOWCOLOR
        o.color = _GlowColor;
    #elif GLOW11_GLOW_VERTEXCOLOR
        o.color = pixelData.color;
    #else 
        o.color = float4(1,0,1,1);
    #endif
    
    #if ALPHA && GLOW11_GLOW_MAINTEX
        fixed alpha = o.color.a;
    #elif ALPHA
        fixed alpha = tex2D(_MainTex, pixelData.uv).a;
    #endif
    
    o.color *= _GlowStrength;

    #if GLOW11_MULTIPLY_GLOWCOLOR
        o.color *= _GlowColor;
    #elif GLOW11_MULTIPLY_VERT
        o.color *= pixelData.color;
    #elif GLOW11_MULTIPLY_VERT_ALPHA
        o.color *= pixelData.color.a;
    #elif GLOW11_MULTIPLY_ILLUMTEX_ALPHA
        #if GLOW11_GLOW_ILLUMTEX
            o.color *= o.color.a;
        #else
            o.color *= UNITY_SAMPLE_1CHANNEL(_Illum, pixelData.uvIllum);
        #endif
    #elif GLOW11_MULTIPLY_MAINTEX_ALPHA
        #if GLOW11_GLOW_MAINTEX
            o.color *= o.color.a;
        #elif ALPHA
            o.color *= alpha;            
        #else
            o.color *= UNITY_SAMPLE_1CHANNEL(_MainTex, pixelData.uv);
        #endif
    #endif
    
    #if ALPHA
        o.color.a = alpha;
    #endif

    return o;
}
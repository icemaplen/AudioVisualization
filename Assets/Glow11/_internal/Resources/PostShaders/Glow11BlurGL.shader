// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// ----------------------------------------------------------------------------
// Glow 11
// Copyright ﾂｩ 2013 Sven Herrmann
// ----------------------------------------------------------------------------
Shader "Hidden/Glow 11/Blur GL" {
    Properties {
        _MainTex ("", 2D) = "" {}
    }
   
    CGINCLUDE
   
    #include "UnityCG.cginc"
     
    struct v2f {
        half4 pos : POSITION;
        half4 uv[5] : TEXCOORD0;
    };
   
    sampler2D _MainTex;
    
    struct appdata_glow {
        half4 vertex : POSITION;
        half4 texcoord[5] : TEXCOORD;
    };
   
    v2f vert( appdata_glow v )
    {
        v2f o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv[0] = v.texcoord[0];
        o.uv[1] = v.texcoord[1];
        o.uv[2] = v.texcoord[2];
        o.uv[3] = v.texcoord[3];
        o.uv[4] = v.texcoord[4];
        return o;
    }
   
    fixed4 frag(v2f pixelData) : COLOR
    {
        return tex2D(_MainTex, pixelData.uv[0]) * .2270270270 +
            (tex2D(_MainTex, pixelData.uv[1]) + tex2D(_MainTex, pixelData.uv[2])) * .3162162162 +
            (tex2D(_MainTex, pixelData.uv[3]) + tex2D(_MainTex, pixelData.uv[4])) * .0702702703;
    }
   
    ENDCG
   
    Subshader {
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
        
          CGPROGRAM
          #pragma glsl
          #pragma only_renderers gles opengl
          #pragma fragmentoption ARB_precision_hint_fastest
          #pragma vertex vert
          #pragma fragment frag
          ENDCG
        }
    }
     
    Fallback off
   
}

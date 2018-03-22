// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// ----------------------------------------------------------------------------
// Glow 11
// Copyright ﾂｩ 2013 Sven Herrmann
// ----------------------------------------------------------------------------
Shader "Hidden/Glow 11/Blur" {
    Properties {
        _MainTex ("", 2D) = "" {}
    }
   
    CGINCLUDE
   
    #include "UnityCG.cginc"
     
    struct v2f {
        half4 pos : POSITION;
        half2 uv[5] : TEXCOORD;
    };
   
    sampler2D _MainTex;
    
    struct appdata_glow {
        half4 vertex : POSITION;
        half2 texcoord : TEXCOORD;
    };

    uniform half _offset1;
    uniform half _offset2;

    half4 _MainTex_TexelSize;

    v2f vertX( appdata_glow v )
    {
        v2f o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv[0] = v.texcoord;
        o.uv[1] = v.texcoord;
        o.uv[2] = v.texcoord;
        o.uv[3] = v.texcoord;
        o.uv[4] = v.texcoord;

        o.uv[1].x -= _offset1 * _MainTex_TexelSize.x;
        o.uv[2].x += _offset1 * _MainTex_TexelSize.x;
        o.uv[3].x -= _offset2 * _MainTex_TexelSize.x;
        o.uv[4].x += _offset2 * _MainTex_TexelSize.x;
        return o;
    }


    v2f vertY( appdata_glow v )
    {
        v2f o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv[0] = v.texcoord;
        o.uv[1] = v.texcoord;
        o.uv[2] = v.texcoord;
        o.uv[3] = v.texcoord;
        o.uv[4] = v.texcoord;

        o.uv[1].y -= _offset1 * _MainTex_TexelSize.y;
        o.uv[2].y += _offset1 * _MainTex_TexelSize.y;
        o.uv[3].y -= _offset2 * _MainTex_TexelSize.y;
        o.uv[4].y += _offset2 * _MainTex_TexelSize.y;
        return o;
    }


    fixed4 frag(v2f pixelData) : COLOR
    {
        return tex2D(_MainTex, pixelData.uv[0]) * .2270270270 +
            (tex2D(_MainTex, pixelData.uv[1]) + tex2D(_MainTex, pixelData.uv[2])) * .3162162162 +
            (tex2D(_MainTex, pixelData.uv[3]) + tex2D(_MainTex, pixelData.uv[4])) * .0702702703;
    }

    uniform fixed4 _varStrength;
    fixed4 fragVar(v2f pixelData) : COLOR
    {
        return tex2D(_MainTex, pixelData.uv[0]) * _varStrength.x +
            (tex2D(_MainTex, pixelData.uv[1]) + tex2D(_MainTex, pixelData.uv[2])) * _varStrength.y +
            (tex2D(_MainTex, pixelData.uv[3]) + tex2D(_MainTex, pixelData.uv[4])) * _varStrength.z;
    }
   
    ENDCG
   
    Subshader {
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
        
          CGPROGRAM
          #pragma fragmentoption ARB_precision_hint_fastest
          #pragma vertex vertX
          #pragma fragment frag
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #pragma fragmentoption ARB_precision_hint_fastest
          #pragma vertex vertY
          #pragma fragment frag
          ENDCG
        }

        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB
        
          CGPROGRAM
          #pragma fragmentoption ARB_precision_hint_fastest
          #pragma vertex vertX
          #pragma fragment fragVar
          ENDCG
        }
        Pass {
          ZTest Always Cull Off ZWrite Off
          Fog { Mode off }
          ColorMask RGB

          CGPROGRAM
          #pragma fragmentoption ARB_precision_hint_fastest
          #pragma vertex vertY
          #pragma fragment fragVar
          ENDCG
        }
    }
     
    Fallback off
   
}

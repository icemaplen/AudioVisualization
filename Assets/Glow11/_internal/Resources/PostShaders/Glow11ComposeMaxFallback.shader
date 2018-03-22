// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// ----------------------------------------------------------------------------
// Glow 11
// Copyright © 2013 Sven Herrmann
// ----------------------------------------------------------------------------
Shader "Hidden/Glow 11/Compose Max Fallback" {
Properties {
    _MainTex ("", 2D) = "white" {}
    _DestTex ("", 2D) = "white" {}
    _Strength ("Strength", Float) = 1.0
}
       
        CGINCLUDE
       
        #include "UnityCG.cginc"
        struct v2f {
            half4 pos : POSITION;
            half2 uv : TEXCOORD0;
        };

        sampler2D _DestTex;
        sampler2D _MainTex;
        uniform fixed _Strength;
       
        v2f vert( appdata_img v )
        {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = v.texcoord.xy;
            return o;
        }
       
        fixed4 frag(v2f pixelData) : COLOR
        {
            return max(tex2D(_DestTex, pixelData.uv), tex2D(_MainTex, pixelData.uv) * _Strength);
        }
       
       
        ENDCG
       
    Subshader {
        
		Pass {
			ColorMask RGB
			ZTest Always Cull Off ZWrite Off Fog { Mode Off }
			
			CGPROGRAM
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}

    }
    
	Fallback off
    
       
}
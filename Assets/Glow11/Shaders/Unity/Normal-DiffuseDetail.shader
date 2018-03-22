Shader "Glow 11/Unity/Diffuse Detail" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_Detail ("Detail (RGB)", 2D) = "gray" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    _GlowStrength ("Glow Strength", Float) = 1.0
}

SubShader {
	Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
	LOD 250
	
CGPROGRAM
#pragma surface surf Lambert

sampler2D _MainTex;
sampler2D _Detail;
fixed4 _Color;

struct Input {
	float2 uv_MainTex;
	float2 uv_Detail;
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
	c.rgb *= tex2D(_Detail,IN.uv_Detail).rgb*2;
	o.Albedo = c.rgb;
	o.Alpha = c.a;
}
ENDCG
}

FallBack "Glow 11/Unity/Diffuse"
CustomEditor "GlowMatInspector"
}

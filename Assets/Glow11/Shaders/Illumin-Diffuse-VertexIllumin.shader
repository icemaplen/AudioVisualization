Shader "Glow 11/Self-Illumin/Diffuse - Vertex Color Illumin" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_EmissionLM ("Emission (Lightmapper)", Float) = 0
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    _GlowStrength ("Glow Strength", Float) = 1.0
}
SubShader {
	Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
	LOD 200
	
CGPROGRAM
#pragma surface surf Lambert

sampler2D _MainTex;
fixed4 _Color;

struct Input {
	float2 uv_MainTex;
	fixed3 color : COLOR;
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
	fixed4 c = tex * _Color;
	o.Albedo = c.rgb;
	o.Emission = IN.color * fixed3(1,1,1);
	o.Alpha = c.a;	
}
ENDCG
} 
FallBack "Glow 11/Unity/Self-Illumin/VertexLit"
CustomEditor "GlowMatInspector"
}
Shader "EasyWaterFastest" {
Properties {
	_MainTex ("MainTex", 2D) = "white" {}	
	_Opacity("_Opacity", Range(-0.1,1.0) ) = 0
}
SubShader {
	Tags { 
	"Queue"="Transparent"
	"RenderType"="Overlay" }
	LOD 150

Blend SrcAlpha OneMinusSrcAlpha

CGPROGRAM
#pragma surface surf Lambert noforwardadd



sampler2D _MainTex;
float _Opacity;

struct Input {
	float2 uv_MainTex;	
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = c.rgb;
	o.Alpha = _Opacity;
}
ENDCG
}

Fallback "Mobile/VertexLit"
}

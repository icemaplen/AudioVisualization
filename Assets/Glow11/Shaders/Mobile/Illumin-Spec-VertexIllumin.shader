// Specular shader which uses the Vertex Color as Illumination
Shader "Glow 11/Mobile/Self-Illumin/Specular (1 Directional Light) Illum Vertex Color" {
Properties {
	_Shininess ("Shininess", Range (0.03, 1)) = 0.078125
	_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)	
    _GlowStrength ("Glow Strength", Float) = 1.0	
}
SubShader { 
	Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
	LOD 250
	
CGPROGRAM
#pragma surface surf MobileBlinnPhong exclude_path:prepass nolightmap noforwardadd halfasview novertexlights

inline fixed4 LightingMobileBlinnPhong (SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
{
	fixed3 normal = normalize(s.Normal);
	fixed diff = max (0, dot (normal, lightDir));
	fixed nh = max (0, dot (normal, halfDir));
	fixed spec = pow (nh, s.Specular*128) * s.Gloss;
	
	fixed4 c;
	c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * (atten*2);
	c.a = 0.0;
	return c;
}

sampler2D _MainTex;
half _Shininess;

struct Input {
	float2 uv_MainTex;
	fixed4 color : COLOR;
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = tex.rgb;
	o.Gloss = tex.a;
	o.Alpha = tex.a;
	o.Specular = _Shininess;
	o.Emission = IN.color;
}
ENDCG
}

FallBack "Glow 11/Unity/Self-Illumin/Diffuse"
CustomEditor "GlowMatInspector" 
}

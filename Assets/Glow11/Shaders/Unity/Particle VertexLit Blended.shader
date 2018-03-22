Shader "Glow 11/Unity/Particles/VertexLit Blended" {
Properties {
	_EmisColor ("Emissive Color", Color) = (.2,.2,.2,0)
	_MainTex ("Particle Texture", 2D) = "white" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    _GlowStrength ("Glow Strength", Float) = 1.0
}

SubShader {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderEffect"="Glow11Transparent" "RenderType"="Glow11Transparent"  }
	Tags { "LightMode" = "Vertex" }
	Cull Off
	Lighting On
	Material { Emission [_EmisColor] }
	ColorMaterial AmbientAndDiffuse
	ZWrite Off
	ColorMask RGB
	Blend SrcAlpha OneMinusSrcAlpha
	AlphaTest Greater .001
	Pass { 
		SetTexture [_MainTex] { combine primary * texture }
	}
}
CustomEditor "GlowMatInspector"
}
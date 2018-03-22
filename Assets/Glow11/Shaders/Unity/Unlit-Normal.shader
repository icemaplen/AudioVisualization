// Unlit shader. Simplest possible textured shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Glow 11/Unity/Unlit/Texture" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)  
    _GlowStrength ("Glow Strength", Float) = 1.0
}

SubShader {
	Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
	LOD 100
	
	Pass {
		Lighting Off
		SetTexture [_MainTex] { combine texture } 
	}
}
CustomEditor "GlowMatInspector"
}

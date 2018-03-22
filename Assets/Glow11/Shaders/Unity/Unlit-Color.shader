// Unlit shader. Simplest possible textured shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Glow 11/Unity/Unlit/Color" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    _GlowStrength ("Glow Strength", Float) = 1.0
}

SubShader {
	Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
	LOD 100

	Lighting Off
    Color [_Color]
    Pass {}
}
CustomEditor "GlowMatInspector"
}

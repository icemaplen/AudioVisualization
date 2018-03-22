// Does not do anything in 3.x
Shader "Glow 11/Unity/Legacy Shaders/Diffuse Fast" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB)", 2D) = "white" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    _GlowStrength ("Glow Strength", Float) = 1.0
}
FallBack "Glow 11/Unity/VertexLit"
CustomEditor "GlowMatInspector"
}
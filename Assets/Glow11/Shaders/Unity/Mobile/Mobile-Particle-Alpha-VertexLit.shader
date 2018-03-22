// Simplified VertexLit Blended Particle shader. Differences from regular VertexLit Blended Particle one:
// - no AlphaTest
// - no ColorMask

Shader "Glow 11/Unity/Mobile/Particles/VertexLit Blended" {
Properties {
	_EmisColor ("Emissive Color", Color) = (.2,.2,.2,0)
	_MainTex ("Particle Texture", 2D) = "white" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)	
    _GlowStrength ("Glow Strength", Float) = 1.0
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderEffect"="Glow11" "RenderType"="Glow11" }
	Blend SrcAlpha OneMinusSrcAlpha
	Cull Off ZWrite Off Fog { Color (0,0,0,0) }
	
	Lighting On
	Material { Emission [_EmisColor] }
	ColorMaterial AmbientAndDiffuse

	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture * primary
			}
		}
	}
}
CustomEditor "GlowMatInspector"  
}
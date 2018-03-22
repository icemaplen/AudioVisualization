Shader "Glow 11/Unity/Reflective/Bumped VertexLit" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Spec Color", Color) = (1,1,1,1)
	_Shininess ("Shininess", Range (0.1, 1)) = 0.7
	_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
	_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {}
	_Cube ("Reflection Cubemap", Cube) = "" { TexGen CubeReflect }
	_BumpMap ("Normalmap", 2D) = "bump" {}
    _GlowTex ("Glow", 2D) = "" {}
    _GlowColor ("Glow Color", Color)  = (1,1,1,1)
    _GlowStrength ("Glow Strength", Float) = 1.0
}

Category {
	Tags { "RenderEffect"="Glow11" "RenderType"="Glow11" }
	LOD 250
	SubShader {
		UsePass "Reflective/Bumped Unlit/BASE"
		Pass {
			Tags { "LightMode" = "Vertex" }
			Blend One One ZWrite Off Fog { Color (0,0,0,0) }
			Material {
				Diffuse [_Color]
				Ambient [_Color]
				Shininess [_Shininess]
				Specular [_SpecColor]
				Emission [_Emission]
			}
			Lighting On
			SeparateSpecular On
			SetTexture [_MainTex] {
				constantColor [_Color]
				Combine texture * primary DOUBLE, texture * primary
			}
		}
	}
}

FallBack "Glow 11/Unity/Reflective/VertexLit"
CustomEditor "GlowMatInspector"
}

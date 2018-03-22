// 2 Textures
// Opacity

Shader "EasyWater0_2TO"
{
Properties {
	_Texture1("_Texture1", 2D) = "black" {}
	_Texture2("_Texture2", 2D) = "black" {}
	_MainTexSpeed("_MainTexSpeed", Float) = 0
	_Texture2Speed("_Texture2Speed", Float) = 0
	_Opacity("_Opacity", Range(-0.1,1.0) ) = 0
}
SubShader {
	Tags { 
		"Queue"="Transparent"
		"IgnoreProjector"="True"
		"RenderType"="Transparent"		
		 }
	LOD 150
	
		Cull Back
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		Blend SrcAlpha OneMinusSrcAlpha
	
CGPROGRAM
#pragma surface surf Lambert noforwardadd
#pragma target 2.0

uniform sampler2D _Texture1;
		uniform sampler2D _Texture2;
		half _MainTexSpeed;
		half _Texture2Speed;
		float _Opacity;


struct Input {
	float2 uv_Texture1;
			float2 uv_Texture2;
};

void surf (Input IN, inout SurfaceOutput o) {
	o.Normal = float3(0.0,0.0,1.0);
				
					 
			
			// Animate MainTex
			float MainTexPos=_Time * _MainTexSpeed;
			float2 MainTexUV=(IN.uv_Texture1.xy) + MainTexPos; 			
			
			float4 Tex1=tex2D(_Texture1,MainTexUV);
			
			// Animate Texture2
			float Texture2Pos=_Time * _Texture2Speed;			
			float2 Tex2UV=(IN.uv_Texture2.xy) + Texture2Pos;		
			
			float4 Tex2=tex2D(_Texture2,Tex2UV);
			// Merge MainTex and Texture2
			float4 TextureMix=Tex1 * Tex2;			
			
			o.Albedo = TextureMix;
			o.Alpha = _Opacity;
}
ENDCG
}

Fallback "Diffuse"
}

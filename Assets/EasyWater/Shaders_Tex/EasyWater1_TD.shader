// 1 Texture
// 1 DistortionMap

Shader "EasyWater1"
{
Properties {
	_Texture1("_Texture1", 2D) = "black" {}
	_MainTexSpeed("_MainTexSpeed", Float) = 0
	_DistortionMap("_DistortionMap", 2D) = "black" {}
	_DistortionSpeed("_DistortionSpeed", Float) = 0
	_DistortionPower("_DistortionPower", Range(0,0.04) ) = 0
	
}
SubShader {
	Tags { 
		"IgnoreProjector"="False"		
		 }
	LOD 150
	
	
CGPROGRAM
#pragma surface surf Lambert noforwardadd
#pragma target 2.0


		uniform sampler2D _Texture1;
		half _MainTexSpeed;
		uniform sampler2D _DistortionMap;
		half _DistortionSpeed;
		half _DistortionPower;


struct Input {
	float2 uv_DistortionMap;
			float2 uv_Texture1;
};

void surf (Input IN, inout SurfaceOutput o) {
	// Animate distortionMap 
			float DistortSpeed=_DistortionSpeed * _Time;
			float2 DistortUV=(IN.uv_DistortionMap.xy) + DistortSpeed;
			// Create Texture for DistorionMap
			float4 DistortTex = tex2D(_DistortionMap,DistortUV);
			// Multiply Tex2DNormal effect by DistortionPower
			
			float FinalDistortion = DistortTex.b * _DistortionPower;			
					
			// Animate MainTex
			float Multiply2=_Time * _MainTexSpeed;
			float2 Texture1UV =(IN.uv_Texture1.xy) + Multiply2; 
			
			// Apply Distorion in MainTex
			float4 FinalDiffuse=tex2D(_Texture1,Texture1UV + FinalDistortion);			
		
					
			
			o.Albedo = FinalDiffuse;
}
ENDCG
}

Fallback "Diffuse"
}

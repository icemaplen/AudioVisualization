Shader "EasyWater3_2TD"
{
Properties {	
	_Texture1("_Texture1", 2D) = "black" {}
	_Texture2("_Texture2", 2D) = "black" {}
	_MainTexSpeed("_MainTexSpeed", Float) = 0
	_Texture2Speed("_Texture2Speed", Float) = 0
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
		uniform sampler2D _Texture2;
		half _MainTexSpeed;
		half _Texture2Speed;
		uniform sampler2D _DistortionMap;
		half _DistortionSpeed;
		half _DistortionPower;
		
		


struct Input {
		
			float2 uv_DistortionMap;
			float2 uv_Texture1;
			float2 uv_Texture2;
};

void surf (Input IN, inout SurfaceOutput o) {
	// Animate distortionMap 
			float DistortSpeed=_DistortionSpeed * _Time;
			float2 DistortUV=(IN.uv_DistortionMap.xy) + DistortSpeed;
			// Create Normal for DistorionMap
			float4 DistortNormal = tex2D(_DistortionMap,DistortUV);
			// Multiply Tex2DNormal effect by DistortionPower
			float2 FinalDistortion = DistortNormal.xy * _DistortionPower;
			
					
			// Animate MainTex
			float Multiply2=_Time * _MainTexSpeed;
			float2 MainTexUV=(IN.uv_Texture1.xy) + Multiply2; 
			
			// Apply Distorion in MainTex
			float4 Tex2D0=tex2D(_Texture1,MainTexUV + FinalDistortion);
			
			// Animate Texture2
			float Multiply3=_Time * _Texture2Speed;
			float2 Tex2UV=(IN.uv_Texture2.xy) + Multiply3;
			
			// Apply Distortion in Texture2
			// float2 Add1=Tex2UV + FinalDistortion;
			float4 Tex2D1=tex2D(_Texture2,Tex2UV + FinalDistortion); 
			
			// Merge MainTex and Texture2
			float4 FinalDiffuse=Tex2D0 * Tex2D1;
			
							
			
			o.Albedo = FinalDiffuse;			
			
			
}
ENDCG
}

Fallback "Diffuse"
}

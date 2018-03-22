Shader "EasyWater6_CTDR"
{
Properties {
	_Color("_Color", Color) = (1,1,1,1)
	_Texture1("_Texture1", 2D) = "black" {}
	_MainTexSpeed("_MainTexSpeed", Float) = 0
	_DistortionMap("_DistortionMap", 2D) = "black" {}
	_DistortionSpeed("_DistortionSpeed", Float) = 0
	_DistortionPower("_DistortionPower", Range(0,0.04) ) = 0
	
	_Reflection("_Reflection", 2D) = "black" {}
	_ReflectPower("_ReflectPower", Range(0,0.6) ) = 0
}
SubShader {
	Tags { 
		"IgnoreProjector"="False"		
		 }
	LOD 150
	
	
CGPROGRAM
#pragma surface surf Lambert noforwardadd
#pragma target 2.0


		fixed4 _Color;
		uniform sampler2D _Texture1;
		half _MainTexSpeed;
		uniform sampler2D _DistortionMap;
		half _DistortionSpeed;
		half _DistortionPower;		
		uniform sampler2D _Reflection;
		float _ReflectPower;
		
		


struct Input {
		
			float3 viewDir;
			float2 uv_DistortionMap;
			float2 uv_Texture1;
};

void surf (Input IN, inout SurfaceOutput o) {
o.Normal = float3(0.0,0.0,1.0);
			
			
			
			float4 ViewDirection=float4( IN.viewDir.x, IN.viewDir.y,IN.viewDir.z *10,0 );
			float4 Normalize0=normalize(ViewDirection);			
			
			float2 ReflexUV= float2((Normalize0.x + 1) * 0.5, (Normalize0.y + 1) * 0.5);
			
			// Animate distortionMap 
			float DistortSpeed=_DistortionSpeed * _Time;
			float2 DistortUV=(IN.uv_DistortionMap.xy) + DistortSpeed;
			// Create Normal for DistorionMap
			float4 DistortNormal =  tex2D(_DistortionMap,DistortUV);
			// Multiply Tex2DNormal effect by DistortionPower
			float2 FinalDistortion = DistortNormal.xy * _DistortionPower;
			
			// Apply DistorionMap in Reflection's UV
			float4 Tex2D2=tex2D(_Reflection,ReflexUV + FinalDistortion);				
			float4 FinalReflex = Tex2D2 * _ReflectPower;
			
			// Animate MainTex
			float Multiply2=_Time * _MainTexSpeed;
			float2 MainTexUV=(IN.uv_Texture1.xy) + Multiply2; 
			
			// Apply Distorion in MainTex
			float4 Tex2D0=tex2D(_Texture1,MainTexUV + FinalDistortion);
			
			// Add Texture with Reflection
			float4 TexNReflex = FinalReflex + Tex2D0;
			TexNReflex.xy = TexNReflex.xy + FinalDistortion.xy;  
			
			// Merge Textures, Reflection and Color
			float4 FinalDiffuse=_Color * TexNReflex;				
			
			
			o.Albedo = FinalDiffuse;
			o.Normal = normalize(o.Normal);
			

}
ENDCG
}

Fallback "Diffuse"
}

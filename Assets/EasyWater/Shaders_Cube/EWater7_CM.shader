Shader "EasyWater7_CUBEMAP"
{
	Properties 
	{
_Color("_Color", Color) = (1,1,1,1)
_Texture1("_Texture1", 2D) = "black" {}
_BumpMap1("_BumpMap1", 2D) = "black" {}
_Texture2("_Texture2", 2D) = "black" {}
_BumpMap2("_BumpMap2", 2D) = "black" {}
_MainTexSpeed("_MainTexSpeed", Float) = 0
_Bump1Speed("_Bump1Speed", Float) = 0
_Texture2Speed("_Texture2Speed", Float) = 0
_Bump2Speed("_Bump2Speed", Float) = 0
_DistortionMap("_DistortionMap", 2D) = "black" {}
_DistortionSpeed("_DistortionSpeed", Float) = 0
_DistortionPower("_DistortionPower", Range(0,0.02) ) = 0
_Specular("_Specular", Range(0,7) ) = 1
_Gloss("_Gloss", Range(0.3,2) ) = 0.3
_Opacity("_Opacity", Range(-0.1,1.0) ) = 0
_Reflection("_Reflection", Cube) = "black" {}
_ReflectPower("_ReflectPower", Range(0,1) ) = 0

	}
	
	SubShader 
	{
		Tags
		{
		"Queue"="Transparent"
		"IgnoreProjector"="False"
		"RenderType"="Overlay"

		}

		
		Cull Back
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		Blend SrcAlpha OneMinusSrcAlpha
		Fog{
		}
		
		
				CGPROGRAM
		#pragma surface surf BlinnPhongEditor
		#pragma target 3.0
		
		
		fixed4 _Color;
		uniform sampler2D _Texture1;
		uniform sampler2D _BumpMap1;
		uniform sampler2D _Texture2;
		uniform sampler2D _BumpMap2;
		half _MainTexSpeed;
		half _Bump1Speed;
		half _Texture2Speed;
		half _Bump2Speed;
		uniform sampler2D _DistortionMap;
		half _DistortionSpeed;
		half _DistortionPower;
		fixed _Specular;
		fixed _Gloss;
		float _Opacity;
		uniform samplerCUBE _Reflection;
		float _ReflectPower;

		struct EditorSurfaceOutput {
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half3 Gloss;
			half Specular;
			half Alpha;
			half4 Custom;
		};
			
		inline half4 LightingBlinnPhongEditor_PrePass (EditorSurfaceOutput s, half4 light)
		{
			half3 spec = light.a * s.Gloss;
			half4 c;
			c.rgb = (s.Albedo * light.rgb + light.rgb * spec);
			c.a = s.Alpha;
			return c;
		}

		inline half4 LightingBlinnPhongEditor (EditorSurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 h = normalize (lightDir + viewDir);
			
			half diff = max (0, dot ( lightDir, s.Normal ));
			
			float nh = max (0, dot (s.Normal, h));
			float spec = pow (nh, s.Specular*128.0);
			
			half4 res;
			res.rgb = _LightColor0.rgb * diff;
			res.w = spec * Luminance (_LightColor0.rgb);
			res *= atten * 2.0;

			return LightingBlinnPhongEditor_PrePass( s, res );
		}
		
		struct Input {
			float3 viewDir;
			float2 uv_DistortionMap;
			float2 uv_Texture1;
			float2 uv_Texture2;
			float2 uv_BumpMap1;
			float2 uv_BumpMap2;
		};

		void surf (Input IN, inout EditorSurfaceOutput o) {
			o.Normal = float3(0.0,0.0,1.0);
			o.Alpha = 1.0;
			o.Albedo = 0.0;
			o.Emission = 0.0;
			o.Gloss = 0.0;
			o.Specular = 0.0;
			o.Custom = 0.0;
			
			float4 ViewDirection=float4( IN.viewDir.x, IN.viewDir.y,IN.viewDir.z,0 ); 	
					
			
			
			// Animate distortionMap 
			float DistortSpeed=_DistortionSpeed * _Time;
			float2 DistortUV=(IN.uv_DistortionMap.xy) + DistortSpeed;
			// Create Normal for DistorionMap
			float4 DistortNormal = float4(UnpackNormal( tex2D(_DistortionMap,DistortUV)).xyz, 1.0 );
			// Multiply Tex2DNormal effect by DistortionPower
			float4 FinalDistortion = DistortNormal * _DistortionPower;
			
			
			
			
			
			
			// Animate MainTex
			float MainTexPos=_Time * _MainTexSpeed;
			float2 MainTexUV=(IN.uv_Texture1.xy) + MainTexPos; 
			
			// Apply Distorion in MainTex
			float4 DistortedMainTex=tex2D(_Texture1,MainTexUV + FinalDistortion);
			
			// Animate Texture2
			float Texture2Pos=_Time * _Texture2Speed;
			float2 Tex2UV=(IN.uv_Texture2.xy) + Texture2Pos;
			
			// Apply Distorion in Texture2
			float4 DistortedTexture2=tex2D(_Texture2,Tex2UV + FinalDistortion); 
			
			// Merge MainTex and Texture2
			float4 TextureMix=DistortedMainTex * DistortedTexture2;
			
			// Add TextureMix with Distortion					
			TextureMix.xy =  TextureMix.xy   + FinalDistortion.xy; 
			
			
			
			// Merge Textures, Texture and Color
			float4 FinalDiffuse = _Color * TextureMix; 			
			
			
			// Animate BumpMap1
			float BumpMap1Pos=_Time * _Bump1Speed;
			float2 Bump1UV=(IN.uv_BumpMap1.xy) + BumpMap1Pos;
			
			// Apply Distortion to BumpMap
			half4 DistortedBumpMap1=tex2D(_BumpMap1,Bump1UV + FinalDistortion);
			
			// Animate BumpMap2
			half BumpMap2Pos=_Time * _Bump2Speed;
			half2 Bump2UV=(IN.uv_BumpMap2.xy) + BumpMap2Pos;
			
			// Apply Distortion to BumpMap2			
			fixed4 DistortedBumpMap2=tex2D(_BumpMap2,Bump2UV + FinalDistortion);
			
			// Get Average from BumpMap1 and BumpMap2
			fixed4 AvgBump= (DistortedBumpMap1 + DistortedBumpMap2) / 2;
			
			// Unpack Normals
			fixed4 UnpackNormal1=float4(UnpackNormal(AvgBump).xyz, 1.0);
			
			
			// Apply DistorionMap in Reflection's UV								
			float4 viewInvert=float4(float4( ViewDirection.x, ViewDirection.x, ViewDirection.x, ViewDirection.x).x, float4( ViewDirection.z, ViewDirection.z, ViewDirection.z, ViewDirection.z).y, float4( ViewDirection.y, ViewDirection.y, ViewDirection.y, ViewDirection.y).z, 0);
						
			float4 TexCUBE0=texCUBE(_Reflection,viewInvert * AvgBump); 
			
			// Get Fresnel from viewDirection angle
			float FresnelView=(1.0 - dot( normalize( float3( IN.viewDir.x, IN.viewDir.y,IN.viewDir.z ).xyz),  float3(0,0,1)  ));
			
			// Multiply reflection by fresnel so it's stronger when it's far
			 float ReflectPowerByAngle =_ReflectPower * FresnelView;
			float4 FinalReflex = TexCUBE0 * ReflectPowerByAngle;
			
			
			
			// Opacity
			fixed FinalAlpha = 1 + _Opacity;
			
			o.Albedo = FinalDiffuse;
			o.Normal = UnpackNormal1;
			o.Emission = FinalReflex;
			o.Specular = _Gloss;
			o.Gloss = _Specular;
			o.Alpha = FinalAlpha;

			o.Normal = normalize(o.Normal);
		}
	ENDCG
	}
	Fallback "Diffuse"
}
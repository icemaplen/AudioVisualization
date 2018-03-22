// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Glow 11/Downsample" {

    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Strength ("Strength", Float) = 0.25
    }
    
    CGINCLUDE
    #include "UnityCG.cginc"
    
    struct v2f {
        half4 pos : POSITION;
        half4 uv[4] : TEXCOORD0;
    };
    
    float4 _MainTex_TexelSize;
    
    v2f vert (appdata_img v)
    {
        v2f o;
        o.pos = UnityObjectToClipPos (v.vertex);
        float4 uv;
        uv.xy = MultiplyUV (UNITY_MATRIX_TEXTURE0, v.texcoord);
        uv.zw = 0;
        float offX = _MainTex_TexelSize.x;
        float offY = _MainTex_TexelSize.y;
        
        // Direct3D9 needs some texel offset!
        #ifdef UNITY_HALF_TEXEL_OFFSET
        uv.x += offX * 2.0f;
        uv.y += offY * 2.0f;
        #endif
        o.uv[0] = uv + float4(-offX,-offY,0,1);
        o.uv[1] = uv + float4( offX,-offY,0,1);
        o.uv[2] = uv + float4( offX, offY,0,1);
        o.uv[3] = uv + float4(-offX, offY,0,1);
        return o;
    }

    ENDCG
    
    
    Category {
        ZTest Always Cull Off ZWrite Off Fog { Mode Off }
        ColorMask RGB
        
        Subshader { 
            Pass {

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma fragmentoption ARB_precision_hint_fastest
                
                sampler2D _MainTex;
                uniform fixed _Strength;
                
                fixed4 frag( v2f i ) : COLOR
                {
                    fixed4 c;
                    c  = tex2D( _MainTex, i.uv[0].xy );
                    c += tex2D( _MainTex, i.uv[1].xy );
                    c += tex2D( _MainTex, i.uv[2].xy );
                    c += tex2D( _MainTex, i.uv[3].xy );
                    c *= _Strength;
                    return c;
                }
                ENDCG
    
            }
            Pass {

                CGPROGRAM
                #pragma vertex vertSimple
                #pragma fragment fragSimple
                #pragma fragmentoption ARB_precision_hint_fastest

                struct v2fSimple {
                    half4 pos : POSITION;
                    half2 uv : TEXCOORD0;
                };
            
                v2fSimple vertSimple( appdata_img v )
                {
                    v2fSimple o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uv = v.texcoord.xy;
                    return o;
                }

                sampler2D _MainTex;
                uniform fixed _Strength;

                fixed4 fragSimple( v2fSimple i ) : COLOR
                {
                    fixed4 c;
                    c  = tex2D( _MainTex, i.uv );
                    c *= _Strength;
                    return c;
                }
                ENDCG

            }
        }
    }
    
    Fallback off

}
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

    #include "UnityCG.cginc"

    struct v2f {
        half4 pos : POSITION;
        half2 texcoord : TEXCOORD;
    };
   
    sampler2D _MainTex;
    
    struct appdata_glow {
        half4 vertex : POSITION;
        half2 texcoord : TEXCOORD;
    };

    // thanks unity for not supporting arrays...
    uniform half4x4 _offsets;
    uniform half4x4 _weights;

    half4 _MainTex_TexelSize;

    v2f vert( appdata_glow v )
    {
        v2f o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.texcoord = v.texcoord.xy;
        return o;
    }
    
half2 tc;
half x;
half y;

half4 offsetX(half offset, half weight) {
    tc.x = x + offset * _MainTex_TexelSize.x;
    half4 tmp = tex2D(_MainTex, tc);
    tc.x = x - offset * _MainTex_TexelSize.x;
    half4 tmp2 = tex2D(_MainTex, tc);
    return (tmp+tmp2) * weight;
}

half4 offsetY(half offset, half weight) {
    tc.y = y + offset * _MainTex_TexelSize.y;
    half4 tmp = tex2D(_MainTex, tc);
    tc.y = y - offset * _MainTex_TexelSize.y;
    half4 tmp2 = tex2D(_MainTex, tc);
    return (tmp+tmp2) * weight;
}


half4 fragY(v2f pixelData) : COLOR
{
    y = pixelData.texcoord.y;
    #define OFFSETFUNC offsetY

    half4 col;
    tc = pixelData.texcoord;
    col = (tex2D(_MainTex, tc) * _weights[0][0]);

    #if RADIUS > 0
    col += OFFSETFUNC(_offsets[1][0],_weights[1][0]);
    #endif

    #if RADIUS > 1
    col += OFFSETFUNC(_offsets[2][0],_weights[2][0]);
    #endif

    #if RADIUS > 2
    col += OFFSETFUNC(_offsets[3][0],_weights[3][0]);
    #endif

    #if RADIUS > 3
    col += OFFSETFUNC(_offsets[0][1],_weights[0][1]);
    #endif

    #if RADIUS > 4
    col += OFFSETFUNC(_offsets[1][1],_weights[1][1]);
    #endif

    #if RADIUS > 5
    col += OFFSETFUNC(_offsets[2][1]+col.r,_weights[2][1]);
    #endif
    
    #if RADIUS > 6
    col += OFFSETFUNC(_offsets[3][1],_weights[3][1]);
    #endif

    #if RADIUS > 7
    col += OFFSETFUNC(_offsets[0][2],_weights[0][2]);
    #endif

    #if RADIUS > 8
    col += OFFSETFUNC(_offsets[1][2],_weights[1][2]);
    #endif

    #if RADIUS > 9
    col += OFFSETFUNC(_offsets[2][2],_weights[2][2]);
    #endif

    #if RADIUS > 10
    col += OFFSETFUNC(_offsets[3][2],_weights[3][2]);
    #endif

    #if RADIUS > 11
    col += OFFSETFUNC(_offsets[0][3],_weights[0][3]);
    #endif

    #if RADIUS > 12
    col += OFFSETFUNC(_offsets[1][3],_weights[1][3]);
    #endif

    #if RADIUS > 13
    col += OFFSETFUNC(_offsets[2][3],_weights[2][3]);
    #endif

    #if RADIUS > 14
    col += OFFSETFUNC(_offsets[3][3],_weights[3][3]);
    #endif
    

    return col;
}



half4 fragX(v2f pixelData) : COLOR
{
    x = pixelData.texcoord.x;
    #define OFFSETFUNC offsetX

    half4 col;
    tc = pixelData.texcoord;
    col = (tex2D(_MainTex, tc) * _weights[0][0]);

    #if RADIUS > 0
    col += OFFSETFUNC(_offsets[1][0],_weights[1][0]);
    #endif

    #if RADIUS > 1
    col += OFFSETFUNC(_offsets[2][0],_weights[2][0]);
    #endif

    #if RADIUS > 2
    col += OFFSETFUNC(_offsets[3][0],_weights[3][0]);
    #endif

    #if RADIUS > 3
    col += OFFSETFUNC(_offsets[0][1],_weights[0][1]);
    #endif

    #if RADIUS > 4
    col += OFFSETFUNC(_offsets[1][1],_weights[1][1]);
    #endif

    #if RADIUS > 5
    col += OFFSETFUNC(_offsets[2][1]+col.r,_weights[2][1]);
    #endif
    
    #if RADIUS > 6
    col += OFFSETFUNC(_offsets[3][1],_weights[3][1]);
    #endif

    #if RADIUS > 7
    col += OFFSETFUNC(_offsets[0][2],_weights[0][2]);
    #endif

    #if RADIUS > 8
    col += OFFSETFUNC(_offsets[1][2],_weights[1][2]);
    #endif

    #if RADIUS > 9
    col += OFFSETFUNC(_offsets[2][2],_weights[2][2]);
    #endif

    #if RADIUS > 10
    col += OFFSETFUNC(_offsets[3][2],_weights[3][2]);
    #endif

    #if RADIUS > 11
    col += OFFSETFUNC(_offsets[0][3],_weights[0][3]);
    #endif

    #if RADIUS > 12
    col += OFFSETFUNC(_offsets[1][3],_weights[1][3]);
    #endif

    #if RADIUS > 13
    col += OFFSETFUNC(_offsets[2][3],_weights[2][3]);
    #endif

    #if RADIUS > 14
    col += OFFSETFUNC(_offsets[3][3],_weights[3][3]);
    #endif
    

    return col;
}



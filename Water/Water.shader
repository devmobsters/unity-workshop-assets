Shader "Unlit/Water"
{
	Properties
	{
		_Color ("Main Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f {
                half3 worldNormal : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert (float4 vertex : POSITION, float3 normal : NORMAL)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                o.worldNormal = UnityObjectToWorldNormal(normal);
                return o;
            }

            fixed4 _Color;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 c = 0;

                c.r = _Color.r + round((i.worldNormal.x + i.worldNormal.z) * 50) / 25;
                c.g = _Color.g + round((i.worldNormal.x + i.worldNormal.z) * 50) / 25;
                c.b = _Color.b + round((i.worldNormal.x + i.worldNormal.z) * 50) / 25;

                return c;
            }
			ENDCG
		}
	}
    Fallback "VertexLit"
}

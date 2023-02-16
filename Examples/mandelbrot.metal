#include <metal_stdlib>
using namespace metal;

#define ITER_MAX 50
#define COMPLEX_MUL(z, w) float2(z.x * w.x - z.y * w.y, z.x * w.y + z.y * w.x)

void m_iter(thread float2* z, float2 c) {
	float2 w = *z;
	*z = COMPLEX_MUL(w, w) + c;
}

float c_abs(float2 z) {
	return sqrt(z.x * z.x + z.y * z.y);
}

float4 shader_main(float2 coords, unsigned int frame) {
	float2 z = coords;
	uint iter_ct = 0;
	while (c_abs(z) < 2 && iter_ct < ITER_MAX) {
		m_iter(&z, coords);
		iter_ct++;
	}

	float v = float(iter_ct) / ITER_MAX;
	return float4(float3(v), 1);
}

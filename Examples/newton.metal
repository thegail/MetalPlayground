#include <metal_stdlib>
using namespace metal;

#define MAX_ITER 100
#define COMPLEX_CONJ(z) float2(z.x, -z.y)
#define COMPLEX_MUL(z, w) float2(z.x * w.x - z.y * w.y, z.x * w.y + z.y * w.x)
#define COMPLEX_DIV(z, w) (COMPLEX_MUL(z, COMPLEX_CONJ(w))/float2(w.x * w.x + w.y * w.y))

float2 fnct(float2 z) {
	return COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(z, z), z), z), z), z), z), z) + float2(15) * COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(z, z), z), z) - float2(16, 0);
}

float2 derv(float2 z) {
	return float2(8) * COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(COMPLEX_MUL(z, z), z), z), z), z), z) + float2(60) * COMPLEX_MUL(COMPLEX_MUL(z, z), z);
}

#define ROOTWO sqrt(2.0)

float4 shader_main(float2 coords, unsigned int frame) {
	float2 z = coords;
	for (int iter = 0; iter < MAX_ITER; iter++) {
		z -= COMPLEX_DIV(fnct(z), derv(z));
	}
	return float4((z + float2(1)) / float2(sqrt(2.0)), 0, 1);
}

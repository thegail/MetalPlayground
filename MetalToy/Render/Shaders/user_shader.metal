//
//  user_shader.metal
//  UserShader
//
//  Created by Teddy Gaillard on 2/12/23.
//

#include <metal_stdlib>
#include "user_shader.h"
using namespace metal;

float4 shader_main(float2 coords) {
	return float4(coords + float2(0.5), 0, 1);
}

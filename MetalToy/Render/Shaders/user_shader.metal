//
//  user_shader.metal
//  UserShader
//
//  Created by Teddy Gaillard on 2/12/23.
//

#include <metal_stdlib>
#include "../../render_config.h"
#include "user_shader.h"
using namespace metal;

float4 shader_main(uint2 coords, uint2 size) {
	float2 value = float2(coords) / float2(size);
	return float4(value, 0, 1);
}

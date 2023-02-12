//
//  make_image.metal
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

#include <metal_stdlib>
#include "../../render_config.h"
#include "user_shader.h"
using namespace metal;

kernel void make_image(texture2d<float, access::write> image [[texture(0)]],
						 uint2 coords [[thread_position_in_grid]],
						 uint2 size [[threads_per_grid]],
						 constant render_config* config [[buffer(0)]]) {
	float2 f_coords = float2(coords) / float2(size);
	float2 centered = f_coords - float2(0.5);
	float2 normalized = centered * float2(2, -2);
	float2 scaled = normalized * float2(config->width);
	float2 positioned = scaled + float2(config->x, config->y);
	image.write(shader_main(positioned), coords);
}

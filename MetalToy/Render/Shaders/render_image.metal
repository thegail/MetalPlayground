//
//  render_image.metal
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

#include <metal_stdlib>
#include "../../render_config.h"
using namespace metal;

kernel void render_image(texture2d<float, access::write> image [[texture(0)]],
						 uint2 coords [[thread_position_in_grid]],
						 uint2 size [[threads_per_grid]],
						 constant render_config* config [[buffer(0)]]) {
	image.write(float4(1, 0, 0, 1), coords);
}
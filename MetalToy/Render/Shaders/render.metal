//
//  render.metal
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

#include <metal_stdlib>
using namespace metal;

struct RasterizerData {
	float4 pos [[position]];
	float2 uv;
};

constexpr constant float3 vertices[] = {
	float3(-1, -1, 0),
	float3(-1, 1, 0),
	float3(1, -1, 0),
	float3(1, 1, 0)
};

vertex RasterizerData render_vertex(uint vid [[vertex_id]]) {
	RasterizerData out;
	float3 in = vertices[vid];
	out.pos = float4(in, 1);
	out.uv.y = 0.5 - in.y * 0.5;
	out.uv.x = in.x * 0.5 + 0.5;
	return out;
}

fragment float4 render_fragment(RasterizerData in [[stage_in]], texture2d<float> image [[texture(0)]]) {
	constexpr sampler linearSampler(coord::normalized, filter::nearest);
	float4 color = image.sample(linearSampler, in.uv);
	return color;
}

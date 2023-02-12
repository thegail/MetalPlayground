//
//  RenderConfiguration.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import Foundation

struct RenderConfiguration {
	var shaderSource: String
	var shaderConfiguration: render_config
	
	static let defaultConfiguration: Self = Self(shaderSource: Self.defaultSource, shaderConfiguration: render_config(x: 0, y: 0, width: 1))
	
	private static let defaultSource = """
	#include <metal_stdlib>
	using namespace metal;
	
	float4 shader_main(float2 coords) {
		return float4(coords, 0, 1);
	}
	
	"""
}

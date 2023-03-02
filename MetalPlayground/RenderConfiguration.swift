//
//  RenderConfiguration.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/11/23.
//

import Foundation

struct RenderConfiguration {
	var shaderSource: String
	var initialCoordinates: SIMD2<Float> = SIMD2(0, 0)
	var x: Float
	var y: Float
	var width: Float
	
	var coordinates: SIMD2<Float> {
		get {
			SIMD2(self.x, self.y)
		}
		set(new) {
			self.initialCoordinates = new
			self.x = new.x
			self.y = new.y
		}
	}
	var gestureCoordinates: SIMD2<Float> {
		get {
			self.coordinates
		}
		set(new) {
			self.x = new.x
			self.y = new.y
		}
	}
	
	static let defaultConfiguration: Self = Self(shaderSource: Self.defaultSource, x: 0, y: 0, width: 1)
	
	private static let defaultSource = """
	#include <metal_stdlib>
	using namespace metal;
	
	float4 shader_main(float2 coords, unsigned int frame) {
		return float4(coords + float2(0.5), 0, 1);
	}
	
	"""
	
	mutating func zoomIn() {
		self.width /= 1.1
	}
	
	mutating func zoomOut() {
		self.width *= 1.1
	}
	
	mutating func goHome() {
		self.coordinates = SIMD2(0, 0)
		self.width = 1
	}
	
	mutating func endGesture() {
		self.initialCoordinates = self.coordinates
	}
}

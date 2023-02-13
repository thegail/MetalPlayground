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
	var initialCoordinates: SIMD2<Float> = SIMD2(0, 0)
	
	var coordinates: SIMD2<Float> {
		get {
			SIMD2(self.shaderConfiguration.x, self.shaderConfiguration.y)
		}
		set(new) {
			self.initialCoordinates = new
			self.shaderConfiguration.x = new.x
			self.shaderConfiguration.y = new.y
		}
	}
	var width: Float {
		get {
			self.shaderConfiguration.width
		}
		set(new) {
			self.shaderConfiguration.width = new
		}
	}
	var gestureCoordinates: SIMD2<Float> {
		get {
			self.coordinates
		}
		set(new) {
			self.shaderConfiguration.x = new.x
			self.shaderConfiguration.y = new.y
		}
	}
	
	static let defaultConfiguration: Self = Self(shaderSource: Self.defaultSource, shaderConfiguration: render_config(x: 0, y: 0, width: 1, frame: 0))
	
	private static let defaultSource = """
	#include <metal_stdlib>
	using namespace metal;
	
	float4 shader_main(float2 coords, unsigned int frame) {
		return float4(coords + float2(0.5), 0, 1);
	}
	
	"""
	
	mutating func zoomIn() {
		self.shaderConfiguration.width /= 1.1
	}
	
	mutating func zoomOut() {
		self.shaderConfiguration.width *= 1.1
	}
	
	mutating func goHome() {
		self.coordinates = SIMD2(0, 0)
		self.shaderConfiguration.width = 1
	}
	
	mutating func endGesture() {
		self.initialCoordinates = self.coordinates
	}
}

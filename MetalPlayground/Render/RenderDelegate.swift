//
//  RenderDelegate.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/12/23.
//

import MetalKit
import SwiftUI

class RenderDelegate: NSObject, MTKViewDelegate {
	var configuration: RenderConfiguration
	var renderer: Renderer
	
	init(configuration: RenderConfiguration) {
		self.configuration = configuration
		
		do {
			self.renderer = try Renderer(configuration: configuration)
		} catch let error {
			print(error)
			fatalError("Failed to initialize renderer")
		}
	}
	
	func draw(in view: MTKView) {
		do {
			try self.renderer.draw(in: view)
		} catch let error {
			print("Error: draw failed! \(error)")
		}
	}
	
	func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
		do {
			try self.renderer.updateSize(size: size)
		} catch let error {
			print(error)
			fatalError("Failed to update renderer")
		}
	}
	
	func updateConfiguration() {
		self.renderer.configuration = self.configuration
		do {
			try self.renderer.updateShader()
		} catch let error {
			print("Error: configuration update failed! \(error)")
		}
	}
}

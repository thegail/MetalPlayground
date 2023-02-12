//
//  RenderDelegate.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import MetalKit

class RenderDelegate: NSObject, MTKViewDelegate {
	var renderer: Renderer?
	
	init(configuration: RenderConfiguration) {
		do {
			self.renderer = try Renderer(configuration: configuration)
		} catch let error {
			print(error)
			fatalError("Failed to initialize renderer")
		}
	}
	
	func draw(in view: MTKView) {
		do {
			try self.renderer!.draw(in: view)
		} catch let error {
			print("Error: draw failed! \(error)")
		}
	}
	
	func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
		do {
			try self.renderer!.updateSize()
		} catch let error {
			print(error)
			fatalError("Failed to update renderer")
		}
	}
}

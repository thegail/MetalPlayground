//
//  RenderDelegate.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import MetalKit

class RenderDelegate: NSObject, MTKViewDelegate {
	var renderer: Renderer?
	
	override init() {
		self.renderer = nil
	}
	
	func draw(in view: MTKView) {
		do {
			try self.renderer!.draw(in: view)
		} catch let error {
			print("Error: draw failed! \(error)")
		}
	}
	
	func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
		if self.renderer == nil {
			do {
				self.renderer = try Renderer()
			} catch let error {
				print(error)
				fatalError("Could not initialize renderer")
			}
		} else {
			do {
				try self.renderer!.updateSize()
			} catch let error {
				print(error)
				fatalError("Could not update renderer")
			}
		}
	}
}

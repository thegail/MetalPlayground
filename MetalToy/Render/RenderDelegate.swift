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
		self.renderer!.draw(in: view)
	}
	
	func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
		if self.renderer == nil {
			self.renderer = Renderer()
		} else {
			self.renderer!.updateSize()
		}
	}
}

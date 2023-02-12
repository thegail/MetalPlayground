//
//  RenderView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import MetalKit
import SwiftUI

struct RenderView: NSViewRepresentable {
	var delegate: RenderDelegate
	
	init(configuration: State<RenderConfiguration>) {
		self.delegate = RenderDelegate(configuration: configuration)
	}
	
	func makeCoordinator() -> RenderDelegate {
		return self.delegate
	}
	
	func makeNSView(context: Context) -> some NSView {
		let metalView = MTKView()
		metalView.delegate = context.coordinator
		guard let device = MTLCreateSystemDefaultDevice() else {
			fatalError("Device doesn't support metal")
		}
		metalView.device = device
		metalView.framebufferOnly = true
		metalView.clearColor = MTLClearColor(red: 0, green: 1, blue: 0, alpha: 1)
		metalView.drawableSize = metalView.frame.size
		
		return metalView
	}
	
	func updateNSView(_ nsView: NSViewType, context: Context) {
		self.delegate.updateConfiguration()
	}
}

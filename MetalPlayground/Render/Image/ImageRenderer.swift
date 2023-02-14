//
//  ImageRenderer.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/13/23.
//

import Metal

class ImageRenderer: Renderer {
	let width: Int
	let height: Int
	
	init(configuration: RenderConfiguration, width: Int, height: Int) throws {
		self.width = width
		self.height = height
		try super.init(configuration: configuration)
		self.outputSize = MTLSize(width: self.width, height: self.height, depth: 1)
		self.outputImage = try MetalUtil.makeExportableImage(size: self.outputSize, device: self.device)
	}
	
	func render() throws -> Data {
		guard let commandBuffer = self.commandQueue.makeCommandBuffer() else {
			throw Error.commandBuffer
		}
		
		try self.encodeCompute(commandBuffer: commandBuffer)
		commandBuffer.commit()
		
		let data = try self.outputImage.toImage()
		return data
	}
}

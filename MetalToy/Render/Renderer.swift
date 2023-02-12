//
//  Renderer.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import MetalKit

class Renderer {
	let device: MTLDevice
	var outputSize: MTLSize
	var outputImage: MTLTexture
	let computePipeline: MTLComputePipelineState
	let renderPipeline: MTLRenderPipelineState
	let indexBuffer: MTLBuffer
	let commandQueue: MTLCommandQueue
	var configuration: RenderConfiguration
	
	init(configuration: RenderConfiguration) throws {
		self.device = try MetalUtil.getDevice()
		self.outputSize = MTLSize(width: 0, height: 0, depth: 0)
		self.outputImage = try MetalUtil.makeOutputImage(size: self.outputSize, device: self.device)
		let (compute, vertex, fragment) = try MetalUtil.getRenderFunctions(device: self.device)
		self.computePipeline = try MetalUtil.makeComputePipeline(device: self.device, function: compute)
		self.renderPipeline = try MetalUtil.makeRenderPipeline(device: self.device, vertex: vertex, fragment: fragment)
		self.indexBuffer = try MetalUtil.makeIndexBuffer(device: self.device, indices: Self.indices)
		self.commandQueue = try MetalUtil.getCommandQueue(device: self.device)
		self.configuration = configuration
	}
	
	func draw(in view: MTKView) throws {
		guard let commandBuffer = self.commandQueue.makeCommandBuffer() else {
			throw Error.commandBuffer
		}
		
		try self.encodeCompute(commandBuffer: commandBuffer)
		try self.encodeRender(commandBuffer: commandBuffer, view: view)
		
		commandBuffer.present(view.currentDrawable!)
		commandBuffer.commit()
	}
	
	func updateSize() throws {}
	
	private func encodeCompute(commandBuffer: MTLCommandBuffer) throws {
		let length = MemoryLayout<render_config>.stride
		var configuration = self.configuration.shaderConfiguration
		guard let configurationBuffer = device.makeBuffer(bytes: &configuration, length: length) else {
			throw Error.dataBuffer(description: "config")
		}
		
		guard let encoder = commandBuffer.makeComputeCommandEncoder() else {
			throw Error.commandEncoder(type: "compute")
		}
		encoder.setComputePipelineState(self.computePipeline)
		encoder.setTexture(self.outputImage, index: 0)
		encoder.setBuffer(configurationBuffer, offset: 0, index: 0)
		encoder.dispatchThreads(self.outputSize, threadsPerThreadgroup: MTLSize(width: 8, height: 8, depth: 8))
		encoder.endEncoding()
	}
	
	private func encodeRender(commandBuffer: MTLCommandBuffer, view: MTKView) throws {
		guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
			throw Error.renderPassDescriptor
		}
		renderPassDescriptor.colorAttachments[0].clearColor = view.clearColor
		
		guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
			throw Error.commandEncoder(type: "render")
		}
		encoder.setFragmentTexture(self.outputImage, index: 0)
		encoder.setRenderPipelineState(self.renderPipeline)
		encoder.drawIndexedPrimitives(type: .triangle, indexCount: Self.indices.count, indexType: .uint16, indexBuffer: self.indexBuffer, indexBufferOffset: 0)
		encoder.endEncoding()
	}
	
	private static let indices: Array<UInt16> = [0, 1, 3, 3, 2, 0]
	
	enum Error: Swift.Error {
		case device, texture, shaderLibrary, shader(name: String), commandQueue
		case commandBuffer, dataBuffer(description: String), commandEncoder(type: String)
		case renderPassDescriptor
	}
}
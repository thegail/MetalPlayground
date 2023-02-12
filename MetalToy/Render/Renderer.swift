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
		self.device = try Self.getDevice()
		self.outputSize = MTLSize(width: 0, height: 0, depth: 0)
		self.outputImage = try Self.makeOutputImage(size: self.outputSize, device: self.device)
		let (compute, vertex, fragment) = try Self.getRenderFunctions(device: self.device)
		self.computePipeline = try Self.makeComputePipeline(device: self.device, function: compute)
		self.renderPipeline = try Self.makeRenderPipeline(device: self.device, vertex: vertex, fragment: fragment)
		self.indexBuffer = try Self.makeIndexBuffer(device: self.device)
		self.commandQueue = try Self.getCommandQueue(device: self.device)
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
	
	private static func getDevice() throws -> MTLDevice {
		guard let device = MTLCreateSystemDefaultDevice() else {
			throw Error.device
		}
		return device
	}
	
	private static func makeOutputImage(size: MTLSize, device: MTLDevice) throws -> MTLTexture {
		let descriptor = MTLTextureDescriptor()
		descriptor.pixelFormat = .rgba32Float
		descriptor.width = size.width
		descriptor.height = size.height
		descriptor.usage = .unknown
		descriptor.storageMode = .private
		guard let texture = device.makeTexture(descriptor: descriptor) else {
			throw Error.texture
		}
		return texture
	}
	
	private static func getRenderFunctions(device: MTLDevice) throws -> (compute: MTLFunction, vertex: MTLFunction, fragment: MTLFunction) {
		guard let library = device.makeDefaultLibrary() else {
			throw Error.shaderLibrary
		}
		guard let compute = library.makeFunction(name: "render_image") else {
			throw Error.shader(name: "render_image")
		}
		guard let vertex = library.makeFunction(name: "render_vertex") else {
			throw Error.shader(name: "render_vertext")
		}
		guard let fragment = library.makeFunction(name: "render_fragment") else {
			throw Error.shader(name: "render_fragment")
		}
		return (compute: compute, vertex: vertex, fragment: fragment)
	}
	
	private static func makeComputePipeline(device: MTLDevice, function: MTLFunction) throws -> MTLComputePipelineState {
		let descriptor = MTLComputePipelineDescriptor()
		descriptor.computeFunction = function
//		if #available(macOS 12.0, *) {
//			computePipelineDescriptor.preloadedLibraries = [dynamic]
//		} else {
//			computePipelineDescriptor.insertLibraries = [dynamic]
//		}
		return try device.makeComputePipelineState(descriptor: descriptor, options: MTLPipelineOption(), reflection: nil)
	}
	
	private static func makeRenderPipeline(device: MTLDevice, vertex: MTLFunction, fragment: MTLFunction) throws -> MTLRenderPipelineState {
		let descriptor = MTLRenderPipelineDescriptor()
		descriptor.vertexFunction = vertex
		descriptor.fragmentFunction = fragment
		descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
		return try device.makeRenderPipelineState(descriptor: descriptor)
	}
	
	private static func makeIndexBuffer(device: MTLDevice) throws -> MTLBuffer {
		guard let buffer = device.makeBuffer(bytes: Self.indices, length: MemoryLayout<UInt16>.stride * Self.indices.count) else {
			throw Error.dataBuffer(description: "indices")
		}
		return buffer
	}
	
	private static func getCommandQueue(device: MTLDevice) throws -> MTLCommandQueue {
		guard let queue = device.makeCommandQueue() else {
			throw Error.commandQueue
		}
		return queue
	}
	
	private static let indices: Array<UInt16> = [0, 1, 3, 3, 2, 0]
	
	enum Error: Swift.Error {
		case device, texture, shaderLibrary, shader(name: String), commandQueue
		case commandBuffer, dataBuffer(description: String), commandEncoder(type: String)
		case renderPassDescriptor
	}
}

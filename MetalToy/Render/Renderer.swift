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
	let commandQueue: MTLCommandQueue
	
	init() throws {
		self.device = try Self.getDevice()
		self.outputSize = MTLSize(width: 0, height: 0, depth: 0)
		self.outputImage = try Self.makeOutputImage(size: self.outputSize, device: self.device)
		let (compute, vertex, fragment) = try Self.getRenderFunctions(device: self.device)
		self.computePipeline = try Self.makeComputePipeline(device: self.device, function: compute)
		self.renderPipeline = try Self.makeRenderPipeline(device: self.device, vertex: vertex, fragment: fragment)
		self.commandQueue = try Self.getCommandQueue(device: self.device)
	}
	
	func draw(in view: MTKView) {
		
	}
	
	func updateSize() {}
	
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
	
	private static func getCommandQueue(device: MTLDevice) throws -> MTLCommandQueue {
		guard let queue = device.makeCommandQueue() else {
			throw Error.commandQueue
		}
		return queue
	}
	
	enum Error: Swift.Error {
		case device, texture, shaderLibrary, shader(name: String), commandQueue
	}
}

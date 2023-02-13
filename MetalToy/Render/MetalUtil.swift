//
//  MetalUtil.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import Metal

enum MetalUtil {
	 static func getDevice() throws -> MTLDevice {
		guard let device = MTLCreateSystemDefaultDevice() else {
			throw Error.device
		}
		return device
	}
	
	static func makeOutputImage(size: MTLSize, device: MTLDevice) throws -> MTLTexture {
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
	
	static func makeExportableImage(size: MTLSize, device: MTLDevice) throws -> MTLTexture {
		let descriptor = MTLTextureDescriptor()
		descriptor.pixelFormat = .bgra8Unorm
		descriptor.width = size.width
		descriptor.height = size.height
		descriptor.usage = .unknown
		descriptor.storageMode = .shared
		guard let texture = device.makeTexture(descriptor: descriptor) else {
			throw Error.texture
		}
		return texture
	}
	
	static func getRenderFunctions(device: MTLDevice) throws -> (compute: MTLFunction, vertex: MTLFunction, fragment: MTLFunction) {
		guard let library = device.makeDefaultLibrary() else {
			throw Error.shaderLibrary
		}
		guard let compute = library.makeFunction(name: "make_image") else {
			throw Error.shader(name: "make_image")
		}
		guard let vertex = library.makeFunction(name: "render_vertex") else {
			throw Error.shader(name: "render_vertex")
		}
		guard let fragment = library.makeFunction(name: "render_fragment") else {
			throw Error.shader(name: "render_fragment")
		}
		return (compute: compute, vertex: vertex, fragment: fragment)
	}
	
	static func makeDynamicLibrary(device: MTLDevice, source: String) throws -> MTLDynamicLibrary {
		let options = MTLCompileOptions()
		options.libraryType = .dynamic
		options.installName = "@executable_path/libUserShader.dylib"
		let library = try device.makeLibrary(source: source, options: options)
		return try device.makeDynamicLibrary(library: library)
	}
	
	static func makeComputePipeline(device: MTLDevice, function: MTLFunction, library: MTLDynamicLibrary?) throws -> MTLComputePipelineState {
		let descriptor = MTLComputePipelineDescriptor()
		descriptor.computeFunction = function
		if let library = library {
			if #available(macOS 12.0, *) {
				descriptor.preloadedLibraries = [library]
			} else {
				descriptor.insertLibraries = [library]
			}
		}
		return try device.makeComputePipelineState(descriptor: descriptor, options: MTLPipelineOption(), reflection: nil)
	}
	
	static func makeRenderPipeline(device: MTLDevice, vertex: MTLFunction, fragment: MTLFunction) throws -> MTLRenderPipelineState {
		let descriptor = MTLRenderPipelineDescriptor()
		descriptor.vertexFunction = vertex
		descriptor.fragmentFunction = fragment
		descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
		return try device.makeRenderPipelineState(descriptor: descriptor)
	}
	
	static func makeIndexBuffer(device: MTLDevice, indices: Array<UInt16>) throws -> MTLBuffer {
		guard let buffer = device.makeBuffer(bytes: indices, length: MemoryLayout<UInt16>.stride * indices.count) else {
			throw Error.dataBuffer(description: "indices")
		}
		return buffer
	}
	
	static func getCommandQueue(device: MTLDevice) throws -> MTLCommandQueue {
		guard let queue = device.makeCommandQueue() else {
			throw Error.commandQueue
		}
		return queue
	}
	
	private typealias Error = Renderer.Error
}

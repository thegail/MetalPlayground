//
//  MTLTexture+toImage.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/13/23.
//

import Metal
import CoreImage
import UniformTypeIdentifiers

extension MTLTexture {
	func toImage() throws -> Data {
		var textureData = Array<UInt8>(repeating: 0, count: self.width * self.height * 4)
		self.getBytes(
			&textureData,
			bytesPerRow: self.width * 4,
			from: MTLRegion(
				origin: MTLOrigin(x: 0, y: 0, z: 0),
				size: MTLSize(width: self.width, height: self.height, depth: 1)
			),
			mipmapLevel: 0
		)
		
		let context = CGContext(
			data: &textureData,
			width: self.width,
			height: self.height,
			bitsPerComponent: 8,
			bytesPerRow: self.width * 4,
			space: CGColorSpaceCreateDeviceRGB(),
			bitmapInfo: UInt32(Int(kColorSyncAlphaPremultipliedFirst.rawValue) | kColorSyncByteOrder32Little)
		)
		
		guard let context = context else {
			throw ImageExportError.failedToCreateContext
		}
		context.flush()
		
		guard let image = context.makeImage() else {
			throw ImageExportError.failedToCreateImage
		}
		
		let maxImageSize = self.width * self.height * 4 + 4096
		guard let imageData = CFDataCreateMutable(CFAllocatorGetDefault().takeRetainedValue(), maxImageSize) else {
			throw ImageExportError.failedToAllocateData
		}
		
		guard let destination = CGImageDestinationCreateWithData(imageData, UTType.png.identifier as CFString, 1, nil) else {
			throw ImageExportError.failedToCreateDestination
		}
		CGImageDestinationAddImage(destination, image, nil)
		
		guard CGImageDestinationFinalize(destination) else {
			throw ImageExportError.failedToFinalizeExport
		}
		
		return imageData as Data
	}
}

enum ImageExportError: Error {
	case failedToCreateContext, failedToCreateImage, failedToAllocateData
	case failedToCreateDestination, failedToFinalizeExport
}

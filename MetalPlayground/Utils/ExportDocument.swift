//
//  ExportDocument.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/13/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ExportDocument: FileDocument {
	static let readableContentTypes: [UTType] = []
	static let writableContentTypes: [UTType] = [.png]
	
	let configuration: RenderConfiguration
	let width: Int
	
	init(configuration: ReadConfiguration) throws { fatalError("Cannot read export file") }
	
	init(renderConfiguration: RenderConfiguration, width: Int) {
		self.configuration = renderConfiguration
		self.width = width
	}
	
	func imageData() throws -> Data {
		let renderer = try ImageRenderer(configuration: self.configuration, width: self.width, height: self.width)
		let data = try renderer.render()
		return data
	}
	
	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		return try FileWrapper(regularFileWithContents: self.imageData())
	}
}

//
//  MetalDocument.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/12/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
	static let metalSource: UTType = UTType(importedAs: "com.apple.metal")
}

struct MetalDocument: FileDocument {
	var text: String
	
	init(text: String = RenderConfiguration.defaultConfiguration.shaderSource) {
		self.text = text
	}
	
	init(configuration: ReadConfiguration) throws {
		guard let data = configuration.file.regularFileContents,
			  let string = String(data: data, encoding: .utf8) else {
			throw CocoaError(.fileReadCorruptFile)
		}
		text = string
	}
	
	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		let data = text.data(using: .utf8)!
		return FileWrapper(regularFileWithContents: data)
	}
	
	static let readableContentTypes: [UTType] = [.metalSource]
}

//
//  MetalToyApp.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

@main
struct MetalToyApp: App {
	@FocusedBinding(\.configuration) var configuration: RenderConfiguration?
	@FocusedBinding(\.document) var document: MetalDocument?
	
    var body: some Scene {
		DocumentGroup(newDocument: MetalDocument()) { file in
			ContentView(document: file.$document/*, documentURL: file.fileURL*/)
		}
		.commands {
			EditorCommands(configuration: $configuration, document: $document)
		}
    }
}

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
	@FocusedBinding(\.exportShown) var exportShown: Bool?
	
    var body: some Scene {
		DocumentGroup(newDocument: MetalDocument()) { file in
			ContentView(document: file.$document)
		}
		.commands {
			EditorCommands(configuration: $configuration, document: $document, exportShown: $exportShown)
		}
    }
}

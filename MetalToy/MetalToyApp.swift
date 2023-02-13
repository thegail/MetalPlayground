//
//  MetalToyApp.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

@main
struct MetalToyApp: App {
	@FocusedBinding(\.document) var document: MetalDocument?
	
    var body: some Scene {
		DocumentGroup(newDocument: MetalDocument()) { file in
			ContentView(document: file.$document)
				.focusedSceneValue(\.document, file.$document)
		}
    }
}

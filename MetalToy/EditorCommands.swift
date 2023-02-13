//
//  EditorCommands.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import SwiftUI

struct EditorCommands: Commands {
	@Binding var configuration: RenderConfiguration?
	@Binding var document: MetalDocument?
	@Binding var exportShown: Bool?
	
	var body: some Commands {
		TextEditingCommands()
		
		CommandGroup(after: .saveItem) {
			Button("Build and Run") {
				guard let text = self.document?.text else {
					return
				}
				self.configuration?.shaderSource = text
			}
			.keyboardShortcut("r", modifiers: .command)
			.disabled(self.configuration == nil || self.document == nil)
			
			Button("Export") {
				self.exportShown = true
			}
			.keyboardShortcut("e", modifiers: [.command, .option])
			.disabled(self.exportShown ?? true)
		}
		
		CommandGroup(before: .toolbar) {
			Button("Zoom In") {
				self.configuration?.zoomIn()
			}
			.keyboardShortcut("+", modifiers: .command)
			.disabled(self.configuration == nil)
			
			Button("Zoom Out") {
				self.configuration?.zoomOut()
			}
			.keyboardShortcut("-", modifiers: .command)
			.disabled(self.configuration == nil)
			
			Button("Actual Size") {
				self.configuration?.goHome()
			}
			.keyboardShortcut("0", modifiers: .command)
			.disabled(self.configuration == nil)
		}
	}
}

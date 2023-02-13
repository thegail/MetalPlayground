//
//  EditorCommands.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import SwiftUI

struct EditorCommands: Commands {
	@Binding var configuration: RenderConfiguration?
	
	var body: some Commands {
		TextEditingCommands()
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

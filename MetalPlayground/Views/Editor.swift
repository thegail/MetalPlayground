//
//  Editor.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct Editor: View {
	@Binding var document: MetalDocument
	@Binding var configuration: RenderConfiguration
	@Binding var exportShown: Bool
	@State var showControls = false
	
    var body: some View {
		ZStack(alignment: .topTrailing) {
			TextEditor(text: self.$document.text)
				.fontDesign(.monospaced)
			if showControls {
				EditorControlsView(configuration: self.$configuration, editorSource: $document.text, exportShown: self.$exportShown)
					.padding()
					.transition(.opacity.animation(.easeIn(duration: 0.1)))
			}
		}
		.onHover(perform: { self.showControls = $0 })
    }
}

struct Editor_Previews: PreviewProvider {
	@State static var value = "Hello, World!"
	
    static var previews: some View {
		Editor(document: .constant(.init()), configuration: .constant(.defaultConfiguration), exportShown: .constant(false))
    }
}

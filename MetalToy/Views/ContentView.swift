//
//  ContentView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ContentView: View {
	@State var configuration: RenderConfiguration = RenderConfiguration.defaultConfiguration
	@State var showControls = false
	@State var showEditorControls = false
	@Binding var document: MetalDocument
	
    var body: some View {
		HStack {
			ZStack(alignment: .topTrailing) {
				RenderView(configuration: configuration)
				if showControls {
					ControlsView(configuration: $configuration)
						.padding()
						.transition(.opacity.animation(.easeIn(duration: 0.1)))
				}
			}
			.onHover(perform: { self.showControls = $0 })
			ZStack(alignment: .topTrailing) {
				EditorView(text: $document.text)
				if showEditorControls {
					EditorControlsView(configuration: $configuration, editorSource: $document.text)
						.padding()
						.transition(.opacity.animation(.easeIn(duration: 0.1)))
				}
			}
			.onHover(perform: { self.showEditorControls = $0 })
		}
		.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(document: .constant(MetalDocument()))
    }
}

//
//  ContentView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ContentView: View {
	@State var configuration: RenderConfiguration
	@State var showControls = false
	@State var showEditorControls = false
	@Binding var document: MetalDocument
	
	init(document: Binding<MetalDocument>) {
		self._document = document
		var configuration = RenderConfiguration.defaultConfiguration
		configuration.shaderSource = document.wrappedValue.text
		self.configuration = configuration
	}
	
	func drag(size: CGSize) -> some Gesture {
		DragGesture()
			.onChanged { value in
				let normalizedStart = SIMD2(value.startLocation) * SIMD2(-1, 1) * SIMD2(repeating: self.configuration.width) / SIMD2(size) - 0.5
				let normalizedCurrent = SIMD2(value.location) * SIMD2(-1, 1) * SIMD2(repeating: self.configuration.width) / SIMD2(size) - 0.5
				let newValue = self.configuration.initialCoordinates + normalizedCurrent - normalizedStart
				self.configuration.gestureCoordinates = newValue
			}
			.onEnded { value in
				let normalizedStart = SIMD2(value.startLocation) * SIMD2(-1, 1) * SIMD2(repeating: self.configuration.width) / SIMD2(size) - 0.5
				let normalizedCurrent = SIMD2(value.predictedEndLocation) * SIMD2(-1, 1) * SIMD2(repeating: self.configuration.width) / SIMD2(size) - 0.5
				let newValue = self.configuration.initialCoordinates + normalizedCurrent - normalizedStart
				self.configuration.gestureCoordinates = newValue
				self.configuration.endGesture()
			}
	}
	
	var magnification: some Gesture {
		MagnificationGesture()
			.onChanged { value in
				self.configuration.width /= pow(Float(value.magnitude), 0.1)
			}
	}
	
    var body: some View {
		HStack {
			ZStack(alignment: .topTrailing) {
				GeometryReader { geometry in
					RenderView(configuration: configuration)
						.aspectRatio(1, contentMode: .fit)
						.gesture(drag(size: geometry.size))
						.gesture(magnification)
				}
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
		.focusedSceneValue(\.configuration, self.$configuration)
		.focusedSceneValue(\.document, self.$document)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(document: .constant(MetalDocument()))
    }
}

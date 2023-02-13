//
//  Viewer.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/13/23.
//

import SwiftUI

struct Viewer: View {
	@Binding var configuration: RenderConfiguration
	@State var showControls = false
	
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
		ZStack(alignment: .topTrailing) {
			GeometryReader { geometry in
				RenderView(configuration: configuration)
					.gesture(drag(size: geometry.size))
					.gesture(magnification)
			}
			if showControls {
				ControlsView(configuration: $configuration)
					.padding()
					.transition(.opacity.animation(.easeIn(duration: 0.1)))
			}
		}
		.aspectRatio(1, contentMode: .fit)
		.onHover(perform: { self.showControls = $0 })
    }
}

struct Viewer_Previews: PreviewProvider {
    static var previews: some View {
		Viewer(configuration: .constant(.defaultConfiguration))
    }
}

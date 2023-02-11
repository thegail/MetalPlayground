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
	
    var body: some View {
		VStack {
			HStack {
				ZStack(alignment: .topTrailing) {
					RenderView()
					if showControls {
						ControlsView(configuration: $configuration)
							.padding()
							.transition(.opacity.animation(.easeIn(duration: 0.1)))
					}
				}
				.onHover(perform: { self.showControls = $0 })
				EditorView(text: $configuration.shaderSource)
			}
		}
		.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ContentView: View {
	@State var configuration: RenderConfiguration = RenderConfiguration.defaultConfiguration
	
    var body: some View {
		VStack {
			HStack {
				OutputView()
				EditorView(text: $configuration.shaderSource)
			}
			ControlsView()
		}
		.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

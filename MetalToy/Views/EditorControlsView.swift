//
//  EditorControlsView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import SwiftUI

struct EditorControlsView: View {
	@Binding var configuration: RenderConfiguration
	@Binding var editorSource: String
	
    var body: some View {
		VStack(alignment: .trailing) {
			Button(action: { configuration.shaderSource = editorSource }, label: { Image(systemName: "hammer.fill") })
		}
		.buttonStyle(ControlButtonStyle())
    }
}

struct EditorControlsView_Previews: PreviewProvider {
	@State static var configuration = RenderConfiguration.defaultConfiguration
	@State static var source = RenderConfiguration.defaultConfiguration.shaderSource
	
    static var previews: some View {
		EditorControlsView(configuration: $configuration, editorSource: $source)
    }
}

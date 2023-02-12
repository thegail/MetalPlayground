//
//  EditorControlsView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import SwiftUI

struct EditorControlsView: View {
	@Binding var configuration: RenderConfiguration
	
    var body: some View {
		VStack(alignment: .trailing) {
			Button(action: {}, label: { Image(systemName: "hammer.fill") })
			Button(action: {}, label: { Image(systemName: "square.and.arrow.down.fill") })
			Button(action: {}, label: { Image(systemName: "folder.fill") })
		}
		.buttonStyle(ControlButtonStyle())
    }
}

struct EditorControlsView_Previews: PreviewProvider {
	@State static var configuration = RenderConfiguration.defaultConfiguration
	
    static var previews: some View {
		EditorControlsView(configuration: $configuration)
    }
}

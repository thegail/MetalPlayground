//
//  ControlsView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ControlsView: View {
	@Binding var configuration: RenderConfiguration
	
    var body: some View {
		VStack(alignment: .trailing, spacing: 30) {
			LocationControls()
			ZoomControls()
		}
		.buttonStyle(ControlButtonStyle())
    }
}

struct ControlsView_Previews: PreviewProvider {
	@State static var configuration = RenderConfiguration.defaultConfiguration
	
    static var previews: some View {
        ControlsView(configuration: $configuration)
    }
}

//
//  ZoomControls.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ZoomControls: View {
	@Binding var configuration: RenderConfiguration
	
    var body: some View {
		VStack {
			Button(action: self.makeZoom(true), label: { Image(systemName: "plus") })
			Button(action: self.makeZoom(false), label: { Image(systemName: "minus") })
		}
    }
	
	private func makeZoom(_ isIn: Bool) -> () -> () {
		if isIn {
			return {
				withAnimation(.easeInOut(duration: 0.2)) {
					self.configuration.zoomIn()
				}
			}
		} else {
			return {
				withAnimation(.easeInOut(duration: 0.2)) {
					self.configuration.zoomOut()
				}
			}
		}
	}
}

struct ZoomControls_Previews: PreviewProvider {
	@State static var configuration: RenderConfiguration = RenderConfiguration.defaultConfiguration
	
    static var previews: some View {
        ZoomControls(configuration: $configuration)
			.buttonStyle(ControlButtonStyle())
    }
}

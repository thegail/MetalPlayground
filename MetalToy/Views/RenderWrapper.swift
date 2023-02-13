//
//  RenderWrapper.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/13/23.
//

import SwiftUI

struct RenderWrapper: View, Animatable {
	var configuration: RenderConfiguration
	
	var animatableData: AnimatablePair<Float, Float> {
		get {
			AnimatablePair(
				self.configuration.shaderConfiguration.x,
				self.configuration.shaderConfiguration.y
			)
		}
		set(new) {
			self.configuration.shaderConfiguration.x = new.first
			self.configuration.shaderConfiguration.y = new.second
		}
	}
	
    var body: some View {
		RenderView(configuration: self.configuration)
    }
}

struct RenderWrapper_Previews: PreviewProvider {
    static var previews: some View {
		RenderWrapper(configuration: .defaultConfiguration)
    }
}

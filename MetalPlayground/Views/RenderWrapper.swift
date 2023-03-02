//
//  RenderWrapper.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/13/23.
//

import SwiftUI

struct RenderWrapper: View, Animatable {
	var configuration: RenderConfiguration
	
	var animatableData: AnimatablePair<Float, AnimatablePair<Float, Float>> {
		get {
			AnimatablePair(
				self.configuration.width,
				AnimatablePair(
					self.configuration.x,
					self.configuration.y
				)
			)
		}
		set(new) {
			self.configuration.width = new.first
			self.configuration.x = new.second.first
			self.configuration.y = new.second.second
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

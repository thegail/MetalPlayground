//
//  LocationControls.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct LocationControls: View {
	@Binding var configuration: RenderConfiguration
	
    var body: some View {
		VStack {
			HStack {
				Button(action: self.makeMove(.up), label: {
					Image(systemName: "chevron.up")
				})
			}
			HStack {
				Button(action: self.makeMove(.left), label: {
					Image(systemName: "chevron.backward")
				})
				Button(action: self.goHome, label: {
					Image(systemName: "house")
				})
				Button(action: self.makeMove(.right), label: {
					Image(systemName: "chevron.forward")
				})
			}
			HStack {
				Button(action: self.makeMove(.down), label: {
					Image(systemName: "chevron.down")
				})
			}
		}
    }
	
	private func goHome() {
		self.configuration.goHome()
	}
	
	private func makeMove(_ direction: MoveDirection) -> () -> () {
		let x: Float
		let y: Float
		switch direction {
		case .up:
			x = 0
			y = 1
		case .down:
			x = 0
			y = -1
		case .left:
			x = -1
			y = 0
		case .right:
			x = 1
			y = 0
		}
		return {
			self.configuration.x += x / 10
			self.configuration.y += y / 10
		}
	}
	
	private enum MoveDirection {
		case up, down, left, right
	}
}

struct LocationControls_Previews: PreviewProvider {
	@State static var configuration: RenderConfiguration = RenderConfiguration.defaultConfiguration
	
    static var previews: some View {
        LocationControls(configuration: $configuration)
			.buttonStyle(ControlButtonStyle())
    }
}

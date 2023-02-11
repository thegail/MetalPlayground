//
//  LocationControls.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct LocationControls: View {
    var body: some View {
		VStack {
			HStack {
				Button(action: {}, label: {
					Image(systemName: "chevron.up")
				})
			}
			HStack {
				Button(action: {}, label: {
					Image(systemName: "chevron.backward")
				})
				Button(action: {}, label: {
					Image(systemName: "house")
				})
				Button(action: {}, label: {
					Image(systemName: "chevron.forward")
				})
			}
			HStack {
				Button(action: {}, label: {
					Image(systemName: "chevron.down")
				})
			}
		}
    }
}

struct LocationControls_Previews: PreviewProvider {
    static var previews: some View {
        LocationControls()
			.buttonStyle(ControlButtonStyle())
    }
}

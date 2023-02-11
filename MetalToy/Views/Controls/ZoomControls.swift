//
//  ZoomControls.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ZoomControls: View {
    var body: some View {
		VStack {
			Button(action: {}, label: { Image(systemName: "plus") })
			Button(action: {}, label: { Image(systemName: "minus") })
		}
    }
}

struct ZoomControls_Previews: PreviewProvider {
    static var previews: some View {
        ZoomControls()
			.buttonStyle(ControlButtonStyle())
    }
}

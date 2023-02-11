//
//  RenderView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct RenderView: View {
    var body: some View {
        Rectangle()
			.foregroundColor(.red)
			.frame(width: 400, height: 400)
    }
}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView()
    }
}

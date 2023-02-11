//
//  ContentView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack {
			HStack {
				OutputView()
				EditorView()
			}
			ControlsView()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

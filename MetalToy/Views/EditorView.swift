//
//  EditorView.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct EditorView: View {
	@Binding var text: String
	
    var body: some View {
        TextEditor(text: $text)
			.frame(width: 400, height: 400)
    }
}

struct EditorView_Previews: PreviewProvider {
	@State static var value = "Hello, World!"
	
    static var previews: some View {
		EditorView(text: $value)
    }
}

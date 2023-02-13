//
//  ExportOptionsSheet.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/13/23.
//

import SwiftUI

struct ExportOptionsSheet: View {
	@Binding var exportWidth: Int
	@Binding var continueExport: Bool
	@Environment(\.dismiss) var dismissAction: DismissAction
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Export Options")
				.font(.title2)
			HStack {
				Text("Width")
				Spacer()
				TextField("Width", value: self.$exportWidth, formatter: NumberFormatter())
					.frame(width: 50)
				Text("pixels")
			}
			.frame(width: 150)
			HStack {
				Spacer()
				Button("Cancel", role: .cancel) {
					self.continueExport = false
					self.dismissAction()
				}
				.keyboardShortcut(.cancelAction)
				Button("Ok") {
					self.continueExport = true
					self.dismissAction()
				}
				.foregroundColor(.accentColor)
				.keyboardShortcut(.defaultAction)
			}
		}
		.frame(width: 400)
		.padding()
    }
}

struct ExportOptionsSheet_Previews: PreviewProvider {
	@State static var width = 0
	
    static var previews: some View {
		ExportOptionsSheet(exportWidth: $width, continueExport: .constant(true))
    }
}

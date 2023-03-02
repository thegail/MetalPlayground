//
//  ContentView.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/11/23.
//

import SwiftUI

struct ContentView: View {
	@Binding var document: MetalDocument
	@State var configuration: RenderConfiguration
	@State var showExportMenu = false
	@State var showExportOptionsMenu = false
	@State var exportWidth = 400
	@State var continueExport = false
	
	init(document: Binding<MetalDocument>) {
		self._document = document
		var configuration = RenderConfiguration.defaultConfiguration
		configuration.shaderSource = document.wrappedValue.text
		self.configuration = configuration
	}
	
    var body: some View {
		HSplitView {
			Viewer(configuration: self.$configuration)
			Editor(document: self.$document, configuration: self.$configuration, exportShown: self.$showExportOptionsMenu)
		}
		.edgesIgnoringSafeArea(.all)
		.focusedSceneValue(\.configuration, self.$configuration)
		.focusedSceneValue(\.document, self.$document)
		.focusedSceneValue(\.exportShown, self.$showExportOptionsMenu)
		.sheet(isPresented: self.$showExportOptionsMenu, onDismiss: {
			if self.continueExport {
				self.showExportMenu = true
			}
		}) {
			ExportOptionsSheet(exportWidth: self.$exportWidth, continueExport: self.$continueExport)
		}
		.fileExporter(
			isPresented: self.$showExportMenu,
			document: ExportDocument(renderConfiguration: self.configuration, width: self.exportWidth),
			contentType: .png,
			defaultFilename: "shader_export",
			onCompletion: { _ in }
		)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(document: .constant(MetalDocument()))
    }
}

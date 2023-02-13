//
//  FocusedValues+document.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/12/23.
//

import SwiftUI

extension FocusedValues {
	struct DocumentFocusedValues: FocusedValueKey {
		typealias Value = Binding<MetalDocument>
	}

	var document: Binding<MetalDocument>? {
		get {
			self[DocumentFocusedValues.self]
		}
		set {
			self[DocumentFocusedValues.self] = newValue
		}
	}
}

extension FocusedValues {
	struct ConfigurationFocusedValues: FocusedValueKey {
		typealias Value = Binding<RenderConfiguration>
	}

	var configuration: Binding<RenderConfiguration>? {
		get {
			self[ConfigurationFocusedValues.self]
		}
		set {
			self[ConfigurationFocusedValues.self] = newValue
		}
	}
}

extension FocusedValues {
	struct ExportShownFocusedValues: FocusedValueKey {
		typealias Value = Binding<Bool>
	}

	var exportShown: Binding<Bool>? {
		get {
			self[ExportShownFocusedValues.self]
		}
		set {
			self[ExportShownFocusedValues.self] = newValue
		}
	}
}

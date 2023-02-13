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

//
//  InternalRenderConfiguration.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 3/2/23.
//

import Foundation

struct InternalRenderConfiguration {
	var frame: UInt32
	var aspect: Float
	
	static let defaultConfiguration = Self(frame: 0, aspect: 1)
}

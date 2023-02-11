//
//  RenderConfiguration.swift
//  MetalToy
//
//  Created by Teddy Gaillard on 2/11/23.
//

import Foundation

struct RenderConfiguration {
	var shaderSource: String
	var shaderConfiguration: render_config
	
	static let defaultConfiguration: Self = Self(shaderSource: "", shaderConfiguration: render_config(x: 0, y: 0, width: 2))
}

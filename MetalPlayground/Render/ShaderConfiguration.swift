//
//  ShaderConfiguration.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 3/2/23.
//

import Foundation

typealias ShaderConfiguration = render_config

extension ShaderConfiguration {
	init(user: RenderConfiguration, auto: InternalRenderConfiguration) {
		self.init(x: user.x, y: user.y, width: user.width, aspect: auto.aspect, frame: auto.frame)
	}
}

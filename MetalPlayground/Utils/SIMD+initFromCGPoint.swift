//
//  SIMD+initFromCGPoint.swift
//  MetalPlayground
//
//  Created by Teddy Gaillard on 2/12/23.
//

import Foundation

extension SIMD2 where Scalar == Float {
	init(_ point: CGPoint) {
		self.init(Float(point.x), Float(point.y))
	}
	
	init(_ size: CGSize) {
		self.init(Float(size.width), Float(size.height))
	}
}

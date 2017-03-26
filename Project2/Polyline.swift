//
//  Polyline.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class Polyline {
    var points: [CGPoint] = []
    var brush = Brush()
    
    public init(brush: Brush){
        self.brush = brush
    }
    
    public func toStroke() -> Stroke {
        return Stroke(line: self)
    }
}

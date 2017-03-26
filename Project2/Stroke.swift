//
//  Stroke.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class Stroke {
    
    public init (line: Polyline){
        points = line.points
        self.brush = line.brush
    }
    
    public func toPolyline() -> Polyline{
        let line = Polyline(brush: brush)
        for point in points {
            line.points.append(CGPoint(x: point.x, y: point.y))
        }
        return line
    }
    
    var points: [CGPoint] = []
    var brush: Brush = Brush()
}

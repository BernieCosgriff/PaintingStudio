//
//  Painting.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class Painting {
    
    private var strokes_: [Stroke] = []
    
    func addStroke(stroke: Stroke){
        strokes_.append(stroke)
    }
    
    func getPolylines() -> [Polyline]{
        var lines: [Polyline] = []
        for stroke in strokes_ {
            lines.append(stroke.toPolyline())
        }
        return lines
    }
    
    func clear(){
        strokes_.removeAll()
    }
}

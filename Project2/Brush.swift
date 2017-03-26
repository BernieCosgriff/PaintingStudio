//
//  Brush.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/16/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class Brush {
    
    var cap = CGLineCap.round
    var join = CGLineJoin.round
    var color = UIColor.black.cgColor
    var width: CGFloat = 5.0
    
    public init(){
        
    }
    
    public init(brush: Brush){
        cap = brush.cap
        join = brush.join
        color = brush.color
        width = brush.width
    }
}

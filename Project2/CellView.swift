//
//  CellView.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/20/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    private var painting: Painting! = nil
    
    public init(frame: CGRect, painting: Painting) {
        super.init(frame: frame)
        self.painting = painting
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        var first = true
        for line in painting.getPolylines() {
            first = true
            context.setStrokeColor(line.brush.color)
            context.setLineCap(line.brush.cap)
            context.setLineJoin(line.brush.join)
            context.setLineWidth(line.brush.width)
            for point in line.points {
                let pt = CGPoint(x: point.x * bounds.width, y: point.y * bounds.height)
                if(first){
                    context.move(to: pt)
                    first = false
                }
                context.addLine(to: pt)
            }
            context.drawPath(using: .stroke)
        }
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(1.0)
        context.addRect(rect)
        context.drawPath(using: .stroke)
    }
    
}

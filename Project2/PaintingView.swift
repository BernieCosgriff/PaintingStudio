//
//  PaintingView.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

protocol PaintingViewDelegate: class {
    func strokeEnded(line: Polyline)
}

class PaintingView: UIView{
    
    private var polyline_: Polyline? = nil
    private var lines_: [Polyline] = []
    weak var delegate_: PaintingViewDelegate? = nil
    var brush = Brush()
    
    public init(frame: CGRect, painting: Painting) {
        super.init(frame: frame)
        lines_ = painting.getPolylines()
        if let b = lines_.last?.brush{
            brush = Brush(brush: b)
        }
        backgroundColor = UIColor.white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        var first = true
        for line in lines_ {
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
        first = true
        if let p = polyline_{
            context.setStrokeColor(brush.color)
            context.setLineCap(brush.cap)
            context.setLineJoin(brush.join)
            context.setLineWidth(brush.width)
            for point in p.points {
                let pt = CGPoint(x: point.x * bounds.width, y: point.y * bounds.height)
                if(first){
                    context.move(to: pt)
                    first = false
                }
                context.addLine(to: pt)
            }
            context.drawPath(using: .stroke)
        }
    }
    
    func setPainting(painting: Painting){
        lines_ = painting.getPolylines()
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        polyline_ = Polyline(brush: Brush(brush: brush))
        let touch = touches.first!.location(in: self)
        polyline_?.points.append(CGPoint(x: touch.x/bounds.width, y: touch.y/bounds.height))
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!.location(in: self)
        polyline_?.points.append(CGPoint(x: touch.x/bounds.width, y: touch.y/bounds.height))
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!.location(in: self)
        polyline_?.points.append(CGPoint(x: touch.x/bounds.width, y: touch.y/bounds.height))
        lines_.append(polyline_!)
        delegate_?.strokeEnded(line: polyline_!)
        setNeedsDisplay()
    }
}

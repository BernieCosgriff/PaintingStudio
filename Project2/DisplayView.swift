//
//  DisplayView.swift
//  Project1
//
//  Created by Bernard Cosgriff on 2/4/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class DisplayView: UIView {
    
    private var join_: CGLineJoin? = nil
    private var cap_: CGLineCap? = nil
    private var width_: CGFloat? = nil
    private var color_: CGColor? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, join: CGLineJoin, cap: CGLineCap, color: CGColor, width: CGFloat){
        super.init(frame: frame)
        join_ = join
        cap_ = cap
        color_ = color
        width_ = width
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineJoin(join_!)
        context?.setLineCap(cap_!)
        context?.setLineWidth(width_!)
        context?.setStrokeColor(color_!)
        var x = bounds.minX + 15
        let y = bounds.midY
        let h = bounds.size.height
        context?.move(to: CGPoint(x: x, y: y))
        x += 50
        context?.addLine(to: CGPoint(x: x, y: y))
        x += 10
        context?.addLine(to: CGPoint(x: x, y: y + (h * 0.2)))
        x += 40
        context?.addLine(to: CGPoint(x: x, y: y - (h * 0.3)))
        x += 50
        context?.addLine(to: CGPoint(x: x, y: y + (h * 0.3)))
        x += 20
        context?.addLine(to: CGPoint(x: x, y: y - (h * 0.2)))
        x += 30
        context?.addLine(to: CGPoint(x: x, y: y + (h * 0.3)))
        x += 20
        context?.addLine(to: CGPoint(x: x, y: y))
        x = bounds.maxX - 15
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.drawPath(using: .stroke)
    }
    
    var join: CGLineJoin {
        get {
            return join_!
        }
        set {
            if(join_ != newValue){
                join_ = newValue
                setNeedsDisplay()
            }
        }
    }
    
    var cap: CGLineCap {
        get {
            return cap_!
        }
        set {
            if(cap_ != newValue){
                cap_ = newValue
                setNeedsDisplay()
            }
        }
    }
    
    var width: CGFloat {
        get {
            return width_!
        }
        set {
            if(width_ != newValue){
                width_ = newValue
                setNeedsDisplay()
            }
        }
    }
    
    var color: CGColor {
        get {
            return color_!
        }
        set {
            if(color_ != newValue){
                color_ = newValue
                setNeedsDisplay()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

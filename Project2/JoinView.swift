//
//  JoinView.swift
//  Project1
//
//  Created by Bernard Cosgriff on 2/4/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class JoinView: UIControl {
    
    private var joinStyle_: CGLineJoin = CGLineJoin.bevel
    private var isHighlighted_: Bool = false
    
    override func draw(_ rect: CGRect){
        
        let context = UIGraphicsGetCurrentContext()
        if(isHighlighted_){
            context?.setStrokeColor(UIColor.yellow.cgColor)
        } else {
            context?.setStrokeColor(UIColor.white.cgColor)
        }
        context?.setLineJoin(joinStyle_)
        context?.setLineWidth(10)
        context?.move(to: CGPoint(x: bounds.midX - 40, y: bounds.maxY * 0.8))
        context?.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY * 0.2))
        context?.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.maxY * 0.8))
        context?.drawPath(using: .stroke)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendActions(for: .valueChanged)
    }
    
    var joinStyle: CGLineJoin {
        get {
            return joinStyle_
        }
        
        set {
            joinStyle_ = newValue
        }
    }
    
    var select: Bool {
        get {
            return isHighlighted_
        }
        set {
            isHighlighted_ = newValue
            setNeedsDisplay()
        }
    }
}

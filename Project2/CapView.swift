//
//  CapView.swift
//  Project1
//
//  Created by Bernard Cosgriff on 2/4/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class CapView: UIControl {
    
    private var lineCap_: CGLineCap = CGLineCap.round
    private var isHighlighted_: Bool = false
    
    override func draw(_ rect: CGRect){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.black.cgColor)
        if(isHighlighted_){
            context?.setStrokeColor(UIColor.yellow.cgColor)
        } else {
            context?.setStrokeColor(UIColor.white.cgColor)
        }
        context?.setLineCap(lineCap_)
        context?.setLineWidth(10.0)
        context?.move(to: CGPoint(x: bounds.midX - 40, y: bounds.midY))
        context?.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.midY))
        context?.drawPath(using: .stroke)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendActions(for: .valueChanged)
    }
    
    var lineCap: CGLineCap {
        get {
            return lineCap_
        }
        
        set {
            lineCap_ = newValue
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

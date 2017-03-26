//
//  ColorChooser.swift
//  Project1
//
//  Created by Bernard Cosgriff on 2/4/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class ColorChooser: UIControl {
    
    private var color_: CGColor = UIColor.black.cgColor
    private var rSlider_: UISlider? = nil
    private var gSlider_: UISlider? = nil
    private var bSlider_: UISlider? = nil
    
    public init(frame: CGRect, color: UIColor){
        super.init(frame: frame)
        let heightThird = bounds.height/3.0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        rSlider_ = UISlider(frame: CGRect(x: 5, y: 20, width: bounds.size.width - 10, height: 10))
        rSlider_?.value = Float(red)
        rSlider_?.maximumTrackTintColor = UIColor.red
        rSlider_?.minimumTrackTintColor = UIColor.red
        rSlider_?.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        addSubview(rSlider_!)
        
        gSlider_ = UISlider(frame: CGRect(x: 5, y: (heightThird * 2) - 20, width: bounds.size.width - 10, height: 10))
        gSlider_?.value = Float(green)
        gSlider_?.maximumTrackTintColor = UIColor.green
        gSlider_?.minimumTrackTintColor = UIColor.green
        gSlider_?.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        addSubview(gSlider_!)
        
        bSlider_ = UISlider(frame: CGRect(x: 5, y: (heightThird * 3), width: bounds.size.width - 10, height: 10))
        bSlider_?.value = Float(blue)
        bSlider_?.maximumTrackTintColor = UIColor.blue
        bSlider_?.minimumTrackTintColor = UIColor.blue
        bSlider_?.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        addSubview(bSlider_!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func colorChanged(){
        color_ = UIColor(red: CGFloat(rSlider_!.value), green: CGFloat(gSlider_!.value), blue: CGFloat(bSlider_!.value), alpha: 1.0).cgColor
        sendActions(for: .valueChanged)
        setNeedsDisplay()
    }
    
    var color: CGColor{
        get{
            return color_
        }
        set{
            color_ = newValue
        }
    }
}

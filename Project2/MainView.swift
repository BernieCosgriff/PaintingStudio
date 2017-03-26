//
//  MainView.swift
//  Project1
//
//  Created by Bernard Cosgriff on 2/4/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    private var colorChooser_: ColorChooser? = nil
    private var capViewRound_: CapView? = nil
    private var capViewButt_: CapView? = nil
    private var capViewSquare_: CapView? = nil
    private var joinViewBevel_: JoinView? = nil
    private var joinViewSquare_: JoinView? = nil
    private var joinViewRound_: JoinView? = nil
    private var slider_: UISlider? = nil
    private var display_: DisplayView? = nil
    private var brush_: Brush! = nil
    
    
    public init(frame: CGRect, brush: Brush) {
        super.init(frame: frame)
        
        brush_ = brush
        
        colorChooser_ = ColorChooser(frame: CGRect(x: 5, y: 69, width: frame.width - 5, height: 186), color: UIColor(cgColor: brush.color))
        colorChooser_?.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        colorChooser_?.backgroundColor = UIColor.clear
        addSubview(colorChooser_!)
        
        let w = (frame.width/3.0) - 5.0
        
        capViewButt_ = CapView()
        capViewButt_?.lineCap = CGLineCap.butt
        capViewButt_?.frame = CGRect(x: 5, y: 280, width: w, height: 50)
        capViewButt_?.addTarget(self, action: #selector(capButtChanged), for: .valueChanged)
        capViewButt_?.backgroundColor = UIColor.clear
        capViewButt_?.select = true
        addSubview(capViewButt_!)
        
        capViewRound_ = CapView()
        capViewRound_?.frame = CGRect(x: w + 10, y: 280, width: w, height: 50)
        capViewRound_?.addTarget(self, action: #selector(capRoundChanged), for: .valueChanged)
        capViewRound_?.backgroundColor = UIColor.clear
        addSubview(capViewRound_!)
        
        capViewSquare_ = CapView()
        capViewSquare_?.lineCap = CGLineCap.square
        capViewSquare_?.frame = CGRect(x: (2 * w) + 15, y: 280, width: w, height: 50)
        capViewSquare_?.addTarget(self, action: #selector(capSquareChanged), for: .valueChanged)
        capViewSquare_?.backgroundColor = UIColor.clear
        addSubview(capViewSquare_!)
        
        joinViewBevel_ = JoinView()
        joinViewBevel_?.frame = CGRect(x: 5, y: 320, width: w, height: 100)
        joinViewBevel_?.addTarget(self, action: #selector(joinBevelChanged), for: .valueChanged)
        joinViewBevel_?.backgroundColor = UIColor.clear
        joinViewBevel_?.select = true
        addSubview(joinViewBevel_!)
        
        joinViewSquare_ = JoinView()
        joinViewSquare_?.joinStyle = CGLineJoin.miter
        joinViewSquare_?.frame = CGRect(x: w+10, y: 320, width: w, height: 100)
        joinViewSquare_?.addTarget(self, action: #selector(joinSquareChanged), for: .valueChanged)
        joinViewSquare_?.backgroundColor = UIColor.clear
        addSubview(joinViewSquare_!)
        
        joinViewRound_ = JoinView()
        joinViewRound_?.joinStyle = CGLineJoin.round
        joinViewRound_?.frame = CGRect(x: (2 * w) + 15, y: 320, width: w, height: 100)
        joinViewRound_?.addTarget(self, action: #selector(joinRoundChanged), for: .valueChanged)
        joinViewRound_?.backgroundColor = UIColor.clear
        addSubview(joinViewRound_!)
        
        slider_ = UISlider(frame: CGRect(x: 10, y: 440, width: w*3 - 10, height: 10))
        slider_?.maximumValue = 25.0
        slider_?.minimumValue = 1.0
        slider_?.value = Float(brush.width)
        slider_?.addTarget(self, action: #selector(widthChanged), for: .valueChanged)
        addSubview(slider_!)
        
        
        display_ = DisplayView(frame: CGRect(x: 10, y: 470, width: w*3 - 10, height: 80), join: brush.join, cap: brush.cap, color: brush.color, width: brush.width)
        display_?.translatesAutoresizingMaskIntoConstraints = false
        display_?.backgroundColor = UIColor.clear
        addSubview(display_!)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var components = colorChooser_!.color.components
        for i in 0..<components!.count - 1 {
            components![i] = 1 - components![i]
        }
        let inverse = CGColor(colorSpace: colorSpace, components: components!)
        let context = UIGraphicsGetCurrentContext()!
        let colours = [colorChooser_!.color, inverse] as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours , locations: nil)
        context.drawLinearGradient(gradient!, start: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY), end: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY), options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
    
    public func widthChanged(){
        if let w = slider_?.value {
            display_?.width = CGFloat(w)
            brush.width = CGFloat(w)
        }
    }
    
    public func joinRoundChanged(){
        joinViewRound_?.select = true
        joinViewBevel_?.select = false
        joinViewSquare_?.select = false
        display_?.join = .round
        brush_.join = .round
    }
    
    public func joinSquareChanged(){
        joinViewRound_?.select = false
        joinViewBevel_?.select = false
        joinViewSquare_?.select = true
        display_?.join = .miter
        brush_.join = .miter
    }
    
    public func joinBevelChanged(){
        joinViewRound_?.select = false
        joinViewBevel_?.select = true
        joinViewSquare_?.select = false
        display_?.join = .bevel
        brush_.join = .bevel
    }
    
    public func capRoundChanged(){
        capViewRound_?.select = true
        capViewButt_?.select = false
        capViewSquare_?.select = false
        display_?.cap = .round
        brush_.cap = .round
    }
    
    public func capButtChanged(){
        capViewRound_?.select = true
        capViewButt_?.select = false
        capViewSquare_?.select = false
        display_?.cap = .butt
        brush_.cap = .butt
    }
    
    public func capSquareChanged(){
        capViewRound_?.select = false
        capViewButt_?.select = false
        capViewSquare_?.select = true
        display_?.cap = .square
        brush_.cap = .square
    }
    
    public func colorChanged(){
        if let v = colorChooser_?.color {
            display_?.color = v
            brush_.color = v
            setNeedsDisplay()
        }
    }
    
    var brush: Brush {
        get {
            return brush_
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

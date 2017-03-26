//
//  PaintingViewController.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class PaintingViewController: UIViewController, PaintingViewDelegate, BrushSettingsControllerDelegate {
    
    private weak var paintingCollection_: PaintingCollection! = nil
    private var paintingView_: PaintingView! = nil
    
    public init(paintingCollection: PaintingCollection) {
        super.init(nibName: nil, bundle: nil)
        paintingCollection_ = paintingCollection
    }
    
    public init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        paintingView_ = PaintingView(frame: frame, painting: paintingCollection_.currentPainting)
        paintingView_.delegate_ = self
        paintingView_.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        paintingView_.contentMode = .redraw
        view.backgroundColor = UIColor.white
        view.addSubview(paintingView_)
        view.autoresizesSubviews = true
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(#imageLiteral(resourceName: "Palette"), for: .normal)
        button.addTarget(self, action: #selector(openBrushSettings), for: UIControlEvents.touchDown)
        navigationItem.titleView = button
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePainting))
        navigationItem.rightBarButtonItem = delete
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if(parent == nil){
            paintingCollection_.refreshPainting()
        }
    }
    public func openBrushSettings(){
        navigationController?.pushViewController(BrushSettingsViewController(frame: UIScreen.main.bounds, brush: paintingView_!.brush), animated: true)
    }
    
    public func deletePainting(){
        paintingCollection_.removePainting()
    }
    
    func strokeEnded(line: Polyline) {
        paintingCollection_.addStroke(stroke: Stroke(line: line))
    }
    
    func setBrush(brush: Brush) {
        paintingView_?.brush = brush
    }
}

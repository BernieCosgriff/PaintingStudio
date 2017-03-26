//
//  BrushSettingsViewController.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

protocol BrushSettingsControllerDelegate: class {
    func setBrush(brush: Brush)
}

class BrushSettingsViewController: UIViewController {
    
    var brush_: Brush! = nil
    private var mainView_: MainView? = nil
    private var mainViewLandscape_: MainViewLandscape? = nil
    weak var delegate_: BrushSettingsControllerDelegate? = nil
    
    public init(frame: CGRect, brush: Brush){
        super.init(nibName: nil, bundle: nil)
        brush_ = brush
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.setHidesBackButton(true, animated: true)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishSettings))
        navigationItem.rightBarButtonItem = done
        if UIDevice.current.orientation.isPortrait {
            mainView_ = MainView(frame: UIScreen.main.bounds, brush: brush_)
            view.addSubview(mainView_!)
        } else {
            mainViewLandscape_ = MainViewLandscape(frame: UIScreen.main.bounds, brush: brush_)
            view.addSubview(mainViewLandscape_!)
        }
    }
    
    public func finishSettings(){
        delegate_?.setBrush(brush: mainView_!.brush)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        if UIDevice.current.orientation.isPortrait {
            if(mainView_ == nil){
                mainView_ = MainView(frame: frame, brush: brush_)
            }
            if let view = mainViewLandscape_{
                view.removeFromSuperview()
            }
            view.addSubview(mainView_!)
        } else {
            if(mainViewLandscape_ == nil){
                mainViewLandscape_ = MainViewLandscape(frame: frame, brush: brush_)
            }
            if let view = mainView_{
                view.removeFromSuperview()
            }
            view.addSubview(mainViewLandscape_!)
        }
    }
}

//
//  PaintingCollectionsViewController.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

class PaintingCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private weak var paintingsCollection_: PaintingCollection! = nil
    var collectionView_: UICollectionView! = nil
    
    public init(paintingCollection: PaintingCollection) {
        super.init(nibName: nil, bundle: nil)
        paintingsCollection_ = paintingCollection
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        collectionView_ = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView_.dataSource = self
        collectionView_.delegate = self
        collectionView_.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView_.backgroundColor = UIColor.white
        collectionView_.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView_.contentMode = .redraw
        view.autoresizesSubviews = true
        view.addSubview(collectionView_)
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPainting))
        navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    public func addPainting(){
        paintingsCollection_.addPainting()
        let path = IndexPath(row: paintingsCollection_.numPaintings, section: 0)
        collectionView_.insertItems(at: [path])
    }
    
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paintingsCollection_.numPaintings + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView_.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if(cell.subviews.count < 2){
            let painting = paintingsCollection_.getPainting(index: indexPath.row)!
            var frame: CGRect! = nil
            if(UIDevice.current.orientation.isPortrait){
                frame = CGRect(x: 0, y: 0, width: cell.bounds.height * (UIScreen.main.bounds.width / UIScreen.main.bounds.height), height: cell.bounds.height)
            } else {
                frame = CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.width  * (UIScreen.main.bounds.height / UIScreen.main.bounds.width))
            }
            let pView = CellView(frame: frame, painting: painting)
            pView.center = CGPoint(x: 45, y: 45)
            pView.isUserInteractionEnabled = false
            pView.contentMode = .redraw
            cell.addSubview(pView)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        paintingsCollection_.selectPainting(index: indexPath.row)
    }
    
}

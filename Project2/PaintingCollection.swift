//
//  PaintingCollection.swift
//  Project2
//
//  Created by Bernard Cosgriff on 2/15/17.
//  Copyright © 2017 Bernard Cosgriff. All rights reserved.
//

import UIKit

protocol PaintingCollectionDelegate: class {
    func paintingSelected()
    func paintingRemoved(index: Int)
    func reloadPainting(index: Int)
}

class PaintingCollection {
    
    private var paintings_: [Painting] = []
    private var currentPaintingIndex_ = -1
    weak var delegate: PaintingCollectionDelegate? = nil
    
    func addPainting() {
        currentPaintingIndex_ = paintings_.count
        paintings_.append(Painting())
        delegate?.paintingSelected()
    }
    
    func removePainting() {
        paintings_.remove(at: currentPaintingIndex_)
        delegate?.paintingRemoved(index: currentPaintingIndex_)
        currentPaintingIndex_ = -1
    }
    
    func addStroke(stroke: Stroke){
        currentPainting.addStroke(stroke: stroke)
    }
    
    func selectPainting(index: Int){
        currentPaintingIndex_ = index
        delegate?.paintingSelected()
    }
    
    func getPainting(index: Int) -> Painting? {
        if(paintings_.count > index){
            return paintings_[index]
        }
        return nil
    }
    
    func refreshPainting(){
        delegate?.reloadPainting(index: currentPaintingIndex_)
    }
    
    var paintings: [Painting] {
        get {
            return paintings_
        }
    }
    
    var numPaintings: Int {
        get {
            return paintings_.count - 1
        }
    }
    
    var currentPainting: Painting {
        get{
            return paintings_[currentPaintingIndex_]
        }
    }
}


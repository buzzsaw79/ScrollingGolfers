//
//  playingGroupCell.swift
//  ScrollingGolfers
//
//  Created by Keith Bamford on 02/03/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import UIKit

typealias Handicap = NSDecimalNumber

class PlayingGroupCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cellSelectedCallPopupDelegate : CellSelectedCallPopupDelegate?
    
    var controller: UIViewController?
    
    var callCount = 0
    
        //MARK: - Properties and Outlets
    let golferCellID = "GolferCellId"
    
    let golfersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let golferCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        golferCollectionView.backgroundColor = UIColor.clear
        golferCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return golferCollectionView
    }()
    
    
    
    var golferArray = [GolferStruct]() {
        didSet {
            print("PGC golferArray SET: \(golferArray)")
        }
    }
    
        //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews()  {
        backgroundColor = UIColor.clear
        
        addSubview(golfersCollectionView)
        
        golfersCollectionView.dataSource = self
        golfersCollectionView.delegate = self
        
        golfersCollectionView.register(GolferCell.self, forCellWithReuseIdentifier: golferCellID)
        

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : golfersCollectionView] ))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : golfersCollectionView] ))
        
        golfersCollectionView.allowsSelection = true
 
    }

        //MARK: - UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: golferCellID, for: indexPath) as! GolferCell
        
        cell.golfer = self.golferArray[indexPath.item]
        
        
        callCount = callCount+1
        print("PGC CellForItem Call Count \(callCount)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width*0.22), height: self.frame.height*0.82)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("PGC Selected Item \(indexPath.row)")
        
        let cell = golfersCollectionView.cellForItem(at: indexPath) as! GolferCell
        
        self.cellSelectedCallPopupDelegate?.cellSelectedCallPopup(indexPath, cell.golfer!)
        
        
        
    }
}




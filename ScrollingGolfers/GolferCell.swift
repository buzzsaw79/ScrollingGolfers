//
//  GolferCell.swift
//  ScrollingGolfers
//
//  Created by Keith Bamford on 10/03/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import UIKit

var golferCount = 0

protocol CellSelectedCallPopupDelegate {
    func cellSelectedCallPopup(_ indexPath : IndexPath,_ golfer: GolferStruct)
}



class GolferCell: UICollectionViewCell {
    
    
    
    
    
    var golferImageView = UIImageView()
    var golferNameLabel: UILabel?
    var golferHandicapLabel: UILabel?
    
    
    
    var golfer: GolferStruct? {
        didSet {
            // Set format for Attributed strings
            let nameLabelAttributes = [ NSAttributedStringKey.foregroundColor: UIColor.darkText,
                                        NSAttributedStringKey.font: UIFont(name: "Damascus", size: 16.0)!]
            let handicapLabelAttributes = [ NSAttributedStringKey.foregroundColor: UIColor.richRed,
                                            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 24.0)!]
            let nameAttrString = NSAttributedString(string: (golfer?.name) ?? "Name", attributes: nameLabelAttributes)
            let handicapAttrString = NSAttributedString(string: String(describing: golfer!.handicap), attributes: handicapLabelAttributes)
            
            golferNameLabel?.attributedText = nameAttrString
            golferHandicapLabel?.attributedText = handicapAttrString
            
            golferImageView.image = golfer?.image//UIImage(named: "head\(golferCount)")
            golferCount += 1
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupViews() {
        backgroundColor = UIColor.white
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        
    
        
        golferImageView.image = golfer?.image
        
        golferImageView.layer.masksToBounds = true
        let origPt = CGPoint.zero          //(x: frame.width/2-frame.height/4 , y: 0)
        
        golferImageView.frame = CGRect(origin: origPt, size: CGSize(width: self.frame.width, height: frame.height/2))
//        golferImageView.contentMode = .scaleAspectFit
        golferImageView.contentMode = .scaleAspectFill
        golferImageView.clipsToBounds = true
        
//        golferImageView.layer.cornerRadius = golferImageView.frame.height/2
        
        var pt = CGPoint(x: 0, y: frame.height/2 + 4)
        golferNameLabel = UILabel(frame: CGRect(origin: pt, size: CGSize(width: frame.width, height: frame.height/4)))
        golferNameLabel?.numberOfLines = 2
        golferNameLabel?.adjustsFontSizeToFitWidth = true
        golferNameLabel?.baselineAdjustment = .alignCenters
        
        
        pt.y = frame.height*3/4
        golferHandicapLabel = UILabel(frame: CGRect(origin: pt, size: CGSize(width: frame.width, height: frame.height/4)))
        
        /*
        let nameLabelAttributes = [ NSForegroundColorAttributeName: UIColor.darkText,
                                    NSFontAttributeName: UIFont(name: "Damascus", size: 16.0)!]
        let handicapLabelAttributes = [ NSForegroundColorAttributeName: UIColor.richRed,
                                        NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 28.0)!]
        let nameAttrString = NSAttributedString(string: (self.golfer?.name) ?? "Name", attributes: nameLabelAttributes)
        let handicapAttrString = NSAttributedString(string: "", attributes: handicapLabelAttributes)
        
        golferNameLabel?.attributedText = nameAttrString
        golferHandicapLabel?.attributedText = handicapAttrString
        */
        
        
        
        addSubview(golferImageView)
        addSubview(golferNameLabel!)
        addSubview(golferHandicapLabel!)
        
        
        golferNameLabel?.textAlignment = NSTextAlignment.center
        golferHandicapLabel?.textAlignment = NSTextAlignment.center
    }
}

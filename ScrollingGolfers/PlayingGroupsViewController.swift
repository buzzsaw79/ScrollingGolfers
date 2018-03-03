//
//  PlayingGroupsViewController.swift
//  ScrollingGolfers
//
//  Created by Keith Bamford on 02/03/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import UIKit

var callCount = 0

class PlayingGroupsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CellSelectedCallPopupDelegate {

        //MARK: - Properties
    private let cellId = "playingGroupsCell"
    private let sectionHeaderCellId = "sectionHeaderCell"
    private let sectionFooterCellId = "sectionFooterCell"
    
    
    
    var golferArray:[GolferStruct] {
        let golferNames = ["Keith Bamford",
                           "Kenny Barratt",
                           "Alan Bromley",
                           "Bernard Bull",
                           "John Bolton",
                           "John Cashman",
                           "Graham Clarke",
                           "Mick Clarke",
                           "Dan DeAbreu",
                           "James DeAbreu",
                           "Mario DeAbreu",
                           "Steve DeAbreu",
                           "Steve Downs",
                           "Adrian Harding",
                           "Nigel Maqueline",
                           "Jeff Mabbitt",
                           "Jimmy Simms",
                           "Jimmy Sweeney"]
        let golferHandicaps:[Handicap] = [17.5, 17.1, 16.5, 26.1, 16.7, 16.4, 21.2, 17.8, 21.7, 25.5, 21.8, 16.2, 5.9, 11.4, 12.8, 13.8, 10.5, 18.4]
        var _golferArray = [GolferStruct]()
        
        if golferHandicaps.count == golferNames.count {
            for (index, golfer) in golferNames.enumerated() {
                let scoreDict = [String:Int]()
                let golferImage = UIImage(named: "head\(index)")
                let golferStruct = GolferStruct(name: golfer, handicap: golferHandicaps[index], image: golferImage, totalWinnings: 0, todaysWinnings: 0, scores: scoreDict)
//                let golferStruct = Golfer(name: golfer, handicap: golferHandicaps[index], totalWinnings: 0, todaysWinnings: 0)
                _golferArray.append(golferStruct)
            }
        }
        
        return _golferArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Lets Play!"
        

        collectionView?.backgroundColor = #colorLiteral(red: 0.6374318004, green: 0.7253503203, blue: 0.478941381, alpha: 1)
        
        collectionView?.register(PlayingGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(sectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderCellId)
        collectionView?.register(sectionFooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: sectionFooterCellId)

    }
        //MARK:- CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PlayingGroupCell
        cell.cellSelectedCallPopupDelegate = self
        
        let fourBall = getGolferGroups(section: indexPath.section)
        
        cell.golferArray = fourBall
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = UIColor.cadetBlue2
        } else {
           cell.backgroundColor = UIColor.seaGreen
       }
        
//        cell.backgroundColor = UIColor.eggShell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height/12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height/24)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        switch kind {
        case UICollectionElementKindSectionHeader:
            print("\(UICollectionElementKindSectionHeader)")
        case UICollectionElementKindSectionFooter:
            print("\(UICollectionElementKindSectionFooter)")
        default:
            print("Cell")
        }
        
        if kind == UICollectionElementKindSectionHeader {
            print("H E A D E R")
            
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderCellId, for: indexPath) as! sectionHeaderCell
            
            //            headerCell.backgroundColor = UIColor.blue
            let sectionHeaderString = "\(getGroupNumber(indexPath: indexPath)!) Group"
            
           // var conditionalAttributes = [String : NSObject]()
            
            var conditionalAttributes = [NSAttributedStringKey : Any]()
            
            
            
            if indexPath.section % 2 == 0 {
                headerCell.backgroundColor = UIColor.cadetBlue2
                conditionalAttributes = [ NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
                                          NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "Helvetica Neue", size: 24.0)!]
            } else {
                headerCell.backgroundColor = UIColor.seaGreen
                conditionalAttributes = [ NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
                                          NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "Helvetica Neue", size: 24.0)!]
            }
            
            
            let myAttributes = conditionalAttributes
            let myAttrString = NSAttributedString(string: sectionHeaderString, attributes: myAttributes)
            
            headerCell.sectionHeaderLabel?.attributedText = myAttrString
            
            return headerCell
        } else if kind == UICollectionElementKindSectionFooter {
            
            print("F O O T E R")
            
            
            let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: sectionFooterCellId, for: indexPath) as! sectionFooterCell
            
            if indexPath.section % 2 == 0 {
                footerCell.backgroundColor = UIColor.cadetBlue2
            } else {
                footerCell.backgroundColor = UIColor.seaGreen
            }
            return footerCell
        } else {
            return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }

        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height/4)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 2.0, left: 8.0, bottom: 2.0, right: 8.0)
//    }
        //MARK: - CellSelectedCallPopupDelegate
    func cellSelectedCallPopup(_ indexPath: IndexPath,_ golfer: GolferStruct) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let popup = sb.instantiateInitialViewController()! as! EnterScorePopupViewController
        
        popup.golfer = golfer
        print("CellSelectedCallPopupDelegate: IndexPath \(indexPath)")
        present(popup, animated: true, completion: nil)
    }
    
    
    
        //MARK: - Helper Functions
    
    private func getGroupNumber(indexPath: IndexPath) -> String? {
        
        switch indexPath.section {
        case 0: return "First"
        case 1: return "Second"
        case 2: return "Third"
        case 3: return "Forth"
        case 4: return "Fifth"
        default: return "\(indexPath.section + 1)th"
        }
        
    }
    
    private func getGolferGroups(section: Int) -> [GolferStruct] {
        callCount = callCount + 1
        
        var _golferArray = self.golferArray
        
        let aFour = golferArray.prefix(4)
        _golferArray.removeFirst(4)
        
        let anotherFour = _golferArray.prefix(4)
        _golferArray.removeFirst(4)
        
        let yetAnotherFour = _golferArray.prefix(4)
        _golferArray.removeFirst(4)
        
        let lastFour = _golferArray.prefix(4)
        
//        print("getGolfer()\(callCount)\n\t aFour  \(aFour)\n\n\t anotherFour \(anotherFour)\n\n\t yetAnotherFour\(yetAnotherFour)\n\n\t lastFour \(lastFour)\n\n")
        
        switch section {
        case 0:
            let fourBall1 = [GolferStruct](aFour) //Array<GolferStruct>(aFour)
            return fourBall1
        case 1:
            let fourBall2 = Array<GolferStruct>(anotherFour)
            return fourBall2
        case 2:
            let fourBall3 = Array<GolferStruct>(yetAnotherFour)
            return fourBall3
        case 3:
            let fourBall4 = Array<GolferStruct>(lastFour)
            return fourBall4
        default:
            return _golferArray
        }

    }
    
    private class sectionHeaderCell: UICollectionReusableView {
        
        var sectionHeaderLabel: UILabel?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            updateUI()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func updateUI() {
            
            sectionHeaderLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: frame.height)))
            addSubview(sectionHeaderLabel!)
            sectionHeaderLabel?.textAlignment = .center
            sectionHeaderLabel?.backgroundColor = UIColor.darkGray
            sectionHeaderLabel?.textColor = .white
            
        }
    }

    private class sectionFooterCell: sectionHeaderCell {
        
        override func updateUI() {
            sectionHeaderLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: frame.height)))
        }
    }
    
    
    
    
    
}



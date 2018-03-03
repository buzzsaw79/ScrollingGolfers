//
//  GolferStruct.swift
//  ScrollingGolfers
//
//  Created by Keith Bamford on 16/03/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import UIKit

struct GolferStruct {
    var name: String
    var handicap: Handicap
    var image: UIImage?
    
    var totalWinnings = 0
    
    var todaysWinnings: Int = 0 {
        willSet {
            self.totalWinnings = todaysWinnings + newValue
        }
    }
    
    var scores: [String:Int]?
    
}

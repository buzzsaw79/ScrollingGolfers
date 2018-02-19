//
//  UIColor+CustomColors.swift
//  tourKeeprNSDefaults
//
//  Created by Keith Bamford on 14/03/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //MARK: -
    //MARK: Hex Colours
    
    static var skyBlue2: UIColor {
        return UIColor(string: "#79BAEC")
    }
    
    static var seaGreen: UIColor {
        return UIColor(string: "#4E8975")
    }
    
    static var lightSeaGreen: UIColor {
        return UIColor(string: "#3EA99F")
    }
    
    static var steelBlue2: UIColor {
        return UIColor(string: "#56A5EC")
    }
    
    static var lightCyan2: UIColor {
        return UIColor(string: "#CFECEC")
    }
    
    static var cadetBlue2: UIColor {
        return UIColor(string: "#77BFC7")
    }

    //MARK: -
    //MARK: RGB Colours
    static var grassGreenColour: UIColor {
        return UIColor(red: 0.4, green: 0.54, blue: 0.19, alpha: 1.0) // Another Green
    }
    
    static var evenCellColour: UIColor {
        return UIColor(red: 0.958, green: 0.942, blue: 0.832, alpha: 0.8) // Oyster White
    }
    
    static var oddCellColour: UIColor {
        return UIColor(red: 0.537, green: 0.675, blue: 0.463, alpha: 1.0) // Pale Green
    }
    
    static var oddCellTextColour: UIColor {
        return UIColor(red: 0.958, green: 0.952, blue: 0.852, alpha: 1) // Green
    }
    
    static var evenCellTextColour: UIColor {
        return UIColor(red: 0.357, green: 0.495, blue: 0.283, alpha: 1.0) // Pale Green
    }
    
    static var footerColour: UIColor {
        return UIColor(red: 0.424, green: 0.443, blue: 0.337, alpha: 1.0) // Reed Green
    }
    
    static var nameLabelTextColour: UIColor {
        return UIColor(red: 0.8, green: 0.4, blue: 0.4, alpha: 1.0)
    }
    
    static var headerColour: UIColor {
        return UIColor(red:0.36, green:0.51, blue:0.54, alpha:1.0)
    }
    
    static var richRed: UIColor {
        return UIColor(red: 0.66, green: 0.12, blue: 0.09, alpha: 1.0)
    }

    static var eggShell: UIColor {
        return UIColor(red: 0.64, green: 0.77, blue: 0.79, alpha: 1.0)
    }
    static var doveSlate: UIColor {
        return UIColor(red: 0.67, green: 0.73, blue: 0.74, alpha: 1.0)
    }
    
    //MARK: -
    //MARK: Methods
    
    convenience init(string: String) {
        var chars = Array(string.hasPrefix("#") ? string.dropFirst() : string.suffix(6))
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        switch chars.count {
        case 3:
            chars = [chars[0], chars[0], chars[1], chars[1], chars[2], chars[2]]
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            alpha = 0
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
   
}



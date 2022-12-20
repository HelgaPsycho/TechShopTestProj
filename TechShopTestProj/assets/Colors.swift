//
//  Colors.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 20.12.2022.
//

import Foundation
import UIKit

extension UIColor {
    
    static var accentPeachColor: UIColor {
        UIColor(named: "peach") ?? UIColor.orange
    }
    
    static var accentIndigoColor: UIColor {
        UIColor(named: "indigo") ?? UIColor.black
    }
    
    static var accentLightIndigoColor: UIColor {
        UIColor(named: "lightIndigo") ?? UIColor.darkGray
    }
    
    static var backgroundGrayColor: UIColor {
        UIColor(named: "lightSilver") ?? UIColor.lightGray
    }
    
    static var backgroundWhiteColor: UIColor {
        UIColor.white
    }
    
    static var symbolsBlackColor: UIColor {
        UIColor.black
    }
    
    static var symbolsGrayColor: UIColor {
        UIColor(named: "darkSilver") ?? UIColor.darkGray
    }
    
    static var symbolWhiteColor: UIColor {
        UIColor.white
    }
    
}

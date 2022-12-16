//
//  ProductInformationViewModel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 16.12.2022.
//

import Foundation
import UIKit

class ProductInformationManager {
    
    func setRatingImage(rating: Double)-> UIImage {
        switch rating {
        case 4.8...  :
            return UIImage(named: "5stars.png")!
        case 4.3... :
            return UIImage(named: "4.5stars.png")!
        case 3.8... :
            return UIImage(named: "4stars.png")!
        case 3.3...:
            return UIImage(named: "3.5stars.png")!
        case 2.8... :
            return UIImage(named: "3.0stars.png")!
        case 2.3... :
            return UIImage(named: "2.5stars.png")!
        case 1.8...:
            return UIImage(named: "2.0stars.png")!
        case 1.3...:
            return UIImage(named: "1.5stars.png")!
        case 0.8...:
            return UIImage(named: "1.0stars.png")!
        case 0.3...:
            return UIImage(named: "0.5stars.png")!
        case 0.0... :
            return UIImage(named: "0stars.png")!
        default:
            return UIImage(named: "5stars.png")!
        }
    }
}


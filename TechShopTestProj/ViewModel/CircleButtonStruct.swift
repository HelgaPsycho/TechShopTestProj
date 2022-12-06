//
//  CircleButtonStruct.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 05.12.2022.
//

import Foundation
struct CircleBatton {
    enum circleButtonModel {
        case normal
        case selected
    }

    
    var imageString: String = "questionmark.square.dashed"
    
    var normalStateBackgroundColorString: String = "white"
    var normalStateImageColorString: String = "darkSilver"
    
    var selectedStateBackgroundColorString: String = "peach"
    var secectedStateImageColorString: String = "white"
    
}

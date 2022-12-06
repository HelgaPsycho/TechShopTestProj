//
//  CircleButtonViewModel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 06.12.2022.
//


import Foundation
import UIKit

public class CircleButtonViewModel: UIButton {
    
    public var circleButtonsArray: [UIButton] = []
    public var labelsUnderButtonsArray : [UILabel] = []
        
    public var backgroundCircleColor: UIColor { get {
        if self.state == .selected {
            return UIColor(named: "peach") ?? UIColor.orange
        } else {
            return UIColor(named: "white") ?? UIColor.white
        }
    }
    }
    
    public var pictureColor: UIColor {
        get {
            if self.state == .selected {
                return UIColor(named: "white") ?? UIColor.white
            } else {
                return UIColor(named: "darkSilver") ?? UIColor.darkGray
            }
        }
    }
    
    public var labelUnderButtonColor: UIColor {
        get {
            if self.state == .selected {
                return UIColor(named: "peach") ?? UIColor.orange
            } else {
                return UIColor.black
            }
        }
    }
    
    func circleButtonPressed (sender: UIButton!){
        for button in circleButtonsArray {
            button.isSelected = false
        }
        sender.isSelected = true
        }
    
    }



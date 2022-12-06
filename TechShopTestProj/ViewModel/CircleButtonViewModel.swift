//
//  CircleButtonViewModel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 06.12.2022.
//


import Foundation
import UIKit

public class CircleButtonViewModel: UIButton {
    
    public  static var circleButtonsArray: [CircleButtonViewModel] = []
    public var labelsUnderButtonsArray : [UILabel] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
    super.init(frame: CGRectZero)
        CircleButtonViewModel.circleButtonsArray.append(self)

    }

    public var backgroundCircleColor: UIColor { get {
        if self.isSelected == true {
            return UIColor(named: "peach") ?? UIColor.orange
        } else {
            return UIColor(named: "white") ?? UIColor.white
        }
    }
    }
    
    public var pictureColor: UIColor {
        get {
            if self.isSelected == true {
                return UIColor(named: "white") ?? UIColor.white
            } else {
                return UIColor(named: "darkSilver") ?? UIColor.darkGray
            }
        }
        set {
            self.currentImage?.withTintColor(newValue)
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
    
//    @objc func circleButtonPressed (sender: UIButton!){
//        for button in CircleButtonViewModel.circleButtonsArray {
//            button.isSelected = false
//            button.backgroundColor = backgroundCircleColor
//            button.currentImage?.withTintColor(pictureColor)
//        }
//        sender.isSelected = true
//        sender.backgroundColor = backgroundCircleColor
//        sender.currentImage?.withTintColor(pictureColor)
//        }
    
    }




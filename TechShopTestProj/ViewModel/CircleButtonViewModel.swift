//
//  CircleButtonViewModel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 06.12.2022.
//


import Foundation
import UIKit

//struct CircleButtonsCreater {
//
//    var sfSymbolsArray: [String] = ["iphone", "laptopcomputer", "waveform.path.ecg", "books.vertical"]
//    var labekUnderButtonsArray: String = ["Phones", "Computers", "Health", "Books"]
//
//    func createCircleButtonsArray()-> [CircleButtonViewModel]{
//        for symbol in sfSymbolsArray {
//            var button = CircleButtonViewModel()
//            let imageColorConfig = UIImage.SymbolConfiguration(paletteColors: [button.pictureColor])
//            button.im
//
//        }
//    }
//
//}
//
//var buttonImage = image
//let color = UIColor(named: "darkSilver")
//let colorConfig = UIImage.SymbolConfiguration(paletteColors: [color!])
//let sizeConfig = UIImage.SymbolConfiguration(scale: .large)
//buttonImage  = buttonImage.withConfiguration(sizeConfig)
//buttonImage = buttonImage.withConfiguration(colorConfig)
//button.backgroundColor = .white
//button.layer.cornerRadius = 35
//button.translatesAutoresizingMaskIntoConstraints = false
//button.widthAnchor.constraint(equalToConstant: 70).isActive = true
//button.heightAnchor.constraint(equalToConstant: 70).isActive = true
//button.setImage(buttonImage, for: .normal)

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




//
//  UIButtons.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 15.12.2022.
//

import UIKit
extension UIButton {
    
    func getBigOrangeButton(named title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        button.titleLabel?.textAlignment = .center
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return button
    }
}

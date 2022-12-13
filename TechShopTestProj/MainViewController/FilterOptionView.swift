//
//  FilterOptionView.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 10.12.2022.
//

import UIKit
import SwiftDropdown

class FilterOptionView: UIView {
    
    lazy var dropDownTitlesArray: [String] = ["Brand", "Price", "Size"]
    lazy var brandDropdownList: [String] = ["Apple", "Sumsung", "Xiaomy"]
    lazy var priceDropdownList: [String] = ["$0 - $100", "$100 - $300", "$300 - $500", "$500 - $1000"]
    lazy var sizeDropdownList: [String] = []
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "cross.png"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant:  40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    var filterOptionsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Filter Options"
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        return label
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.white
        label.text = "Done"
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        button.addSubview(label)
        
        button.widthAnchor.constraint(equalToConstant:  100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    
    
    lazy var brandLabel: UILabel = getLabelWith(title: dropDownTitlesArray[0])
    lazy var priceLabel: UILabel = getLabelWith(title: dropDownTitlesArray[1])
    lazy var sizeLabel: UILabel = getLabelWith(title: dropDownTitlesArray[2])
    
    private func getLabelWith(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = title
        label.textAlignment = .left
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        return label
    }
    
    lazy var brandDropdown: SwiftDropdown = getDropdownWith(name: dropDownTitlesArray[0], itemsArray: brandDropdownList)
    lazy var priceDropdown: SwiftDropdown = getDropdownWith(name: dropDownTitlesArray[1], itemsArray: priceDropdownList)
    lazy var sizeDropdown: SwiftDropdown = getDropdownWith(name: dropDownTitlesArray[2], itemsArray: sizeDropdownList)
    
    private func getDropdownWith(name: String, itemsArray: [String])-> SwiftDropdown {
        let dropdown = SwiftDropdown()
        dropdown.placeholderText = name
        dropdown.options = itemsArray
        dropdown.placeholderFont = UIFont(name: "MarkPro-Regular", size: 18)
        dropdown.placeholderColor = UIColor.black
        dropdown.arrowImage = UIImage(named: "downArrow")
        dropdown.arrowPosition = .right
        dropdown.borderWidth = 1
        //        dropdown.layer.masksToBounds = true
        //        dropdown.layer.cornerRadius = 10 - работает не коректно
        dropdown.borderColor = UIColor(named: "lightGray")?.cgColor ?? UIColor.lightGray.cgColor
        dropdown.disableArrowAnimation = false
        dropdown.itemsFont = UIFont(name: "MarkPro-Regular", size: 18)
        dropdown.itemsTextColor = UIColor.black
        dropdown.checkmarkColor = UIColor(named: "darkSilver") ?? UIColor.darkGray
        dropdown.selectedItemBackgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
        // dropdown.dropdownHeight = 40
        dropdown.dropdownExtraSpace = 450 // placeholder frame высчитывается от  родительской вьюшки, а options - от всего контроллера. TODO - оптимизировать без константых значений
        
        return dropdown
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        brandDropdown.delegate = self
        priceDropdown.delegate = self
        priceDropdown.delegate = self
        setupHierarhy()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupHierarhy(){
        self.addSubview(cancelButton)
        self.addSubview(doneButton)
        self.addSubview(filterOptionsTitle)
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(brandLabel)
        verticalStackView.addArrangedSubview(brandDropdown)
        verticalStackView.addArrangedSubview(priceLabel)
        verticalStackView.addArrangedSubview(priceDropdown)
        verticalStackView.addArrangedSubview(sizeLabel)
        verticalStackView.addArrangedSubview(sizeDropdown)
        
    }
    
    
    private func setupConstraints(){
        cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        
        doneButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        doneButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        filterOptionsTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        filterOptionsTitle.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor).isActive = true
        
        verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant:  10).isActive = true
        
        brandDropdown.rightAnchor.constraint(equalTo: verticalStackView.rightAnchor).isActive = true
        brandDropdown.leftAnchor.constraint(equalTo: verticalStackView.leftAnchor).isActive = true
        
        priceDropdown.rightAnchor.constraint(equalTo: verticalStackView.rightAnchor).isActive = true
        priceDropdown.leftAnchor.constraint(equalTo: verticalStackView.leftAnchor).isActive = true
        
        sizeDropdown.rightAnchor.constraint(equalTo: verticalStackView.rightAnchor).isActive = true
        sizeDropdown.leftAnchor.constraint(equalTo: verticalStackView.leftAnchor).isActive = true
    }
    
    @objc func cancelButtonPressed(sender: UIButton) {
        removeFromSuperview()
    }
    
    @objc func doneButtonPressed(sender: UIButton){
        //TODO запрос API ?
        
        removeFromSuperview()
    }
    
}


// РАСШИРЕНИЯ ДЛЯ ПЕРЕДАЧИ ДАННЫХ ИЗ DROPDOWN
extension FilterOptionView: SwiftDropdownDelegate {
    func dropdownItemSelected(index: Int, item: String) {
        print("\(item) selected")
        // TODO API
    }

}

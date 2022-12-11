//
//  FilterOptionView.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 10.12.2022.
//

import UIKit

class FilterOptionView: UIView {
    
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
        stackView.backgroundColor = .yellow
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Brand"
        label.textAlignment = .left
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Price"
        label.textAlignment = .left
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        return label
    }()
    
    var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Size"
        label.textAlignment = .left
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
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
        
        verticalStackView.addArrangedSubview(priceLabel)
        
        verticalStackView.addArrangedSubview(sizeLabel)

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
        
       
    }
    
    @objc func cancelButtonPressed(sender: UIButton) {
        removeFromSuperview()
    }
    
    @objc func doneButtonPressed(sender: UIButton){
        //TODO запрос API

        removeFromSuperview()
    }


}

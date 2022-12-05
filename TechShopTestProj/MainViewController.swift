//
//  ViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 04.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - initialized elements
    
    private lazy var selectCategoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hotSalesView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkSilver")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bestSellerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var explorerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "indigo")
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "lightSilver")
        view.addSubview(selectCategoryView)
        setupSelectCategoryView()
        view.addSubview(hotSalesView)
        setupHotSalesView()
        view.addSubview(bestSellerView)
        setupBestSellersView()
        view.addSubview(explorerView)
        setupExplorerView()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    // MARK: - setup elements
    
    //MARK:  - setup select category view
    
    func setupSelectCategoryView() {
        selectCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        selectCategoryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        selectCategoryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        selectCategoryView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/10).isActive = true
        
        selectCategoryView.addSubview(selectCategoryLabel)
        setupTitleLabels(label: selectCategoryLabel)
        setupSelectCategoryLabelConstraints()
        selectCategoryView.addSubview(filterButton)
        setupFilterButtonConstraints ()
        selectCategoryView.addSubview(buttonsStackView)
        setupButtonsStackViewConstrains()
        buttonsStackView.addArrangedSubview(circle1)
        setupCircleButton(button: circle1, image: UIImage(systemName: "iphone")!)
        buttonsStackView.addArrangedSubview(circle2)
        setupCircleButton(button: circle2, image: UIImage(systemName: "laptopcomputer")!)
        buttonsStackView.addArrangedSubview(circle3)
        setupCircleButton(button: circle3, image: UIImage(systemName: "waveform.path.ecg")!)
        buttonsStackView.addArrangedSubview(circle4)
        setupCircleButton(button: circle4, image: UIImage(systemName: "books.vertical")!)
        selectCategoryView.addSubview(labelsHorizontalStackView)
        setuplabelsHorizontalStackView()
        labelsHorizontalStackView.addArrangedSubview(phoneLabel)
        setupLabelsUnderButtons(label: phoneLabel)
        labelsHorizontalStackView.addArrangedSubview(computerLabel)
        setupLabelsUnderButtons(label: computerLabel)
        labelsHorizontalStackView.addArrangedSubview(healthLabel)
        setupLabelsUnderButtons(label: healthLabel)
        labelsHorizontalStackView.addArrangedSubview(booksLabel)
        setupLabelsUnderButtons(label: booksLabel)
    
    }
    
    
    private lazy var selectCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupSelectCategoryLabelConstraints () {
        selectCategoryLabel.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor).isActive = true
        selectCategoryLabel.topAnchor.constraint(equalTo: selectCategoryView.topAnchor).isActive = true
        selectCategoryLabel.widthAnchor.constraint(equalTo: selectCategoryView.widthAnchor, multiplier: 3/4).isActive = true
        selectCategoryLabel.heightAnchor.constraint(equalTo: selectCategoryView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "filter.png"), for: .normal)
        return button
    }()
    
    func setupFilterButtonConstraints () {
        filterButton.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor, constant: -4).isActive = true
        filterButton.centerYAnchor.constraint(equalTo: selectCategoryLabel.centerYAnchor).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 11).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
    
    }
    
    private lazy var buttonsStackView: UIStackView  = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
        
    }()
    
    private func setupButtonsStackViewConstrains() {
        buttonsStackView.centerYAnchor.constraint(equalTo: selectCategoryView.centerYAnchor).isActive = true
        buttonsStackView.heightAnchor.constraint(equalTo: selectCategoryView.heightAnchor, multiplier: 1/3).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor, constant: -8).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor, constant: 8).isActive = true
    }
    

    var circle1: UIButton = {
        var button = UIButton()
        return button
    }()
    
    var circle2: UIButton = {
        var button = UIButton()
        return button
    }()
    
    var circle3: UIButton = {
        var button = UIButton()
        return button
    }()
    
    var circle4: UIButton = {
        var button = UIButton()
        return button
    }()
    
    var labelsHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        return stackView
        
    }()
    
    private func setuplabelsHorizontalStackView() {
        labelsHorizontalStackView.bottomAnchor.constraint(equalTo: selectCategoryView.bottomAnchor).isActive = true
        labelsHorizontalStackView.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor).isActive = true
        labelsHorizontalStackView.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor).isActive = true
        labelsHorizontalStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10).isActive = true
        
    }
    
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phones"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var computerLabel: UILabel = {
        let label = UILabel()
        label.text = "Computer"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var healthLabel: UILabel = {
        let label = UILabel()
        label.text = "Health"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var booksLabel: UILabel = {
        let label = UILabel()
        label.text = "Books"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupTitleLabels (label: UILabel) {
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Select Category"
        label.font = UIFont(name: "MarkPro-Heavy", size: 25)
    }
    
    func setupLabelsUnderButtons (label: UILabel){
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "MarkPro-Medium", size: 12)
    }
    
    //MARK: - setup hot sales view
    
    func  setupHotSalesView() {
        hotSalesView.topAnchor.constraint(equalTo: selectCategoryView.bottomAnchor, constant: 0).isActive = true
        hotSalesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        hotSalesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        hotSalesView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/10).isActive = true
    }
    
    func setupBestSellersView() {
        bestSellerView.topAnchor.constraint(equalTo: hotSalesView.bottomAnchor, constant: 0).isActive = true
        bestSellerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        bestSellerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        bestSellerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/10).isActive = true
    }
    
    func setupExplorerView() {
        explorerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        explorerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        explorerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        explorerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    func  setupCircleButton(button: UIButton, image: UIImage){
        var buttonImage = image
        let color = UIColor(named: "darkSilver")
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [color!])
        let sizeConfig = UIImage.SymbolConfiguration(scale: .large)
        buttonImage  = buttonImage.withConfiguration(sizeConfig)
        buttonImage = buttonImage.withConfiguration(colorConfig)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.setImage(buttonImage, for: .normal)
    }

}


extension MainViewController {

}

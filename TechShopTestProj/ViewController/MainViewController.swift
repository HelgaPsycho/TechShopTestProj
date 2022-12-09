//
//  ViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 04.12.2022.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    
   // var hotSalesAndBestSellersManager = HotSalesAndBAstSellersManager()
    var pictureManager = PictureManager()
   // var hotSalesModelArray: [HotSalesModel] = []
   // var bestSalesModelArray: [BestSellersModel] = []
    lazy var picture = UIImage()
    
    //Carousel
    let urls: [URL] = [
    URL(string: "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both")!,
    URL(string: "https://cdn-2.tstatic.net/kupang/foto/bank/images/pre-order-samsung-galaxy-a71-laris-manis-inilah-rekomendasi-ponsel-harga-rp-6-jutaan.jpg")!,
    URL(string: "https://static.digit.in/default/942998b8b4d3554a6259aeb1a0124384dbe0d4d5.jpeg")!
    ]
    
    
   lazy var carousel = Carousel(frame: .zero, urls: urls)
   // lazy var carousel = Carousel(frame: .zero, urls: urls, hotSales: hotSalesModelArray)
    // MARK: - initialized elements
    
    private lazy var selectCategoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hotSalesView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
    //    hotSalesAndBestSellersManager.delegate = self
      //  hotSalesAndBestSellersManager.fetchHotSales()
        view.backgroundColor = UIColor(named: "lightSilver")
        view.addSubview(selectCategoryView)
        setupSelectCategoryView()
        view.addSubview(hotSalesView)
        setupHotSalesView()
        view.addSubview(bestSellerView)
        setupBestSellersView()
        view.addSubview(explorerView)
        setupExplorerView()
        
//        pictureManager.delegate = self
//        pictureManager.fetchHotSales(pictureURL: //"https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both")
        
        //Carousel
        setupHierarchy()
        setupComponents()
        setupConstraints()
    
    
    }
    
    //Carousel
    override func loadView() {
     //   hotSalesAndBestSellersManager.fetchHotSales()
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
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
        
        addAndSetupCirclesToButtonStackView()
        
        selectCategoryView.addSubview(labelsHorizontalStackView)
        setuplabelsHorizontalStackView()
        
        labelsHorizontalStackView.addArrangedSubview(phoneLabel)
        
        labelsHorizontalStackView.addArrangedSubview(computerLabel)
        
        labelsHorizontalStackView.addArrangedSubview(healthLabel)
       
        labelsHorizontalStackView.addArrangedSubview(booksLabel)

        setupLabelsUnderButtons ()
        

    }
    
    
    private lazy var selectCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Category"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "filter.png"), for: .normal)
        return button
    }()
    
    private func setupSelectCategoryLabelConstraints () {
        selectCategoryLabel.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor).isActive = true
        selectCategoryLabel.topAnchor.constraint(equalTo: selectCategoryView.topAnchor).isActive = true
        selectCategoryLabel.widthAnchor.constraint(equalTo: selectCategoryView.widthAnchor, multiplier: 3/4).isActive = true
        selectCategoryLabel.heightAnchor.constraint(equalTo: selectCategoryView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
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
    
    lazy var circle1: CircleButtonViewModel = {
        var button = CircleButtonViewModel()
        //button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var circle2: CircleButtonViewModel = {
        var button = CircleButtonViewModel()
       // button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var circle3: CircleButtonViewModel = {
        var button = CircleButtonViewModel()
      //  button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var circle4: CircleButtonViewModel = {
        var button = CircleButtonViewModel()
      //  button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(circleButtonPressed), for: .touchUpInside)
        return button
    }()

    
    var circleButtonsArray: [UIButton] = []
    var symbolsForButtonsArray: [String] = []
    
    
    func addAndSetupCirclesToButtonStackView(){
        var index = 0
        
        circleButtonsArray = [circle1, circle2, circle3, circle4]
        symbolsForButtonsArray = ["iphone", "laptopcomputer", "waveform.path.ecg", "books.vertical"]
        
        for button in circleButtonsArray {
            buttonsStackView.addArrangedSubview(button)
            setupCircleButton(button: button, image: (UIImage(systemName: symbolsForButtonsArray[index]) ?? UIImage(systemName:  "questionmark.square.dashed"))!)
            index += 1
        }
        
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
    
    var labelsUnderButtonsArray: [UILabel] = []
    
    func setupTitleLabels (label: UILabel) {
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "MarkPro-Heavy", size: 25)
    }
    
    func setupLabelsUnderButtons (){
        labelsUnderButtonsArray = [phoneLabel, computerLabel, healthLabel, booksLabel]
        for label in labelsUnderButtonsArray {
            label.textAlignment = .center
            label.textColor = .black
            label.font = UIFont(name: "MarkPro-Medium", size: 12)
        }
    }
    
    //MARK: - setup constraints
    
    
    private func  setupHotSalesView() {
        hotSalesView.topAnchor.constraint(equalTo: selectCategoryView.bottomAnchor, constant: 0).isActive = true
        hotSalesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        hotSalesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        hotSalesView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2/10).isActive = true
    }
    
    
    private func setupBestSellersView() {
        bestSellerView.topAnchor.constraint(equalTo: hotSalesView.bottomAnchor, constant: 0).isActive = true
        bestSellerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        bestSellerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        bestSellerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/10).isActive = true
    }
    
    private func setupExplorerView() {
        explorerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        explorerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        explorerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        explorerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    //MARK: - BUTTONS FUNCS

    
    @objc func circleButtonPressed (sender: CircleButtonViewModel){
        for button in CircleButtonViewModel.circleButtonsArray {
            button.isSelected = false
            button.backgroundColor = button.backgroundCircleColor
            sender.setImage(sender.currentImage?.withTintColor(button.pictureColor, renderingMode: .alwaysOriginal), for: .selected)
        }
        sender.isSelected = true
        sender.backgroundColor = sender.backgroundCircleColor
        sender.setImage(sender.currentImage?.withTintColor(sender.pictureColor, renderingMode: .alwaysOriginal), for: .selected)
        }

    

}


extension MainViewController {

}

//MARK: - HotSalesAndBestSellersManagerDelegate

extension MainViewController: HotSalesAndBestSellersManagerDelegate {

    
    func didUpdateBestSellers(_ hotSalesAndBestSellersManager: HotSalesAndBAstSellersManager, bestSellers: [BestSellersModel]) {
        DispatchQueue.main.async {//[self] in
//            for i in bestSellers {
//                print (i)
//
//            }
       //     bestSalesModelArray = bestSellers
        }
    }
    

    func didUpdateHotSales(_ hotSalessManager: HotSalesAndBAstSellersManager, hotSales: [HotSalesModel])
    {
        DispatchQueue.main.async { [self] in
//            for i in hotSales {
//                print (i)
//
//            }
//            hotSalesModelArray = hotSales
//            print(hotSalesModelArray)
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension MainViewController: PictureManagerDelegate {
    
    func didUpdatePicture(_ pictureManager: PictureManager, picture: UIImage) {
        self.picture = picture
    }
}


//MARK: - CAROUSEL EXT

extension MainViewController {
    
    func setupHierarchy() {
        self.view.addSubview(carousel)
    }
    
    func setupComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            carousel.rightAnchor.constraint(equalTo: hotSalesView.rightAnchor),
            carousel.leftAnchor.constraint(equalTo: hotSalesView.leftAnchor),
            carousel.bottomAnchor.constraint(equalTo: hotSalesView.bottomAnchor),
            carousel.topAnchor.constraint(equalTo: hotSalesView.topAnchor)
        
        ])
    }
    
}

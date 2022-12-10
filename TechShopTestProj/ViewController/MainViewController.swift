//
//  ViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 04.12.2022.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    lazy var carousel = Carousel(frame: .zero)
    var managerAPI = HotSalesAndBAstSellersManager()
    
    var bestSellersArray: [BestSellersModel] = []
    var hotSalesArray: [HotSalesModel] = []

    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
        static let itemHeight: CGFloat = 230.0
    }


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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerAPI.delegate = self
        managerAPI.fetchHotSales()
        view.backgroundColor = UIColor(named: "lightSilver")
        view.addSubview(selectCategoryView)
        setupSelectCategoryView()
        view.addSubview(hotSalesView)
        setupHotSalesView()
        view.addSubview(bestSellerView)
        setupBestSellersView()
        bestSellerView.addSubview(bestSellersLabel)
        setupTitleLabels(label: bestSellersLabel)
        setupBestSellersLabelContstraints()
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BestSellersCell.self, forCellWithReuseIdentifier: BestSellersCell.identifier)
        
        setupHierarchy()
        setupComponents()
        setupConstraints()
    
        collectionView.reloadData()
    
    }
    
    //Carousel
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
    }
   
    
    // MARK: - setup elements
    
    //MARK:  - setup select category view
    
    func setupSelectCategoryView() {
        
        setupSelectCategoryConstraints()
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

    
    private lazy var buttonsStackView: UIStackView  = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
        
    }()
    
    
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
    
    var bestSellersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Best Sellers"
        return label
        
    }()
    
    
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
    
    
    private func setupSelectCategoryConstraints(){
        
        selectCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        selectCategoryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        selectCategoryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        selectCategoryView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/10).isActive = true
    }
    
    private func setupSelectCategoryLabelConstraints () {
        selectCategoryLabel.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor).isActive = true
        selectCategoryLabel.topAnchor.constraint(equalTo: selectCategoryView.topAnchor).isActive = true
        selectCategoryLabel.widthAnchor.constraint(equalTo: selectCategoryView.widthAnchor, multiplier: 3/4).isActive = true
        selectCategoryLabel.heightAnchor.constraint(equalTo: selectCategoryView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private func setupFilterButtonConstraints () {
        filterButton.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor, constant: -4).isActive = true
        filterButton.centerYAnchor.constraint(equalTo: selectCategoryLabel.centerYAnchor).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 11).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
    
    }
    
    private func setupButtonsStackViewConstrains() {
        buttonsStackView.centerYAnchor.constraint(equalTo: selectCategoryView.centerYAnchor).isActive = true
        buttonsStackView.heightAnchor.constraint(equalTo: selectCategoryView.heightAnchor, multiplier: 1/3).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor, constant: -10).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor, constant: 10).isActive = true
    }
    
    private func setuplabelsHorizontalStackView() {
        labelsHorizontalStackView.bottomAnchor.constraint(equalTo: selectCategoryView.bottomAnchor).isActive = true
        labelsHorizontalStackView.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor).isActive = true
        labelsHorizontalStackView.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor).isActive = true
        labelsHorizontalStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10).isActive = true
        
    }
    private func  setupHotSalesView() {
        hotSalesView.topAnchor.constraint(equalTo: selectCategoryView.bottomAnchor, constant: 0).isActive = true
        hotSalesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        hotSalesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        hotSalesView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2/10).isActive = true
    }
    
    
    private func setupBestSellersView() {
        bestSellerView.topAnchor.constraint(equalTo: hotSalesView.bottomAnchor, constant: 0).isActive = true
        bestSellerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        bestSellerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        bestSellerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    
    }
    
    private func setupBestSellersLabelContstraints() {
        bestSellersLabel.topAnchor.constraint(equalTo: bestSellerView.topAnchor).isActive = true
        bestSellersLabel.rightAnchor.constraint(equalTo: bestSellerView.rightAnchor).isActive = true
        bestSellersLabel.leftAnchor.constraint(equalTo: bestSellerView.leftAnchor).isActive = true
        bestSellersLabel.heightAnchor.constraint(equalTo: bestSellerView.heightAnchor, multiplier: 4/30).isActive = true
        
        
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

//MARK: - CAROUSEL EXT  + BEST SELLERS COLLECTION VIEW SETUP

extension MainViewController {
    
    private func setupHierarchy() {
        self.view.addSubview(carousel)
    
    }
    
    private func setupComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 10
        
        collectionView.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            carousel.rightAnchor.constraint(equalTo: hotSalesView.rightAnchor),
            carousel.leftAnchor.constraint(equalTo: hotSalesView.leftAnchor),
            carousel.bottomAnchor.constraint(equalTo: hotSalesView.bottomAnchor),
            carousel.topAnchor.constraint(equalTo: hotSalesView.topAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
            collectionView.rightAnchor.constraint(equalTo: bestSellerView.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: bestSellerView.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bestSellerView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: bestSellersLabel.bottomAnchor)
         ])
        
        
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //   print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
       }
    
}

    extension MainViewController: UICollectionViewDataSource {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // the number of cells are wholly dependent on the number of colours
            return bestSellersArray.count
        }



        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            print("COLLECTIONVIEW CELL FOR ITEM CALLED")

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellersCell.identifier, for: indexPath) as! BestSellersCell
            let product = bestSellersArray[indexPath.row]
            cell.setup(with: product)
            return cell


        }

    }


extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: 0)

        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        let boarderSpasing: CGFloat = 10
        let totalSpacing: CGFloat = ((itemsInRow - 1) * spacing) + (boarderSpasing * 2)
        let finalWidth = ((width - totalSpacing) / itemsInRow)

        return finalWidth - 5
    }
    
    
}

extension MainViewController: HotSalesAndBestSellersManagerDelegate {
    func didUpdateHotSales(_ hotSalessManager: HotSalesAndBAstSellersManager, hotSales: [HotSalesModel]) {
        
        hotSalesArray = hotSales
        carousel.getHotSalesArray(hotSalesArray)
    }
    
    func didUpdateBestSellers(_ hotSalesAndBestSellersManager: HotSalesAndBAstSellersManager, bestSellers: [BestSellersModel]){
        
        DispatchQueue.main.async { [self] in
        
            bestSellersArray = bestSellers
            collectionView.reloadData()
        
            
        }
    }
    func didFailWithError(error: Error){}
}

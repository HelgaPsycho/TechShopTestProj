//
//  ViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 04.12.2022.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    public weak var delegate: MainViewControllerDelegate?
    
    var managerAPI = HotSalesAndBAstSellersManager()
    
    var bestSellersArray: [BestSellersModel] = []
    var hotSalesArray: [HotSalesModel] = []
    
    private lazy var selectCategoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        button.addTarget(self, action: #selector(filterButtonPresssed), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var phonesButton: UIButton = getCircleButton(with: "Phones",and: UIImage(systemName: "iphone")!)
    lazy var computersButton: UIButton = getCircleButton(with: "Computer", and: UIImage(systemName: "laptopcomputer")!)
    lazy var healthButton: UIButton = getCircleButton(with: "Health", and: UIImage(systemName: "waveform.path.ecg")!)
    lazy var booksButton: UIButton = getCircleButton(with: "Books", and: UIImage(systemName: "books.vertical")!)
    lazy var toolsButton: UIButton = getCircleButton(with: "Tools", and: UIImage(systemName: "wrench.and.screwdriver")!)
    
    private var buttonsArrray: [UIButton] = []
    
    private lazy var hotSalesView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var carousel = Carousel(frame: .zero)
    
    private lazy var bestSellerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bestSellersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Best Sellers"
        return label
        
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
        static let itemHeight: CGFloat = 230.0
    }

    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerAPI.delegate = self
        managerAPI.fetchHotSales()
        
        view.backgroundColor = UIColor(named: "lightSilver")
        
        view.addSubview(selectCategoryView)
        view.addSubview(hotSalesView)
        view.addSubview(carousel)
        view.addSubview(bestSellerView)
        view.addSubview(collectionView)
    
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BestSellersCell.self, forCellWithReuseIdentifier: BestSellersCell.identifier)
        
        setupComponents()
        setupHierarchy()
        setupConstraints()
        
        collectionView.reloadData()
        
    }
    
    //Carousel
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
    }
    
    private func setupComponents() {
        
        setupTitleLabels(label: selectCategoryLabel)
        setupTitleLabels(label: bestSellersLabel)
        
        phonesButton.isSelected = true
        phonesButton.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        
        carousel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
    }
    
    private func setupHierarchy() {
        
        selectCategoryView.addSubview(selectCategoryLabel)
        selectCategoryView.addSubview(filterButton)
        selectCategoryView.addSubview(buttonsScrollView)
        selectCategoryView.addSubview(buttonsScrollView)
        
        selectCategoryView.addSubview(buttonsScrollView)
        buttonsScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(phonesButton)
        scrollContentView.addSubview(computersButton)
        scrollContentView.addSubview(healthButton)
        scrollContentView.addSubview(booksButton)
        scrollContentView.addSubview(toolsButton)
        
        bestSellerView.addSubview(bestSellersLabel)


    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            selectCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            selectCategoryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            selectCategoryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            selectCategoryView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/10),
            
            selectCategoryLabel.leftAnchor.constraint(equalTo: selectCategoryView.leftAnchor),
            selectCategoryLabel.topAnchor.constraint(equalTo: selectCategoryView.topAnchor),
            selectCategoryLabel.widthAnchor.constraint(equalTo: selectCategoryView.widthAnchor, multiplier: 3/4),
            selectCategoryLabel.heightAnchor.constraint(equalTo: selectCategoryView.heightAnchor, multiplier: 1/3),
            
            filterButton.rightAnchor.constraint(equalTo: selectCategoryView.rightAnchor, constant: -4),
            filterButton.centerYAnchor.constraint(equalTo: selectCategoryLabel.centerYAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 11),
            filterButton.heightAnchor.constraint(equalToConstant: 13),

            buttonsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsScrollView.bottomAnchor.constraint(equalTo: selectCategoryView.bottomAnchor),
            buttonsScrollView.topAnchor.constraint(equalTo: selectCategoryLabel.bottomAnchor),
            
            scrollContentView.leadingAnchor.constraint(equalTo: buttonsScrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: buttonsScrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: buttonsScrollView.bottomAnchor),
            scrollContentView.topAnchor.constraint(equalTo: buttonsScrollView.topAnchor),
            
            scrollContentView.heightAnchor.constraint(equalTo: buttonsScrollView.heightAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: buttonsScrollView.widthAnchor, multiplier: 1.2)
        

        ])
        var leftAnchor = scrollContentView.leftAnchor
        for button in buttonsArrray {
            button.centerYAnchor.constraint(equalTo: scrollContentView.centerYAnchor, constant: -20).isActive = true
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
            leftAnchor = button.rightAnchor
        }
        
   
        NSLayoutConstraint.activate([
            hotSalesView.topAnchor.constraint(equalTo: selectCategoryView.bottomAnchor, constant: 0),
            hotSalesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            hotSalesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            hotSalesView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2/10),
            
            carousel.rightAnchor.constraint(equalTo: hotSalesView.rightAnchor),
            carousel.leftAnchor.constraint(equalTo: hotSalesView.leftAnchor),
            carousel.bottomAnchor.constraint(equalTo: hotSalesView.bottomAnchor),
            carousel.topAnchor.constraint(equalTo: hotSalesView.topAnchor),
        
            bestSellerView.topAnchor.constraint(equalTo: hotSalesView.bottomAnchor, constant: 0),
            bestSellerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            bestSellerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            bestSellerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            bestSellersLabel.topAnchor.constraint(equalTo: bestSellerView.topAnchor),
            bestSellersLabel.rightAnchor.constraint(equalTo: bestSellerView.rightAnchor),
            bestSellersLabel.leftAnchor.constraint(equalTo: bestSellerView.leftAnchor),
            bestSellersLabel.heightAnchor.constraint(equalTo: bestSellerView.heightAnchor, multiplier: 4/30),
            
            collectionView.rightAnchor.constraint(equalTo: bestSellerView.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: bestSellerView.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bestSellerView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: bestSellersLabel.bottomAnchor)
         ])
        
        
    }
    
    
    
//MARK: - SETUP OBJECTS FUNC
    
    private func setupTitleLabels (label: UILabel) {
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "MarkPro-Heavy", size: 25)
    }

    
    private func  getCircleButton(with title: String, and image: UIImage)-> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let normalColorConfig = UIImage.SymbolConfiguration(paletteColors: [UIColor(named: "darkSilver") ?? UIColor.darkGray])
        let normalImage = image.withConfiguration(normalColorConfig)
        button.setImage(normalImage, for: .normal)
        let selectedColorConfig = UIImage.SymbolConfiguration(paletteColors: [UIColor.white])
        let selectedImage = image.withConfiguration(selectedColorConfig)
        button.setImage(selectedImage, for: .selected)
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor(named: "peach"), for: .selected)
        button.titleLabel?.font = UIFont(name: "MarkPro-Medium", size: 12)
        button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        //button.layer.masksToBounds = true
        button.layer.cornerRadius = 35
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.titleLabel?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        button.titleLabel?.topAnchor.constraint(equalTo: button.bottomAnchor,constant: 10).isActive = true
        buttonsArrray.append(button)
        button.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        
        return button
    }
    
    //MARK: - OBJC BUTTONS FUNCS
    
    
    @objc private func categoryButtonPressed (sender: UIButton){
        for button in buttonsArrray {
            button.isSelected = false
            button.backgroundColor = .white
        }
        sender.isSelected = true
        sender.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
    }
    
    @objc private func filterButtonPresssed(sender: UIButton){
        filterOptionCalled()
        
    }
    
}


//MARK: - extension FilterOptionView CALLED

extension MainViewController {

    
   private func filterOptionCalled () {
        let filterOptionView = FilterOptionView()
        
        view.addSubview(filterOptionView)
        view.bringSubviewToFront(filterOptionView)

        filterOptionView.leftAnchor.constraint(equalTo: bestSellerView.leftAnchor, constant: -8).isActive = true
        filterOptionView.rightAnchor.constraint(equalTo: bestSellerView.rightAnchor, constant: 8).isActive = true
        filterOptionView.bottomAnchor.constraint(equalTo: bestSellerView.bottomAnchor).isActive = true
        filterOptionView.topAnchor.constraint(equalTo: bestSellerView.topAnchor, constant: 10).isActive = true
    
    }

}


//MARK: - extension UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("DID SELECT ITEM AT CALLED")
        
        self.delegate?.navigateToProductDetailsController()
       }
    
}


//MARK: - extension UICollectionViewDataSourse

    extension MainViewController: UICollectionViewDataSource {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // the number of cells are wholly dependent on the number of colours
            return bestSellersArray.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellersCell.identifier, for: indexPath) as! BestSellersCell
            let product = bestSellersArray[indexPath.row]
            cell.setup(with: product)
            return cell
        }
    }

//MARK: - extension UICollectionViewLDelegateFlowLayout

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

// MARK: - extension HotSalesAndBestSellersManagerDelegate

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



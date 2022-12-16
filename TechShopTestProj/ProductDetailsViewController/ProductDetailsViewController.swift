//
//  ProductDetailsViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    var productsInCart: Int = 0 {
        didSet {
            if productsInCart > 0 {
                productsInCartView.isHidden = false
                productsInCartLabel.text = "\(productsInCart)"
                productsInCartLabel.isHidden = false
            }
        }
    }
    
    var APImanager = ProductDetailsManager()
    var cartManager = MyCartManager()
    
    var urls: [String] = []
    
    public weak var delegate: ProductsDetailsControllerDelegate?
    
    lazy var carousel = ProductDetailsImagesCarousel(frame: .zero)
    var informationView = ProductInformationView(frame: .zero)
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "back.png"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant:  40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.addTarget(self, action: #selector(navigateBackToMainController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "cart.png"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant:  40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.addTarget(self, action: #selector(navigateToMyCartController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var productsInCartView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return view
    }()
    
    private lazy var productsInCartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(named: "peach")
        label.text = ""
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Medium", size: 15)
        label.font = font
        
        return label
    }()
    
    private lazy var topViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Product Details"
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Medium", size: 18)
        label.font = font
        return label
    }()
    
    private lazy var informationViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        APImanager.delegate = self
        APImanager.fetchProductDetails()
        cartManager.delegate = self
        cartManager.fetchMyCartInfo()
        setupHierarhy()
        setupComponents()
        setupConstraints()
        // Do any additional setup after loading the view.
    }

    
    private func setupHierarhy(){
        view.addSubview(topView)
        topView.addSubview(backButton)
        topView.addSubview(cartButton)
        topView.addSubview(topViewLabel)
        view.addSubview(carousel)
        view.addSubview(informationViewContainer)
        informationViewContainer.addSubview(informationView)
        view.bringSubviewToFront(informationView)
        cartButton.addSubview(productsInCartView)
        productsInCartView.addSubview(productsInCartLabel)
    }
    
    private func setupComponents() {
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
        
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.backgroundColor = .clear
        informationView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 10

        collectionView.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/10),
            
            backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 40),
            
            cartButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -40),
            cartButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            topViewLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            topViewLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            carousel.rightAnchor.constraint(equalTo: view.rightAnchor),
            carousel.leftAnchor.constraint(equalTo: view.leftAnchor),
            carousel.topAnchor.constraint(equalTo: topView.bottomAnchor),
            carousel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/10),
            
            informationViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            informationViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            informationViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            informationViewContainer.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 5),
            
            informationView.rightAnchor.constraint(equalTo: informationViewContainer.rightAnchor),
            informationView.leftAnchor.constraint(equalTo: informationViewContainer.leftAnchor),
            informationView.bottomAnchor.constraint(equalTo: informationViewContainer.bottomAnchor),
            informationView.topAnchor.constraint(equalTo: informationViewContainer.topAnchor),
            
            productsInCartView.topAnchor.constraint(equalTo: cartButton.topAnchor, constant: 2),
            productsInCartView.leftAnchor.constraint(equalTo: cartButton.leftAnchor, constant: 2),
            
            productsInCartLabel.centerYAnchor.constraint(equalTo: productsInCartView.centerYAnchor),
            productsInCartLabel.centerXAnchor.constraint(equalTo: productsInCartView.centerXAnchor)
            
        ])
    }
}
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    


//
//MARK: - COORDINATOR
extension ProductDetailsViewController {
    
    @objc func navigateBackToMainController(sender: UIButton) {
        self.delegate?.navigateBackToMainController()
    }
    
    @objc func navigateToMyCartController(sender: UIButton){
        self.delegate?.navigateToMyCartController()
    }
}

extension ProductDetailsViewController: ProductDetailsManagerDelegate {
    func didUpdateProductImages(_ productDetailsManager: ProductDetailsManager, imagesStrings: [String]) {
        DispatchQueue.main.async { [self] in
            self.urls = imagesStrings
            carousel.getImageStrings(urls)
            
        }
    }
    
    func didUpdateProductDetails(_ productDetailsManager: ProductDetailsManager, productDetails: ProductDetailsModel) {
        DispatchQueue.main.async { [self] in
            
            informationView.setupModel(model: productDetails)
           // informationView.reloadInputViews()
          
            
        }
    
    }
    

    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension ProductDetailsViewController: MyCartManagerDelegate {
    func didUpdateMyCart(_ myCartManager: MyCartManager, myCart: MyCartModel) {
        //
    }
    
    func didUpdateBasketProducts(_ myCartManager: MyCartManager, productsDetails: [ProductModel]) {
       
        DispatchQueue.main.async { [self] in
        
            productsInCart = productsDetails.count
        
            
        }
    }
    
    
}

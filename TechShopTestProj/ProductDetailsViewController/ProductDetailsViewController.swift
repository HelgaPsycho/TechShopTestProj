//
//  ProductDetailsViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    public weak var delegate: ProductsDetailsControllerDelegate?
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.yellow
        return view
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarhy()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
    }
    
    private func setupHierarhy(){
        view.addSubview(topView)
        topView.addSubview(backButton)
        topView.addSubview(cartButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10),
            
            backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 40),
            
            cartButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -40),
            cartButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
            
            
            
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


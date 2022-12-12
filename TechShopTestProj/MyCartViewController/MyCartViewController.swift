//
//  MyCartViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import UIKit

class MyCartViewController: UIViewController {
    
    public weak var delegate: MyCartControllerDelegate?
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        button.addTarget(self, action: #selector(navigateBackToProductsDetailController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var adressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "adress.png"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant:  40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
       // button.addTarget(self, action: #selector(  ), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var topViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Add adress"
        label.textAlignment = .right
        let font = UIFont(name: "MarkPro-Medium", size: 15)
        label.font = font
        return label
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarhy()
        setupConstraints()
       
    }
    
    func setupView(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
    }
    
    private func setupHierarhy(){
        view.addSubview(topView)
        topView.addSubview(backButton)
        topView.addSubview(adressButton)
        topView.addSubview(topViewLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/10),
            
            backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 40),
            
            adressButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -40),
            adressButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            topViewLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topViewLabel.rightAnchor.constraint(equalTo: adressButton.leftAnchor, constant: -5)
            
            
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

extension MyCartViewController {
    
    @objc func navigateBackToProductsDetailController(sender: UIButton) {
        print("1 BACK TO PRODUCT DETAIL CONTROLLER BUTTON PRESSED")
        self.delegate?.navigateBackToLastController()
        
    }
    
   
}


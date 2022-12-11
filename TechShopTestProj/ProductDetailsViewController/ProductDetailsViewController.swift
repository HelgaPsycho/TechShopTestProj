//
//  ProductDetailsViewController.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    public weak var delegate: ProductsDetailsControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "lightSilver") ?? UIColor.lightGray
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//MARK: - COORDINATOR
extension ProductDetailsViewController {
    
    @objc func navigateBackToMainController() {
        self.delegate?.navigateBackToMainController()
    }
    
    @objc func navigateToMyCartController(){
        self.delegate?.navigateToMyCartController()
    }
}


//
//  ProductDetailsViewCoordinator.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import Foundation
import UIKit


protocol BackToMainViewControllerDelegate: class {
    
    func navigateBackToMainController(newOrderCoordinator: ProductDetailsViewCoordinator)
    
}

class ProductDetailsViewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator
    weak var delegate: BackToMainViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let productDetailsViewController: ProductDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.delegate = self
        self.navigationController.pushViewController(productDetailsViewController, animated: true)
    }
}

extension ProductDetailsViewCoordinator : ProductsDetailsControllerDelegate {
    func navigateBackToMainController() {
        self.delegate?.navigateBackToMainController(newOrderCoordinator: self)
    }
    
    // Navigate to third page
    func navigateToMyCartController() {
        let myCartController: MyCartViewController = MyCartViewController()
       // myCartController.delegate = self
        self.navigationController.pushViewController(myCartController, animated: true)
    }
    
}


public protocol ProductsDetailsControllerDelegate: class {
    func navigateBackToMainController()
    func navigateToMyCartController()
}

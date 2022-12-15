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
    let productDetailsViewController: ProductDetailsViewController = ProductDetailsViewController()
    
    func start() {
        productDetailsViewController.delegate = self
        self.navigationController.pushViewController(productDetailsViewController, animated: true)
    }
}

extension ProductDetailsViewCoordinator: ProductsDetailsControllerDelegate {
    func navigateBackToMainController() {
        self.delegate?.navigateBackToMainController(newOrderCoordinator: self)
    }
    
    // Navigate to third page
    func navigateToMyCartController() {
        let myCartCoordinator = MyCartViewCoordinator(navigationController: navigationController)
        myCartCoordinator.delegate = self
        childCoordinators.append(myCartCoordinator)
        myCartCoordinator.start()
    }
    
}


public protocol ProductsDetailsControllerDelegate: class {
    func navigateBackToMainController()
    func navigateToMyCartController()
}

extension ProductDetailsViewCoordinator: BackToProductsDetailsControllerDelegate {
    func navigateBackToProductDetailsController(newOrderCoordinator: MyCartViewCoordinator){

        newOrderCoordinator.navigationController.popViewController(animated: true)
        childCoordinators.removeLast()

    }
}

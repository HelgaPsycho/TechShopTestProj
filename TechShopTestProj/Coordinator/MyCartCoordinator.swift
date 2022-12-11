//
//  MyCartCoordinator.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import Foundation
import UIKit

protocol BackToProductsDetailsControllerDelegate: class {
    
    func navigateBackToProductDetailsController(newOrderCoordinator: MyCartViewCoordinator)
    
}


class MyCartViewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator
    weak var delegate: BackToProductsDetailsControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myCartViewController: MyCartViewController = MyCartViewController()
        myCartViewController.delegate = self
        self.navigationController.pushViewController(myCartViewController, animated: true)
    }
}

extension MyCartViewCoordinator: MyCartControllerDelegate {
    func navigateBackToLastController() {
        self.delegate?.navigateBackToProductDetailsController(newOrderCoordinator: self)
        print("2 NAVIGATE BACT TO PRODUCT DETAIL CONTROLLER")
    }
    
    
}

public protocol MyCartControllerDelegate: class {
    func navigateBackToLastController ()
}


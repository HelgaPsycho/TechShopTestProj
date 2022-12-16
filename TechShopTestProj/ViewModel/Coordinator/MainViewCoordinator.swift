//
//  MainViewCoordinator.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//
import Foundation

import UIKit

class MainViewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
       
        let mainViewController : MainViewController = MainViewController()
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]
        
    }
    
    
    func printMainViewCoordinator(){
    
    }

}

extension MainViewCoordinator: MainViewControllerDelegate {
  
    // Navigate to next page
    func navigateToProductDetailsController() {
       
       let productDetailsViewCoordinator = ProductDetailsViewCoordinator(navigationController: navigationController)
       productDetailsViewCoordinator.delegate = self
       childCoordinators.append(productDetailsViewCoordinator)
        productDetailsViewCoordinator.start()
    }
    
    
}


public protocol MainViewControllerDelegate: AnyObject {
    func navigateToProductDetailsController()
}

extension MainViewCoordinator: BackToMainViewControllerDelegate {
    
    // Back from third page
    func navigateBackToMainController(newOrderCoordinator: ProductDetailsViewCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}

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
        print("MAIN VIEW COORDINATOR INIT")
    }
    
    func start() {
        print("START MAIN VEW COORDINATOR CALLED")
        let mainViewController : MainViewController = MainViewController()
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]
        print("NAVIGATION CONTOROLLER VIEW CONTROLLERS: \(self.navigationController.viewControllers)")
    }
    
    
    func printMainViewCoordinator(){
        print("PRINT MAIN VIEW COORDINATOR CALLED")
    }

}

extension MainViewCoordinator: MainViewControllerDelegate {
  
    // Navigate to next page
    func navigateToProductDetailsController() {
        print("NAVIGATE TO PRODUCT DELAILS CONTROLLER CALLED")
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

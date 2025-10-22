//
//  AppCoordinator .swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/10/25.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - StartFunction
    func start() {
        showCalculator()
    }
    
    func showCalculator(){
        let calculatorVC = CalculatorViewController()
        calculatorVC.coordinator = self
        navigationController.pushViewController(calculatorVC, animated: true)
    }
    
    func showHistory(){
        let historyVC = HistoryViewController()
        historyVC.coordinator = self
        historyVC.modalPresentationStyle = .pageSheet
        
        if let sheet = historyVC.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        navigationController.topViewController?.present(historyVC, animated: true)
    }
    
}

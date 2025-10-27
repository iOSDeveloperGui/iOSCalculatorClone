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
    let coreDataManager: CoreDataManager
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManager){
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - StartFunction
    func start() {
        showCalculator()
    }
    
    func showCalculator(){
        let calculatorVC = CalculatorViewController(coreDataManager: coreDataManager)
        calculatorVC.coordinator = self
        navigationController.pushViewController(calculatorVC, animated: true)
    }
    
    func showHistory(){
        let historyCoordinator = HistoryCoordinator(
            navigationController: navigationController,
            coreDataManager: coreDataManager
        )
        historyCoordinator.parentCoordinator = self
        childCoordinators.append(historyCoordinator)
        historyCoordinator.start()
    }
    
}

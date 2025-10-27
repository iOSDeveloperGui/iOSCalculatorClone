//
//  HistoryCoordinator.swift
//  CalculatorClone
//
//  Created by iOS Developer on 21/10/25.
//

import Foundation
import UIKit

class HistoryCoordinator: Coordinator{
    
    //MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let coreDataManager: CoreDataManager
    
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManager){
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
    }
    
    func start() {
        let historyVC = HistoryViewController(coreDataManager: coreDataManager)
        historyVC.coordinator = self
        
        if let sheet = historyVC.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        navigationController.present(historyVC, animated: true)
        
    }
    

}

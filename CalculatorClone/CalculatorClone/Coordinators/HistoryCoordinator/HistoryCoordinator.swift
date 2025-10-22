//
//  HistoryCoordinator.swift
//  CalculatorClone
//
//  Created by iOS Developer on 21/10/25.
//

import Foundation
import UIKit

class HistoryCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let historyVC = HistoryViewController()
        //historyVC.coordinator = self
        
        if let sheet = historyVC.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        historyVC.present(historyVC, animated: true)
        
    }
    

}

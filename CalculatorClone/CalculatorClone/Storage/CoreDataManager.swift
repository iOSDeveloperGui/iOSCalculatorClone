//
//  CoreDataManager.swift
//  CalculatorClone
//
//  Created by iOS Developer on 21/10/25.
//

import Foundation
import CoreData

class CoreDataManager{
    //MARK: - Property
    let coreDataService: CoreDataProtocol
    
    init(coreDataService: CoreDataProtocol){
        self.coreDataService = coreDataService
    }
    
    func saveCalculation(_ calculation: String, result: String){
        coreDataService.saveCalculation(calculation, result: result)
    }
    
    func fetchHistory() -> [CalculationHistory]{
        coreDataService.fetchHistory()
    }
    
    func deleteCalculation(_ calculation: CalculationHistory){
        coreDataService.deleteCalculation(calculation)
    }
    
    func clearAllHistory(){
        coreDataService.clearAllHistory()
    }
    
}

//
//  CoreDataService.swift
//  CalculatorClone
//
//  Created by iOS Developer on 22/10/25.
//

import Foundation
import CoreData

class CoreDataService: CoreDataProtocol{
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalculatorHistory")
        container.loadPersistentStores { _, error in
            if let error = error{
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func saveCalculation(_ calculation: String, result: String) {
        <#code#>
    }
    
    func fetchHistory() -> [CalculationHistory] {
        <#code#>
    }
    
    func deleteCalculation(_ calculation: CalculationHistory) {
        <#code#>
    }
    
    func clearAllHistory() {
        <#code#>
    }
    
    
}

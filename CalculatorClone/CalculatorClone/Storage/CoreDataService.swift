//
//  CoreDataService.swift
//  CalculatorClone
//
//  Created by iOS Developer on 22/10/25.
//

import Foundation
import CoreData

class CoreDataService: CoreDataProtocol{
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalculationHistory")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveCalculation(_ calculation: String, result: String) {
        let history = NSEntityDescription.insertNewObject(
            forEntityName: "CalculationHistory",
            into: context
        ) as! CalculationHistory
        
        history.calculation = calculation
        history.result = result
        history.timeStamp = Date()
        
        do{
            try context.save()
        } catch{
            print("Failed to save: \(error)")
        }
    }
    
    func fetchHistory() -> [CalculationHistory] {
        let request: NSFetchRequest<CalculationHistory> = NSFetchRequest(entityName: "CalculationHistory")
        request.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false)]
        
        do{
            return try context.fetch(request)
        } catch{
            print("Failed to fetch: \(error)")
            return []
        }
    }
    
    func deleteCalculation(_ calculation: CalculationHistory) {
        context.delete(calculation)
        do{
            try context.save()
        } catch{
            print("Failed to delete: \(error)")
        }
    }
    
    func clearAllHistory() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CalculationHistory")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do{
            try context.execute(deleteRequest)
            try context.save()
        } catch{
            print("Failed to clear history: \(error)")
        }
    }
    
}

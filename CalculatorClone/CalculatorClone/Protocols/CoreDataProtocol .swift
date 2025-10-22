//
//  CoreDataProtocol .swift
//  CalculatorClone
//
//  Created by iOS Developer on 22/10/25.
//

import Foundation
import CoreData

protocol CoreDataProtocol{
    func saveCalculation(_ calculation: String, result: String)
    func fetchHistory() -> [CalculationHistory]
    func deleteCalculation(_ calculation: CalculationHistory)
    func clearAllHistory()
}

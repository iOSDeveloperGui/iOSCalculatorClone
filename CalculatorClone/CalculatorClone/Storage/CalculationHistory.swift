//
//  CalculationHistory.swift
//  CalculatorClone
//
//  Created by iOS Developer on 17/10/25.
//

import Foundation
import CoreData

class CalculationHistory: NSManagedObject{
    @NSManaged var calculation: String
    @NSManaged var result: String
    @NSManaged var timeStamp: Date
}

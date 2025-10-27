//
//  HistoryModel.swift
//  CalculatorClone
//
//  Created by iOS Developer on 27/10/25.
//

import Foundation

class HistoryModel{
    //MARK: - Properties 
    let calendar = Calendar.current
    let now = Date()
    
    //MARK: - Arrays
    var todayItems: [CalculationHistory] = []
    var yesterdayItems: [CalculationHistory] = []
    var previous7DaysItems: [CalculationHistory] = []
    var olderItems: [CalculationHistory] = []
}

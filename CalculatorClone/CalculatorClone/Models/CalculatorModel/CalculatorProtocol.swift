//
//  CalculatorProtocol.swift
//  CalculatorClone
//
//  Created by iOS Developer on 21/09/25.
//

import Foundation

protocol CalculatorProtocol{
    func inputNumber(_ number: String) -> String 
    func inputDecimal() -> String
    func setOperation(_ operation: Operation) -> String
    func calculateResult() -> String
    func percentage() -> String
    func toggleSign() -> String
    func performCalculation(_ first: Double, _ second: Double, _ operation: Operation) -> Double
    func formatNumber(_ number: Double) -> String
    func clear() -> String 
}

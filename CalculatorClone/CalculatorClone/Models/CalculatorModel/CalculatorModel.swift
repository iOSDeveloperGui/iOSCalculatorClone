//
//  Calculator.swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/09/25.
//

import Foundation

class CalculatorModel: CalculatorProtocol{
    
    //MARK: - Properties
    private var currentValue: String = "0"
    private var previousValue: Double = 0.0
    private var currentOperation: Operation?
    private var resetDisplay: Bool = false
    @Published public var buttons: [[CalculatorButton]] = []
    
    func inputNumber(_ number: String) -> String {
        if resetDisplay || currentValue == "0"{
            currentValue = number
            resetDisplay = false
        } else{
            currentValue += number
        }
        return currentValue
    }
    
    func inputDecimal() -> String {
        if resetDisplay{
            currentValue = "0."
            resetDisplay = false
        } else if !(currentValue.contains(".")){
            currentValue += "."
        }
        return currentValue
    }
    
    func setOperation(_ operation: Operation) -> String {
        if let current = Double(currentValue){
            if let existingOp = currentOperation{
                previousValue = performCalculation(previousValue, current, existingOp)
                currentValue = formatNumber(previousValue)
            } else{
                previousValue = current
            }
            currentOperation = operation
            resetDisplay = true
        }
        return currentValue
    }
    
    func calculateResult() -> String {
        guard let operation = currentOperation,
              let current = Double(currentValue) else{
            return currentValue
        }
        
        let result = performCalculation(previousValue, current, operation)
        currentValue = formatNumber(result)
        currentOperation = nil
        resetDisplay = true
        previousValue = 0
        return currentValue
    }
    
    func percentage() -> String {
        if let current = Double(currentValue){
            let result = current / 100
            currentValue = formatNumber(result)
        }
        return currentValue
    }
    
    func toggleSign() -> String {
        if let current = Double(currentValue){
            currentValue = formatNumber(current)
        }
        return currentValue
    }
    
    func performCalculation(_ first: Double, _ second: Double, _ operation: Operation) -> Double{
        switch operation {
        case .add:
            return first + second
        case .subtract:
            return first - second
        case .multiply:
            return first * second 
        case .divide:
            return second != 0 ? first / second : 0
        }
    }
    
    func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 && abs(number) < 1e10{
            return String(format: "%.0f", number)
        } else{
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 8
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: number)) ?? "0"
        }
    }
    
    func clear() -> String {
        currentValue = "0"
        previousValue = 0.0
        currentOperation = nil
        resetDisplay = false
        return currentValue
    }
    
}

//
//  ViewController.swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/09/25.
//

import UIKit

class CalculatorViewController: UIViewController {
    //MARK: - Instances
    private let model = CalculatorModel()
    private let contentView = CalculatorView()
    private var currentExpression = ""
    private let coreDataManager: CoreDataManager
    
    weak var coordinator: AppCoordinator?
    
    //MARK: - AppLifeCycle
    init(coreDataManager: CoreDataManager){
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        settingButon()
    }
    
    override func loadView() {
        view = contentView
    }

    
    //MARK: - ButtonTappedFunction

    @objc
    private func buttonTapped(_ sender: CalculatorButton){
        guard let title = sender.currentTitle else { return }
        
        switch title{
        
        case "0"..."9":
            currentExpression += title
            contentView.displayLabel.text = model.inputNumber(title)
            updateDisplayFont()
        
        case ",":
            currentExpression += "."
            contentView.displayLabel.text = model.inputDecimal()
            updateDisplayFont()
            
        case "+", "−", "×", "÷":
            if !currentExpression.isEmpty{
                currentExpression += title
            }
            guard let operation = Operation(rawValue: title) else{
                print("Invalid Operation: \(title)")
                return
            }
            contentView.displayLabel.text = model.setOperation(operation)
            updateDisplayFont()
            updateExpressionLabel()
            
        case "=":
            let result = model.calculateResult()
            contentView.displayLabel.text = result
            updateDisplayFont()
            saveToHistory(currentExpression, result)
            currentExpression = ""
            contentView.expressionLabel.text = ""
            
        case "AC":
            contentView.displayLabel.text = model.clear()
            currentExpression = ""
            contentView.expressionLabel.text = ""
            updateDisplayFont()
            
        case "%":
            currentExpression += "%"
            contentView.displayLabel.text = model.percentage()
            updateDisplayFont()
            updateExpressionLabel()
        case "+/−":
            contentView.displayLabel.text = model.toggleSign()
            updateDisplayFont()
            updateExpressionLabel()
        default:
            break
        }
    }
    
    
    @objc
    private func historyTapped(){
        print("Tapped")
        coordinator?.showHistory()
    }
    
    private func settingButon(){
        contentView.historyButton.addTarget(self, action: #selector(historyTapped), for: .touchUpInside)
    }
    
    //MARK: - SetupButton function
    func setupUI(){
        let buttonLayout: [[(String, CalculatorButton.TypeButton)]] = [
            [("AC", .function), ("+/−", .function), ("%", .function), ("÷", .operation)],
            [("7", .number), ("8", .number), ("9", .number), ("×", .operation)],
            [("4", .number), ("5", .number), ("6", .number), ("−", .operation)],
            [("1", .number), ("2", .number), ("3", .number), ("+", .operation)],
            [("", .number), ("0", .number), (",", .number), ("=", .equals)]
        ]
        
        for row in buttonLayout{
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 12
            
            var rowButtons: [CalculatorButton] = []
            
            for(title, type) in row{
                if title.isEmpty{
                    let button = CalculatorButton(title: "", type: type)
                    rowButtons.append(button)
                    rowStack.addArrangedSubview(button)
                } else{
                    let button = CalculatorButton(title: title, type: type)
                    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                    rowButtons.append(button)
                    rowStack.addArrangedSubview(button)
                }
            }
            model.buttons.append(rowButtons)
            contentView.buttonStackView.addArrangedSubview(rowStack)
        }
        
    }
    
    private func updateExpressionLabel(){
        self.contentView.expressionLabel.text = currentExpression
    }
    
    //MARK: - UpdateDisplayFontFunction
    private func updateDisplayFont(){
        guard let text = contentView.displayLabel.text else { return }
        let length = text.count
        
        var fontSize: CGFloat = 80
        switch length{
        case 0...6:
            fontSize = 80
        case 7...8:
            fontSize = 64
        case 9...10:
            fontSize = 52
        default:
            fontSize = 40
        }
        
        UIView.animate(withDuration: 0.1){
            self.contentView.displayLabel.font = .systemFont(ofSize: fontSize, weight: .light)
        }
    }
    
    //MARK: - SaveToHistory
    private func saveToHistory(_ calculation: String, _ result: String){
        if !currentExpression.isEmpty{
            coreDataManager.saveCalculation(calculation, result: result)
        }
    }
}


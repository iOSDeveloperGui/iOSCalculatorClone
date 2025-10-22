//
//  CalculatorComponent .swift
//  CalculatorClone
//
//  Created by iOS Developer on 17/10/25.
//

import Foundation
import UIKit

class CalculatorButton: UIButton{
    enum TypeButton{
        case number
        case operation
        case function
        case equals
    }

    let button: TypeButton
    
    init(title: String, type: TypeButton){
        self.button = type
        super.init(frame: .zero)
        updateAppearance()
        
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateAppearance(){
        switch button{
        
        case .number:
            backgroundColor = UIColor(white: 0.2, alpha: 1)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
            
        case .function:
            backgroundColor = UIColor(named: "elegantGray")
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
            
        case .operation, .equals:
            backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 52, weight: .regular)
        }
    }
    

    
    override var isHighlighted: Bool{
        didSet{
            alpha = isHighlighted ? 0.4 : 1.0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
}

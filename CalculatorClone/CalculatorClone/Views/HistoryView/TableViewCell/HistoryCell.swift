//
//  HistoryCell.swift
//  CalculatorClone
//
//  Created by iOS Developer on 22/10/25.
//

import Foundation
import UIKit

class HistoryCell: UITableViewCell{
    //MARK: - UIElements
    private lazy var calculationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupConstraints()
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubViewsFunction
    private func addSubViews(){
        addSubview(calculationLabel)
        addSubview(resultLabel)
    }
    
    //MARK: - SetupUIFunction
    private func setupUI(){
        backgroundColor = .black
        selectionStyle = .none
    }
    
    //MARK: - setupConstraintsFunction
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            calculationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            calculationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            calculationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            resultLabel.topAnchor.constraint(equalTo: calculationLabel.bottomAnchor, constant: 8),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            resultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    //MARK: - ConfigureFunction
    public func configure(with calculation: CalculationHistory){
        calculationLabel.text = calculation.calculation
        resultLabel.text = calculation.result
    }
    
    
    
    
}

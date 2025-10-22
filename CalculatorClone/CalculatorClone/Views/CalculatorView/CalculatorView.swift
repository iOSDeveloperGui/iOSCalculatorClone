//
//  CalculatorView.swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/09/25.
//

import UIKit

class CalculatorView: UIView {
    
    //MARK: - UIElements
    public lazy var toolbarView: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = false
        toolbar.backgroundColor = UIColor(white: 0.1, alpha: 1)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    public lazy var historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1)
        button.setImage(createCalculatorIcon(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var expressionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(white: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .systemFont(ofSize: 80, weight: .medium)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - initialization
    override init(frame: CGRect){
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
        setupToolbarItems()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        toolbarView.frame = CGRect(x: 0, y: safeAreaInsets.top, width: bounds.width,height: 44)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews(){
        addSubview(toolbarView)
        addSubview(expressionLabel)
        addSubview(displayLabel)
        addSubview(buttonStackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            expressionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64),
            expressionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            expressionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            expressionLabel.heightAnchor.constraint(equalToConstant: 40),

            displayLabel.topAnchor.constraint(equalTo: expressionLabel.bottomAnchor, constant: 12),
            displayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            displayLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20),
            
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonStackView.heightAnchor.constraint(equalToConstant: 450)
        ])
        
    }
    
    private func setupToolbarItems(){
        let historyBarButton = UIBarButtonItem(customView: historyButton)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarView.items = [historyBarButton, flexibleSpace]
        toolbarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        toolbarView.autoresizingMask = [.flexibleWidth]
    }
    
    private func createCalculatorIcon() -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        return UIImage(systemName: "list.bullet", withConfiguration: config)
    }
}

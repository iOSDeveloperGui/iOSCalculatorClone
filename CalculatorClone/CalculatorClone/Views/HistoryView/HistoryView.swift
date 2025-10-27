//
//  HistoryView.swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/10/25.
//

import Foundation
import UIKit

class HistoryView: UIView{
    //MARK: - UIElements
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .singleLine
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.backgroundColor = UIColor(named: "elegantGray")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public lazy var bottomContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(named: "toolColor")
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    public lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubViewfunc
    private func addSubViews(){
        addSubview(tableView)
        addSubview(bottomContainer)
        bottomContainer.addSubview(editButton)
        bottomContainer.addSubview(clearButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor),

            bottomContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 60),

            editButton.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 20),
            editButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor),

            clearButton.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -20),
            clearButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor)
        ])

    }
}

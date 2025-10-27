//
//  HistoryViewController.swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/10/25.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController{
    
    //MARK: - Instances
    private let contentView = HistoryView()
    private let model = HistoryModel()
    
    //MARK: - Properties
    public let coreDataManager: CoreDataManager
    public var sections: [HistorySection] = []
    private var isEditMode: Bool = false
    
    weak var coordinator: HistoryCoordinator?
    
    //MARK: - AppLifeCycle
    init(coreDataManager: CoreDataManager){
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "elegantGray")
        setupTableView()
        setupButtons()
        loadHistory()
    }
    
    override func loadView() {
        view = contentView
    }
    
    //MARK: - LoadHistory Function
    public func loadHistory(){
        let history = coreDataManager.fetchHistory()
        sections = organizeHistoryIntoSections(history)
        contentView.tableView.reloadData()
    }
    
    private func organizeHistoryIntoSections(_ history: [CalculationHistory]) -> [HistorySection] {
        // Clear previous items before organizing
        model.todayItems.removeAll()
        model.yesterdayItems.removeAll()
        model.previous7DaysItems.removeAll()
        model.olderItems.removeAll()
        sections.removeAll()

        for item in history {
            guard let date = item.timeStamp else { continue } // safely unwrap the optional Date

            let daysDiff = model.calendar.dateComponents([.day], from: date, to: model.now).day ?? 0

            if model.calendar.isDateInToday(date) {
                model.todayItems.append(item)
            } else if model.calendar.isDateInYesterday(date) {
                model.yesterdayItems.append(item)
            } else if daysDiff <= 7 {
                model.previous7DaysItems.append(item)
            } else {
                model.olderItems.append(item)
            }
        }

        if !model.todayItems.isEmpty {
            sections.append(HistorySection(title: "Today", calculations: model.todayItems))
        }

        if !model.yesterdayItems.isEmpty {
            sections.append(HistorySection(title: "Yesterday", calculations: model.yesterdayItems))
        }

        if !model.previous7DaysItems.isEmpty {
            sections.append(HistorySection(title: "Previous 7 days", calculations: model.previous7DaysItems))
        }

        if !model.olderItems.isEmpty {
            sections.append(HistorySection(title: "Old", calculations: model.olderItems))
        }

        return sections
    }

    
    //MARK: - SetupTableView
    private func setupTableView(){
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    //MARK: - SetupButtons
    
    private func setupButtons(){
        contentView.editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        contentView.clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }
    
    @objc
    private func editTapped(){
        isEditMode.toggle()
        contentView.tableView.setEditing(isEditMode, animated: true)
        contentView.editButton.setTitle(isEditMode ? "Done" : "Edit", for: .normal)
    }
    
    @objc
    private func clearTapped(){
        let alert = UIAlertController(
            title: "Clear all History? ",
            message: "This Cannot be undone",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive){ [weak self] _ in
            self?.coreDataManager.clearAllHistory()
            self?.loadHistory()
        })
        present(alert, animated: true)
    }
}

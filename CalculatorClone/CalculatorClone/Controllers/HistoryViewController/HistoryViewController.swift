//
//  HistoryViewController.swift
//  CalculatorClone
//
//  Created by iOS Developer on 20/10/25.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController{
    
    //MARK: - Properties
    private let contentView = HistoryView()
    public let sections: [HistorySection] = []
    private var isEditMode: Bool = false
    
    
    weak var coordinator: AppCoordinator?
    
    //MARK: - AppLifeCycle
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "elegantGray")
        
    }
    
    override func loadView() {
        view = contentView
    }
    
    
}

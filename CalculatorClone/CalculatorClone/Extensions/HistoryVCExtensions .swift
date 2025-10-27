//
//  HistoryVCExtensions .swift
//  CalculatorClone
//
//  Created by iOS Developer on 22/10/25.
//

import Foundation
import UIKit

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].calculations.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let calculation = sections[indexPath.section].calculations[indexPath.row]
        cell.configure(with: calculation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let calculation = sections[indexPath.section].calculations[indexPath.row]
            coreDataManager.deleteCalculation(calculation)
            loadHistory()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            if let header = view as? UITableViewHeaderFooterView {
                header.textLabel?.textColor = UIColor(white: 0.5, alpha: 1)
                header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            }
        }
    
}

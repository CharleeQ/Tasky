//
//  CheckButton.swift
//  Tasky
//
//  Created by Кирилл Какареко on 16.01.2022.
//

import UIKit

class CheckButton: UIButton {

    var isComplete: Bool? {
        didSet {
            if isComplete == true {
                self.setImage(
                    UIImage(systemName: "checkmark.circle.fill")?
                        .maskWithColor(color: .systemIndigo),
                    for: .normal
                )
            } else {
                self.setImage(
                    UIImage(systemName: "circle")?
                        .maskWithColor(color: .systemIndigo),
                    for: .normal
                )
            }
        }
    }
    
    func changeStatus(task: Task) {
        
        guard let isComplete = isComplete else { return }
        self.isComplete = !isComplete
        
        guard let date = task.date, let isComplete = self.isComplete else { return }
        DataManager.shared.update(
            task: task,
            title: task.title,
            description: task.descript,
            date: date,
            isComplete: isComplete
        )
        
    }
    
}

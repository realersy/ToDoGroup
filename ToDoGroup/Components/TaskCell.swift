//
//  TaskCell.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 11.07.2023.
//

import Foundation
import UIKit

class TaskCell: UICollectionViewCell{
    
    let isCompletedButton = UIButton()
    let taskNameLabel = UILabel()
    let deleteTaskButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        //View
        layer.cornerRadius = 22
        backgroundColor = .systemBlue
        
        // isCompleted Button
        isCompletedButton.setImage(UIImage(named: "undone"), for: [])
        contentView.addSubview(isCompletedButton)
        isCompletedButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isCompletedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            isCompletedButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            isCompletedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            isCompletedButton.heightAnchor.constraint(equalToConstant: 30),
            isCompletedButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        //Task Name Label
        taskNameLabel.textColor = .white
        taskNameLabel.text = "default"
        taskNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskNameLabel.leadingAnchor.constraint(equalTo: isCompletedButton.trailingAnchor, constant: 12),
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            taskNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            taskNameLabel.widthAnchor.constraint(equalToConstant: 250),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 30)
        
        ])
        //Delete button
        deleteTaskButton.setImage(UIImage(named: "closeButton"), for: [])
        contentView.addSubview(deleteTaskButton)
        deleteTaskButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            deleteTaskButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            deleteTaskButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            deleteTaskButton.widthAnchor.constraint(equalToConstant: 30),
            deleteTaskButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func conf(_ task: Task){
        taskNameLabel.text = task.taskName
    }
}

//
//  TaskCell.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 11.07.2023.
//

import Foundation
import UIKit

protocol TaskCellDelegate: AnyObject{
    func completionDidChange(index: Int, completed: Bool)
    func deleteDidHappen(index: Int)
}

class TaskCell: UICollectionViewCell{
    
    private let isCompletedButton = UIButton()
    private let taskNameLabel = UILabel()
    private let deleteTaskButton = UIButton()
    private let buttonBackground = UIView()
    private var isCompleted: Bool = false
    private var index: Int = 0
    
    let completedImage = UIImage(named: "done")?.withRenderingMode(.alwaysTemplate)
    let incompleteImage = UIImage(named: "undone")
    
    weak var delegate: TaskCellDelegate?
    
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
        
        //button background
        buttonBackground.backgroundColor = .white
        buttonBackground.layer.cornerRadius = 15
        contentView.addSubview(buttonBackground)
        buttonBackground.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            buttonBackground.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonBackground.heightAnchor.constraint(equalToConstant: 30),
            buttonBackground.widthAnchor.constraint(equalToConstant: 30)
            
        ])
        // isCompleted Button
        isCompletedButton.setImage(UIImage(named: "undone"), for: [])
        contentView.addSubview(isCompletedButton)
        isCompletedButton.translatesAutoresizingMaskIntoConstraints = false
        isCompletedButton.addTarget(self, action: #selector(pressedCompleted), for: .touchUpInside)
        NSLayoutConstraint.activate([
            isCompletedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            isCompletedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
        deleteTaskButton.addTarget(self, action: #selector(pressedDelete), for: .touchUpInside)
        NSLayoutConstraint.activate([
            deleteTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            deleteTaskButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            deleteTaskButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            deleteTaskButton.widthAnchor.constraint(equalToConstant: 30),
            deleteTaskButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func conf(_ task: Task, index: Int, color: String){
        self.index = index
        self.isCompleted = task.isCompleted
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: task.taskName, attributes: task.isCompleted ? attributes : [:])
        taskNameLabel.attributedText = attributedString
        backgroundColor = UIColor(color)
        isCompletedButton.setImage(task.isCompleted ? completedImage : incompleteImage, for: [])
        isCompletedButton.tintColor = UIColor(color)
        
        
    }
    //MARK: More OBJC functions
    @objc func pressedCompleted(){
        
        self.isCompleted.toggle()
        self.isCompletedButton.setImage(self.isCompleted ? completedImage : incompleteImage, for: [])
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: taskNameLabel.text!, attributes: isCompleted ? attributes : [:])
        taskNameLabel.attributedText = attributedString
        self.delegate?.completionDidChange(index: self.index, completed: self.isCompleted)
    }
    
    @objc func pressedDelete(){
        delegate?.deleteDidHappen(index: index)
    }
}

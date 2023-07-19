//
//  SmallTaskGroupCell.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 09.07.2023.
//

import Foundation
import UIKit

class SmallTaskGroupCell: UICollectionViewCell{
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let cancelButton = UIButton()
    let pinButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        // View
        layer.cornerRadius = 22
        // Title Label
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 41),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        // Pin Button
        pinButton.setImage(UIImage(named: "pinButton"), for: [])
        pinButton.addTarget(self, action: #selector(pinButtonPressed), for: .touchUpInside)
        contentView.addSubview(pinButton)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),
            pinButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            pinButton.heightAnchor.constraint(equalToConstant: 20),
            pinButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        
        //Description Label
        descLabel.textColor = .white
        descLabel.font = .systemFont(ofSize: 12, weight: .medium)
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descLabel)
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
            descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -31)
        
        ])
        
        //Cancel Button
        cancelButton.setImage(UIImage(named: "closeButton"), for: [])
        contentView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
        
        ])
        
    }
    
    @objc func pinButtonPressed(){}
    
    func conf(_ group: TaskGroup){
        
        var numOfCompletedTasks = 0
        for elem in group.tasks{
            if elem.isCompleted{
                numOfCompletedTasks += 1
            }
        }
        
        
        titleLabel.text = group.groupName
        backgroundColor = UIColor(group.groupColor)
        descLabel.text = "Completed \(numOfCompletedTasks) " + "/ \(group.tasks.count)" + " tasks"
    }
}

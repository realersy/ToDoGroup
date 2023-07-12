//
//  AddTaskGroupCell.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 10.07.2023.
//

import Foundation
import UIKit

class AddTaskGroupCell: UICollectionViewCell{
    
    let addButton = UIButton()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        //ContentView
        backgroundColor = .systemGray
        layer.cornerRadius = 22
        
        //Title Label
        titleLabel.text = "Add New List"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        //Add Button
        addButton.setImage(UIImage(named: "addButton"), for: [])
        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 65),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -65),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        ])
    }
}


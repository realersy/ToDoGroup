//
//  BigTaskGroupCell.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 10.07.2023.
//

import Foundation
import UIKit

class BigTaskGroupCell: UICollectionViewCell{
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let cancelButton = UIButton()
    //let pinButton = UIButton()
    let progressBar = UIProgressView(progressViewStyle: .bar)
    
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
        
        // Pin Button
//        pinButton.setImage(UIImage(named: "pinButton"), for: [])
//        contentView.addSubview(pinButton)
//        pinButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pinButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),
//            pinButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
//            pinButton.heightAnchor.constraint(equalToConstant: 20),
//            pinButton.widthAnchor.constraint(equalToConstant: 20)
//        ])
        
        // Title Label
        titleLabel.text = "Work"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
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
            cancelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
        
        ])
        
        //ProgressBar
        progressBar.trackTintColor = .black.withAlphaComponent(0.2)
        progressBar.progressTintColor = .white
        progressBar.layer.cornerRadius = 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers?[1].cornerRadius = 2
        progressBar.subviews[1].clipsToBounds = true
        contentView.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.heightAnchor.constraint(equalToConstant: 4)
        
        ])
    }
    
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
        let ratio = Float(numOfCompletedTasks) / Float(group.tasks.count)
        progressBar.setProgress(ratio, animated: false)
        
    }
}

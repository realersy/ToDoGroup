//
//  TasksViewController.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 11.07.2023.
//

import Foundation
import UIKit

//MARK: Add Task Protocol
protocol AddTaskProtocol: AnyObject{
    func tasksDidChange(tasks: [Task])
}

class TasksViewController: UIViewController{
    
    //MARK: Properties
    
    let tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    weak var delegate: AddTaskProtocol?
    var group: TaskGroup
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressedAdd))

        setup()
    }
    
    
    //MARK: Custom Init
    
    init(group: TaskGroup) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: OBJC func PressedAdd()
    @objc func pressedAdd(){
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        alertController.addTextField{ textField in
            textField.accessibilityIdentifier = "task"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default){ test in
            if
                let textField = alertController.textFields?.first(where: {$0.accessibilityIdentifier == "task"}),
                textField.text != ""
            {
                
                  let newTask = Task(taskName: textField.text!, isCompleted: false)
                  self.group.tasks.append(newTask)
                  self.delegate?.tasksDidChange(tasks: self.group.tasks)
                  self.tasksCollectionView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

//MARK: Setup
extension TasksViewController{
    func setup(){
        tasksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tasksCollectionView.alwaysBounceVertical = true
        tasksCollectionView.bounces = true

        tasksCollectionView.dataSource = self
        tasksCollectionView.delegate = self
        
        tasksCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: "taskCell")
        view.addSubview(tasksCollectionView)
        
        NSLayoutConstraint.activate([
            tasksCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            tasksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tasksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
//MARK: CollectionView Delegate and Data Source
extension TasksViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.conf(group.tasks[indexPath.row], index: indexPath.row, color: group.groupColor)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.tasks.count
    }
}

//MARK: Collection View Flow Layout Delegate

extension TasksViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-40, height: 60)
    }
}

extension TasksViewController: TaskCellDelegate{
    func completionDidChange(index: Int, completed: Bool) {
        group.tasks[index].isCompleted = completed
        delegate?.tasksDidChange(tasks: group.tasks)
    }
    func deleteDidHappen(index: Int) {
        group.tasks.remove(at: index)
        delegate?.tasksDidChange(tasks: group.tasks)
        tasksCollectionView.reloadData()
    }
}

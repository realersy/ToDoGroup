//
//  ViewController.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 09.07.2023.
//

import UIKit

let COLORS = [UIColor("#BF5AF2"), UIColor("#0979EB"), UIColor("#5E5CE6"), UIColor("#E43C32")]

class ViewController: UIViewController, AddTaskProtocol {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    
    
    var groups: [TaskGroup] = [TaskGroup(groupName: "Work", tasks: [Task(taskName: "Submit papers", isCompleted: false), Task(taskName: "Do analysis", isCompleted: true)], groupColor: .systemMint), TaskGroup(groupName: "Daily", tasks: [], groupColor: .systemGray), TaskGroup(groupName: "School", tasks: [Task(taskName: "Do homework", isCompleted: false)], groupColor: .systemPink)]
    
    var indexPath: IndexPath?
    
    func tasksDidChange(tasks: [Task]) {
        guard let indexPath else { return }
        groups[indexPath.row].tasks = tasks
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setup()
    }
    
}
//MARK: Setup
extension ViewController{
    func setup(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.bounces = true
        
        collectionView.register(BigTaskGroupCell.self, forCellWithReuseIdentifier: "bigCell")
        collectionView.register(SmallTaskGroupCell.self, forCellWithReuseIdentifier: "smallCell")
        collectionView.register(AddTaskGroupCell.self, forCellWithReuseIdentifier: "addCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
//MARK: CollectionView Data Source and Delegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0{
            if groups.count != 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCell", for: indexPath) as! BigTaskGroupCell
                cell.conf(groups[indexPath.row])
                cell.cancelButton.tag = indexPath.row
                cell.cancelButton.addTarget(self, action: #selector(confirmDelete), for: .touchUpInside)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as! AddTaskGroupCell
            return cell
            
        } else if indexPath.last == groups.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as! AddTaskGroupCell
            cell.addButton.addTarget(self, action: #selector(pressedAdd), for: .touchUpInside)
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCell", for: indexPath) as! SmallTaskGroupCell
            cell.conf(groups[indexPath.row])
            cell.cancelButton.tag = indexPath.row
            cell.pinButton.tag = indexPath.row
            cell.cancelButton.addTarget(self, action: #selector(confirmDelete), for: .touchUpInside)
            cell.pinButton.addTarget(self, action: #selector(pinPressed), for: .touchUpInside)
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        if indexPath.row != groups.count{
            let tasksViewController = TasksViewController(group: groups[indexPath.row])
            tasksViewController.delegate = self
            navigationController?.pushViewController(tasksViewController, animated: true)
        }
    }
    //MARK: Target Function - Add Task Group
    @objc func pressedAdd(){
        let alertController = UIAlertController(title: "Add Task Group", message: nil, preferredStyle: .alert)
        
        alertController.addTextField{ textField in
            textField.accessibilityIdentifier = "taskGroup"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default){ test in
            if
                let textField = alertController.textFields?.first(where: {$0.accessibilityIdentifier == "taskGroup"}),
                textField.text != ""
            {
                
                let newTaskGroup = TaskGroup(groupName: textField.text!, tasks: [], groupColor: .gray)
                self.groups.append(newTaskGroup)
                self.collectionView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    //MARK: Target Function - Confirm Delete
    @objc func confirmDelete(_ sender: UIButton){
        let alertController = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this task group?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default){ [self] test in
            self.groups.remove(at: sender.tag)
            self.collectionView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    //MARK: Target Func - Pin Pressed
    @objc func pinPressed(_ sender: UIButton){
        let tempGroup = groups[sender.tag]
        groups[sender.tag] = groups[0]
        groups[0] = tempGroup
        collectionView.reloadData()
    }
}

//MARK: Flow Layout Delegate
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            let cellWidth = UIScreen.main.bounds.width - 24
            return CGSize(width: cellWidth, height: 120)
        } else{
            let cellWidth = (UIScreen.main.bounds.width / 2) - 12 - 3
            return CGSize(width: cellWidth, height: 120)
        }
    }
}


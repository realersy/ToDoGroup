//
//  TaskGroup.swift
//  ToDoGroup
//
//  Created by Ersan Shimshek on 09.07.2023.
//

import Foundation
import UIKit

var COUNTER = 0

struct TaskGroup: Codable{
    let groupName: String
    var tasks: [Task]
    var groupColor: String
    
    init(groupName: String, tasks: [Task], groupColor: String) {
        self.groupName = groupName
        self.tasks = tasks
        self.groupColor = groupColor
        
        if COUNTER == 3{
            self.groupColor = COLORS[COUNTER]
            COUNTER = 0
        }else{
            self.groupColor = COLORS[COUNTER]
            COUNTER += 1
        }
    }
}

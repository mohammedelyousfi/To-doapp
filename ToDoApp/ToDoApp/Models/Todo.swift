//
//  Task.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 10/12/2022.
//

import UIKit

class Todo: NSObject {
    
    var Id : Int = 0
    var Title : String = ""
    var TaskDescription : String = ""
    var IsDone : Bool = false
    var DueDate : Date? = nil

    init(title: String, desc: String, id: Int, done: Bool = false, date: Date? = nil) {
        self.Id = id
        self.Title = title
        self.TaskDescription = desc
        self.IsDone = done
        self.DueDate = date
    }
}

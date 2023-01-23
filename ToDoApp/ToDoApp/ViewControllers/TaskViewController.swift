//
//  TaskViewController.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 16/11/2022.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var TaskTitle: UILabel!
    @IBOutlet weak var mDoneBtn: UIButton!
    @IBOutlet weak var TaskDescription: UITextView!
    @IBOutlet weak var DueDate: UILabel!
    var data: Todo?
    
    lazy private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mDoneBtn.layer.cornerRadius = 20
        if let task = data {
            TaskTitle.text = task.Title
            TaskDescription.text = task.TaskDescription
            if (data?.DueDate != nil) {
                DueDate.text = dateFormatter.string(from: task.DueDate!)
            } else {
                DueDate.text = "Date not set..."
            }
            
        } else {
            TaskTitle.text = "404 ERROR"
            TaskDescription.text = ""
        }
        TaskDescription.isEditable = false
    }
    
    @IBAction func SetDone(_ sender: UIButton) {
        if let todo = data {
            DB.changeStatus(todo: todo)
            myData = DB.getAllTodos()
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadCalendar"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadCategoryTasks"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
    
    
}

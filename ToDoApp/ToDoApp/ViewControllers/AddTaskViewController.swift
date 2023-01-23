//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 27/11/2022.
//

import UIKit

class AddTaskViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var mSaveBtn: UIButton!
    @IBOutlet weak var dueDate: UIDatePicker!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mSaveBtn.layer.cornerRadius = 20
        taskDescription.delegate = self
        
        taskDescription.text = "Description"
        taskDescription.textColor = UIColor.lightGray
        // create the alert
        let alert = UIAlertController(title: "Todo-App (ElYousfi/Waly) tuto",
                                      message: "Create your task by adding title, date and description", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let todo = Todo(
            title: (taskTitle.text!.isEmpty ? "Untitled" : taskTitle.text) ?? "Untitled",
            desc: taskDescription.text.elementsEqual("Description") ? "" : taskDescription.text,
            id: myData.count + 1,
            done: false,
            date: dueDate.date)
        DB.insertTodo(todo: todo)
        myData = DB.getAllTodos()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        navigationController?.popViewController(animated: true)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
}

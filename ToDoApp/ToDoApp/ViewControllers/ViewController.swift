//
//  ViewController.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 29/10/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var mSearchTF: UITextField!
    @IBOutlet weak var tasksDataView: UITableView!
    var myFilterData = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = DB.openDatabase()
        DB.createTodoTable()
        myData = DB.getAllTodos()
        myFilterData = DB.getAllTodos()
        tasksDataView.dataSource = self
        self.mSearchTF.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        myFilterData = DB.getAllTodos()
        self.tasksDataView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TaskViewController {
            let row = tasksDataView.indexPathForSelectedRow!.row
            viewController.data = myFilterData[row]
        }
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let searchText  = textField.text! + string
        
        if searchText.count >= 2 {
            
            myFilterData = myData.filter({ (result) -> Bool in
                return result.Title.range(of: searchText, options: .caseInsensitive) != nil || result.TaskDescription.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            
        }
        else{
            myFilterData = myData
        }
        tasksDataView.reloadData()
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
            DB.deleteTodo(todo: myFilterData[row])
            myData = DB.getAllTodos()
            myFilterData = DB.getAllTodos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFilterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtask", for: indexPath) as! TaskCell
        
        cell.TaskTitle?.text = myFilterData[indexPath.row].Title
        cell.TaskSubtitle?.text = myFilterData[indexPath.row].TaskDescription
        return cell
    }
}
var myData = [Todo]()

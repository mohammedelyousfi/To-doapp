//
//  CalendarViewController.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 10/12/2022.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var rows = SECTION_TITLES
    @IBOutlet weak var tasksDataView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks(section:"Today")
        tasksDataView.dataSource = self
        tasksDataView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadCalendar), name: NSNotification.Name(rawValue: "loadCalendar"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (rows[indexPath.row].IsSectionTitle) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionTitle", for: indexPath) as! SectionCell
            cell.SectionTitle?.text = rows[indexPath.row].Title
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtask", for: indexPath) as! TaskCell
        cell.TaskTitle?.text = rows[indexPath.row].Title
        cell.TaskSubtitle?.text = rows[indexPath.row].data?.TaskDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (rows[indexPath.row].IsSectionTitle) {
            loadTasks(section: rows[indexPath.row].Title)
            self.tasksDataView.reloadData()
        }
    }
    
    func loadTasks(section: String) {
        rows = []
        if (section == "Today") {
            let today = myData.filter { (task: Todo) -> Bool in
                task.DueDate != nil && Calendar.current.isDateInToday(task.DueDate!)
            }
            rows.append(TODAY)
            for item in today {
                rows.append(Section(todo: item))
            }
            rows.append(contentsOf: [TOMORROW, THIS_WEEK, LATER])
        }
        if (section == "Tomorrow") {
            let tomorrow = myData.filter { (task: Todo) -> Bool in
                task.DueDate != nil && Calendar.current.isDateInTomorrow(task.DueDate!)
            }
            rows.append(contentsOf: [TODAY, TOMORROW])
            for item in tomorrow {
                rows.append(Section(todo: item))
            }
            rows.append(contentsOf: [THIS_WEEK, LATER])
        }
        if (section == "This Week") {
            let today = Date.today()
            let monday = Date.today().next(.monday, considerToday: false)
            let thisWeek = myData.filter { (task: Todo) -> Bool in
                task.DueDate != nil && task.DueDate! >= today && task.DueDate! < monday
            }
            rows.append(contentsOf: [TODAY, TOMORROW, THIS_WEEK])
            for item in thisWeek {
                rows.append(Section(todo: item))
            }
            rows.append(LATER)
        }
        if (section == "Later") {
            let monday = Date.today().next(.monday)
            let later = myData.filter { (task: Todo) -> Bool in
                task.DueDate != nil && task.DueDate! > monday
            }
            rows.append(contentsOf: [TODAY, TOMORROW, THIS_WEEK, LATER])
            for item in later {
                rows.append(Section(todo: item))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tasksDataView.indexPathForSelectedRow!.row
        if (!rows[row].IsSectionTitle) {
            if let viewController = segue.destination as? TaskViewController {
                viewController.data = rows[row].data
            }
        }
    }
    
    @objc func loadCalendar(notification: NSNotification){
        loadTasks(section:"Today")
        self.tasksDataView.reloadData()
    }
    
}

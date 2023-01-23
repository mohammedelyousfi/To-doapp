//
//  Sections.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 10/12/2022.
//

import UIKit

class Section: NSObject {
    var Title : String = ""
    var IsSectionTitle : Bool = false
    var Checked : Bool = false
    var data : Todo? = nil
    
    init(title: String, isSectionTitle: Bool = false, isChecked: Bool = false) {
        self.Title = title
        self.IsSectionTitle = isSectionTitle
        self.Checked = isChecked
    }
    
    init(todo : Todo) {
        self.data = todo
        self.Title = todo.Title
        self.IsSectionTitle = false
        self.Checked = todo.IsDone
    }
}

var TODAY: Section = Section(title:"Today", isSectionTitle: true)
var TOMORROW: Section = Section(title:"Tomorrow", isSectionTitle: true)
var THIS_WEEK: Section = Section(title:"This Week", isSectionTitle: true)
var LATER: Section = Section(title:"Later", isSectionTitle: true)

var SECTION_TITLES = [TODAY, TOMORROW, THIS_WEEK, LATER]

//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Mohammed El Yousfi on 10/12/2022.
//

import UIKit

class TaskCell: UITableViewCell {


    @IBOutlet weak var TaskTitle: UILabel!
    @IBOutlet weak var TaskSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

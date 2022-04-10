//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Domenica Torres on 4/10/22.
//

import UIKit
protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender:ToDoCell)

}

class ToDoCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    weak var delegate: ToDoCellDelegate?

    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
}

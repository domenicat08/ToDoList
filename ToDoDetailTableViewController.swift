//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Domenica Torres on 4/10/22.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDateDatePicker: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var toDo: ToDo?
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDueDate: Date
        
        if let toDo = toDo {
            navigationItem.title = "To Do"
            titleTextField.text = toDo.title
            isCompleteButton.isSelected = toDo.isComplete
            currentDueDate = toDo.dueDate
            notesTextView.text = toDo.notes
        } else {
            currentDueDate = Date().addingTimeInterval(24*60*60)
        }
        dueDateDatePicker.date = currentDueDate
        //updateDueDateLabel(date: currentDueDate)
       // updateSaveButtonState ()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            switch indexPath {
            case datePickerIndexPath where isDatePickerHidden == true:
                return 0
            case notesIndexPath:
                return 200
            default:
                return UITableView.automaticDimension
            }
        }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]:
            isDatePickerHidden = !isDatePickerHidden
            
            dueDateLabel.textColor = isDatePickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
   
        func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
        func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()  //this will prevent the user to create a "to do" list without a title
    }
    
        func returnPressed(_ sender: UITextField, forEvent event: UIEvent) {
        sender.resignFirstResponder()
    }
    
        func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    func updateDueDateLabel(date: Date){
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
   
        
        func prepare (for segue: UIStoryboardSegue, sender: Any?){
        
            guard segue.identifier == "saveUnwind" else { return }
            
            let title = titleTextField.text!
            let isComplete = isCompleteButton.isSelected
            let dueDate = dueDateDatePicker.date
            let notes = notesTextView.text
        
        //toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        if toDo != nil{
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
        } else {
            toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        }
  
    }

 

    
  
    
    
}
}

//
//  ViewController.swift
//  PomodoroToDo
//
//  Created by Brian Alldred on 13/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var items = ["item1", "item2" , "item3"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeItems = defaults.array(forKey: K.Keys.todoArray) as? [String] {
            items = safeItems
        }
        
    }

    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get a reference to the cell selected and toggle checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField : UITextField?
        
        let alert = UIAlertController(title: "Add new TODO list item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // save the item to the cells
            if let safeTextField = textField {
                print(safeTextField.text!)
                self.items.append(safeTextField.text!)
                self.defaults.set(self.items, forKey: K.Keys.todoArray)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}


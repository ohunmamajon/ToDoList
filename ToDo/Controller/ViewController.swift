//
//  ViewController.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/02/20.
//

import UIKit

class ViewController: UITableViewController {
    let defaults = UserDefaults.standard

   var itemArray = [Item]()
        override func viewDidLoad() {
            super.viewDidLoad()
            
           let newItem = Item()
            newItem.title = "Hello John"
            itemArray.append(newItem)
            let newItem1 = Item()
             newItem1.title = "Hello Alex"
             itemArray.append(newItem1)
            let newItem2 = Item()
             newItem2.title = "Hello Geremy"
             itemArray.append(newItem2)
            
            
//            if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//                itemArray = items
//            }
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            let item = itemArray[indexPath.row]
            cell.textLabel?.text = item.title
            if item.done == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
    
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


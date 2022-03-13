//
//  ViewController.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/02/20.
//

import UIKit
import CoreData
class ViewController: UITableViewController{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   var itemArray = [Item]()
        override func viewDidLoad() {
            super.viewDidLoad()
           
            print ( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            loadItems()
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            let item = itemArray[indexPath.row]
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            return cell
        }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItems()
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems () {
        
        do {
            try context.save()
        } catch {
           print ("Error saving context, \(error)")
        }
    }
    func loadItems (with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do {
           itemArray = try context.fetch(request)
        } catch {
           print ("Error fetching context, \(error)")
        }
    }
    
}

//MARK: - Search Bar methods
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
        tableView.reloadData()
    }
}

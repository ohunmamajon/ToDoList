//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/05/07.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCategories()

    }
    
    //MARK: - Tableview DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet"
        return cell
    
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row] 
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do{
            try realm.write {
                realm.add(category)
            } }
        catch {
            print("error saving category \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories() {
         categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newCategory = Category()
            newCategory.name = textfield.text!
            self.save(category: newCategory)
            
            
        }
        alert.addAction(action)
        alert.addTextField { field in
            textfield = field
            textfield.placeholder = " Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
    
}

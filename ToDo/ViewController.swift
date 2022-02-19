//
//  ViewController.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/02/20.
//

import UIKit

class ViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demo"]
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            cell.textLabel?.text = itemArray[indexPath.row]
            return cell
        }

}

//
//  ViewController.swift
//  Todoey
//
//  Created by Sathish Gangichetty on 2/14/19.
//  Copyright © 2019 Sathish Gangichetty. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Destroy Demogorgon"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find eleven"
        itemArray.append(newItem3)
        
//        self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    
    //MARK - Tableview DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create Cell and Load Data
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title //Set Cell Title
        
        
        let item = itemArray[indexPath.row]
        
        //Set Accessory Check Mark - Programming logic using Ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none
        
    
        return cell
    }
    
    // MARK - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Respond to selection
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData() //Reload Data To Ensure Data Integrity
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK -  Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks add item button
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField{
            (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
  
    }
    
}



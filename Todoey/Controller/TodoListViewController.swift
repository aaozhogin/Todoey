//
//  ViewController.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 10/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit





class TodoListViewController: UITableViewController {
//
//    defaults.set(itemArray, forkey: "TodoListArray")
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
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
//        print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
////            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            itemArray[indexPath.row].done = true
//            print("updated accessoryType with checkbox")
        
            self.tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
//        self.defaults.set(itemArray, forKey: "TodoListArray1")
        
       saveItems()
        
        self.tableView.reloadData()
    }
    
    //MARK: Add button
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks add item button in UI Alert
                let oneMoreItem = Item()
                oneMoreItem.title = textField.text!
                self.itemArray.append(oneMoreItem)
            
                self.saveItems()
                self.tableView.reloadData()
                
            }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            try itemArray = decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding: \(error)")
            }
        }
    }
}
    
    



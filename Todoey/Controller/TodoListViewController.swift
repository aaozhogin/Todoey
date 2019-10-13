//
//  ViewController.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 10/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {
//
//    defaults.set(itemArray, forkey: "TodoListArray")
    var itemArray = [Item]()
//    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newItem = Item()
//        newItem.title = "new"
//        newItem.done = false
//        searchBar.delegate = self

//        print(dataFilePath)
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
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
//
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert)
        
   
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks add item button in UI Alert
            
            
            let newItem = Item(context: self.context)
            newItem.title  = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.saveItems()
    //                let oneMoreItem = Item()
    //                oneMoreItem.title = textField.text!
    //                self.itemArray.append(oneMoreItem)
    //
    //                self.saveItems()
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
 
        do {
            
            try context.save()
            
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Error fetching data from context \(error)")
        }
            
    }   
}
//MARK: Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//        loadItems(with: request)
//    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
             let request : NSFetchRequest<Item> = Item.fetchRequest()
                   
                   request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
               
                   
                   request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                   
                   
                   loadItems(with: request)
            self.tableView.reloadData()
           }
        }
    }
   
    



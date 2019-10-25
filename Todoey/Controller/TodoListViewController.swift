//
//  ViewController.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 10/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
//
//    defaults.set(itemArray, forkey: "TodoListArray")
    let realm = try! Realm()
    
    var toDoItems : Results<Item>!
    
    var selectedCategory : Category? {
        
        didSet {
            loadItems()
        }
    }
//    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            loadItems()
//        let newItem = Item()
//        newItem.title = "new"
//        newItem.done = false
//        searchBar.delegate = self

//        print(dataFilePath)
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        }
        
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row]
        {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
                     
            
        } else {cell.textLabel?.text = "No items added"}
        
     
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
//                try realm.write {
//                    realm.delete(item)
                }
            
            } catch {print("\(error)")}
            
            tableView.reloadData()
        }
//        print(itemArray[indexPath.row])
//
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
//        toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
////            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            itemArray[indexPath.row].done = true
//            print("updated accessoryType with checkbox")
        
            
        
//        self.defaults.set(itemArray, forKey: "TodoListArray1")
        
//        saveItems(item: newItem)
        
        
    }
    
    //MARK: Add button
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert)
        
   
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks add item button in UI Alert
            
            if let currentCategory = self.selectedCategory {
            
            do {
                try self.realm.write {
                      let newItem = Item()
                      newItem.title  = textField.text!
                      currentCategory.items.append(newItem)
                      newItem.dateCreated = Date()
                   }
                } catch {
                    print("\(error)")}
            }
            
            self.tableView.reloadData()
            

}
//            newItem.parentCategory = self.selectedCategory
            
            
            
//            self.itemArray.append(newItem)
//            self.saveItems()
    //                let oneMoreItem = Item()
    //                oneMoreItem.title = textField.text!
    //                self.itemArray.append(oneMoreItem)
    //
         
           
                
            
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
//    func saveItems(item: Item) {
//
//        do {
//            try realm.write {realm.add(item)}
////            try context.save()
//
//        } catch {
//            print("Error saving context: \(error)")
//        }
//        tableView.reloadData()
    
    
    func loadItems() {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        toDoItems = realm.objects(Item.self)
        tableView.reloadData()
//        let request : NSFetchRequest<Item> = Item.fetchRequest()

        //creating predicate
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        //adding predicate to the request

//        if let additionalPredicate = predicate {
//
//            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//            request.predicate = compoundPredicate
//        } else {
//            request.predicate = categoryPredicate
//
//        }
//            do {
//            itemArray = try context.fetch(request)
//            tableView.reloadData()
//        } catch {
//            print("Error fetching data from context \(error)")
//        }

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
            
            toDoItems =  toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            
           }
        tableView.reloadData()
        }
    }





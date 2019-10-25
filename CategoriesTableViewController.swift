//
//  CategoriesTableViewController.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 11/10/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

//import UIKit
//import CoreData
import RealmSwift

class CategoriesTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray?[indexPath.row]
           
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        
           return cell
       }

    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
//            self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
            
//            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    
    
    // MARK: - Table view data source



    
    func loadCategories() {

        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
        
    }
//    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
//        do {
//                  categoryArray = try context.fetch(request)
//                  tableView.reloadData()
//              } catch {
//                  print("Error fetching data from context \(error)")
//              }
//                  
//        
//        }
       
    func save(category: Category) {
    
           do {
               
            try realm.write {
                realm.add(category)
            }
               
           } catch {
               print("Error saving context: \(error)")
           }
        tableView.reloadData()
       }
    

    //MARK: TableView Delegate Mehods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDoItems", sender: self)  
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categoryArray?[indexPath.row]
            
        }
    }
}

extension CategoriesTableViewController: UISearchBarDelegate {
    
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            //loadCategories()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        } else {
//            let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
//
//            request.sortDescriptors = [NSSortDescriptor(key:"name", ascending: true)]
//
//            loadCategories(with: request)
            
        }
    
    
    


//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Philip Aggesen on 27/01/2019.
//  Copyright © 2019 PFA. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        loadCategories()


    }

    //MARK: TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    //MARK: Data Manipulation Methods
    
    func loadCategories() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()

        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error getting categories into the array: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func saveCategories() {
        do {
            try context.save()
            print("Saving to context")
        } catch {
            print("Error saving: \(error) ")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (alertaction) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = alertTextField.text
            self.categoryArray.append(newCategory)
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            alertTextField = textField
            alertTextField.placeholder = "Add a new category"
            
        }

        present(alert, animated: true, completion: nil)
    }
    
     //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
        
    }
    
    
}

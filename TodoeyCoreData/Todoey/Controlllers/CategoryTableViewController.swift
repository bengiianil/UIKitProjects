//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Bengi Anıl on 29.12.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import CoreData
import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // context, data save edilene kadar geçici depolama sağlar
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categoryArray[indexPath.row]
        }
    }

    // MARK: - Functions
    private func saveItems() { ///Write
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    private func loadItems(request: NSFetchRequest<Category> = Category.fetchRequest()) { ///Read
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from  context \(error)")
        }
        self.tableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            ///Create:
            let newItem = Category(context: self.context)
            newItem.name = textField.text ?? ""
            self.categoryArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true)
    }
}

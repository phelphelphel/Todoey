//
//  ViewController.swift
//  Todoey
//
//  Created by Philip Aggesen on 20/01/2019.
//  Copyright © 2019 PFA. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Get milk", "Find the cat", "Play soccer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Tableview datasource delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        if selectedCell?.accessoryType == .checkmark {
            selectedCell?.accessoryType = .none
        }
        else {
            selectedCell?.accessoryType = .checkmark
        }

        
    }   

}


//
//  GroceryListsTableViewController.swift
//  Grocery List-1
//
//  Created by Khalid Mohamed on 11/17/16.
//  Copyright © 2016 Khalid Mohamed. All rights reserved.
//

import UIKit
import CoreData

class GroceryListsTableViewController: UITableViewController {
    
    var managedObjectContext :NSManagedObjectContext!
    var stores: [Store] = []
 

    
    @IBAction func addGroceryStore (_ sender:AnyObject) {
        let alert = UIAlertController(title: "New Grocery Store", message: "Add a New Grocery Store", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
        guard let textfield = alert.textFields?.first
            else {
                return
        
         self.tableView.reloadData()
        }
            
        let store = NSEntityDescription.insertNewObject(forEntityName: "Store", into: self.managedObjectContext) as! Store
            
         store.name = textfield.text
            
        try! self.managedObjectContext.save()
         self.stores.append(store)
         self.tableView.reloadData()
            
          
        
    }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
       
        
    }

    func populategroceryLists() {
        let request = NSFetchRequest<Store>(entityName: "Store")
        self.stores = try! self.managedObjectContext.fetch(request)
        self.tableView.reloadData()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Shopping List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier : "Cell")
        
        populategroceryLists()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Store = stores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Store.value(forKeyPath:"name") as? String

        return cell
    }
    
    // Override to support conditional editing of the table view.
    //override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
     //   return true
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle .delete {
         self.stores.remove(at: indexPath.row)
         self.tableView.reloadData()
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

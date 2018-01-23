//
//  TableViewController.swift
//  Les 1
//
//  Created by Maurice on 11/10/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var articleList: [Article] = [ ]
    var nextId : Int = 0
    let webservice = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webservice.getRootObject(withSuccess: { (rootObject) in
            
            self.articleList = rootObject.results
            self.nextId = rootObject.nextId
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        return articleList.count
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){   /*Get the new view controller using segue.destinationViewController.*/  /* Pass the selected object to the new view controller.*/
        if let viewController = segue.destination as? DetailsViewController
        {
            if let cell = sender as? TableViewCell
            {
                viewController.article = cell.article
                viewController.titleText = cell.lableTitle.text;
                viewController.descriptionText = cell.lableDescription.text;
            }
        }
    }
 
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row >= self.articleList.count - 1){
            webservice.getMoreRootObjects(nextId: nextId, withSuccess: { (rootObject) in
                self.articleList += rootObject.results
                self.nextId = rootObject.nextId
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOverview", for: indexPath) as! TableViewCell
        //cell = array[indexPath.row].title
        
        cell.article = articleList[indexPath.row];
        cell.setData()
        cell.runImageFetch()
        
        
        
        
        //indexPath.row voor index van de array van de tableview

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

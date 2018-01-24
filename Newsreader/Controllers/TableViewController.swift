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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _webservice.getRootObject(withSuccess: { (rootObject) in
            self.articleList = rootObject.results
            self.nextId = rootObject.nextId
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articleList.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let viewController = segue.destination as? DetailsViewController
        {
            if let cell = sender as? TableViewCell
            {
                viewController.article = cell.article
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row >= self.articleList.count - 1){
            _webservice.getMoreRootObjects(nextId: nextId, withSuccess: { (rootObject) in
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
        cell.load()

        return cell
    }
}

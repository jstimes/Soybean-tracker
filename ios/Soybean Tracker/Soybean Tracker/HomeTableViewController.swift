//
//  HomeTableViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/6/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit
import Alamofire

class HomeTableViewController: UITableViewController {
    
    var entries = [SoybeanData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Entries"
        
        //let parameters: Parameters = ["id": 11]
        Alamofire.request("https://baskar-group.me.iastate.edu/soybean_app/get.php?id=11", method: .get/*, parameters: parameters, encoding: JSONEncoding.default*/)
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
        if entries.count == 0 {
            self.navigationController?.setToolbarHidden(true, animated: false)
        }
        else {
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
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
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)

        let index = indexPath.row
        let entry = entries[index]
        cell.imageView?.image = UIImage(contentsOfFile: entry.imagePath!)
        
        cell.textLabel?.text = Utils.stringForDate(entry.date!)
        cell.detailTextLabel?.text = entry.disease

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func uploadOnClick(btn: UIBarButtonItem) {
        print("ooowee")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination
        
        if segue.identifier == "Create" {
            let navVC = destination as! UINavigationController
            let createEntryVC = navVC.visibleViewController as! CreateEntryViewController
            createEntryVC.homeReference = self
        }
        
        //if let detailVC = destination as? EntryDetailViewController {
    }
    

}

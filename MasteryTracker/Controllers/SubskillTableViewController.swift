//
//  SkillTableViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class SubskillTableViewController: UITableViewController {
    
    var data: Int? = 0
    var subskills: [Subskill] = []
    
    @objc func showExpertises(sender: UITapGestureRecognizer) {
        let position: CGPoint =  sender.location(in: self.tableView)
        let indexPath: IndexPath = self.tableView.indexPathForRow(at: position)!
        let cell = self.tableView.cellForRow(at: indexPath) as! EntryTableViewCell
        performSegue(withIdentifier: "ShowExpertisesSegue", sender: cell)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "ShowSubskillDetailSegue", sender: cell)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Subskill.listSubskillsRows()
        subskills = Subskill.getSubskillsForSkill(num:data!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subskills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SubskillTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EntryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EntryTableViewCell.")
        }
        
        let subskill = subskills[indexPath.row]
        
        cell.nameLabel.text = subskill.name
        cell.ratingLabel.text = subskill.rating.description
        cell.id = subskill.id
        cell.tapRecognizer1.addTarget(self, action: #selector(SubskillTableViewController.showExpertises))
        cell.nextViewImage.gestureRecognizers = []
        cell.nextViewImage.gestureRecognizers!.append(cell.tapRecognizer1)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationViewController = segue.destination as? ExpertiseTableViewController {
            destinationViewController.subskillNum = (sender as! EntryTableViewCell).id
            destinationViewController.skillNum = data
        } else if let destinationViewController = segue.destination as? SubskillDetailViewController {
            destinationViewController.subskill = subskills[self.tableView.indexPath(for: sender as! EntryTableViewCell)!.row]
        }
    }
    

}

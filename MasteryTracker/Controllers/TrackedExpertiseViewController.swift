//
//  ExpertiseTableViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class TrackedExpertiseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: Properties
    
    @IBOutlet weak var trackedExpertisesTableView: UITableView!
    
    @IBOutlet weak var weekDaysLeading: NSLayoutConstraint!
    @IBOutlet weak var weekDays: WeekDays!
    
    var expertises = [Expertise]()
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        //print("Unwind to Root View Controller")
    }
    
    //MARK: Private Methods
    
    private func loadExpertises() {
        expertises = Expertise.getTrackedExpertises()
    }
    
    //MARK: Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return expertises.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TrackedExpertiseTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrackedExpertiseTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TrackedExpertiseTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let expertise = expertises[indexPath.row]
        
        cell.expertise = expertise
        cell.nameLabel.text = expertise.name
        cell.ratingLabel.text = expertise.rating.description
        cell.weekTracker.setTracking(id: expertise.id, type: CriteriaType.expertise)
        cell.weekTracker.updateButtons()
        weekDaysLeading.constant = cell.weekTracker.frame.origin.x - 6
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "ShowTrackedReportSegue", sender: cell)
    }

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.tableView.contentInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.size.height, left:  CGFloat(0.0), bottom: CGFloat(0.0), right: CGFloat(0.0))
         */
        // Load Sample Data
        trackedExpertisesTableView.dataSource = self
        trackedExpertisesTableView.delegate = self
        loadExpertises()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        loadExpertises()
        weekDays.reloadInputViews()
        trackedExpertisesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
     
        if let destinationViewController = segue.destination as? TrackedReportViewController {
            destinationViewController.expertise     = (sender as! TrackedExpertiseTableViewCell).expertise
        }
    }
}

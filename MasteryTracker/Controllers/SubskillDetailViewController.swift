//
//  SubskillDetailViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-05.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class SubskillDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var criteriaTable: UITableView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var ratingName: UILabel!
    @IBOutlet weak var subskillName: UILabel!
    @IBOutlet weak var trackingImage: UIImageView!
    @IBOutlet weak var previousImage: UIImageView!
    @IBOutlet weak var nextImage: UIImageView!
    
    var skillNum: Int?
    var subskillNum: Int?
    var subskill: Subskill?
    var criterias: [Criteria] = [Criteria]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard subskill != nil else {
            fatalError("SubskillDetailViewController received subskill as nil")
        }
        criterias = Criteria.getCriteriaForType(type: CriteriaType.subskill)
        criteriaTable.dataSource = self
        criteriaTable.delegate = self
        ratingNumber.text = subskill!.rating.description
        ratingName.text = criterias[subskill!.rating].name
        subskillName.text = subskill!.name
        
    }

    @IBAction func changeRating(sender: UITapGestureRecognizer) {
        var rating: Int
        if(sender.view == previousImage) {
            rating = subskill!.decrementRating()
            ratingNumber.text = rating.description
            ratingName.text = criterias[rating].name
        } else if (sender.view == nextImage) {
            rating = subskill!.incrementRating()
            ratingNumber.text = rating.description
            ratingName.text = criterias[rating].name
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RatingDescription"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CriteriaTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CriteriaTableViewCell.")
        }
        
        let criteria = criterias[indexPath.row]
        
        cell.criteriaRatingLabel?.text = criteria.rating.description
        cell.criteriaNameLabel?.text = criteria.name
        cell.criteriaDescriptionLabel?.text = criteria.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterias.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

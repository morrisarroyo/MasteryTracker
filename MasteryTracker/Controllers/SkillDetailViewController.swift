//
//  SkillDetailViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-06.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class SkillDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var criteriaTable: UITableView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var ratingName: UILabel!
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var trackingImage: UIImageView!
    @IBOutlet weak var previousImage: UIImageView!
    @IBOutlet weak var nextImage: UIImageView!
    
    var skillNum: Int?
    var skill: Skill?
    var criterias: [Criteria] = [Criteria]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard skill != nil else {
            fatalError("SkillDetailViewController received skill as nil")
        }
        criterias = Criteria.getCriteriaForType(type: CriteriaType.skill)
        criteriaTable.dataSource = self
        criteriaTable.delegate = self
        ratingNumber.text = skill!.rating.description
        ratingName.text = criterias[skill!.rating].name
        skillName.text = skill!.name
    }

    @IBAction func changeRating(sender: UITapGestureRecognizer) {
        var rating: Int
        if(sender.view == previousImage) {
            rating = skill!.decrementRating()
        } else {
            rating = skill!.incrementRating()
        }
        ratingNumber.text = rating.description
        ratingName.text = criterias[rating].name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RatingDescription"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CriteriaTableViewCell else {
            fatalError("The dequeued cell is not an instance of CriteriaTableViewCell - SkillDetailViewController")
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

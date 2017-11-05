//
//  CriteriaViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-03.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class ExpertiseCriteriaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var criteriaTable: UITableView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var ratingName: UILabel!
    @IBOutlet weak var trackingImage: UIImageView!
    @IBOutlet weak var expertiseName: UILabel!
    @IBOutlet weak var previousImage: UIImageView!
    @IBOutlet weak var nextImage: UIImageView!
    
    var skillNum: Int?
    var subskillNum: Int?
    var expertiseNum: Int?
    var expertise: Expertise?
    var criterias: [Criteria] = [Criteria]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Criteria.listCriteriasRows()
        guard expertise != nil else { fatalError("ExpertiseCriteriaViewController received expertise as nil")
        }
        criterias = Criteria.getCriteriaForType(type:  CriteriaType.expertise)
        criteriaTable.dataSource = self
        criteriaTable.delegate = self
        ratingNumber.text = expertise!.rating.description
        ratingName.text = criterias[expertise!.rating].name
        expertiseName.text = expertise!.name
        setTrackedImage(tracked: expertise!.tracked)
    }

    @IBAction func changeRating(sender: UITapGestureRecognizer) {
        var rating: Int
        if(sender.view == previousImage) {
            rating = expertise!.decrementRating()
            ratingNumber.text = rating.description
            ratingName.text = criterias[rating].name
        } else if (sender.view == nextImage) {
            rating = expertise!.incrementRating()
            ratingNumber.text = rating.description
            ratingName.text = criterias[rating].name
        }
    }
    
    @IBAction func toggleTracked(sender: UITapGestureRecognizer) {
        print("toggle")
        setTrackedImage(tracked: expertise!.toggleTracked())
    }
    
    func setTrackedImage(tracked: Bool) {
        if (tracked) {
            trackingImage.image = #imageLiteral(resourceName: "checkboxTicked")
        } else {
            trackingImage.image = #imageLiteral(resourceName: "checkboxBlank")
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //let cell = criteriaTable.dequeueReusableCell(withIdentifier: "RatingDescription", for: indexPath)
        //cell.subviews[0].
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = criteriaTable.dequeueReusableCell(withIdentifier: "RatingDescription", for: indexPath)
        //cell.subviews[0].
        return cell
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

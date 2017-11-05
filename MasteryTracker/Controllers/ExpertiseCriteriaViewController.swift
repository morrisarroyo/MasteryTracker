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
    
    var skillNum: Int?
    var subskillNum: Int?
    var expertiseNum: Int?
    var expertise: Expertise?
    var criterias: [Criteria] = []
    var criteriaCell:  CriteriaTableViewCell = CriteriaTableViewCell()
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
        trackingImage.image = #imageLiteral(resourceName: "checkboxBlank")
        expertiseName.text = expertise!.name
        // Do any additional setup after loading the view.
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

//
//  CriteriaViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-03.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class ExpertiseCriteriaViewController: UITableViewController {
    @IBOutlet weak var criteriaTable: UITableView!
    
    var skillNum: Int?
    var subskillNum: Int?
    var expertiseNum: Int?
    var criterias: [Criteria] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        criterias = Criteria.getCriteriaForType(type:  CriteriaType.expertise)
        criteriaTable.dataSource = self
        criteriaTable.delegate = self
        criteriaTable.register(UITableViewCell.self, forCellReuseIdentifier:"RatingDescription")
        //Criteria.listCriteriasRows()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = criteriaTable.dequeueReusableCell(withIdentifier: "RatingDescription", for: indexPath)
        //cell.subviews[0].
        return cell
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

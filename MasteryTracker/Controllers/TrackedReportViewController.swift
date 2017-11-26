//
//  TrackedReportViewController.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-15.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class TrackedReportViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var trackedName: UILabel!
    @IBOutlet weak var total: UILabel!
    private var report: TrackedReport!
    private var trackedDays: [TrackedDay]!
    var expertise:Expertise!
    override func viewDidLoad() {
        super.viewDidLoad()
        let abs = TrackedAbstraction()
        report = abs.getTrackedReportForExpertise(id: expertise.id)
        trackedDays = abs.getTrackedDaysForExpertise(id: expertise.id)
        message.text = "Keep Going!"
        trackedName.text = expertise.name
        total.text = report.total.description
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

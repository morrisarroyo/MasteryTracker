//
//  TrackedExpertiseTableViewCell.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-18.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class TrackedExpertiseTableViewCell: UITableViewCell {

    //Mark: Properties
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var WeekTracker: WeekTracker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CriteriaTableViewCell.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-03.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class CriteriaTableViewCell: UITableViewCell {
   
    @IBOutlet weak var criteriaNameLabel: UILabel!
    @IBOutlet weak var criteriaRatingLabel: UILabel!
    @IBOutlet weak var criteriaDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

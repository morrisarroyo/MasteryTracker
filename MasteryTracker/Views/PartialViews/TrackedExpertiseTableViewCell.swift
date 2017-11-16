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
    @IBOutlet weak var weekTracker: WeekTracker!
    var expertise: Expertise!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    override func prepareForReuse() {
        ratingLabel.text = nil
        nameLabel.text = nil
        weekTracker = WeekTracker()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        <#code#>
    }

    required init?(coder aDecoder: NSCoder) {
        
    }
 */
}

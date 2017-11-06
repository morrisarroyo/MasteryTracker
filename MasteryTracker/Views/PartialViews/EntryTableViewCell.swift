//
//  EntryTableViewCell.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var ratingLabel: UITextField!
    @IBOutlet weak var nextViewImage: UIImageView!
    let tapRecognizer1: UITapGestureRecognizer = UITapGestureRecognizer()
    var id: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

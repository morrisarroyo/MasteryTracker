//
//  WeekDays.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-07.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class WeekDays: UIStackView {

    //private var days: Int
    @IBInspectable var daySize: CGSize = CGSize(width: 35.0, height: 35.0) {
        didSet {
            //setupButtons()
        }
    }
    @IBInspectable var dayCount: Int = 7 {
        didSet {
            //setupButtons()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

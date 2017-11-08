//
//  WeekDays.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-07.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class WeekDays: UIStackView {

    private var dayLabels = [UILabel] ()
    
    @IBInspectable var width: CGFloat = CGFloat(35.0) {
        didSet {
            setupDays()
        }
    }
    
    @IBInspectable var dayCount: Int = 7 {
        didSet {
            setupDays()
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
        setupDays()
        
    }
    
    //Mark: Private Methods
    private func setupDays() {
        for label in dayLabels {
            removeArrangedSubview(label)
            label.removeFromSuperview()
        }
        var date = Date()
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E\nMMM d")
        
        for i in 0..<dayCount {
            print(i)
            let label = UILabel()
            // Attributes
            label.textAlignment = NSTextAlignment.center
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 2
            
            // Set Label Text
            label.text = formatter.string(from: date)
            date = NSCalendar.current.date(byAdding: .day, value: -1, to: date)!
            // Constraints
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
            dayLabels.append(label)
        }
        dayLabels = dayLabels.reversed()
        for label in dayLabels{
            addArrangedSubview(label)
            NSLayoutConstraint(item:label, attribute: .centerYWithinMargins, relatedBy: .equal, toItem: self, attribute: .centerYWithinMargins, multiplier: 1.0, constant: 0.0).isActive = true
            let i = dayLabels.index(of: label)
            if i! > 0 {
                NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: dayLabels[i! - 1], attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
            }
        }
    }
}

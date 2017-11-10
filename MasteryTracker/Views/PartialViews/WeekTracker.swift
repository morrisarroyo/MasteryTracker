//
//  WeekTracker.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-19.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

@IBDesignable class WeekTracker: UIStackView {

    
    //Mark: Properties
    private var dayButtons            = [UIButton] ()
    private var trackedDays           = [TrackedDay]()
    private var trackedReport         : TrackedReport?
    private var daysSinceFirstTracked = 0
    @IBInspectable var daySize: CGSize = CGSize(width: 35.0, height: 35.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var dayCount: Int = 7 {
        didSet {
            setupButtons()
        }
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    //Mark: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    //Mark: Button Action
    @objc func dayButtonPressed(button: UIButton) {
        guard let index = dayButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the dayButtons array: \(dayButtons)")
        }
        dayButtons[index].isSelected = !dayButtons[index].isSelected
        trackedDays[index].done = dayButtons[index].isSelected
        updateTracking(day: trackedDays[index])
    }
    
    func setTracking(id: Int, type: CriteriaType) {
        if type == CriteriaType.expertise {
            let abs = TrackedAbstraction()
            trackedDays = abs.getTrackedDaysForExpertise(id: id)
            trackedReport = abs.getTrackedReportForExpertise(id: id)!
        }
        if(trackedDays.count == 0) {
            print("setTracking, No trackedDays for id \(id) and typeId \(type)")
        }
        if(trackedReport == nil) {
            print("setTracking, No trackedReport for id \(id) and typeId \(type)")
        }
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        print(trackedReport!.firstDay)
        if trackedReport!.firstDay.count > 0 {
            let since = df.date(from: trackedReport!.firstDay)!
            daysSinceFirstTracked = DateUtility.daysDifferenceForDates(from: since, to: Date())
        } else {
            daysSinceFirstTracked = 0
            print("setTracking, No trackedReport.firstDay for id \(id) and typeId \(type) is not a valid date")
        }
    }
    
    //Mark: Private Methods
    func updateButtons() {
        var countDownToFirst = daysSinceFirstTracked
        for i in (0..<trackedDays.count).reversed() {
            if (0 <= countDownToFirst) {
                dayButtons[i].isEnabled   = true
                dayButtons[i].isSelected  = trackedDays[i].done
            }
            countDownToFirst -= 1
        }
    }
    
    func updateTracking(day: TrackedDay) {
        let abs = TrackedAbstraction()
        abs.updateTrackedDay(day)
        //day.dayOffset
        if (day.done) {
            trackedReport!.currentStreak += 1
            if (trackedReport!.currentStreak > trackedReport!.longestStreak) {
                trackedReport!.longestStreak = trackedReport!.currentStreak
            }
        }
        abs.updateTrackedReport(trackedReport!)
    }
    
    private func setupButtons() {
        // clear any existing buttons
        for button in dayButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        dayButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let xMark = UIImage(named: "x", in: bundle, compatibleWith: self.traitCollection)
        let checkMark = UIImage(named:"check", in: bundle, compatibleWith: self.traitCollection)
        let dashMark = UIImage(named:"dash", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<dayCount {
             // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(dashMark, for: .disabled)
            button.setImage(xMark, for: .normal)
            button.setImage(checkMark, for: .selected)
        
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
           button.heightAnchor.constraint(lessThanOrEqualToConstant: daySize.width).isActive = true
            button.widthAnchor.constraint(lessThanOrEqualToConstant: daySize.height).isActive = true
            NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: button, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
            //Setup the button action
            button.addTarget(self, action: #selector(WeekTracker.dayButtonPressed(button:)), for: .touchUpInside)
            button.isEnabled = false
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the day button array
            dayButtons.append(button)
        }
    }
}

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
    private var dayButtons = [UIButton] ()
    
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
    @objc func dayButtonLongPressed(button: UIButton) {
        guard let index = dayButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the dayButtons array: \(dayButtons)")
        }
            dayButtons[index].isSelected = !dayButtons[index].isSelected
    }
    //Mark: Private Methods
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
        
       var i = 0
        for _ in 0..<dayCount {
            i = i + 1
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(xMark, for: .normal)
            button.setImage(checkMark, for: .selected)
        
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: daySize.width).isActive = true
            button.widthAnchor.constraint(equalToConstant: daySize.height).isActive = true
         
            //Setup the button action
            button.addTarget(self, action: #selector(WeekTracker.dayButtonLongPressed(button:)), for: .touchUpInside)
        
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the day button array
            dayButtons.append(button)
        }
    }
    
   
}

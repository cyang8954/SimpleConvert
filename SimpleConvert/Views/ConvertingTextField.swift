//
//  ConvertingTextField.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertingTextField: UIView {

    var textField:UITextField?
    var unitLabel:UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        if (self.unitLabel == nil) {
            
            let textField = UITextField(frame: CGRect.zero)
            self.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.keyboardType = UIKeyboardType.decimalPad
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textField]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["textField":textField]))
            
            textField.font = UIFont.systemFont(ofSize: 15)
            
            textField.backgroundColor = UIColor.white
            
            self.textField = textField
            
            
            let unitLabel = UILabel(frame: CGRect.zero)
            self.addSubview(unitLabel)
            unitLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[unitLabel]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["unitLabel":unitLabel]))
            
            unitLabel.font = UIFont.boldSystemFont(ofSize: 15)
            
            self.unitLabel = unitLabel
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textField]-6-[unitLabel]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["unitLabel":unitLabel,"textField":textField]))
            
            NSLayoutConstraint.init(item: textField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100).isActive = true
            
        }

    }
}

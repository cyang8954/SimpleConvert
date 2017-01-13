//
//  ConvertingTextFieldHeader.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertingTextFieldHeader: UITableViewHeaderFooterView {

    var chooseUnitButton:UIButton?
    var textfield:ConvertingTextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    func setup () {
        if (self.chooseUnitButton == nil) {
            
            let chooseUnitButton = UIButton(frame: CGRect.zero)
            self.contentView.addSubview(chooseUnitButton)
            chooseUnitButton.translatesAutoresizingMaskIntoConstraints = false
            chooseUnitButton.setTitle("Change Unit", for: UIControlState.normal)
            chooseUnitButton.backgroundColor = UIColor.white
            chooseUnitButton.contentEdgeInsets = UIEdgeInsets(top: 6, left:6 , bottom: 6, right: 6)
            chooseUnitButton.layer.cornerRadius = 5
            chooseUnitButton.layer.borderColor = UIColor.blue.cgColor
            chooseUnitButton.setTitleColor(UIColor.blue, for:UIControlState.normal)
            chooseUnitButton.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
            chooseUnitButton.backgroundColor = UIColor.clear
            chooseUnitButton.layer.borderWidth = 1;
            
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[chooseUnitButton]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["chooseUnitButton":chooseUnitButton]))
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[chooseUnitButton]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["chooseUnitButton":chooseUnitButton]))
            
            self.chooseUnitButton = chooseUnitButton
            
            
            let textfield = ConvertingTextField(frame: CGRect.zero)
            self.contentView.addSubview(textfield)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[textfield]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["textfield":textfield]))
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[textfield]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["textfield":textfield]))
            
            self.textfield = textfield
        
            
        }
    }

}

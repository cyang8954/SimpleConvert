//
//  ConvertingTableViewCell.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertingTableViewCell: UITableViewCell {

    private var leftLabel:UILabel?
    private var rightLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    func setup () {
        if (self.leftLabel == nil) {
            
            let leftLabel = UILabel(frame: CGRect.zero)
            self.contentView.addSubview(leftLabel)
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[leftLabel]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["leftLabel":leftLabel]))
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[leftLabel]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["leftLabel":leftLabel]))
            
            leftLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            self.leftLabel = leftLabel
            
            
            let rightLabel = UILabel(frame: CGRect.zero)
            self.contentView.addSubview(rightLabel)
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[rightLabel]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["rightLabel":rightLabel]))
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[rightLabel]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["rightLabel":rightLabel]))
            
            rightLabel.font = UIFont.systemFont(ofSize: 14)
            
            self.rightLabel = rightLabel
            
        }
    }
    
    public func update(withConvertItem convertItem:ConvertItem) {
        self.leftLabel?.text = "\(convertItem.nameToShow!) (\(convertItem.nameInChinese!))"
        self.rightLabel?.text = "\(convertItem.value!) \(convertItem.nameToShowShort!)"
    }

}

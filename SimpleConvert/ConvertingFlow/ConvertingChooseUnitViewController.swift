//
//  ConvertingChooseUnitViewController.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/12/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit


class ConvertingChooseUnitViewController: SCTableViewController {

    let ConvertCellID = "convertCell"
    
    var type:String?
    var allUnitsInType:Array<String>?
    
    var convertedItemList:Array<ConvertItem>?
    
    override func loadView() {
        super.loadView()
        
        self.title = self.type
        self.allUnitsInType = Mapping.unitsInType[type!]
        
        for unit in self.allUnitsInType! {
            
            let convertItem = ConvertItem(withUnit: unit, value: 0)
            self.convertedItemList?.append(convertItem)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ConvertingTableViewCell.classForCoder(), forCellReuseIdentifier: ConvertCellID)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.allUnitsInType?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConvertCellID, for: indexPath) as! ConvertingTableViewCell
        
        let convertItem = self.convertedItemList?[indexPath.row]
        
        cell.updateWithOutValueLabel(withConvertItem: convertItem!)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
}

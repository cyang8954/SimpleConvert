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
    var isAddItem:Bool?
    
    weak var convertingController:ConvertingViewController?
    var exsitingItemList:Array<ConvertItem>?
    
    var allUnitsInType:Array<String>?
    var selectedUnit:String?
    var convertedItemList:Array<ConvertItem>?
    
    override func loadView() {
        super.loadView()
        
        self.title = self.type
        self.allUnitsInType = Mapping.unitsInType[type!]
        
        self.convertedItemList = Array()
        
        var exsitingItemArrayString = Array<String>()
        
        if (self.exsitingItemList != nil) {
        
            for convertItem in self.exsitingItemList! {
                exsitingItemArrayString.append(convertItem.unit!)
            }
        
        }
        
        for unit in self.allUnitsInType! {
            
            var shouldAdd = true
            
            for string in exsitingItemArrayString {
                
                if string == unit {
                    shouldAdd = false
                }
            }
           
            if (shouldAdd) {
                let convertItem = ConvertItem(withUnit: unit, value: 0)
                self.convertedItemList?.append(convertItem)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ConvertingTableViewCell.classForCoder(), forCellReuseIdentifier: ConvertCellID)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.convertedItemList?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConvertCellID, for: indexPath) as! ConvertingTableViewCell
        
        let convertItem = self.convertedItemList?[indexPath.row]
        
        cell.updateWithOutValueLabel(withConvertItem: convertItem!)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUnit = self.convertedItemList?[indexPath.row].unit!
        self.dismiss(animated: true, completion: nil)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        let convertItem = ConvertItem(withUnit: self.selectedUnit!, value: 0)
        
        if (self.isAddItem!) {
            
            //if add item is true, we add the item to converting controller,
            self.convertingController?.addConvertItem(convertItem)
            
        } else {
            
            //else we replace the converted item
            self.convertingController?.replaceConvertedItem(convertItem)
            
        }
        
        super.dismiss(animated: true, completion: completion)
    }
    
}

//
//  ConvertingChooseUnitViewController.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/12/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit


class ConvertingChooseUnitViewController: SCTableViewController, UISearchBarDelegate {

    let ConvertCellID = "convertCell"
    let HeaderID = "headerID"
    
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
        
        self.updateItemList(withSearchString: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ConvertingTableViewCell.classForCoder(), forCellReuseIdentifier: ConvertCellID)
        self.tableView.register(UITableViewHeaderFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: HeaderID)
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderID)
        
        let subViewSearchBar = header?.viewWithTag(-10)
        
        if (subViewSearchBar == nil) {
            
            let searchBar = UISearchBar()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            header?.addSubview(searchBar)
            searchBar.tag = -10
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[searchBar]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["searchBar":searchBar ]))
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchBar]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["searchBar":searchBar ]))
            
            searchBar.delegate = self
            
            
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    // MARK: search bar
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var searchString:String
        
        if (text.characters.count > 0) {
            searchString = searchBar.text! + text
        } else {
            let endIndex = searchBar.text?.index((searchBar.text?.endIndex)!, offsetBy: -1)
            searchString = (searchBar.text?.substring(to: endIndex!))!
        }
            
        self.updateItemList(withSearchString: searchString)
        
        self.tableView.reloadData()
        
        return true
    }
    
    // MARK: navigation
    
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
    
    // MARk: helper
    
    func updateItemList(withSearchString searchString:String?) {
        
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
            
            if (searchString != nil) {
                
                let convertItemToCompare = ConvertItem(withUnit: unit, value: 0)
                
                if convertItemToCompare.unit!.lowercased().contains(searchString!.lowercased()) == false
                    && convertItemToCompare.nameToShow!.lowercased().contains(searchString!.lowercased()) == false
                    && convertItemToCompare.nameToShowShort!.lowercased().contains(searchString!.lowercased()) == false
                    && convertItemToCompare.nameInChinese!.lowercased().contains(searchString!.lowercased()) == false {
                    shouldAdd = false
                }
                
            }
            
            if (shouldAdd) {
                let convertItem = ConvertItem(withUnit: unit, value: 0)
                self.convertedItemList?.append(convertItem)
            }
        }

    }
}

//
//  ConvertingViewController.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

let ConvertCellID = "convertCell"
let ConvertingHeaderID = "headerID"

class ConvertingViewController: SCTableViewController, UITextFieldDelegate {
    
    var type:String?
    var convertingItem:ConvertItem?
    
    var allUnitsInType:Array<String>?
    var unitListToShow:Array<String>?
    
    var convertedItemList:Array<ConvertItem>?
    
    var convertTextField:UITextField?

    
    override func loadView() {
        super.loadView()
        
        self.title = self.type
        
        self.convertingItem = ConvertItem(withUnit: Mapping.defaultUnitsFromType[self.type!]!, value: 0)
        
        
        self.allUnitsInType = Mapping.unitsInType[type!]
        
        self.unitListToShow = Utility.getDefaultUnitList(forType: self.type!)
        
        self.convertedItemList = Array();
        
        for unit in self.unitListToShow! {
            
            let convertItem = ConvertItem(withUnit: unit, value: 0)
            self.convertedItemList?.append(convertItem)
        }
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ConvertingTableViewCell.classForCoder(), forCellReuseIdentifier: ConvertCellID)
        self.tableView.register(ConvertingTextFieldHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: ConvertingHeaderID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.convertedItemList?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConvertCellID, for: indexPath) as! ConvertingTableViewCell
        
        let convertItem = self.convertedItemList?[indexPath.row]
        
        cell.update(withConvertItem: convertItem!)
    
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let convertingHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: ConvertingHeaderID) as! ConvertingTextFieldHeader
        
        convertingHeader.textfield?.unitLabel?.text = "\((self.convertingItem?.nameToShowShort)!) (\((self.convertingItem?.nameInChinese)!))"
    
        
        convertingHeader.chooseUnitButton?.addTarget(self, action:#selector(self.chooseUnitButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        Utility.addToolBar(toTextField: (convertingHeader.textfield?.textField)!, buttonTitle: "Done", target: self, action: #selector(self.doneButtonPressed(_:)), cancelAction:#selector(self.toolBarCancelButtonPressed(_:)))
        
        self.convertTextField = convertingHeader.textfield?.textField
        self.convertTextField?.delegate = self
        self.convertTextField?.addTarget(self, action: #selector(self.textFieldDidChangeValue(_:)), for: UIControlEvents.editingChanged)
        
        return convertingHeader
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
         if editingStyle == .delete {
            
            if (self.convertedItemList.count > 0) {
            
                let itemToRemove = (self.convertedItemList?[indexPath.row])! as ConvertItem
                
                self.convertedItemList?.remove(at: indexPath.row)
                
                Utility.removeDefaultUnit(forType: (self.convertingItem?.type)!, unit: (itemToRemove.unit)!)
                
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            } else {
                
            }

         }
    }
    
//     // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//     
//    }
// 
//    
//    
//     // Override to support conditional rearranging of the table view.
//     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//     // Return false if you do not want the item to be re-orderable.
//     return true
//     }
// 

    
    // MARK: navigations
    
    func chooseUnitButtonPressed(_ sender:UIButton) {
        print("buttonPressed");
    }
    
    func doneButtonPressed(_ sender:UIBarButtonItem) {
        self.convertTextField?.resignFirstResponder()
        self.convert()
    }

    func toolBarCancelButtonPressed(_ sender:UIBarButtonItem) {
        self.convertTextField?.text = nil;
        self.convert()
        self.convertTextField?.resignFirstResponder()
    }
    
    
    // MARK: textfield 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "."){
            if ((textField.text?.contains("."))!){
                return false;
            }
        }
        
        return true;
    }
    
    func textFieldDidChangeValue(_ textField: UITextField) {
        self.convert()
    }
    
    
    // MARK: Helper
    func convert() {
        let enteredString = (self.convertTextField?.text)!
        self.convertingItem?.value = (enteredString as NSString).doubleValue
        for itemToConvertTo in self.convertedItemList! {
            ConvertHandler.convert(fromItem: self.convertingItem!, convertingItem: itemToConvertTo);
        }
        self.tableView.reloadData()
    }
}

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

class ConvertingViewController: SCTableViewController {
    
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
        return (self.unitListToShow?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConvertCellID, for: indexPath) as! ConvertingTableViewCell
        
        let convertItem = self.convertedItemList?[indexPath.row]
        
        cell.update(withConvertItem: convertItem!)

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
        
        return convertingHeader
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 76
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: navigations
    
    func chooseUnitButtonPressed(_ sender:UIButton) {
        print("buttonPressed");
    }
    
    func doneButtonPressed(_ sender:UIBarButtonItem) {
        let enteredString = (self.convertTextField?.text)!
        self.convertingItem?.value = (enteredString as NSString).doubleValue
        for itemToConvertTo in self.convertedItemList! {
            ConvertHandler.convert(fromItem: self.convertingItem!, convertingItem: itemToConvertTo);
        }
        self.tableView.reloadData()
    }

    func toolBarCancelButtonPressed(_ sender:UIBarButtonItem) {
        self.convertTextField?.resignFirstResponder()
    }
    
}

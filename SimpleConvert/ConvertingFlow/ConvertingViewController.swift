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
        
        let longpress = UILongPressGestureRecognizer(target: self, action:#selector(self.longPressGestureRecognized(gestureRecognizer:)))
        self.tableView.addGestureRecognizer(longpress)
        
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
            
            if ((self.convertedItemList?.count)! > 1) {
            
                let itemToRemove = (self.convertedItemList?[indexPath.row])! as ConvertItem
                
                self.convertedItemList?.remove(at: indexPath.row)
                
                Utility.removeDefaultUnit(forType: (self.convertingItem?.type)!, unit: (itemToRemove.unit)!)
                
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            } else {
                
                Utility.showAlert(toViewController:self, title:"Removing Unit", message:"You should have at least one unit for converting", actions:nil)
                
                self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.right)
            }

         }
    }

    
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
    
    func swapConvertItem(atIndex firstIndex:Int, secondeIndex:Int) {
        swap(&self.convertedItemList![firstIndex], &self.convertedItemList![secondeIndex])
        
        var convertListUnitsArray = Array<String>()
        for convertItem in self.convertedItemList! {
            convertListUnitsArray.append(convertItem.unit!)
        }
        
        Utility.setDefaultUnitList(forType: (self.convertingItem?.type)!, list: convertListUnitsArray)
    }
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: self.tableView)
        var indexPath = self.tableView.indexPathForRow(at: locationInView)
        
        struct My {
            static var cellSnapshot : UIView? = nil
        }
        struct Path {
            static var initialIndexPath : NSIndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath as NSIndexPath?
                let cell = self.tableView.cellForRow(at: indexPath!) as UITableViewCell!
                My.cellSnapshot  = self.snapshopOfCell(inputView: cell!)
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                self.tableView.addSubview(My.cellSnapshot!)
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                    
                }, completion: { (finished) -> Void in
                    if finished {
                        cell?.isHidden = true
                    }
                })
            }
        case UIGestureRecognizerState.changed:
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            if ((indexPath != nil) && (indexPath as NSIndexPath? != Path.initialIndexPath)) {
                
                self.swapConvertItem(atIndex: indexPath!.row, secondeIndex: Path.initialIndexPath!.row)
                tableView.moveRow(at: Path.initialIndexPath! as IndexPath, to: indexPath!)
                Path.initialIndexPath = indexPath as NSIndexPath?
            }
        default:
            let cell = tableView.cellForRow(at: Path.initialIndexPath! as IndexPath) as UITableViewCell!
            cell?.isHidden = false
            cell?.alpha = 0.0
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                My.cellSnapshot!.center = (cell?.center)!
                My.cellSnapshot!.transform = CGAffineTransform.identity
                My.cellSnapshot!.alpha = 0.0
                cell?.alpha = 1.0
            }, completion: { (finished) -> Void in
                if finished {
                    Path.initialIndexPath = nil
                    My.cellSnapshot!.removeFromSuperview()
                    My.cellSnapshot = nil
                }
            })
        }
        
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5, height: 0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
}

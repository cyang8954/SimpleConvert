//
//  Utility.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    // MARK: user default general
    
    class func initDefaults(forKey key:String) {
        let unitDefaultDictionary = NSMutableDictionary()
        UserDefaults.standard.set(unitDefaultDictionary, forKey: key)
        
        UserDefaults.standard.synchronize()
        
    }
    
    
    // MARK: for default converting units
    
    class func getDefaultConvertingUnit(forType type:String) -> String {
        var defaultConvertingUnitList = UserDefaults.standard.dictionary(forKey: Constants.Keys.DefaultConvertingUnit)
        if (defaultConvertingUnitList == nil) {
            initDefaults(forKey: Constants.Keys.DefaultConvertingUnit)
        }
        
        let userSettingUnitToConvert = defaultConvertingUnitList?[type]
        
        if userSettingUnitToConvert != nil {
            
            return userSettingUnitToConvert as! String
        } else {
            
            let defaultUserSettingValue = (Mapping.baseUnitForType?[type])!
            setDefualtConvertingUnit(forType: type, unit: defaultUserSettingValue)
            return defaultUserSettingValue
        }
        
    }
    
    class func setDefualtConvertingUnit(forType type:String, unit:String) {
        var unitsDefault = UserDefaults.standard.dictionary(forKey: Constants.Keys.DefaultConvertingUnit)
        
        unitsDefault?[type] = unit
        UserDefaults.standard.set(unitsDefault, forKey: Constants.Keys.DefaultConvertingUnit)
        UserDefaults.standard.synchronize()
    }
    
    
    
    // MARK: for default units to convert to
    
    
    class func getDefaultUnitList(forType type:String) -> Array<String>? {
        var unitsDefault = UserDefaults.standard.dictionary(forKey: Constants.Keys.UnitDefault)
        
        if (unitsDefault == nil) {
            initDefaults(forKey: Constants.Keys.UnitDefault)
       
        }
        
        let typeListDefault = unitsDefault?[type]
        
        if (typeListDefault != nil) {
            return typeListDefault as! Array<String>?
        } else {
            //set default with default units value
            
            let defaultUnitsValue = Mapping.loadingUnitsInType![type]
            
            setDefaultUnitList(forType: type, list: defaultUnitsValue!)
            
            return defaultUnitsValue
            
        }
        
    }
    
    class func removeDefaultUnit(forType type:String, unit:String) {
        var defaultUnitList = getDefaultUnitList(forType: type)
        
        var i = 0;
        for aUnit in defaultUnitList! {
            if aUnit == unit {
                defaultUnitList?.remove(at: i)
                setDefaultUnitList(forType:type, list:defaultUnitList!)
                
                return
            }
            
            i = i + 1
        }
    }
    
    class func setDefaultUnitList (forType type:String, list:Array<String>) {
        
        var unitsDefault = UserDefaults.standard.dictionary(forKey: Constants.Keys.UnitDefault)
        
        unitsDefault?[type] = list
        UserDefaults.standard.set(unitsDefault, forKey: Constants.Keys.UnitDefault)
        UserDefaults.standard.synchronize()
    }
    
    class func addDefaultUnit(_ unit:String, type:String) {
        var defaultUnitList = getDefaultUnitList(forType: type)
        defaultUnitList?.append(unit)
        
        setDefaultUnitList(forType: type, list: defaultUnitList!)
    }
    
    
    // MARK: UI
    
    class func addToolBar(toTextField textField:UITextField, buttonTitle:String, target:Any, action:Selector, cancelAction:Selector) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true

        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: target, action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: target, action: cancelAction)

        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        textField.inputAccessoryView = toolBar

    }
    
    class func showAlert(toViewController viewController:UIViewController, title:String, message:String, actions:Array<UIAlertAction>?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style:  UIAlertActionStyle.default, handler: { (nil) in
            alertController.dismiss(animated: true, completion: nil)
        })
    
        if actions != nil {
            
            for action in actions! {
                alertController.addAction(action)
            }
        }
        
        alertController.addAction(okAction)
    
        
        viewController.present(alertController, animated: true, completion: nil)

    }
    
    
    class func getJson(fromFile file:String) -> NSDictionary? {
        
        if let path = Bundle.main.path(forResource:file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                
                if dictionary != nil {
                    print("jsonData:\(dictionary)")
                    
                    return dictionary;
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return nil;
    }
    
    
}

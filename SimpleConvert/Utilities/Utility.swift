//
//  Utility.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    class func initDefaults(forKey key:String) {
        let unitDefaultDictionary = NSMutableDictionary()
        UserDefaults.standard.set(unitDefaultDictionary, forKey: key)
        
        UserDefaults.standard.synchronize()
    }
    
    
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
            
            let defaultUnitsValue = Mapping.defaultUnitsInType[type]
            
            setDefaultUnitList(forType: type, list: defaultUnitsValue!)
            
            return defaultUnitsValue
            
        }
        
    }
    
    class func setDefaultUnitList (forType type:String, list:Array<String>) {
        
        var unitsDefault = UserDefaults.standard.dictionary(forKey: Constants.Keys.UnitDefault)
        
        unitsDefault?[type] = list
        UserDefaults.standard.set(unitsDefault, forKey: Constants.Keys.UnitDefault)
        UserDefaults.standard.synchronize()
    }
    
}

//
//  Mapping.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class Mapping: NSObject {
    
    static var unitMapping:[String:Dictionary<String, String>]?
    
    static var baseUnitForType:[String:String]?
    //all the units in a type
    static var unitsInType:[String:Array<String>]?
    
    //default units in a type that showing when launch the fisrt time
    static var loadingUnitsInType:[String:Array<String>]?
    
    static var unitToBaseFormula:[String:Double]?

    class func initMappingFromJson(withFileName fileName:String) {
        let json = Utility.getJson(fromFile: fileName)! as NSDictionary
        
        self.unitMapping = json[Constants.Keys.UnitMapping] as? [String:Dictionary]
        self.baseUnitForType = json[Constants.Keys.BaseUnitForType] as? [String:String]
        self.unitsInType = json[Constants.Keys.UnitsInType] as? [String:Array<String>]
        self.loadingUnitsInType = json[Constants.Keys.LoadingUnitsForType] as? [String:Array]
        self.unitToBaseFormula = json[Constants.Keys.UnitToBaseFormula] as? [String:Double]
        
    }
    
}

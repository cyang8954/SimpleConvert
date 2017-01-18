//
//  ConvertItem.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertItem: NSObject {
    
    var type: String?
    var unit: String?
    
    var nameToShow: String?
    var nameToShowShort: String?
    var nameInChinese: String?
    
    var value: Double?
    
    init(withUnit unit:String, value:Double) {
        super.init()
        self.unit = unit
        self.value = value
        self.initProperties(withUnit: self.unit!)
    }
    
    init(withType type:String, unit:String, value:Double, nameToShow:String, nameToShowShort:String, nameInChinese:String) {
        super.init()
        self.type = type
        self.unit = unit
        self.value = value
        self.nameToShow = nameToShow
        self.nameInChinese = nameInChinese
    }
    
    func initProperties(withUnit unit:String) {
        
        let convertDictionary = Mapping.unitMapping?[unit]!
        
        self.type = convertDictionary?[Constants.Keys.UnitType] ;
        self.nameToShow = convertDictionary?[Constants.Keys.UnitNameToShow]
        self.nameToShowShort = convertDictionary?[Constants.Keys.UnitNameToShowShort]
        self.nameInChinese = convertDictionary?[Constants.Keys.UnitNameToShowChinese]
        
    }
    
    override func copy() -> Any {
        let copyItem = ConvertItem(withUnit: self.unit!, value: self.value!)
        return copyItem
    }
}

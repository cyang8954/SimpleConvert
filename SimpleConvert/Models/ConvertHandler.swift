//
//  ConvertHandler.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertHandler: NSObject {
    
    class func convertToDefault(_ itemToConvert:ConvertItem) -> ConvertItem {
        //find itemToConvert's default unit
        let type = itemToConvert.type!
        let defaultUnit = Mapping.defaultUnitsFromType[type]!
        
        let convertedDefaultValue = itemToConvert.value! * Formula.unitToDefault[itemToConvert.unit!]!
        
        let unitMappingForDefaultUnit = Mapping.unitMapping[defaultUnit]!
        
        let defaultItem = ConvertItem(withType: type, unit: defaultUnit, value: convertedDefaultValue, nameToShow: unitMappingForDefaultUnit[Constants.Keys.UnitNameToShow]!, nameToShowShort: unitMappingForDefaultUnit[Constants.Keys.UnitNameToShowShort]!, nameInChinese: unitMappingForDefaultUnit[Constants.Keys.UnitNameToShowChinese]!)
        
        return defaultItem
    }
    
    class func convert(fromDefault defaultItem:ConvertItem, convertingItem:ConvertItem)  {
        
        let unit = convertingItem.unit!
        let defaultValue = defaultItem.value!
        
        convertingItem.value = defaultValue/Formula.unitToDefault[unit]!;
    }
    
    
    
}



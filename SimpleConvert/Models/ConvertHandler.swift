//
//  ConvertHandler.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertHandler: NSObject {
    
    class func convertToDefault(itemToConvert:ConvertItem) -> ConvertItem {
        //find itemToConvert's default unit
        let type = itemToConvert.type!
        let defaultUnit = Mapping.defaultUnitsFromType[type]!
        
        let convertedDefaultValue = itemToConvert.value! * Formula.unitToDefault[itemToConvert.unit!]!
        
        let defaultItem = ConvertItem(withType: type, unit: defaultUnit, value: convertedDefaultValue, nameToShow: Mapping.unitsNameToShow[defaultUnit]!, nameToShowShort: Mapping.unitsNameToShowShort[defaultUnit]!, nameInChinese: Mapping.unitsNameToShowChinese[defaultUnit]!)
        
        return defaultItem
    }
    
    class func convert(fromDefault defaultItem:ConvertItem, convertingItem:ConvertItem)  {
        
        let unit = convertingItem.unit!
        let defaultValue = defaultItem.value!
        
        convertingItem.value = defaultValue/Formula.unitToDefault[unit]!;
    }
    
    
    
}



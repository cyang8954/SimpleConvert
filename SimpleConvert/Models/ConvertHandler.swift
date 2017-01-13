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
    
    class func convert(fromItem item:ConvertItem, convertingItem:ConvertItem)  {
        
        let defaultItem = self.convertToDefault(item)
        
        let unit = convertingItem.unit!
        let defaultValue = defaultItem.value!
        
        convertingItem.value = defaultValue/Formula.unitToDefault[unit]!;
    }
    
    class func switchItemValues(_ firstItem:ConvertItem, secondItem:ConvertItem) {
        let middleItem = firstItem.copy() as! ConvertItem
        self.copyItemValues(secondItem, toItem: firstItem)
        self.copyItemValues(middleItem, toItem: secondItem)

    }
    
    class func copyItemValues(_ fromItem:ConvertItem, toItem:ConvertItem) {
        toItem.value = fromItem.value
        toItem.nameInChinese = fromItem.nameInChinese
        toItem.type = fromItem.type
        toItem.unit = fromItem.unit
        toItem.nameToShow = fromItem.nameToShow
        toItem.nameToShowShort = fromItem.nameToShowShort
    }
    
}



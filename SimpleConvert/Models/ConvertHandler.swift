//
//  ConvertHandler.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertHandler: NSObject {
    
    class func convertToBase(_ itemToConvert:ConvertItem) -> ConvertItem {
        //find itemToConvert's default unit
        let type = itemToConvert.type!
        let baseUnit = (Mapping.baseUnitForType?[type])!
        
        let convertedBaseValue = itemToConvert.value! * (Mapping.unitToBaseFormula?[itemToConvert.unit!])!
        
        let unitMappingForBaseUnit = Mapping.unitMapping![baseUnit]
        
        let baseItem = ConvertItem(withType: type, unit: baseUnit, value: convertedBaseValue, nameToShow: unitMappingForBaseUnit![Constants.Keys.UnitNameToShow]!, nameToShowShort: unitMappingForBaseUnit![Constants.Keys.UnitNameToShowShort]!, nameInChinese: unitMappingForBaseUnit![Constants.Keys.UnitNameToShowChinese]!)
        
        return baseItem
    }
    
    class func convert(fromItem item:ConvertItem, convertingItem:ConvertItem)  {
        
        let baseItem = self.convertToBase(item)
        
        let unit = convertingItem.unit!
        let baseValue = baseItem.value!
        
        convertingItem.value = baseValue/(Mapping.unitToBaseFormula?[unit])!;
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



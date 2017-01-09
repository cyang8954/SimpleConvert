//
//  ConvertHandler.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class ConvertHandler: NSObject {
    
    static let defaultUnitsFromType = [
        Constants.Types.Distance:Constants.Units.Meter,
        
    ]
    
    static let unitsInType = [
        
        Constants.Types.Distance:[
            Constants.Units.Meter,
            Constants.Units.CentMeter,
            Constants.Units.Foot
        ],
    
    ]
    
    static let unitsNameToShow = [
        Constants.Units.Meter:Constants.UnitNameToShow.Meter,
        Constants.Units.CentMeter:Constants.UnitNameToShow.CentMeter,
        Constants.Units.Foot:Constants.UnitNameToShow.Foot
    ]
    
    static let unitsNameToShowShort = [
        Constants.Units.Meter:Constants.UnitNameToShowShort.Meter,
        Constants.Units.CentMeter:Constants.UnitNameToShowShort.CentMeter,
        Constants.Units.Foot:Constants.UnitNameToShowShort.Foot
    ]
    
    static let unitsNameToShowChinese = [
        Constants.Units.Meter:Constants.UnitNameToShowChinese.Meter,
        Constants.Units.CentMeter:Constants.UnitNameToShowChinese.CentMeter,
        Constants.Units.Foot:Constants.UnitNameToShowChinese.Foot
    ]
    
    
    class func convertToDefault(itemToConvert:ConvertItem) -> ConvertItem {
        //find itemToConvert's default unit
        let type = itemToConvert.type!
        let defaultUnit = defaultUnitsFromType[type]!
        
        let convertedDefaultValue = itemToConvert.value! * Formula.unitToDefault[itemToConvert.unit!]!
        
        let defaultItem = ConvertItem(withType: type, unit: defaultUnit, value: convertedDefaultValue, nameToShow: unitsNameToShow[defaultUnit]!, nameToShowShort: unitsNameToShowShort[defaultUnit]!, nameInChinese: unitsNameToShowChinese[defaultUnit]!)
        
        return defaultItem
    }
    

    
}



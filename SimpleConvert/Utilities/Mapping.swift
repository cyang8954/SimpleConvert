//
//  Mapping.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class Mapping: NSObject {
    
    static let unitMapping = [
        //distances
        Constants.Units.Meter : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.Meter,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.Meter,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.Meter,
            Constants.Keys.UnitType:Constants.Types.Distance
        ],
        Constants.Units.CentiMeter : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.CentiMeter,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.CentiMeter,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.CentiMeter,
            Constants.Keys.UnitType:Constants.Types.Distance
        ],
        Constants.Units.Foot : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.Foot,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.Foot,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.Foot,
            Constants.Keys.UnitType:Constants.Types.Distance
        ],
        
        //areas 
        Constants.Units.SquareMeter : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.SquareMeter,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.SquareMeter,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.SquareMeter,
            Constants.Keys.UnitType:Constants.Types.Area
        ],
        Constants.Units.SquareFoot : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.SquareFoot,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.SquareFoot,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.SquareFoot,
            Constants.Keys.UnitType:Constants.Types.Area
        ],
        Constants.Units.Acre : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.Acre,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.Acre,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.Acre,
            Constants.Keys.UnitType:Constants.Types.Area
        ],

    
    ]
    
    static let defaultUnitsFromType = [
        Constants.Types.Distance:Constants.Units.Meter,
        Constants.Types.Area:Constants.Units.SquareMeter,
    ]
    
    //all the units in a type
    static let unitsInType = [
        
        Constants.Types.Distance:[
            Constants.Units.Meter,
            Constants.Units.CentiMeter,
            Constants.Units.Foot
        ],
        
        Constants.Types.Area:[
            Constants.Units.SquareMeter,
            Constants.Units.SquareFoot,
            Constants.Units.Acre
        ]
        
    ]
    
    //default units in a type that showing when launch the fisrt time
    static let defaultUnitsInType = [
        
        Constants.Types.Distance:[
            Constants.Units.Meter,
            Constants.Units.CentiMeter,
            Constants.Units.Foot
        ],
        
        Constants.Types.Area:[
            Constants.Units.SquareMeter,
            Constants.Units.SquareFoot,
            Constants.Units.Acre
        ]
        
    ]

    
}

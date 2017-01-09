//
//  Constants.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

class Constants {
    
    struct Keys {
        static let UnitType = "type"
        static let Unit = "unit"
        static let UnitNameToShow = "unitNameToShow"
        static let UnitNameToShowShort = "unitNameToShowShort"
        static let UnitNameToShowChinese = "unitNameToShowChinese"
        static let UnitDefault = "unitDefault"
    }
    
    struct Types {
        static let Distance = "Distance"
        static let Area = "Area"
    }
    
    struct Units {
        //distance
        static let Meter = "meter";
        static let CentiMeter = "centiMeter";
        static let Foot = "foot";
        
        //area
        static let SquareMeter = "squareMeter";
        static let SquareFoot = "squareFoot";
        static let Acre = "acre";
    }
    
    struct UnitNameToShow {
        //distance
        static let Meter = "Meter";
        static let CentiMeter = "CentiMeter";
        static let Foot = "Foot";
        
        //area
        static let SquareMeter = "Square Meter";
        static let SquareFoot = "Square Foot";
        static let Acre = "Acre";
    }
    
    struct UnitNameToShowShort {
        //distance
        static let Meter = "m";
        static let CentiMeter = "cm";
        static let Foot = "ft";
        
        //area
        static let SquareMeter = "m²";
        static let SquareFoot = "sq.ft";
        static let Acre = "ac.";
    }
    
    struct UnitNameToShowChinese {
        //distance
        static let Meter = "米";
        static let CentiMeter = "厘米";
        static let Foot = "英尺";
        
        //area
        static let SquareMeter = "平方米";
        static let SquareFoot = "平方英尺";
        static let Acre = "英亩";
    }
    
}

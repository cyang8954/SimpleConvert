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
            Constants.Keys.Type:Constants.Types.Distance
        ],
        Constants.Units.CentMeter : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.CentMeter,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.CentMeter,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.CentMeter,
            Constants.Keys.Type:Constants.Types.Distance
        ],
        Constants.Units.Foot : [
            Constants.Keys.UnitNameToShow:Constants.UnitNameToShow.Foot,
            Constants.Keys.UnitNameToShowShort:Constants.UnitNameToShowShort.Foot,
            Constants.Keys.UnitNameToShowChinese:Constants.UnitNameToShowChinese.Foot,
            Constants.Keys.Type:Constants.Types.Distance
        ],
    
    ]
    
}

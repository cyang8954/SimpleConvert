//
//  FirstViewController.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testItemToConvert = ConvertItem(withUnit: Constants.Units.Foot, value: 3)
        

        let defaultItem = ConvertHandler.convertToDefault(testItemToConvert);
        
        print(defaultItem.value);
        
        let cmItem = ConvertItem(withUnit: Constants.Units.CentMeter, value: 0);
        
        ConvertHandler.convert(fromDefault: defaultItem, convertingItem: cmItem);
        
        print (cmItem.value);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  FirstViewController.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let CellID = "typeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testItemToConvert = ConvertItem(withUnit: Constants.Units.SquareFoot, value: 3000)
        

        let defaultItem = ConvertHandler.convertToDefault(testItemToConvert)
        
        print(defaultItem.value!)
        
        let cmItem = ConvertItem(withUnit: Constants.Units.Acre, value: 0)
        
        ConvertHandler.convert(fromDefault: defaultItem, convertingItem: cmItem)
        
        print (cmItem.value!)
        
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Array(Mapping.unitsInType.keys).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        
        let allTypeArray = Array(Mapping.unitsInType.keys)
    
        cell.textLabel!.text = allTypeArray[indexPath.row]
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}


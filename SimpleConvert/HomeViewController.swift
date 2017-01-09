//
//  FirstViewController.swift
//  SimpleConvert
//
//  Created by Tianhang Yang on 1/8/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class HomeViewController: SCTableViewController {
    
    let TypeCellID = "typeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testItemToConvert = ConvertItem(withUnit: Constants.Units.SquareFoot, value: 3000)
        

        let defaultItem = ConvertHandler.convertToDefault(testItemToConvert)
        
        print(defaultItem.value!)
        
        let cmItem = ConvertItem(withUnit: Constants.Units.Acre, value: 0)
        
        ConvertHandler.convert(fromDefault: defaultItem, convertingItem: cmItem)
        
        print (cmItem.value!)
        
        self.title = "Choose a type"
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: TypeCellID)
        
    }
    
    
    // MARK: table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Array(Mapping.unitsInType.keys).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeCellID, for: indexPath)
        
        let allTypeArray = Array(Mapping.unitsInType.keys)
    
        cell.textLabel!.text = allTypeArray[indexPath.row]
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allTypeArray = Array(Mapping.unitsInType.keys)
        
        let typeSelected = allTypeArray[indexPath.row]
        
        let convertingViewController = ConvertingViewController()
        
        convertingViewController.type = typeSelected
        
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        self.navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.pushViewController(convertingViewController, animated: true)
        
    }
    

}


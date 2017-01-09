//
//  SCTableViewController.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class SCTableViewController: SCViewController, UITableViewDelegate, UITableViewDataSource {

    let CellID = "cell"
    
    open var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["tableView":tableView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["tableView":tableView]))
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellID)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height, 0, 0, 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: -1))
        self.tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        
        return cell
        
    }
    

}

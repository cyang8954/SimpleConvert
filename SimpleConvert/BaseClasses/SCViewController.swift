//
//  SCViewController.swift
//  SimpleConvert
//
//  Created by Yang, Tianhang (Chris) on 1/9/17.
//  Copyright © 2017 Chris Yang. All rights reserved.
//

import UIKit

class SCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print ("\(self) deinit")
    }
    
    
    func dismissSelf() {
        if (self.navigationController?.viewControllers[0] != self && self.navigationController != nil) {
            let _ = self.navigationController?.popViewController(animated: true);
        } else if (self.navigationController == nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }

}

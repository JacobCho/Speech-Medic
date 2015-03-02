//
//  SMNavigationController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-03-02.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class SMNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor(red: 64.0/255.0, green: 163.0/255.0, blue: 63.0/255.0, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}

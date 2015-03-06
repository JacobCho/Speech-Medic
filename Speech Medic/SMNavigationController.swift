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
        
        self.navigationBar.barTintColor = UIColor(red: 174.0/255.0, green: 213.0/255.0, blue: 129.0/255.0, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.translucent = false
    }

}

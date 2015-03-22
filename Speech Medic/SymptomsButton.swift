//
//  SymptomsButton.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-03-11.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class SymptomsButton: UIButton {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        backgroundColor = UIColor.whiteColor()
        layer.cornerRadius = bounds.height/2
        layer.masksToBounds = true
    }
    
}
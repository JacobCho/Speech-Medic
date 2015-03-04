//
//  SymptomTableViewCell.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-27.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class SymptomTableViewCell: UITableViewCell {

    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var symptomSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        symptomSwitch.enabled = false
    }
    
}

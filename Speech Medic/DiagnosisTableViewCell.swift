//
//  DiagnosisTableViewCell.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-28.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class DiagnosisTableViewCell: UITableViewCell {

    @IBOutlet weak var consistentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lesionSiteLabel: UILabel!
    @IBOutlet weak var percentageBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.percentageBackgroundView.layer.cornerRadius = 27
        self.percentageBackgroundView.clipsToBounds = true
    
    }
    
}

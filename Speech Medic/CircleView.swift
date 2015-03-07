//
//  CircleView.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-03-06.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    
    override func drawRect(rect: CGRect) {
        
        var circle = UIBezierPath(arcCenter: CGPointMake(self.bounds.width/2, self.bounds.height/2), radius: (min(bounds.size.width-3, bounds.size.height-3) / 2.0), startAngle: 0.0, endAngle: CGFloat(M_PI) * 2.0, clockwise: true)
        circle.closePath()
        UIColor(red: 174.0/255.0, green: 213.0/255.0, blue: 129.0/255.0, alpha: 1).setStroke()
        circle.lineWidth = 3.0
        circle.stroke()
        
    }

}

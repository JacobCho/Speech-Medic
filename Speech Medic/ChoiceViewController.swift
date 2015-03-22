//
//  ChoiceViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-03-11.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

@objc
protocol ChoiceViewControllerDelegate {
    optional
    func setupMotorSpeech(controller: ChoiceViewController)
    optional
    func setupAphasia(controller: ChoiceViewController)
    
}

class ChoiceViewController: UIViewController {
    
    var delegate : ChoiceViewControllerDelegate?
    var motorSpeechButton : SymptomsButton?
    let window = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createMotorSpeechButton()
    }

    func motorSpeechButtonPressed(sender: SymptomsButton) {
        self.performSegueWithIdentifier("SymptomsSegue", sender: sender)
        delegate!.setupMotorSpeech!(self)
    }

    func aphasiaButtonPressed(sender: SymptomsButton) {
        self.performSegueWithIdentifier("SymptomsSegue", sender: sender)
        delegate!.setupAphasia!(self)
    }
    
    func createMotorSpeechButton() {
        
        self.motorSpeechButton = SymptomsButton(frame: CGRect(x: window.width/2 - 65, y: window.height + 25, width: 25, height: 25))
        self.motorSpeechButton!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.motorSpeechButton!)
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: nil, animations: { () -> Void in
            let newFrame = CGRect(x: self.window.width/2 - 65, y: self.window.height/2 - 50, width: 25, height: 25)
            
            self.motorSpeechButton!.frame = newFrame
            
        }) { finished in
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.motorSpeechButton!.transform = CGAffineTransformMakeScale(4.0, 4.0)
                })
            
            self.motorSpeechButton?.addTarget(self, action: "motorSpeechButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SymptomsSegue" {
            let symptomsVC = segue.destinationViewController as SymptomsViewController
            self.delegate = symptomsVC
        }
    }
    

}

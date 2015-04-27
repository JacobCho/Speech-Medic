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
    var aphasiaButton : SymptomsButton?
    let window = UIScreen.mainScreen().bounds
    @IBOutlet weak var creditLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createMotorSpeechButton()
        self.createAphasiaButton()
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
        
        self.motorSpeechButton = SymptomsButton(frame: CGRect(x: window.width/2, y: window.height + 25, width: 100, height: 100))
        self.motorSpeechButton!.transform = CGAffineTransformMakeScale(0.25, 0.25)
        self.motorSpeechButton!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.motorSpeechButton!)
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: nil, animations: { () -> Void in
            let newFrame = CGRect(x: self.window.width/2 - 80, y: self.window.height/2 - 50, width: 25, height: 25)
            
            self.motorSpeechButton!.frame = newFrame
            
        }) { finished in
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.motorSpeechButton!.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }) { finished in
                    
                self.motorSpeechButton!.setTitle("Motor Speech", forState: .Normal)
            }
            
            self.motorSpeechButton?.addTarget(self, action: "motorSpeechButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }
    
    func createAphasiaButton() {
        
        self.aphasiaButton = SymptomsButton(frame: CGRect(x: window.width/2, y: window.height + 25, width: 100, height: 100))
        self.aphasiaButton!.transform = CGAffineTransformMakeScale(0.25, 0.25)
        self.aphasiaButton!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.aphasiaButton!)
        
        UIView.animateWithDuration(1.0, delay: 0.8, options: nil, animations: { () -> Void in
            let newFrame = CGRect(x: self.window.width/2 + 40, y: self.window.height/2 - 50, width: 25, height: 25)
            
            self.aphasiaButton!.frame = newFrame
            
            }) { finished in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.aphasiaButton!.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }) { finished in
                        self.aphasiaButton!.setTitle("Aphasia", forState: .Normal)
                        
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.creditLabel.alpha = 1.0
                        })
                }
                
                self.aphasiaButton?.addTarget(self, action: "aphasiaButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SymptomsSegue" {
            let symptomsVC = segue.destinationViewController as! SymptomsViewController
            self.delegate = symptomsVC
        }
    }
    

}

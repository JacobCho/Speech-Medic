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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func motorSpeechButtonPressed(sender: SymptomsButton) {
        self.performSegueWithIdentifier("SymptomsSegue", sender: sender)
        delegate!.setupMotorSpeech!(self)
    }

    @IBAction func aphasiaButtonPressed(sender: SymptomsButton) {
        self.performSegueWithIdentifier("SymptomsSegue", sender: sender)
        delegate!.setupAphasia!(self)
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

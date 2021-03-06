//
//  SymptomsViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-26.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit



class SymptomsViewController: UIViewController, UITableViewDataSource, ChoiceViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diagnosisButton: UIButton!
    
    var aphasiaSetup : Bool = false
    
    var oralExamArray : [Symptom]?
    var voiceQualityArray : [Symptom]?
    var articulationArray : [Symptom]?
    var diadoArray : [Symptom]?
    var aphasiaArray : [Symptom]?
    var sectionsArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 90, 0)
        self.diagnosisButton.layer.masksToBounds = false
        self.diagnosisButton.layer.shadowOpacity = 0.2
        self.diagnosisButton.layer.shadowRadius = 0.5
        self.diagnosisButton.layer.shadowOffset = CGSizeMake(1.0, 3.0)
        
    }
    
    @IBAction func diagnoseButtonPressed(sender: UIButton) {

    }
    
    
    @IBAction func clearAllButtonPressed(sender: UIBarButtonItem) {
        
        if !aphasiaSetup {
        
            for symptom in oralExamArray! {
                if symptom.isSymptom == true {
                    symptom.isSymptom = false
                }
            }
            
            for symptom in voiceQualityArray! {
                if symptom.isSymptom == true {
                    symptom.isSymptom = false
                }
            }
            
            for symptom in articulationArray! {
                if symptom.isSymptom == true {
                    symptom.isSymptom = false
                }
            }
            
            for symptom in diadoArray! {
                if symptom.isSymptom == true {
                    symptom.isSymptom = false
                }
            }
        }
        else {
            for symptom in aphasiaArray! {
                if symptom.isSymptom == true {
                    symptom.isSymptom = false
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.sectionsArray.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.width, 40))
        sectionHeaderView.backgroundColor = UIColor(red: 197.0/255.0, green: 225.0/255.0, blue: 165.0/255.0, alpha: 1)
        sectionHeaderView.alpha = 0.9
        
        // Setup section speech bubble image
        let speechButtonImageView = UIImageView(frame: CGRectMake(5, 5, 250, sectionHeaderView.frame.height-10))
        speechButtonImageView.image = UIImage(named: "speechBubbleIcon")
        sectionHeaderView.addSubview(speechButtonImageView)
        
        // Setup section header label
        let sectionHeaderLabel = UILabel(frame: CGRectMake(25, 0, 250, sectionHeaderView.frame.height))
        sectionHeaderLabel.font = UIFont.boldSystemFontOfSize(15)
        sectionHeaderLabel.textColor = UIColor.whiteColor()
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        if !aphasiaSetup {
        
            switch section {
                case 0:
                    sectionHeaderLabel.text = "Oral Exams"
                case 1:
                    sectionHeaderLabel.text = "Voice Exams"
                case 2:
                    sectionHeaderLabel.text = "Articulation Exams"
                case 3:
                    sectionHeaderLabel.text = "Diadochokinetics"
                case 4:
                    sectionHeaderLabel.text = "Aphasia Exams"
                default:
                    sectionHeaderLabel.text = ""
            }
            
        } else {
            switch section {
            case 0:
                sectionHeaderLabel.text = "Aphasia Exams"
            default:
                sectionHeaderLabel.text = ""
            }
        }
        
        return sectionHeaderView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.sectionsArray[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("SymptomCell") as! SymptomTableViewCell

        let symptom = self.sectionsArray[indexPath.section][indexPath.row] as! Symptom
        cell.symptomLabel.text = symptom.name
        if symptom.isSymptom == true {
            cell.symptomSwitch.on = true
        } else {
            cell.symptomSwitch.on = false
        }
        
        cell.symptomSwitch.addTarget(self, action: "switchTriggered:", forControlEvents: .ValueChanged)
        
        return cell
    }
    
    // MARK: Helper Methods
    
    func switchTriggered(sender: UISwitch) {
        let tableCell : UITableViewCell = sender.superview?.superview as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(tableCell)
        
        let symptom = self.sectionsArray[indexPath!.section][indexPath!.row] as! Symptom
        
        if sender.on == true {
            symptom.isSymptom = true
        } else {
            symptom.isSymptom = false
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DiagnosisSegue" {
            var diagnosisVC = segue.destinationViewController as! DiagnosisViewController
            if !aphasiaSetup {
                diagnosisVC.oralExamArray = self.oralExamArray!
                diagnosisVC.voiceQualityArray = self.voiceQualityArray!
                diagnosisVC.articulationArray = self.articulationArray!
                diagnosisVC.diadoArray = self.diadoArray!

            } else {
                diagnosisVC.aphasiaArray = self.aphasiaArray!
            }
            diagnosisVC.aphasiaSetup = aphasiaSetup
        }
    }
    
    // MARK: ChoiceViewController Delegate
    
    func setupAphasia(controller: ChoiceViewController) {
        self.aphasiaArray = Symptom.setupAphasiaArray()
        self.sectionsArray = [self.aphasiaArray!]
        self.aphasiaSetup = true
    }
    
    func setupMotorSpeech(controller: ChoiceViewController) {
        self.oralExamArray = Symptom.setupOralExamArray()
        self.voiceQualityArray = Symptom.setupVoiceQualityArray()
        self.articulationArray = Symptom.setupArticulationArray()
        self.diadoArray = Symptom.setupDiadoArray()
        
        self.sectionsArray = [self.oralExamArray!, self.voiceQualityArray!, self.articulationArray!, self.diadoArray!]
        self.aphasiaSetup = false
    }

}

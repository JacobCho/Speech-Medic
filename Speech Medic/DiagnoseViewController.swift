//
//  DiagnoseViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-26.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class DiagnoseViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let oralExamArray : [Symptom] = Symptom.setupOralExamArray()
    var voiceQualityArray : [Symptom] = Symptom.setupVoiceQualityArray()
    var prosodyArray : [Symptom] = Symptom.setupProsodyArray()
    var articulationArray : [Symptom] = Symptom.setupArticulationArray()
    var AMRArray : [Symptom] = Symptom.setupAMRArray()
    var SMRArray : [Symptom] = Symptom.setupSMRArray()
    var aphasiaArray : [Symptom] = Symptom.setupAphasiaArray()
    var sectionsArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.sectionsArray = [self.oralExamArray, self.voiceQualityArray, self.prosodyArray, self.articulationArray, self.AMRArray, self.SMRArray, self.aphasiaArray]
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.sectionsArray.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.width, 40))
        sectionHeaderView.backgroundColor = UIColor.whiteColor()
        sectionHeaderView.alpha = 0.9
        
        // Setup section header label
        let sectionHeaderLabel = UILabel(frame: CGRectMake(10, 0, 300, sectionHeaderView.frame.height))
        sectionHeaderLabel.font = UIFont.boldSystemFontOfSize(16)
        sectionHeaderLabel.textColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1)
        
         sectionHeaderView.addSubview(sectionHeaderLabel)
        
        switch section {
            case 0:
                sectionHeaderLabel.text = "Oral Exams"
            case 1:
                sectionHeaderLabel.text = "Voice Quality Exams"
            case 2:
                sectionHeaderLabel.text = "Prosody Exams"
            case 3:
                sectionHeaderLabel.text = "Articulation Exams"
            case 4:
                sectionHeaderLabel.text = "Alternate Motion Rates Exams"
            case 5:
                sectionHeaderLabel.text = "Sequential Motor Rates Exams"
            case 6:
                sectionHeaderLabel.text = "Aphasia Exams"
            default:
                sectionHeaderLabel.text = ""

        }
        
        return sectionHeaderView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.sectionsArray[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("SymptomCell") as SymptomTableViewCell

        let symptom = self.sectionsArray[indexPath.section][indexPath.row] as Symptom
        cell.symptomLabel.text = symptom.name
        if symptom.isSymptom == true {
            cell.symptomSwitch.on = true
        } else {
            cell.symptomSwitch.on = false
        }
        
        cell.symptomSwitch.addTarget(self, action: Selector("switchTriggered:"), forControlEvents: .ValueChanged)
        
        return cell
    }
    
    func switchTriggered(sender: UISwitch) {
        let cellSwitch : UISwitch = sender
        let tableCell : UITableViewCell = cellSwitch.superview?.superview as UITableViewCell
        let indexPath = self.tableView.indexPathForCell(tableCell)
        
        let symptom = self.sectionsArray[indexPath!.section][indexPath!.row] as Symptom
        
        if cellSwitch.on == true {
            symptom.isSymptom = true
        } else {
            symptom.isSymptom = false
        }
        
    }
    
    

}

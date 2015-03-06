//
//  DiagnosisViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-28.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class DiagnosisViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var oralExamArray : [Symptom] = [] // 7
    var voiceQualityArray : [Symptom] = [] // 4
    var prosodyArray : [Symptom] = [] // 1
    var articulationArray : [Symptom] = [] // 5
    var AMRArray : [Symptom] = [] // 3
    var SMRArray : [Symptom] = [] // 1
    var aphasiaArray : [Symptom] = [] // 3
    var totalSymptoms : Int = 0
    
    // Diagnosis'
    // Motor Speech
    let flaccidDys = Diagnosis(name: "Flaccid Dysarthria", lesionSite: "Brainstem or spinal/peripheral (LMN)")
    let spasticDys = Diagnosis(name: "Spastic Dysarthria", lesionSite: "Brainstem or cerebrum (UMN)")
    let ataxicDys = Diagnosis(name: "Ataxic Dysarthria", lesionSite: "Cerebellum")
    let hypoDys = Diagnosis(name: "Hypokinetic Dysarthria", lesionSite: "Basal ganglia")
    let hyperDys = Diagnosis(name: "Hyperkinetic Dysarthria", lesionSite: "Basal ganglia")
    let uniUMNDys = Diagnosis(name: "Unilateral UMN Dysarthria", lesionSite: "Brainstem or cerebrum")
    let apraxSpeech = Diagnosis(name: "Apraxia of Speech", lesionSite: "Dominant cerebral hemisphere")
    let flaccidSpas = Diagnosis(name: "Mixed (Flaccid-Spastic)", lesionSite: "Amyotrophic lateral sclerosis (ALS)")
    let ataxicSpas = Diagnosis(name: "Mixed (Ataxic-Spastic)", lesionSite: "Multiple sclerosis (MS)")
    
    // Aphasia
    let conAphasia = Diagnosis(name: "Conduction Aphasia", lesionSite: "Parietal, above Wernicke's")
    let brocha = Diagnosis(name: "Broca's Aphasia", lesionSite: "Brodmann area 44")
    let wernickes = Diagnosis(name: "Wernicke's Aphasia", lesionSite: "Brodmann area 22")
    let sensoryAphasia = Diagnosis(name: "Transcortical Sensory Aphasia", lesionSite: "Temporal lobe")
    let motorAphasia = Diagnosis(name: "Transcortical Motor Aphasia", lesionSite: "Frontal lobe")
    let mixedAphasia = Diagnosis(name: "Transcortical Mixed Aphasia", lesionSite: "Frontal and temporal lobe")
    let globalAphasia = Diagnosis(name: "Global Aphasia", lesionSite: "Dominant cerebral hemisphere")
    let speechApraxia = Diagnosis(name: "Apraxia of Speech", lesionSite: "Dominant cerebral hemisphere")
    let anomicAphasia = Diagnosis(name: "Anomic Aphasia", lesionSite: "")
    
    var motorSpeechArray : [Diagnosis] = []
    var aphasiaDiagnosisArray : [Diagnosis] = []
    var diagnosisArray : [NSArray] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMotorSpeechDiagnosis()
        self.setupAphasiaDiagnosis()
        
        self.setupCertainty()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.diagnosisArray.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.width, 40))
        sectionHeaderView.backgroundColor = UIColor(red: 197.0/255.0, green: 225.0/255.0, blue: 165.0/255.0, alpha: 1)
        sectionHeaderView.alpha = 0.9
        
        // Setup section header label
        let sectionHeaderLabel = UILabel(frame: CGRectMake(10, 0, 300, sectionHeaderView.frame.height))
        sectionHeaderLabel.font = UIFont.boldSystemFontOfSize(16)
        sectionHeaderLabel.textColor = UIColor.whiteColor()
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        switch section {
        case 0:
            sectionHeaderLabel.text = "Motor Speech Diagnosis"
        case 1:
            sectionHeaderLabel.text = "Aphasia Diagnosis"
        default:
            sectionHeaderLabel.text = ""
            
        }
        
        return sectionHeaderView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diagnosisArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DiagnosisCell") as DiagnosisTableViewCell
        
        let diagnosis = diagnosisArray[indexPath.section][indexPath.row] as Diagnosis
        
        cell.nameLabel.text = diagnosis.name
        
        if indexPath.section == 0 {
            cell.percentageLabel.hidden = false
        
            if let certainty = diagnosis.certainty {
                if certainty >= self.getMaxCertainty() {
                    cell.consistentImageView.image = UIImage(named: "consistentIcon")
                } else {
                    cell.consistentImageView.image = UIImage(named: "unconsistentIcon")
                }
                cell.percentageLabel.text = String(Int(certainty*100)) + "%"
            } else {
                cell.consistentImageView.image = UIImage(named: "unconsistentIcon")
                cell.percentageLabel.hidden = true
            }
        } else {
            
            if diagnosis.isConsistent == true {
                cell.consistentImageView.image = UIImage(named: "consistentIcon")

            } else {
                cell.consistentImageView.image = UIImage(named: "unconsistentIcon")

            }
            cell.percentageLabel.hidden = true
        }
        
        return cell
    }
    
    // MARK: Summing Methods
    
    func setupMotorSpeechDiagnosis() {
        motorSpeechArray = [self.flaccidDys, self.spasticDys, self.ataxicDys, self.hypoDys, self.hyperDys, self.uniUMNDys, self.apraxSpeech, self.flaccidSpas, self.ataxicDys, self.conAphasia, self.brocha, self.wernickes, self.sensoryAphasia, self.motorAphasia, self.mixedAphasia, self.globalAphasia, self.speechApraxia, self.anomicAphasia]
        
        self.diagnosisArray = [self.motorSpeechArray]
    }
    
    func setupAphasiaDiagnosis() {
        aphasiaDiagnosisArray = [self.conAphasia, self.brocha, self.wernickes, self.sensoryAphasia, self.motorAphasia, self.mixedAphasia, self.globalAphasia, self.speechApraxia, self.anomicAphasia]
        
        self.getAphasiaDiagnosis()
        self.sortAphasiaArray()
    }
    
    
    func sumForFlaccidDys() -> Int {
        
        var counter : Int = 0
        
        
        if self.oralExamArray[0].isSymptom {
            counter++
        }
        
        if self.oralExamArray[1].isSymptom {
            counter++
        }
        
        if self.oralExamArray[3].isSymptom {
            counter++
        }
       
        if self.voiceQualityArray[0].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[2].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[3].isSymptom {
            counter++
        }
        
        if self.articulationArray[0].isSymptom {
            counter++
        }
        
        
        return counter + 1
    }
    
    func sumForSpasticDys() -> Int {
        
        var counter : Int = 0
        
        if !self.oralExamArray[1].isSymptom {
            counter++
        }
        
        if self.oralExamArray[2].isSymptom {
            counter++
        }
        
        if self.oralExamArray[4].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[1].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[3].isSymptom {
            counter++
        }
    
        
        if self.AMRArray[0].isSymptom {
            counter++
        }
        
        
        return counter + 1
    }
    
    func sumForAtaxicDys() -> Int {
        
        var counter : Int = 0
        
        if self.articulationArray[2].isSymptom {
            counter++
        }
        
        if self.AMRArray[1].isSymptom {
            counter++
        }
        
        return counter + 1
     }
    
    func sumForHypoDys() -> Int {
        
        var counter : Int = 0
    
        if !self.oralExamArray[1].isSymptom {
            counter++
        }
        
        if self.oralExamArray[5].isSymptom {
            counter++
        }
            
        if self.voiceQualityArray[0].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[3].isSymptom {
            counter++
        }
        
        if self.prosodyArray[0].isSymptom {
            counter++
        }
        
        if self.AMRArray[2].isSymptom {
            counter++
        }
        
        return counter + 1
    }
    
    func sumForHyperDys() -> Int {
        
        var counter : Int = 0
        
        if !self.oralExamArray[1].isSymptom {
            counter++
        }
        
        if self.oralExamArray[6].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[1].isSymptom {
            counter++
        }
        
        if self.articulationArray[1].isSymptom {
            counter++
        }
        
        if self.articulationArray[2].isSymptom {
            counter++
        }
        
        if self.AMRArray[1].isSymptom {
            counter++
        }
        
        return counter + 1
    }
    
    func sumForUniUMNDys() -> Int {
        var counter : Int = 0
        
        if self.oralExamArray[0].isSymptom {
            counter--
        } else {
            counter++
        }
        
        if self.oralExamArray[1].isSymptom {
            counter++
        }
        
        if self.oralExamArray[2].isSymptom {
            counter++
        }
        
        if self.oralExamArray[3].isSymptom {
            counter++
        }
        
        if self.oralExamArray[4].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[0].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[1].isSymptom {
            counter++
        }
        
        if self.articulationArray[2].isSymptom {
            counter++
        }
        
        if self.AMRArray[0].isSymptom {
            counter++
        }
        
        if self.AMRArray[1].isSymptom {
            counter++
        }
        
        return counter + 1
    }
    
    func sumForApraxiaSpeech() -> Int {
        
        var counter : Int = 0
        
        if self.voiceQualityArray[3].isSymptom {
            counter++
        }
        
        if self.articulationArray[2].isSymptom {
            counter++
        }
        
        if self.articulationArray[3].isSymptom {
            counter++
        }
        
        if self.articulationArray[4].isSymptom {
            counter++
        }
        
        if self.SMRArray[0].isSymptom {
            counter++
        }
        
        return counter + 1
    }
    
    func sumForFlaccidSpas() -> Int {
        
        var counter : Int = 0
        
        if self.oralExamArray[0].isSymptom {
            counter++
        }
        
        if !self.oralExamArray[1].isSymptom {
            counter++
        }
        
        if self.oralExamArray[2].isSymptom {
            counter++
        }
        
        if self.oralExamArray[3].isSymptom {
            counter++
        }
        
        if self.oralExamArray[4].isSymptom {
            counter++
        }
        
        for symptom in self.voiceQualityArray {
            if symptom.isSymptom {
                counter++
            }
        }
        
        if self.articulationArray[0].isSymptom {
            counter++
        }
        
        if self.AMRArray[0].isSymptom {
            counter++
        }
        
        return counter + 1
    }
    
    func sumForAtaxicSpas() -> Int {
        
        var counter : Int = 0
        
        if self.oralExamArray[2].isSymptom {
            counter++
        }
        
        if self.oralExamArray[4].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[1].isSymptom {
            counter++
        }
        
        if self.voiceQualityArray[3].isSymptom {
            counter++
        }
        
        if self.AMRArray[0].isSymptom {
            counter++
        }
        
        return counter + 1
        
    }
    
    // MARK: Certainty Methods
    
    func getCertainty(diagnosis: Int, total: Int) -> Double {
        let certainty = Double(diagnosis)/Double(total)
        
        return certainty
    }
    
    func setupCertainty() {
        self.totalSymptoms = self.sumForFlaccidDys() + self.sumForSpasticDys() + self.sumForAtaxicDys() + self.sumForHypoDys() + self.sumForHyperDys() + self.sumForUniUMNDys() + self.sumForApraxiaSpeech() + self.sumForFlaccidSpas() + self.sumForAtaxicSpas()
        
        flaccidDys.certainty = self.getCertainty(self.sumForFlaccidDys(), total: self.totalSymptoms)
        spasticDys.certainty = self.getCertainty(self.sumForSpasticDys(), total: self.totalSymptoms)
        ataxicDys.certainty = self.getCertainty(self.sumForAtaxicDys(), total: self.totalSymptoms)
        hypoDys.certainty = self.getCertainty(self.sumForHypoDys(), total: self.totalSymptoms)
        hyperDys.certainty = self.getCertainty(self.sumForHyperDys(), total: self.totalSymptoms)
        uniUMNDys.certainty = self.getCertainty(self.sumForUniUMNDys(), total: self.totalSymptoms)
        apraxSpeech.certainty = self.getCertainty(self.sumForApraxiaSpeech(), total: self.totalSymptoms)
        flaccidSpas.certainty = self.getCertainty(self.sumForFlaccidSpas(), total: self.totalSymptoms)
        ataxicSpas.certainty = self.getCertainty(self.sumForAtaxicSpas(), total: self.totalSymptoms)
        
        self.motorSpeechArray.sort({ $0.certainty > $1.certainty })

        self.diagnosisArray.removeAll(keepCapacity: true)
        self.diagnosisArray.append(self.motorSpeechArray)
        self.diagnosisArray.append(self.aphasiaDiagnosisArray)
        
        self.tableView.reloadData()
    }
    
    func getMaxCertainty() -> Double{
        
        var maxCertainty : Double = 0.0
        
        for diagnosis in motorSpeechArray {
            if let certainty = diagnosis.certainty {
                if certainty >= maxCertainty {
                    maxCertainty = certainty
                }
            }
        }
        
        return maxCertainty
    }
    
    func getAphasiaDiagnosis() {
        
        // Conduction Aphasia
        if self.aphasiaArray[0].isSymptom && self.aphasiaArray[1].isSymptom && !self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[0].isConsistent == true
            
        }
        
        // Broca's Aphasia
        if !self.aphasiaArray[0].isSymptom && self.aphasiaArray[1].isSymptom && !self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[1].isConsistent == true
            
        }
        
        // Wernicke's Aphasia
        if self.aphasiaArray[0].isSymptom && !self.aphasiaArray[1].isSymptom && !self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[2].isConsistent = true
            
        }
        
        // Transcortical Sensory Aphasia
        if self.aphasiaArray[0].isSymptom && !self.aphasiaArray[1].isSymptom && self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[3].isConsistent = true
            
        }
        
        // Transcortical Motor Aphasia
        if !self.aphasiaArray[0].isSymptom && self.aphasiaArray[1].isSymptom && self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[4].isConsistent = true
            
        }
        
        // Transcortical Mixed Aphasia
        if !self.aphasiaArray[0].isSymptom && !self.aphasiaArray[1].isSymptom && self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[5].isConsistent = true
            
        }
        
        // Global Aphasia
        if !self.aphasiaArray[0].isSymptom && !self.aphasiaArray[1].isSymptom && !self.aphasiaArray[2].isSymptom {
            self.aphasiaDiagnosisArray[6].isConsistent = true
        }
        
        // Apraxia of Speech
        if !self.aphasiaArray[0].isSymptom && self.aphasiaArray[1].isSymptom && !self.aphasiaArray[2].isSymptom {
            
            self.aphasiaDiagnosisArray[7].isConsistent = true
        }
        
        // Anomic Aphasia
        if self.aphasiaArray[0].isSymptom && self.aphasiaArray[1].isSymptom && self.aphasiaArray[2].isSymptom {
            
            self.aphasiaDiagnosisArray[8].isConsistent = true
        }
    }
    
    func sortAphasiaArray() {
        
        for var i = 0; i < self.aphasiaDiagnosisArray.count; i++ {
            if self.aphasiaDiagnosisArray[i].isConsistent {
                self.aphasiaDiagnosisArray.insert(self.aphasiaDiagnosisArray[i], atIndex: 0)
                self.aphasiaDiagnosisArray.removeAtIndex(i+1)
            }
            
        }
    }
}

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
    
    var aphasiaSetup : Bool = false

    var oralExamArray : [Symptom]? // 7
    var voiceQualityArray : [Symptom]? // 5
    var articulationArray : [Symptom]? // 5
    var diadoArray : [Symptom]? // 4
    var aphasiaArray : [Symptom]? // 3
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
        
        if aphasiaSetup {
            self.setupAphasiaDiagnosis()
        } else {
            self.setupMotorSpeechDiagnosis()
        }
        
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
            if !aphasiaSetup {
                sectionHeaderLabel.text = "Motor Speech Diagnosis"
            } else {
                sectionHeaderLabel.text = "Aphasia Diagnosis"
            }
        default:
            sectionHeaderLabel.text = ""
            
        }
        
        return sectionHeaderView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diagnosisArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DiagnosisCell") as! DiagnosisTableViewCell
        
        let diagnosis = diagnosisArray[indexPath.section][indexPath.row] as! Diagnosis
        
        cell.nameLabel.text = diagnosis.name
        cell.lesionSiteLabel.text = diagnosis.possibleLesionSite
        
        if indexPath.section == 0 && !aphasiaSetup {
        
            if let certainty = diagnosis.certainty {
                if certainty >= self.getMaxCertainty() {
                    cell.consistentImageView.image = UIImage(named: "consistentIcon")
                } else {
                    cell.consistentImageView.image = UIImage(named: "unconsistentIcon")
                }
            } else {
                cell.consistentImageView.image = UIImage(named: "unconsistentIcon")

            }
        } else {
            
            if diagnosis.isConsistent == true {
                cell.consistentImageView.image = UIImage(named: "consistentIcon")

            } else {
                cell.consistentImageView.image = UIImage(named: "unconsistentIcon")

            }

        }
        
        return cell
    }
    
    // MARK: Summing Methods
    
    func setupMotorSpeechDiagnosis() {
        motorSpeechArray = [self.flaccidDys, self.spasticDys, self.ataxicDys, self.hypoDys, self.hyperDys, self.uniUMNDys, self.apraxSpeech, self.flaccidSpas, self.ataxicDys, self.conAphasia, self.brocha, self.wernickes, self.sensoryAphasia, self.motorAphasia, self.mixedAphasia, self.globalAphasia, self.speechApraxia, self.anomicAphasia]
        
        self.setupCertainty()
    }
    
    func setupAphasiaDiagnosis() {
        aphasiaDiagnosisArray = [self.conAphasia, self.brocha, self.wernickes, self.sensoryAphasia, self.motorAphasia, self.mixedAphasia, self.globalAphasia, self.speechApraxia, self.anomicAphasia]
        
        self.getAphasiaDiagnosis()
        self.sortAphasiaArray()
        self.diagnosisArray.append(self.aphasiaDiagnosisArray)
    }
    
    
    func sumForFlaccidDys() -> Int {
        
        var counter : Int = 0
        
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let articulation = self.articulationArray {
        
                    if oralExam[0].isSymptom {
                        counter++
                    }
                    
                    if oralExam[1].isSymptom {
                        counter++
                    }
                    
                    if oralExam[3].isSymptom {
                        counter++
                    }
                   
                    if voiceQuality[0].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[2].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[3].isSymptom {
                        counter++
                    }
                    
                    if articulation[0].isSymptom {
                        counter++
                    }
                }
            }
        }
        
        
        return counter + 1
    }
    
    func sumForSpasticDys() -> Int {
        
        var counter : Int = 0
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let diado = self.diadoArray {
                
                    if !oralExam[1].isSymptom {
                        counter++
                    }
                    
                    if oralExam[2].isSymptom {
                        counter++
                    }
                    
                    if oralExam[4].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[1].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[3].isSymptom {
                        counter++
                    }
                    
                    if diado[0].isSymptom {
                        counter++
                    }
                }
            }
        }
        
        return counter + 1
    }
    
    func sumForAtaxicDys() -> Int {
        
        var counter : Int = 0
        if let articulation = self.articulationArray {
            if let diado = self.diadoArray {
                if articulation[2].isSymptom {
                    counter++
                }
                
                if diado[1].isSymptom {
                    counter++
                }
            }
        }
        
        return counter + 1
     }
    
    func sumForHypoDys() -> Int {
        
        var counter : Int = 0
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let diado = self.diadoArray {
                    if !oralExam[1].isSymptom {
                        counter++
                    }
                    
                    if oralExam[5].isSymptom {
                        counter++
                    }
                        
                    if voiceQuality[0].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[3].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[4].isSymptom {
                        counter++
                    }
                    
                    if diado[2].isSymptom {
                        counter++
                    }
                }
            }
        }
        
        return counter + 1
    }
    
    func sumForHyperDys() -> Int {
        
        var counter : Int = 0
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let articulation = self.articulationArray {
                    if let diado = self.diadoArray {
        
                        if !oralExam[1].isSymptom {
                            counter++
                        }
                        
                        if oralExam[6].isSymptom {
                            counter++
                        }
                        
                        if voiceQuality[1].isSymptom {
                            counter++
                        }
                        
                        if articulation[1].isSymptom {
                            counter++
                        }
                        
                        if articulation[2].isSymptom {
                            counter++
                        }
                        
                        if diado[1].isSymptom {
                            counter++
                        }
                    }
                }
            }
        }
        
        return counter + 1
    }
    
    func sumForUniUMNDys() -> Int {
        var counter : Int = 0
        
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let articulation = self.articulationArray {
                    if let diado = self.diadoArray {
                        if oralExam[0].isSymptom {
                            counter--
                        } else {
                            counter++
                        }
                        
                        if oralExam[1].isSymptom {
                            counter++
                        }
                        
                        if oralExam[2].isSymptom {
                            counter++
                        }
                        
                        if oralExam[3].isSymptom {
                            counter++
                        }
                        
                        if oralExam[4].isSymptom {
                            counter++
                        }
                        
                        if voiceQuality[0].isSymptom {
                            counter++
                        }
                        
                        if voiceQuality[1].isSymptom {
                            counter++
                        }
                        
                        if articulation[2].isSymptom {
                            counter++
                        }
                        
                        if diado[0].isSymptom {
                            counter++
                        }
                        
                        if diado[1].isSymptom {
                            counter++
                        }
                    }
                }
            }
        }
        
        return counter + 1
    }
    
    func sumForApraxiaSpeech() -> Int {
        
        var counter : Int = 0
        if let voiceQuality = self.voiceQualityArray {
            if let articulation = self.articulationArray {
                if let diado = self.diadoArray {
        
                    if voiceQuality[3].isSymptom {
                        counter++
                    }
                    
                    if articulation[2].isSymptom {
                        counter++
                    }
                    
                    if articulation[3].isSymptom {
                        counter++
                    }
                    
                    if articulation[4].isSymptom {
                        counter++
                    }
                    
                    if diado[3].isSymptom {
                        counter++
                    }
                }
            }
        }
        
        return counter + 1
    }
    
    func sumForFlaccidSpas() -> Int {
        
        var counter : Int = 0
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let articulation = self.articulationArray {
                    if let diado = self.diadoArray {
        
                        if oralExam[0].isSymptom {
                            counter++
                        }
                        
                        if !oralExam[1].isSymptom {
                            counter++
                        }
                        
                        if oralExam[2].isSymptom {
                            counter++
                        }
                        
                        if oralExam[3].isSymptom {
                            counter++
                        }
                        
                        if oralExam[4].isSymptom {
                            counter++
                        }
                        
                        for symptom in voiceQuality {
                            if symptom.isSymptom {
                                counter++
                            }
                        }
                        
                        if articulation[0].isSymptom {
                            counter++
                        }
                        
                        if diado[0].isSymptom {
                            counter++
                        }
                    }
                }
            }
        }
        
        return counter + 1
    }
    
    func sumForAtaxicSpas() -> Int {
        
        var counter : Int = 0
        if let oralExam = self.oralExamArray {
            if let voiceQuality = self.voiceQualityArray {
                if let diado = self.diadoArray {
        
                    if oralExam[2].isSymptom {
                        counter++
                    }
                    
                    if oralExam[4].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[1].isSymptom {
                        counter++
                    }
                    
                    if voiceQuality[3].isSymptom {
                        counter++
                    }
                    
                    if diado[0].isSymptom {
                        counter++
                    }
                }
            }
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
        
        self.tableView.reloadData()
    }
    
    func getMaxCertainty() -> Double {
        
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
        
        if let aphasia = self.aphasiaArray {
        
            // Conduction Aphasia
            if aphasia[0].isSymptom && aphasia[1].isSymptom && !aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[0].isConsistent == true
                
            }
            
            // Broca's Aphasia
            if !aphasia[0].isSymptom && aphasia[1].isSymptom && !aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[1].isConsistent == true
                
            }
            
            // Wernicke's Aphasia
            if aphasia[0].isSymptom && !aphasia[1].isSymptom && !aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[2].isConsistent = true
                
            }
            
            // Transcortical Sensory Aphasia
            if aphasia[0].isSymptom && !aphasia[1].isSymptom && aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[3].isConsistent = true
                
            }
            
            // Transcortical Motor Aphasia
            if !aphasia[0].isSymptom && aphasia[1].isSymptom && aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[4].isConsistent = true
                
            }
            
            // Transcortical Mixed Aphasia
            if !aphasia[0].isSymptom && !aphasia[1].isSymptom && aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[5].isConsistent = true
                
            }
            
            // Global Aphasia
            if !aphasia[0].isSymptom && !aphasia[1].isSymptom && !aphasia[2].isSymptom {
                self.aphasiaDiagnosisArray[6].isConsistent = true
            }
            
            // Apraxia of Speech
            if !aphasia[0].isSymptom && aphasia[1].isSymptom && !aphasia[2].isSymptom {
                
                self.aphasiaDiagnosisArray[7].isConsistent = true
            }
            
            // Anomic Aphasia
            if aphasia[0].isSymptom && aphasia[1].isSymptom && aphasia[2].isSymptom {
                
                self.aphasiaDiagnosisArray[8].isConsistent = true
            }
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

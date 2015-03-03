//
//  DiagnosisViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-28.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class DiagnosisViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var oralExamArray : [Symptom] = [] // 7
    var voiceQualityArray : [Symptom] = [] // 4
    var prosodyArray : [Symptom] = [] // 1
    var articulationArray : [Symptom] = [] // 5
    var AMRArray : [Symptom] = [] // 3
    var SMRArray : [Symptom] = [] // 1
    var aphasiaArray : [Symptom] = []
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
    let flaccidSpas = Diagnosis(name: "Mixed (flaccid-spastic)", lesionSite: "Amyotrophic lateral sclerosis (ALS)")
    let ataxicSpas = Diagnosis(name: "Mixed (ataxic-spastic)", lesionSite: "Multiple sclerosis (MS)")
    
    // Aphasia
    let conAphasia = Diagnosis(name: "Conduction aphasia", lesionSite: "Parietal, above Wernicke's")
    let brocha = Diagnosis(name: "Broca's aphasia", lesionSite: "Brodmann area 44")
    let wernickes = Diagnosis(name: "Wernicke's aphasia", lesionSite: "Brodmann area 22")
    let sensoryAphasia = Diagnosis(name: "Transcortical sensory aphasia", lesionSite: "Temporal lobe")
    let motorAphasia = Diagnosis(name: "Transcortical motor aphasia", lesionSite: "Frontal lobe")
    let mixedAphasia = Diagnosis(name: "Transcortical mixed aphasia", lesionSite: "Frontal and temporal lobe")
    let globalAphasia = Diagnosis(name: "Global aphasia", lesionSite: "Dominant cerebral hemisphere")
    let speechApraxia = Diagnosis(name: "Apraxia of Speech", lesionSite: "Dominant cerebral hemisphere")
    let anomicAphasia = Diagnosis(name: "Anomic aphasia", lesionSite: "")
    
    var diagnosisArray : [Diagnosis] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.setupDiagnosis()
        
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
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        self.tableView.reloadData()
        
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diagnosisArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DiagnosisCell") as DiagnosisTableViewCell
        
        let diagnosis = diagnosisArray[indexPath.row]
        
        cell.nameLabel.text = diagnosis.name
        cell.lesionSiteLabel.text = diagnosis.possibleLesionSite
        
        if let certainty = diagnosis.certainty {
            if certainty >= self.getMaxCertainty() {
                cell.consistentLabel.text = "Consistent"
            } else {
                cell.consistentLabel.text = "Inconsistent"
            }
            cell.percentageLabel.text = String(Int(certainty*100)) + "%"
        }
        
        return cell
    }
    
    // MARK: Summing Methods
    
    func setupDiagnosis() {
        diagnosisArray = [self.flaccidDys, self.spasticDys, self.ataxicDys, self.hypoDys, self.hyperDys, self.uniUMNDys, self.apraxSpeech, self.flaccidSpas, self.ataxicDys, self.conAphasia, self.brocha, self.wernickes, self.sensoryAphasia, self.motorAphasia, self.mixedAphasia, self.globalAphasia, self.speechApraxia, self.anomicAphasia]
        
        self.tableView.reloadData()
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
    
    func getMaxCertainty() -> Double{
        
        var maxCertainty : Double = 0.0
        
        for diagnosis in diagnosisArray {
            if let certainty = diagnosis.certainty {
                if certainty >= maxCertainty {
                    maxCertainty = certainty
                }
            }
        }
        
        return maxCertainty
    }
    

    
    
}

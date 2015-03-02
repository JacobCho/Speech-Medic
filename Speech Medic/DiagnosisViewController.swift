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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.totalSymptoms = self.sumForFlaccidDys() + self.sumForSpasticDys() + self.sumForAtaxicDys() + self.sumForHypoDys() + self.sumForHyperDys() + self.sumForUniUMNDys() + self.sumForApraxiaSpeech() + self.sumForFlaccidSpas() + self.sumForAtaxicSpas()
    
        println((self.getCertainty(self.sumForFlaccidDys(), total: self.totalSymptoms))*100)
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DiagnosisCell") as DiagnosisTableViewCell
        
        return cell
    }
    
    // MARK: Summing Methods
    
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
        println(diagnosis)
        println(total)
        
        let certainty = Double(diagnosis)/Double(total)
        
        return certainty
    }
    

    
    
}

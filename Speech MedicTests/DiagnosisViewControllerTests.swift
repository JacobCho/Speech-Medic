//
//  DiagnosisViewControllerTests.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-03-08.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit
import XCTest
import Speech_Medic

class DiagnosisViewControllerTests: XCTestCase {
    
    let oralExamArray : [Symptom] = Symptom.setupOralExamArray()
    let voiceQualityArray : [Symptom] = Symptom.setupVoiceQualityArray()
    let articulationArray : [Symptom] = Symptom.setupArticulationArray()
    let diadoArray : [Symptom] = Symptom.setupDiadoArray()
    let aphasiaArray : [Symptom] = Symptom.setupAphasiaArray()
    
    
    func testflaccidDys() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[0].isSymptom = true
        self.voiceQualityArray[2].isSymptom = true
        self.voiceQualityArray[3].isSymptom = true
        self.articulationArray[0].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.articulationArray = self.articulationArray
    
        let expected : Int = 5
        
        XCTAssertEqual(diagnosisVC.sumForFlaccidDys(), expected, "Flaccid Dys equals 5")
        
    }
    
    func testSpasticDys() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[1].isSymptom = false
        self.oralExamArray[4].isSymptom = true
        self.voiceQualityArray[1].isSymptom = true
        self.voiceQualityArray[3].isSymptom = true
        self.diadoArray[0].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 6
        
        XCTAssertEqual(diagnosisVC.sumForSpasticDys(), expected, "Spastic Dys equals 6")
    }
    
    func testAtaxicDys() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.articulationArray[2].isSymptom = true
        self.diadoArray[1].isSymptom = true
        
        diagnosisVC.articulationArray = self.articulationArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 3
        
        XCTAssertEqual(diagnosisVC.sumForAtaxicDys(), expected, "Ataxic Dys equals 3")
        
    }
    
    func testHypoDys() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[1].isSymptom = false
        self.oralExamArray[5].isSymptom = true
        self.voiceQualityArray[3].isSymptom = true
        self.voiceQualityArray[4].isSymptom = true
        self.diadoArray[2].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 6
        
        XCTAssertEqual(diagnosisVC.sumForHypoDys(), expected, "Hypo Dys equals 6")
        
    }
    
    func testHyperDys() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[1].isSymptom = false
        self.oralExamArray[6].isSymptom = true
        self.voiceQualityArray[1].isSymptom = true
        self.articulationArray[2].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.articulationArray = self.articulationArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 5
        
        XCTAssertEqual(diagnosisVC.sumForHyperDys(), expected, "Hyper Dys equals 4")
    }
    
    func testUniUMNDys() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[0].isSymptom = true   // should be -1
        self.oralExamArray[1].isSymptom = true
        self.oralExamArray[2].isSymptom = true
        self.oralExamArray[3].isSymptom = true
        self.oralExamArray[4].isSymptom = true
        self.voiceQualityArray[0].isSymptom = true
        self.voiceQualityArray[1].isSymptom = true
        self.articulationArray[2].isSymptom = true
        self.diadoArray[0].isSymptom = true
        self.diadoArray[1].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.articulationArray = self.articulationArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 9
        
        XCTAssertEqual(diagnosisVC.sumForUniUMNDys(), expected, "UniUMN Dys equals 9")
        
    }
    
    func testApraxiaSpeech() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.voiceQualityArray[3].isSymptom = true
        self.articulationArray[3].isSymptom = true
        self.diadoArray[3].isSymptom = true
        
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.articulationArray = self.articulationArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 4
        
        XCTAssertEqual(diagnosisVC.sumForApraxiaSpeech(), expected, "Apraxia Speech equals 4")
    }
    
    func testFlaccidSpas() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[1].isSymptom = false
        self.oralExamArray[2].isSymptom = true
        self.oralExamArray[3].isSymptom = true
        self.voiceQualityArray[1].isSymptom = true
        self.voiceQualityArray[3].isSymptom = true
        self.articulationArray[0].isSymptom = true
        self.diadoArray[0].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.articulationArray = self.articulationArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 8
        
        XCTAssertEqual(diagnosisVC.sumForFlaccidSpas(), expected, "Flaccid Spas equals 8")
    }
    
    func testAtaxicSpas() {
        
        let diagnosisVC = DiagnosisViewController()
        
        self.oralExamArray[2].isSymptom = true
        self.voiceQualityArray[1].isSymptom = true
        self.diadoArray[0].isSymptom = true
        
        diagnosisVC.oralExamArray = self.oralExamArray
        diagnosisVC.voiceQualityArray = self.voiceQualityArray
        diagnosisVC.diadoArray = self.diadoArray
        
        let expected : Int = 4
        
        XCTAssertEqual(diagnosisVC.sumForAtaxicSpas(), expected, "Ataxic Spas equals 4")
    }
    
    func testGetCertainty() {
        
        let diagnosisVC = DiagnosisViewController()
        
        let diagnosis : Int = 1
        let total : Int = 4
        
        let expected : Double = 0.25
        
        XCTAssertEqual(diagnosisVC.getCertainty(1, total: 4), expected, "Certainty is 0.25")
        
    }

}

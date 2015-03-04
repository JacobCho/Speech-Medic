//
//  Symptom.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-27.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import Foundation

class Symptom: NSObject {
    
    var name : String
    var isSymptom : Bool = false
    
    init(name: String) {
        self.name = name

    }
    
    class func setupOralExamArray() -> [Symptom] {
        
        let fasciculationsSymptom = Symptom(name: "Fasciculations (twitching) or atrophy")
        let tongueWeaknessSymptom = Symptom(name: "Unilateral weakness in tongue or central face")
        let hypergagSymptom = Symptom(name: "Hyperactive gag")
        let hypogagSymptom = Symptom(name: "Hypoactive gag")
        let primitiveReflexesSymptom = Symptom(name: "Primitive reflexes (sucking, snout, jaw jerk)")
        let reducedFacialExpressionSymptom = Symptom(name: "Reduced facial expression")
        let facialTicksSymptom = Symptom(name: "Facial ticks or tremors")
        
        let oralExamArray = [fasciculationsSymptom, tongueWeaknessSymptom, hypergagSymptom, hypogagSymptom, primitiveReflexesSymptom, reducedFacialExpressionSymptom, facialTicksSymptom]
        
        return oralExamArray
        
    }
    
    class func setupVoiceQualityArray() -> [Symptom] {
        
        let breathinessSymptom = Symptom(name: "Breathiness, speaking on inhalation")
        let voicePitchSymptom = Symptom(name: "Harsh, low pitch voice")
        let hypernasalSymptom = Symptom(name: "Hypernasal, audible nasal emission")
        let monopitchSymptom = Symptom(name: "Monopitch, monoloudness")
        
        let voiceQualityArray = [breathinessSymptom, voicePitchSymptom, hypernasalSymptom, monopitchSymptom]
        
        return voiceQualityArray
        
    }
    
    class func setupProsodyArray() -> [Symptom] {
        
        let shortRushesOfSpeechSymptom = Symptom(name: "Short rushes of speech")
        
        let prosodyArray = [shortRushesOfSpeechSymptom]
        
        return prosodyArray
    }
    
    class func setupArticulationArray() -> [Symptom] {
        
        let rapidDetWRestSymptom = Symptom(name: "Rapid deterioration, recovery with rest")
        let rapidDetSymptom = Symptom(name: "Rapid deterioration with increased rate")
        let impreciseBreakdownsSymptom = Symptom(name: "Imprecise breakdowns or articulation")
        let articulatoryGropingSymptom = Symptom(name: "Articulatory groping, self-correction attempts")
        let increasedErrorsSymptom = Symptom(name: "Increased errors with increased length, automatic speech better")
        
        let articulationArray = [rapidDetWRestSymptom, rapidDetSymptom, impreciseBreakdownsSymptom, articulatoryGropingSymptom, increasedErrorsSymptom]
        
        return articulationArray
    }
    
    class func setupAMRArray() -> [Symptom] {
        
        let slowSymptom = Symptom(name: "AMR slow and regular, errors are slow and regular (spastic)")
        let irregularSymptom = Symptom(name: "AMR irregular, irregular articulatory breakdowns (ataxic/hyper)")
        let rapidSymptom = Symptom(name: "AMR rapid and blurred (hypokinetic)")
        
        let AMRArray = [slowSymptom, irregularSymptom, rapidSymptom]
        
        return AMRArray
    }
    
    class func setupSMRArray() -> [Symptom] {
        
        let smrSymptom = Symptom(name: "SMRs poorly sequenced, non-speech oral apraxia")
        
        let SMRArray = [smrSymptom]
        
        return SMRArray
    }
    
    class func setupAphasiaArray() -> [Symptom] {
        let fluentSpeechSymptom = Symptom(name: "Fluent Speech")
        let intactCompSymptom = Symptom(name: "Intact Comprehension")
        let goodRepititionSymptom = Symptom(name: "Good Repitition")
        
        let aphasiaArray = [fluentSpeechSymptom, intactCompSymptom, goodRepititionSymptom]
        
        return aphasiaArray
    }

}

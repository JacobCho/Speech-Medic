//
//  Diagnosis.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-28.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import Foundation

class Diagnosis: NSObject {
    
    var name : String
    var isConsistent : Bool = false
    var possibleLesionSite : String
    var certainty : Double?
    
    init(name: String, lesionSite: String) {
        
        self.name = name
        self.possibleLesionSite = lesionSite
    }

}

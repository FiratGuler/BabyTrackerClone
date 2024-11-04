//
//  SymptompsFirebaseModel.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation


struct SymptompsFirebaseModel : Codable {
    var id : String
    var time : Date
    var symptomps : [String]
    var note : String
    var category : FirebaseDataCategory = .symptom
}

//
//  FirebaseDataType.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 3.11.2024.
//

import Foundation

enum FirebaseDataType {
    case sleep(SleepFirebaseModel)
    case feeding(FeedingFirebaseModel)
    case symptom(SymptompsFirebaseModel)
}  

struct FirebaseDataModel : Codable {
    var sleep : [SleepFirebaseModel]
    var feeding : [FeedingFirebaseModel]
    var symptomps : [SymptompsFirebaseModel]
}

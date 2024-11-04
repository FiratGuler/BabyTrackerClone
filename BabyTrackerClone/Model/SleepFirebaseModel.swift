//
//  SleepFirebaseModel.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation


struct SleepFirebaseModel : Codable {
    var id : String
    var fellSleep : Date
    var wokeUp : Date
    var note : String
    var category : FirebaseDataCategory = .sleep
    
}

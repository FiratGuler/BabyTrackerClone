//
//  FeedingFirebaseModel.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation


struct FeedingFirebaseModel : Codable {
    var id : String
    var time : Date
    var amount : String
    var note : String
    var category : FirebaseDataCategory = .feeding
}

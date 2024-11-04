//
//  SymptompsModel.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation


struct SymptompsItem {
    var name : String
    var imageName : String
    var didClick : Bool
    
    static let SymptosData : [SymptompsItem] = [
        SymptompsItem(name: "Runny Nose", imageName: "RunnyNose", didClick: false),
        SymptompsItem(name: "Heartburn", imageName: "Heartburn", didClick: false),
        SymptompsItem(name: "No Appetite", imageName: "NoAppetite", didClick: false),
        SymptompsItem(name: "Rush", imageName: "Rush", didClick: false),
        SymptompsItem(name: "Low Energy", imageName: "LowEnergy", didClick: false),
        SymptompsItem(name: "Nausea", imageName: "Nausea", didClick: false),
        SymptompsItem(name: "Cough", imageName: "Cough", didClick: false),
        SymptompsItem(name: "Fever", imageName: "Fever", didClick: false)
    ]
}

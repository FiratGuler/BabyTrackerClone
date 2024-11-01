//
//  SymptompsModel.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation


struct SymptompsModel {
    var name : String
    var imageName : String
    var didClick : Bool
    
    static let SymptosData : [SymptompsModel] = [
        SymptompsModel(name: "Runny Nose", imageName: "RunnyNose", didClick: false),
        SymptompsModel(name: "Heartburn", imageName: "Heartburn", didClick: false),
        SymptompsModel(name: "No Appetite", imageName: "NoAppetite", didClick: false),
        SymptompsModel(name: "Rush", imageName: "Rush", didClick: false),
        SymptompsModel(name: "Low Energy", imageName: "LowEnergy", didClick: false),
        SymptompsModel(name: "Nausea", imageName: "Nausea", didClick: false),
        SymptompsModel(name: "Cough", imageName: "Cough", didClick: false),
        SymptompsModel(name: "Fever", imageName: "Fever", didClick: false)
    ]
}

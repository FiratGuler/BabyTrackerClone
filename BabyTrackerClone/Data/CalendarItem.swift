//
//  CalendarItem.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation

struct CalendarItem {
    var imageName: String
    var selectedImageName: String
    var didSelect: Bool
    var dataCategory: FirebaseDataCategory
    
    static let CalenderData: [CalendarItem] = [
        CalendarItem(imageName: "All", selectedImageName: "AllSelected", didSelect: true, dataCategory: .all),
        CalendarItem(imageName: "FeedingIcon", selectedImageName: "FeedingIconSelected", didSelect: false, dataCategory: .feeding),
        CalendarItem(imageName: "SleepIcon", selectedImageName: "SleepIconSelected", didSelect: false, dataCategory: .sleep),
        CalendarItem(imageName: "SymptomsIcon", selectedImageName: "SymptomsIconSelected", didSelect: false, dataCategory: .symptom)
    ]
}



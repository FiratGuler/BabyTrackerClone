//
//  Date+Extensions.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 4.11.2024.
//

import Foundation

extension Date {
    func convertToString(format: String = "h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: self)
    }
}


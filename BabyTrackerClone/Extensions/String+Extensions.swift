//
//  String+Extensions.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import Foundation

extension String {
    func convertToDate(format: String = "h:mm a") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") 
        
        return dateFormatter.date(from: self)
    }
}

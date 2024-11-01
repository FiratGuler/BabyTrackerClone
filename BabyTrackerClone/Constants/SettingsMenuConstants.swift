//
//  SettingsMenuConstants.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit

struct SettingsMenuConstants {
    struct MenuItem {
        let title: String
        let icon: UIImage?

        static let allItems: [MenuItem] = [
            MenuItem(title: "Rate Us", icon: UIImage(named: "RateUsIcon")),
            MenuItem(title: "Terms of Use", icon: UIImage(named: "TicketIcon")),
            MenuItem(title: "Privacy Policy", icon: UIImage(named: "PrivacyIcon")),
            MenuItem(title: "Contact Us", icon: UIImage(named: "PhoneIcon")),
            MenuItem(title: "Restore Purchase", icon: UIImage(named: "RestoreIcon"))
        ]
    }
}


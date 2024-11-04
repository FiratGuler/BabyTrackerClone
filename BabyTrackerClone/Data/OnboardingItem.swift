//
//  OnboardingConstants.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 30.10.2024.
//

import Foundation


struct OnboardingItem {
    let title: String
    let subtitle: String
    let imageName: String
}

struct OnboardingConstants {
    static let items: [OnboardingItem] = [
        OnboardingItem(
            title: "Track Your Baby's Activities with Ease",
            subtitle: "Get started with tracking your baby's feedings, diaper changes, sleep patterns, and more...",
            imageName: "OnboardingBack1"
        ),
        OnboardingItem(
            title: "Stay Connected with Caregivers",
            subtitle: "Share access to your baby's tracker with family members, babysitters, or healthcare providers",
            imageName: "OnboardingBack2"
        )
    ]
}

//
//  AppDelegate.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 30.10.2024.
//

import UIKit
import NeonSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Font.configureFonts(font: .Poppins)
        Neon.activatePremiumTest()

        Neon.configure(
            window: &window,
            onboardingVC: OnboardingVC(),
            paywallVC: PaywallVC(),
            homeVC: HomeVC()
        )
        
        return true
    }



}


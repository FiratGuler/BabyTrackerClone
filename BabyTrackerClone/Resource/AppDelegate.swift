//
//  AppDelegate.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 30.10.2024.
//

import UIKit
import NeonSDK
import Firebase
import Adapty

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Font.configureFonts(font: .Poppins)
        FirebaseApp.configure()
        AuthManager.signInAnonymously()
        
        AdaptyManager.configure(withAPIKey: "public_live_J2LhHYDu.Y7y8sVxv1i1RpuyjgQ87",
                                       placementIDs: ["placement1"])
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


//
//  OnboardingVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 30.10.2024.
//

import UIKit
import NeonSDK

final class OnboardingVC: NeonOnboardingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        
        self.configureButton(
            title: "Next",
            titleColor: .white,
            font: Font.custom(size: 18, fontWeight: .Bold),
            cornerRadious: 25,
            height: 64,
            horizontalPadding: 30,
            bottomPadding: 50,
            backgroundColor: .appPurple,
            borderColor: nil,
            borderWidth: nil
        )
        
        self.configureBackground(
            type: .halfBackgroundImage(
                backgroundColor: .white,
                offset: 50,
                isFaded: false)
        )

        self.configurePageControl(
            type: .V1,
            currentPageTintColor: .appPurple,
            tintColor: .lightGray,
            radius: 2,
            padding: 2
        )
    
        self.configureText(
            titleColor: .black,
            titleFont: Font.custom(size: 31, fontWeight: .SemiBold),
            subtitleColor: .black,
            subtitleFont: Font.custom(size: 17, fontWeight: .Regular)
        )
        
        addPage()
    }
    
    private func addPage() {
        let onboardingData = OnboardingConstants.items

        for item in onboardingData {
            self.addPage(
                title: item.title,
                subtitle: item.subtitle,
                image: UIImage(named: item.imageName)!
            )
        }
    }
    
    override func onboardingCompleted(){
        present(destinationVC: HomeVC(), slideDirection: .right)
    }
    
    
    
    
    
}

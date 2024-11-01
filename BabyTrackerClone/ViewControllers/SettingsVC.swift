//
//  SettingsVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit
import SnapKit
import NeonSDK


final class SettingsVC: UIViewController {
    
    private let customNavBar = CustomNavigationBar()
    private let premiumButton = UIButton()
    private var previousButton: UIButton?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        
        configureNavigationBar()
        configurePremiumButton()
        setupMenuItems()
    }
    
    private func configureNavigationBar() {
        
        customNavBar.titleTextColor = .appPurple
        customNavBar.isRightButtonVisible = false
        customNavBar.setTitle("Settings")
        customNavBar.setLeftButtonIcon("AppBackIcon")
        
        view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        customNavBar.leftButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    
    private func configurePremiumButton() {
        premiumButton.setImage(UIImage(named: "PremiumImage"), for: .normal)
        premiumButton.layer.cornerRadius = UIConstants.cornerRadius
        
        view.addSubview(premiumButton)
        premiumButton.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(81)
        }
    }
    
    private func setupMenuItems() {
        
        for menuItem in SettingsMenuConstants.MenuItem.allItems {
            let menuButton = SettingsMenuButton(menuItem: menuItem)
            view.addSubview(menuButton)
            
            menuButton.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(60)
                
                if let previousButton = previousButton {
                    make.top.equalTo(previousButton.snp.bottom).offset(20)
                } else {
                    make.top.equalTo(premiumButton.snp.bottom).offset(20)
                }
            }
        
            previousButton = menuButton
        }
    }
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
        
    }
    
}

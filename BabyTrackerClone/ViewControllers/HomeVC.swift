//
//  ViewController.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 30.10.2024.
//

import UIKit
import SnapKit


final class HomeVC: UIViewController {
    
  
    
    private let customNavigationBar = CustomNavigationBar()
    private var feedingButton = UIButton()
    private var sleepButton = UIButton()
    private var symptomsButton = UIButton()
    
    private var lastButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupCustomNavigationBar()
        configureFeedingButton()
        configureSleepButton()
        configureSymptomsButton()
    }
    
    private func setupCustomNavigationBar() {
        view.addSubview(customNavigationBar)
        
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        customNavigationBar.leftButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        customNavigationBar.rightButton.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
    }
    
    private func configureFeedingButton() {
        feedingButton.setImage(UIImage(named: "ButtonImage1"), for: .normal)
        feedingButton.layer.cornerRadius = UIConstants.cornerRadius
        
        view.addSubview(feedingButton)
        feedingButton.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).offset(22)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(63)
        }
        
        feedingButton.addTarget(self, action: #selector(feedingButtonTapped), for: .touchUpInside)
    }
    
    private func configureSleepButton() {
        sleepButton.setImage(UIImage(named: "ButtonImage2"), for: .normal)
        sleepButton.layer.cornerRadius = UIConstants.cornerRadius
        
        view.addSubview(sleepButton)
        sleepButton.snp.makeConstraints { make in
            make.top.equalTo(feedingButton.snp.bottom).offset(22)
            make.left.right.height.equalTo(feedingButton)
        }
        
        sleepButton.addTarget(self, action: #selector(sleepButtonTapped), for: .touchUpInside)
    }
    
    private func configureSymptomsButton() {
        symptomsButton.setImage(UIImage(named: "ButtonImage3"), for: .normal)
        symptomsButton.layer.cornerRadius = UIConstants.cornerRadius
        
        view.addSubview(symptomsButton)
        symptomsButton.snp.makeConstraints { make in
            make.top.equalTo(sleepButton.snp.bottom).offset(22)
            make.left.right.height.equalTo(feedingButton)
        }
        
        symptomsButton.addTarget(self, action: #selector(symptomsButtonTapped), for: .touchUpInside)
    }
    
    
    
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        present(destinationVC: SettingsVC(), slideDirection: .right)
    }
    
    @objc private func rightBarButtonTapped() {
        present(destinationVC: CalendarVC(), slideDirection: .right)
    }
    
    @objc private func feedingButtonTapped() {
        present(destinationVC: FeedingVC(), slideDirection: .right)
    }
    
    @objc private func sleepButtonTapped() {
        present(destinationVC: SleepVC(), slideDirection: .right)
    }
    
    @objc private func symptomsButtonTapped() {
        present(destinationVC: SymptompsVC(), slideDirection: .right)
    }
    
}


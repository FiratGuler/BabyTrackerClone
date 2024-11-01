//
//  SleepVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit
import NeonSDK

final class SleepVC: UIViewController {
    
    private let customNavBar = CustomNavigationBar()
    private let fellSleepTextfield = CustomTextfield(placetext: "Fell Sleep", inputType: .textField, keyboardType: .numberPad)
    private let wokeUpTextfield = CustomTextfield(placetext: "Woke Up", inputType: .textField, keyboardType: .numberPad)
    private let noteTextView = CustomTextfield(placetext: "Note", inputType: .textView)
    private let saveButton = CustomSaveButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureTextFields()
        configureSaveButton()
    }
    
    private func configureNavigationBar() {
        
        customNavBar.titleTextColor = .appPurple
        customNavBar.isRightButtonVisible = false
        customNavBar.setTitle("Sleep")
        customNavBar.setLeftButtonIcon("AppBackIcon")
        
        view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        customNavBar.leftButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    
    private func configureTextFields(){
        view.addSubview(fellSleepTextfield)
        fellSleepTextfield.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(60)
        }
        
        view.addSubview(wokeUpTextfield)
        wokeUpTextfield.snp.makeConstraints { make in
            make.top.equalTo(fellSleepTextfield.snp.bottom).offset(22)
            make.left.right.height.equalTo(fellSleepTextfield)
        }
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(wokeUpTextfield.snp.bottom).offset(22)
            make.left.right.equalTo(fellSleepTextfield)
            make.height.equalTo(view.snp.height).dividedBy(3)
        }
    }
    
    private func configureSaveButton(){
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(22)
            make.left.right.equalTo(fellSleepTextfield)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        print("savebuttontapped")
        LottieManager.showFullScreenLottie(animation: .loadingPlane)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            LottieManager.removeFullScreenLottie()
        }
    }
}


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
    private let fellSleepTextfield = CustomTextfield(placetext: "Fell Sleep", inputType: .textField)
    private let wokeUpTextfield = CustomTextfield(placetext: "Woke Up", inputType: .textField)
    private let noteTextView = CustomTextfield(placetext: "Note", inputType: .textView)
    private let saveButton = CustomSaveButton()
    private var sleepId : String?
    
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
    
    private func configureTextFields() {
        fellSleepTextfield.showDatePicker()
        fellSleepTextfield.onTextChange = checkTextFields
        
        view.addSubview(fellSleepTextfield)
        fellSleepTextfield.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(60)
        }
        
        wokeUpTextfield.showDatePicker()
        wokeUpTextfield.onTextChange = checkTextFields
        
        view.addSubview(wokeUpTextfield)
        wokeUpTextfield.snp.makeConstraints { make in
            make.top.equalTo(fellSleepTextfield.snp.bottom).offset(22)
            make.left.right.height.equalTo(fellSleepTextfield)
        }
        
        noteTextView.onTextChange = checkTextFields
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(wokeUpTextfield.snp.bottom).offset(22)
            make.left.right.equalTo(fellSleepTextfield)
            make.height.equalTo(view.snp.height).dividedBy(3)
        }
    }
    
    private func configureSaveButton() {
        saveButton.isHidden = true
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(22)
            make.left.right.equalTo(fellSleepTextfield)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func formatForFirebase() -> SleepFirebaseModel? {
        sleepId = UUID().uuidString
        
        guard let fellString = fellSleepTextfield.text,
              let fellDate = fellString.convertToDate() else {
            print("fellSleep Textfield error")
            return nil
        }
        
        guard let wokeString = wokeUpTextfield.text,
              let wokeUpDate = wokeString.convertToDate() else {
            print("wokeUp Textfield error")
            return nil
        }
        
        guard let note = noteTextView.textViewContent else {
            print("Note TextView error")
            return nil
        }
        
        return SleepFirebaseModel(id: sleepId!, fellSleep: fellDate, wokeUp: wokeUpDate, note: note)
    }
    
    private func checkTextFields() {
        let isFellSleepFilled = !(fellSleepTextfield.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isWokeUpFilled = !(wokeUpTextfield.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isNoteFilled = !(noteTextView.textViewContent ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  && noteTextView.textViewContent != noteTextView.placeholderText
        
        saveButton.isHidden = !(isFellSleepFilled && isWokeUpFilled && isNoteFilled)
    }
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        
        LottieManager.showFullScreenLottie(animation: .loadingPlane)
        
        guard let sleepModel = formatForFirebase() else {
            print("Failed to create SleepFirebaseModel.")
            return
        }
        
        guard let id = sleepId else {
            print("Failed to create ID.")
            return
        }
        
        FirebaseManager.shared.addSleep(sleepModel: sleepModel, uuid: id)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            LottieManager.removeFullScreenLottie()
            self.dismiss(animated: true)
        }
        
    }
}


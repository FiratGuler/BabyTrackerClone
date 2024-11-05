//
//  FeedingVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit
import NeonSDK



final class FeedingVC: UIViewController, UITextFieldDelegate {
    
    private let customNavBar = CustomNavigationBar()
    private let timeTextfield = CustomTextfield(placetext: "Time", inputType: .textField)
    private let amountTextfield = CustomTextfield(placetext: "Amount (ml)", inputType: .textField, keyboardType: .numberPad)
    private let noteTextView = CustomTextfield(placetext: "Note", inputType: .textView)
    private let saveButton = CustomSaveButton()
    private var feedingId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureTextfields()
        configureSaveButton()
    }
    
    private func configureNavigationBar() {
        
        customNavBar.titleTextColor = .appPurple
        customNavBar.isRightButtonVisible = false
        customNavBar.setTitle("Feeding")
        customNavBar.setLeftButtonIcon("AppBackIcon")
        
        view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        customNavBar.leftButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    
    private func configureTextfields() {
        
        timeTextfield.showDatePicker()
        timeTextfield.onTextChange = checkTextFields
        
        view.addSubview(timeTextfield)
        timeTextfield.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(60)
        }
        
        amountTextfield.onTextChange = checkTextFields
        
        view.addSubview(amountTextfield)
        amountTextfield.snp.makeConstraints { make in
            make.top.equalTo(timeTextfield.snp.bottom).offset(22)
            make.left.right.height.equalTo(timeTextfield)
        }
        
        noteTextView.onTextChange = checkTextFields
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(amountTextfield.snp.bottom).offset(22)
            make.left.right.equalTo(timeTextfield)
            make.height.equalTo(view.snp.height).dividedBy(3)
        }
        
    
    }
    
    private func configureSaveButton() {
        
        saveButton.isHidden = true
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(22)
            make.left.right.equalTo(timeTextfield)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func formatForFirebase() -> FeedingFirebaseModel? {
        
        feedingId = UUID().uuidString
        
        guard let timeString = timeTextfield.text,
              let date = timeString.convertToDate() else {
            print("Time Textfield error")
            return nil
        }
        
        guard let amount = amountTextfield.text else {
            print("Amount Textfield error")
            return nil
        }
        
        guard let note = noteTextView.textViewContent else {
            print("Note TextView error")
            return nil
        }
        
        return FeedingFirebaseModel(id: feedingId!, time: date, amount: amount, note: note)
    }
    
    private func checkTextFields() {
        let isTimeFilled = !(timeTextfield.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isAmountFilled = !(amountTextfield.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        let isNoteFilled = !(noteTextView.textViewContent ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                            && noteTextView.textViewContent != noteTextView.placeholderText

        saveButton.isHidden = !(isTimeFilled && isAmountFilled && isNoteFilled)
    }

    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        
        LottieManager.showFullScreenLottie(animation: .loadingPlane)
        
        guard let feedingModel = formatForFirebase() else {
            print("Failed to create FeedingFirebaseModel.")
            return
        }
        
        guard let id = feedingId else {
            print("Failed to create ID.")
            return
        }
        
        FirebaseManager.shared.addFeeding(feedingModel: feedingModel, uuid: id)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            LottieManager.removeFullScreenLottie()
            self.dismiss(animated: true)
        }
        
    }
    

}


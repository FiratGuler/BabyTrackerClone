//
//  SymptompsVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit
import NeonSDK

final class SymptompsVC: UIViewController {
    
    private let customNavBar = CustomNavigationBar()
    private let timeTextfield = CustomTextfield(placetext: "Time", inputType: .textField)
    private let symptonsTextfield = CustomTextfield(placetext: "Symptons", inputType: .clickableTextField)
    private let noteTextView = CustomTextfield(placetext: "Note", inputType: .textView)
    private let saveButton = CustomSaveButton()
    private var symptompsId : String?
    
    var selectedSymptoms: [String] = []
    
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
        customNavBar.setTitle("Symptomps")
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
        
        symptonsTextfield.onTextChange = checkTextFields
        
        view.addSubview(symptonsTextfield)
        symptonsTextfield.snp.makeConstraints { make in
            make.top.equalTo(timeTextfield.snp.bottom).offset(22)
            make.left.right.height.equalTo(timeTextfield)
        }
        
        symptonsTextfield.onTap = { [weak self] in
            self?.didClickTextField()
        }
        
        noteTextView.onTextChange = checkTextFields
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(symptonsTextfield.snp.bottom).offset(22)
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
    
    private func didClickTextField() {
        let symptompsVc = SymptompsSelectedVC()
        symptompsVc.delegate = self
        present(destinationVC: symptompsVc, slideDirection: .right)
    }
    
    private func onSelectedSymptoms(selectedNames: [String]) {
        symptonsTextfield.text = selectedNames.joined(separator: ", ")
    }
    
    private func formatForFirebase() -> SymptompsFirebaseModel? {
        
        symptompsId = UUID().uuidString
        
        guard let timeString = timeTextfield.text,
              let date = timeString.convertToDate() else {
            print("Time Textfield error")
            return nil
        }
        
        guard !selectedSymptoms.isEmpty else {
            print("Symptoms selection is empty")
            return nil
        }
        
        guard let note = noteTextView.textViewContent else {
            print("Note TextView error")
            return nil
        }

        return SymptompsFirebaseModel(id: symptompsId!, time: date, symptomps: selectedSymptoms, note: note)
    }
    
    private func checkTextFields() {
        let isTimeFilled = !(timeTextfield.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isSymptonsFilled = !(symptonsTextfield.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isNoteFilled = !(noteTextView.textViewContent ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && noteTextView.textViewContent != noteTextView.placeholderText
        
        saveButton.isHidden = !(isTimeFilled && isSymptonsFilled && isNoteFilled)
    }
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        
        LottieManager.showFullScreenLottie(animation: .loadingPlane)
        
        guard let symptompsModel = formatForFirebase() else {
            print("Failed to create SymptompsFirebaseModel.")
            return
        }
        
        FirebaseManager.shared.addSymptomps(symptompsModel: symptompsModel, uuid: symptompsId!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            LottieManager.removeFullScreenLottie()
            self.dismiss(animated: true)
        }
    }
    
}

extension SymptompsVC : SymptompsSelectedDelegate {
    func didSelectSymptoms(names: [String]) {
        selectedSymptoms = names
        onSelectedSymptoms(selectedNames: names)
    }
}

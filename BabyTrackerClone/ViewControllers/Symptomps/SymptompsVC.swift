//
//  SymptompsVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit

final class SymptompsVC: UIViewController {

    private let customNavBar = CustomNavigationBar()
    private let timeTextfield = CustomTextfield(placetext: "Time", inputType: .textField, keyboardType: .numberPad)
    private let symptonsTextfield = CustomTextfield(placetext: "Symptons", inputType: .clickableTextField)
    private let noteTextView = CustomTextfield(placetext: "Note", inputType: .textView)
    private let saveButton = CustomSaveButton()
    
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
        
        view.addSubview(timeTextfield)
        timeTextfield.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(60)
        }
        
        view.addSubview(symptonsTextfield)
        symptonsTextfield.snp.makeConstraints { make in
            make.top.equalTo(timeTextfield.snp.bottom).offset(22)
            make.left.right.height.equalTo(timeTextfield)
        }
        
        symptonsTextfield.onTap = { [weak self] in
            self?.didClickTextField()
        }
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(symptonsTextfield.snp.bottom).offset(22)
            make.left.right.equalTo(timeTextfield)
            make.height.equalTo(view.snp.height).dividedBy(3)
        }
    }
    
    private func configureSaveButton() {
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
    
    func onSelectedSymptoms(selectedNames: [String]) {
        symptonsTextfield.text = selectedNames.joined(separator: ", ")
       }
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        print("saveButton tapped")
    }
    
}

extension SymptompsVC : SymptompsSelectedDelegate {
    func didSelectSymptoms(names: [String]) {
        selectedSymptoms = names
        onSelectedSymptoms(selectedNames: names)
    }
}

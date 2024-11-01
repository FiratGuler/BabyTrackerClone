//
//  SymptompsSelectedVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import UIKit
import NeonSDK

protocol SymptompsSelectedDelegate: AnyObject {
    func didSelectSymptoms(names: [String])
}

class SymptompsSelectedVC: UIViewController {
    
    private let customNavBar = CustomNavigationBar()
    private let saveButton = CustomSaveButton()
    private var symptompsArray : [SymptompsModel] = SymptompsModel.SymptosData
    private var collectionView = NeonCollectionView<SymptompsModel, SymptompsCollectionCell>()

    weak var delegate: SymptompsSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        didSelect()
    }
    
    
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureCollectionView()
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
    
    private func configureCollectionView() {
        collectionView = NeonCollectionView<SymptompsModel, SymptompsCollectionCell>(
            objects: SymptompsModel.SymptosData,
            itemsPerRow: 2,
            leftPadding: 25,
            rightPadding: 25,
            horizontalItemSpacing: 20,
            verticalItemSpacing: 5
        )
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom).offset(22)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureSaveButton() {
        saveButton.isHidden = true
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            make.left.right.equalToSuperview().inset(22)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func updateSaveButtonVisibility() {
        saveButton.isHidden = !symptompsArray.contains { $0.didClick }
    }
    
    private func didSelect() {
        collectionView.didSelect = { [weak self] object, indexPath in
            guard let self = self else { return }
            
            self.symptompsArray[indexPath.item].didClick.toggle()
            
            if let cell = self.collectionView.cellForItem(at: indexPath) as? SymptompsCollectionCell {
                cell.configure(with: self.symptompsArray[indexPath.item])
            }
            
            self.updateSaveButtonVisibility()
        }
    }
    
    private func getSelectedSymptomNames() -> [String] {
        return symptompsArray
            .filter { $0.didClick }
            .map { $0.name }
    }
    
 
    
    // MARK: - Selectors
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        
        let selectedNames = getSelectedSymptomNames()
        LottieManager.showFullScreenLottie(animation: .loadingPlane)

        delegate?.didSelectSymptoms(names: selectedNames)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            LottieManager.removeFullScreenLottie()
            self.dismiss(animated: true)
        }
    }
}

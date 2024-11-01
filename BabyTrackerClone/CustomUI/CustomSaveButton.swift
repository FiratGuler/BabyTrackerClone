//
//  CustomSaveButton.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit

class CustomSaveButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI(){
        self.setTitle("Save", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: UIConstants.mediumFont, size: 20)
        self.backgroundColor = .appPurple
        self.layer.cornerRadius = 31
        self.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

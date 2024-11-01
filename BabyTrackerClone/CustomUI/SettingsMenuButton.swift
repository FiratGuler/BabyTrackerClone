//
//  SettingsMenuButton.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit

class SettingsMenuButton: UIButton {
    
    private var arrowImageView = UIImageView()
    private var iconImageView = UIImageView()
    
    init(menuItem: SettingsMenuConstants.MenuItem) {
        super.init(frame: .zero)
        
        setupUI(menuItem: menuItem)
    }
    
    private func setupUI(menuItem: SettingsMenuConstants.MenuItem) {

        iconImageView.image = menuItem.icon
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        
        self.setTitle(menuItem.title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.contentHorizontalAlignment = .left
        self.backgroundColor = .settingsMenu
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
        self.layer.cornerRadius = UIConstants.cornerRadius
        
        
        arrowImageView.image = UIImage(named: "arrow")
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

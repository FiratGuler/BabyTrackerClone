//
//  CalenderCollectionCell.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import UIKit
import NeonSDK

class CalendarCollectionCell : NeonCollectionViewCell <CalendarItem> {
    
    var iconImageView = UIImageView()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
    
    override func configure(with calendarItem : CalendarItem) {
        super.configure(with: calendarItem)
        
        iconImageView.image = UIImage(named: calendarItem.didSelect ? calendarItem.selectedImageName : calendarItem.imageName)
        
    }
    
}


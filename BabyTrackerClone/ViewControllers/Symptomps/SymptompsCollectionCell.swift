//
//  SymptompsCollectionCell.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 1.11.2024.
//

import UIKit
import NeonSDK

class SymptompsCollectionCell : NeonCollectionViewCell <SymptompsItem> {
    private var imageView = UIImageView()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.appPurple.cgColor
        self.layer.cornerRadius = 25
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configure(with symptomps : SymptompsItem) {
        super.configure(with: symptomps)
        imageView.image = UIImage(named: symptomps.imageName)
        
        if symptomps.didClick {
            self.layer.borderWidth = 2
        } else {
            self.layer.borderWidth = 0
        }
    }
}

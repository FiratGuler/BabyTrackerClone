//
//  CustomLabelView.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 4.11.2024.
//

import UIKit

class CustomLabelView : UIView {
    
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    
    init(text : String) {
        super.init(frame: .zero)
        textLabel.text = text
        setupUI()
    }
    
    private func setupUI(){
        imageView.image = UIImage(named: "PaywallArticle")
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.width.equalTo(10)
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(22)
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

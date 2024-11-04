//
//  CustomPriceLabel.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 4.11.2024.
//

import UIKit

class CustomPriceView : UIView {
    
    private var paywallName = UILabel()
    private var paywallPrice = UILabel()
    
 
    
    init(paywallName:String , paywallPrice : String) {
        
        super.init(frame: .zero)
    
        self.paywallName.text = paywallName
        self.paywallPrice.text = paywallPrice
        setupUI()
    }
    
    private func setupUI(){
        
        self.backgroundColor = .settingsMenu
        self.layer.cornerRadius = 25
        
        addSubview(paywallName)
        paywallName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(self.snp.width).dividedBy(1.5)
        }
        
        addSubview(paywallPrice)
        paywallPrice.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalTo(paywallName.snp.right)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

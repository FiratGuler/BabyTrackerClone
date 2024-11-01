//
//  CustomNavigationBar.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit

class CustomNavigationBar: UIView {
    
    let leftButton = UIButton()
    let titleLabel = UILabel()
    let rightButton = UIButton()
    
    
    var titleTextColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var isRightButtonVisible: Bool = true {
        didSet {
            rightButton.isHidden = !isRightButtonVisible
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        backgroundColor = .white
        
        setupLayout()
        configureLeftBarButton()
        configureTitleLabel()
        configureRightBarButton()
    }
    
    private func configureLeftBarButton() {
        leftButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        leftButton.tintColor = .black
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Home"
        titleLabel.font = UIFont(name: UIConstants.mediumFont, size: 22)

        titleLabel.textColor = titleTextColor
    }
    
    private func configureRightBarButton() {
        rightButton.setImage(UIImage(named: "CalendarIcon"), for: .normal)
        rightButton.tintColor = .black
    }
    
    private func setupLayout() {
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(26)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        

        rightButton.isHidden = !isRightButtonVisible
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setLeftButtonIcon(_ iconName: String) {
        leftButton.setImage(UIImage(named: iconName), for: .normal)
      }
}

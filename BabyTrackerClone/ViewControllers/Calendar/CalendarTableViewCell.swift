//
//  CalendarTableViewCell.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 3.11.2024.
//

import UIKit
import NeonSDK

class CalendarTableViewCell: NeonTableViewCell<FirebaseDataType> {
    
    private var iconImageView = UIImageView()
    private var titleLabel = UILabel()
    private var dateLabel = UILabel()
    private var containerView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          
          setupUI()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    override func configure(with data : FirebaseDataType) {
        super.configure(with: data)
     
        switch data {
        case .sleep(let sleepData):
            iconImageView.image = UIImage(named: "SleepIconSelected")
            titleLabel.text = "Sleep"
            dateLabel.text = "\(sleepData.fellSleep.convertToString())"
        case .feeding(let feedingData):
            iconImageView.image = UIImage(named: "FeedingIconSelected")
            titleLabel.text = "Feeding"
            dateLabel.text = "\(feedingData.time.convertToString())"
        case .symptom(let symptomData):
            iconImageView.image = UIImage(named: "SymptomsIconSelected")
            titleLabel.text = "Symptom"
            dateLabel.text = "\(symptomData.time.convertToString())"
        }
      

    }
        
    private func setupUI() {
        
        configureSelf()
        configureIconImageView()
        configureTitleLabel()
        configureDateLabel()
    }
    
    private func configureSelf() {
        containerView.backgroundColor = .settingsMenu
        containerView.layer.cornerRadius = 25
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(5)
            make.left.right.equalToSuperview().inset(10)
        }
        
    }
    
    private func configureIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
        
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = .appPurple
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureDateLabel() {
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
        }
    }
    
  

}



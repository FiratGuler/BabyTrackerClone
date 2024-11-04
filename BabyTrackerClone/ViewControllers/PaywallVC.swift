//
//  PaywallVC.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 30.10.2024.
//

import UIKit
import NeonSDK
import Adapty

final class PaywallVC: UIViewController,AdaptyManagerDelegate {
    
    private var closeButton = UIButton()
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var priceView : CustomPriceView?
    private var startButton = CustomSaveButton(buttonName: "Start")
    private let legalView = NeonLegalView()
    
    private let titles = [
        "Share the care",
        "All-in-one baby tracker",
        "Watch your baby's growth"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = .white
        
        adaptySetup()
        
        configureCloseButton()
        configureImageView()
        configureTitleLabel()
        configureArticleLabel()
        configureLegalView()
        configureStartButton()
    }
  
    private func configureCloseButton(){
        closeButton.setImage(UIImage(named: "PaywallClose"), for: .normal)
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.width.height.equalTo(50)
        }
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func configureImageView(){
        imageView.image = UIImage(named: "PaywallImage")
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).dividedBy(1.5)
            make.height.equalTo(view.snp.width).dividedBy(2)
        }
    }
    
    private func configureTitleLabel(){
        titleLabel.text = "Get Premium !"
        titleLabel.font = UIFont(name: UIConstants.boldFont, size: 27)
        titleLabel.textColor = .appPurple
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    private func configureArticleLabel() {
        var previousLabel: CustomLabelView?
        
        for title in titles {
            let articleLabel = CustomLabelView(text: title)
            view.addSubview(articleLabel)
            
            articleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().dividedBy(1.5)
                make.height.equalTo(50)
                
                if let previous = previousLabel {
                    make.top.equalTo(previous.snp.bottom)
                } else {
                    make.top.equalTo(titleLabel.snp.bottom).offset(32)
                }
            }
            
            previousLabel = articleLabel
        }
    }
    
    private func configurePriceView() {
        view.addSubview(priceView!)
        priceView!.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(22)
            make.height.equalTo(80)
        }
    }
    
    private func configureStartButton(){
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(legalView.snp.bottom).inset(62)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(22)
            make.height.equalTo(60)
        }
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func configureLegalView(){
        legalView.configureLegalController(onVC: self, backgroundColor: .black, headerColor: .blue, titleColor: .black, textColor: .white)
        legalView.restoreButtonClicked = {
            
        }
        legalView.textColor = .black
        view.addSubview(legalView)
        legalView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(22)
            make.height.equalTo(50)
        }
    }
    
    // Adapty
    
    private func adaptySetup() {
        AdaptyManager.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            AdaptyManager.selectedPaywall = AdaptyManager.getPaywall(placementID: "placement1")
            
            if let paywall = AdaptyManager.selectedPaywall{
                Adapty.logShowPaywall(paywall)
            }
            self.packageFetched()
        })
    }
    
    func packageFetched() {
        if let product = AdaptyManager.getPackage(id: "com.test.weekly") {
            print("price: ", product.price)
            priceView = CustomPriceView(paywallName: "Weekly", paywallPrice: "\(product.price)$")
            configurePriceView()
        }
    }
    
    func weeklySelected(){
        AdaptyManager.selectPackage(id: "com.test.weekly")
    }
    
    // MARK: - Selector
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func startButtonTapped() {
        weeklySelected()
        AdaptyManager.purchase(animation: .loadingBar, animationColor : .red, animationWidth: 100) {
            
            print("succesful")
        } completionFailure: {
            
            print("faile")
        }
    }
        
    
       
}

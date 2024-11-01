//
//  CustomTextfield.swift
//  BabyTrackerClone
//
//  Created by Fırat Güler on 31.10.2024.
//

import UIKit

enum TextInputType {
    case textField
    case textView
    case clickableTextField
}

enum KeyboardTypeOption {
    case defaultKeyboard
    case numberPad
}


class CustomTextfield: UIView {
    
    let placeholderColor: UIColor = .placeholderColorApp
    var placeholderText = ""
    var onTap: (()-> Void)?
    

    
    private var textField: UITextField?
    private var textView: UITextView?
    
    var text: String? {
            get {
                return textField?.text
            }
            set {
                textField?.text = newValue
            }
        }
    
    
    // MARK: - Init
    
    /// KeyboardType specified
    init(placetext: String, inputType: TextInputType,keyboardType : KeyboardTypeOption) {
        super.init(frame: .zero)
        
        placeholderText = placetext
        setupUI(inputType: inputType,keyboardType : keyboardType)
    }
    
    /// Default keyboard type or Clickable func
    init(placetext: String, inputType: TextInputType) {
        super.init(frame: .zero)
        
        self.placeholderText = placetext
        setupUI(inputType: inputType, keyboardType: .defaultKeyboard)
    }
    
    
    // MARK: - Functions
    
    private func setupUI(inputType: TextInputType,keyboardType : KeyboardTypeOption, isClickable: Bool = false) {
        
        switch inputType {
        case .textField:
            setupTextField(keyboardType : keyboardType)
        case .textView:
            setupTextView()
        case .clickableTextField:
            setupClickableTextField()
        }
        
        self.backgroundColor = .settingsMenu
        self.layer.cornerRadius = 25
    }
    
    // TextField
    private func setupTextField(keyboardType : KeyboardTypeOption) {
        textField = UITextField(frame: .zero)
        guard let textField = textField else { return }
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        switch keyboardType {
        case .defaultKeyboard:
            textField.keyboardType = .default
        case .numberPad:
            textField.keyboardType = .numberPad
        }
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.font = UIFont(name: UIConstants.regularFont, size: 14)
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // TextView
    private func setupTextView() {
        textView = UITextView(frame: .zero)
        guard let textView = textView else { return }
        
        textView.text = placeholderText
        textView.textColor = placeholderColor
        textView.font = UIFont(name: UIConstants.regularFont, size: 14)
        textView.layer.cornerRadius = 25
        textView.backgroundColor = .settingsMenu
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0)
        
        self.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textView.delegate = self
    }
    
    // ClickableTextField
    private func setupClickableTextField() {
        
        textField = UITextField(frame: .zero)
        guard let textField = textField else { return }
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        textField.isUserInteractionEnabled = false
        textField.backgroundColor = .settingsMenu
        textField.layer.cornerRadius = 25
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        let iconImageView = UIImageView(image: UIImage(named: "arrow"))
        iconImageView.tintColor = .gray
        textField.rightView = iconImageView
        textField.rightViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iconImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        iconImageView.center = rightView.center
        rightView.addSubview(iconImageView)
        textField.rightView = rightView
        
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    @objc private func handleTap() {
           onTap?()
       }
}

// MARK: - Extensions

extension CustomTextfield: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = placeholderColor
        }
    }
}
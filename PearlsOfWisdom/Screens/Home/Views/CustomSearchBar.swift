//
//  CustomSearchBar.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Seferli on 15.10.22.
//

import Foundation
import UIKit
import SnapKit

class CustomSearchBar: UIView {
    private var textField: UITextField!
    
    private var imageSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 30
        } else {
            return 20
        }
    }
    
    private var textSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 24
        } else {
            return 16
        }
    }
    
    private var cancelButton: UIButton!
    
    var onTextChange: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomSearchBar {
    private func setupViews() {
        
        let searchImage = UIImageView.new {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(systemName: "magnifyingglass")
            $0.tintColor = .black
            $0.layer.opacity = 0.3
        }
        
        textField = UITextField.new {
            $0.placeholder = "Search..."
            $0.font = .systemFont(ofSize: textSize, weight: .medium)
            $0.autocorrectionType = .no
        }
        
        textField.addTarget(self, action: #selector(onTextChange(_:)), for: .editingChanged)
        
        cancelButton = UIButton.new(type: .system) {
            $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            $0.tintColor = .black
            $0.layer.opacity = 0.3
        }
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        cancelButton.isHidden = true
        
        let divider = UIView.new {
            $0.backgroundColor = .black
            $0.layer.opacity = 0.3
        }
        
        let searchStack = UIStackView.new {
            $0.distribution = .fill
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
        
        searchStack.addArrangedSubview(searchImage)
        searchStack.addArrangedSubview(textField)
        searchStack.addArrangedSubview(cancelButton)
        
        self.addSubview(searchStack)
        self.addSubview(divider)
        
        searchImage.snp.makeConstraints { make in
            make.width.height.equalTo(imageSize)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.height.equalTo(imageSize)
        }
        
        searchStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(divider.snp.top)
        }
        
        divider.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        setupToolBar()
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolBar.items = [space, done]
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func doneTapped() {
        textField.endEditing(true)
    }
    
    @objc private func onTextChange(_ sender: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            cancelButton.isHidden = true
        } else {
            cancelButton.isHidden = false
        }
        onTextChange?(text)
    }
    
    @objc private func cancelButtonTapped() {
        textField.text = ""
        onTextChange?("")
        textField.endEditing(true)
        cancelButton.isHidden = true
    }
    
    private func setupBinds() {
        
    }
}

//
//  QuoteCell.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 10.11.22.
//

import Foundation
import UIKit

class QuoteCell: UITableViewCell {
    static let identifier = "QuoteCell"
    
    private var quoteLabel: UILabel!
    private var authorLabel: UILabel!
    
    var onShareTapped: (() -> Void)?
    
    private var fontSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 28
        } else {
            return 16
        }
    }
    
    private var imageSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 30
        } else {
            return 20
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuoteCell {
    private func setupViews() {
        self.backgroundColor = .clear
        
        let bg = UIView.new {
            $0.backgroundColor = UIColor.secondaryBackgroundColor
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        let stack = UIStackView.new {
            $0.distribution = .fill
            $0.spacing = 5
            $0.axis = .vertical
            $0.alignment = .leading
        }
        
        quoteLabel = UILabel.new {
            $0.font = .systemFont(ofSize: fontSize, weight: .medium)
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        authorLabel = UILabel.new {
            $0.font = .systemFont(ofSize: fontSize - 4, weight: .medium)
            $0.textColor = UIColor.white.withAlphaComponent(0.6)
        }
        
        let shareIcon = UIButton(type: .system)
        shareIcon.setImage(UIImage(systemName: "square.and.arrow.up")?.resized(to: CGSize(width: imageSize, height: imageSize)), for: .normal)
        shareIcon.tintColor = .actionColor
        shareIcon.addTarget(self, action: #selector(shareIconTapped), for: .touchUpInside)
        
        stack.addArrangedSubview(quoteLabel)
        stack.addArrangedSubview(authorLabel)
        
        contentView.addSubview(bg)
        
        bg.addSubview(stack)
        bg.addSubview(shareIcon)
        
        bg.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.trailing.top.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(shareIcon.snp.leading).offset(-16)
        }
        
        shareIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func shareIconTapped() {
        self.onShareTapped?()
    }
    
    func setupCellWith(_ model: QuotesViewModel.Quote) {
        self.quoteLabel.text = model.quote
        self.authorLabel.text = "-\(model.author)"
    }
}

//
//  HomeCell.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Seferli on 15.10.22.
//

import Foundation
import UIKit

struct HomeCellModel {
    let title: String
    let arabicTitle: String
    let fileName: String
}

class HomeCell: UITableViewCell {
    static let identifier = "HomeCell"
    
    private var title: UILabel!
    private var arabicTitle: UILabel!
    
    private var fontSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 28
        } else {
            return 16
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCell {
    private func setupViews() {
        self.backgroundColor = .clear
        
        let bg = UIView.new {
            $0.backgroundColor = UIColor.secondaryBackgroundColor
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        title = UILabel.new {
            $0.font = .systemFont(ofSize: fontSize, weight: .medium)
            $0.textColor = .white
        }
        
        arabicTitle = UILabel.new {
            $0.font = .systemFont(ofSize: fontSize, weight: .medium)
            $0.textColor = .white
        }
        
        let arrow = UIImageView.new {
            $0.image = UIImage(systemName: "chevron.right")
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .white.withAlphaComponent(0.6)
        }
        
        contentView.addSubview(bg)
        
        bg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        bg.addSubview(title)
        bg.addSubview(arabicTitle)
        bg.addSubview(arrow)
        
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(10)
        }
        
        arabicTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.trailing.equalTo(arrow.snp.leading).offset(-10)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupBinds() {
        
    }
    
    func setupHomeCellWith(_ model: HomeCellModel) {
        self.title.text = model.title
        self.arabicTitle.text = model.arabicTitle
    }
}

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
        title = UILabel.new {
            $0.font = .systemFont(ofSize: fontSize, weight: .semibold)
            $0.textColor = .black
        }
        
        arabicTitle = UILabel.new {
            $0.font = .systemFont(ofSize: fontSize, weight: .medium)
            $0.textColor = .black
        }
        
        contentView.addSubview(title)
        contentView.addSubview(arabicTitle)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(10)
        }
        
        arabicTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-10)
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

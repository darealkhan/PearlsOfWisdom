//
//  TableViewHeaderView.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 10.11.22.
//

import Foundation
import UIKit

class TableViewHeaderView: UIView {
    private var headerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor
        
        headerLabel = UILabel.new {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setupHeaderWith(_ header: String) {
        headerLabel.text = header
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: headerLabel.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  AboutViewController.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 11.11.22.
//

import Foundation
import SnapKit
import UIKit

class AboutViewController: UIViewController {
    private var fontSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 28
        } else {
            return 16
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

extension AboutViewController {
    private func setupViews() {
        view.backgroundColor = .backgroundColor
        title = "About"
        
        let informationLabel = UILabel.new {
            $0.text = """
            The work is the compilation from "Dar al-Hadith Databank" and the Book "Nahjul Fasahah".

            We present this meager offering before Imam e Zamana (atfs) without His help and blessings we would not have been able to complete.
            
            It is a great honor and blessing for us to be able to share with all momineen such glorious teachings of 14 Masoomeen (a.s.)
            """
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: fontSize, weight: .medium)
        }
        
        let urlLabel = UILabel.new {
            $0.text = "https://www.ya-mahdi.net"
            $0.textColor = .actionColor
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: fontSize, weight: .bold)
            $0.isUserInteractionEnabled = true
        }
        
        let urlGesture = UITapGestureRecognizer(target: self, action: #selector(urlTapped))
        urlLabel.addGestureRecognizer(urlGesture)
        
        view.addSubview(informationLabel)
        view.addSubview(urlLabel)
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func urlTapped() {
        if let url = URL(string: "https://www.ya-mahdi.net") {
            UIApplication.shared.open(url)
        }
    }
}

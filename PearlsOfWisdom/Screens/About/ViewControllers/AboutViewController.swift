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
            Salamun Alaikum

            Alhamdulillah after successful mobile Apps we have moved to web, for the user who need to use pdfs, take printouts and also print books.

            We took the whole content of the App "Pearls Of Wisdom" on this website for the ease of users worldwide to take benefit with the content,

            Please fell free to contact us for your valuable feedback and improvements.

            We are thankful to all those who took part in this noble cause by participating with their valuable suggestions.

            Iltemase dua
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

//
//  DetailViewController.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Seferli on 15.10.22.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController {
    private var htmlName: String
    
    init(htmlName: String) {
        self.htmlName = htmlName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBinds()
    }
}

extension DetailViewController {
    private func setupViews() {
        view.backgroundColor = .backgroundColor
        
        guard let mainHTMLUrl = Bundle.main.url(forResource: htmlName, withExtension: "html") else {
            print("no")
            return
        }
        
        guard let dividerURL = Bundle.main.url(forResource: "divider1", withExtension: "png") else {
            print("no")
            return
        }
        
        let webView = WKWebView()
        if #available(iOS 15.0, *) {
            webView.underPageBackgroundColor = .backgroundColor
        }
        webView.backgroundColor = .backgroundColor
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        webView.navigationDelegate = self
        webView.loadFileURL(mainHTMLUrl, allowingReadAccessTo: dividerURL)
    }
    
    private func setupBinds() {
    }
}

extension DetailViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
  }
}

//
//  QuotesViewController.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Səfərli on 11.11.22.
//

import Foundation
import UIKit
import SnapKit

class QuotesViewController: UIViewController {
    private var tableView: UITableView!
    
    private var quotes = [QuotesViewModel.Quote]()
    
    private let viewModel = QuotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBinds()
    }
}

extension QuotesViewController {
    private func setupViews() {
        view.backgroundColor = .backgroundColor
        title = "Quotes"
        
        tableView = UITableView.new {
            $0.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.identifier)
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupBinds() {
        viewModel.getQuotes { [weak self] quotes in
            self?.quotes = quotes
            self?.tableView.reloadData()
        }
    }
    
    private func shareQuoteWith(_ model: QuotesViewModel.Quote) {
        let text = """
        \(model.quote)
        -\(model.author)
        """

        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: (UIApplication.shared.windows.first?.frame.width)!, height: 350)
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCell.identifier, for: indexPath) as! QuoteCell
        let quote = quotes[indexPath.row]
        cell.setupCellWith(quote)
        cell.onShareTapped = { [weak self] in
            self?.shareQuoteWith(quote)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
}

//
//  HomeViewController.swift
//  PearlsOfWisdom
//
//  Created by Ayxan Seferli on 15.10.22.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
  private var tableView: UITableView!
  private var searchBar: CustomSearchBar!
  
  private var data = [HomeCellModel]()
  private var filteredData = [HomeCellModel]()
  
  private let viewModel = HomeViewModel()
  
  private let topPadding: CGFloat = UIScreen.main.bounds.height * 0.20347222222
  private let sidePadding: CGFloat = UIScreen.main.bounds.width * 0.0813253012
  private let bottomPadding: CGFloat = UIScreen.main.bounds.height * 0.08888888888
  
  private var searchBarHeight: CGFloat {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return 60
    } else {
      return 40
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupBinds()
  }
}

extension HomeViewController {
  private func setupViews() {
    view.backgroundColor = UIColor.backgroundColor
    
    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backButton
    navigationController?.navigationBar.tintColor = .white
    
    title = "Home"
    
    searchBar = CustomSearchBar()
    
    tableView = UITableView.new {
      $0.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.identifier)
      $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
      $0.showsVerticalScrollIndicator = false
      $0.separatorStyle = .none
    }
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    
    //        view.addSubview(welcomeMessage)
    view.addSubview(searchBar)
    view.addSubview(tableView)
    
    //        welcomeMessage.snp.makeConstraints { make in
    //            make.leading.equalToSuperview().offset(16)
    //            make.trailing.equalToSuperview().offset(-16)
    //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
    //        }
    
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  private func setupBinds() {
    viewModel.getQuotes { [weak self] data in
      self?.data = data
      self?.filteredData = data
      self?.tableView.reloadData()
    }
    
    searchBar.onTextChange = { [weak self] text in
      guard let self = self else { return }
      if text.isEmpty {
        self.filteredData = self.data
        self.tableView.reloadData()
      } else {
        self.filteredData = self.data.filter({ $0.title.lowercased().contains(text.lowercased()) })
        self.tableView.reloadData()
      }
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return filteredData.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = TableViewHeaderView()
    switch section {
    case 0:
      headerView.setupHeaderWith("Random quote")
      return headerView
    case 1:
      headerView.setupHeaderWith("Detailed Quotes")
      return headerView
    default:
      headerView.setupHeaderWith("")
      return headerView
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCell.identifier, for: indexPath) as! QuoteCell
      guard let quote = viewModel.getRandomQuote() else {
        return UITableViewCell()
      }
      cell.setupCellWith(quote)
      cell.onShareTapped = { [weak self] in
        self?.shareQuoteWith(quote)
      }
      cell.selectionStyle = .none
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
      let data = filteredData[indexPath.row]
      cell.setupHomeCellWith(data)
      cell.selectionStyle = .none
      return cell
    default:
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      let selected = filteredData[indexPath.row]
      let vc = DetailViewController(htmlName: selected.fileName)
      vc.title = selected.title
      vc.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

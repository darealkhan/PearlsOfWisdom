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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
    }
}

extension HomeViewController {
    private func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        let bg = UIImageView.new {
            $0.contentMode = .scaleToFill
            $0.image = UIImage(named: "bg")
        }
        
        searchBar = CustomSearchBar()
        
        tableView = UITableView.new {
            $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
            $0.showsVerticalScrollIndicator = false
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        view.addSubview(bg)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        bg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding + 10)
            make.leading.equalToSuperview().offset(sidePadding + 10)
            make.trailing.equalToSuperview().offset(-sidePadding - 10)
            make.height.equalTo(searchBarHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalToSuperview().offset(sidePadding)
            make.trailing.equalToSuperview().offset(-sidePadding)
            make.bottom.equalToSuperview().offset(-bottomPadding)
        }
    }
    
    private func setupBinds() {
        viewModel.fetchData { [weak self] data in
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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        cell.setupHomeCellWith(filteredData[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = filteredData[indexPath.row]
        let vc = DetailViewController(htmlName: selected.fileName)
        vc.title = selected.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

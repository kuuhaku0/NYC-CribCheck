//
//  ViewController2.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import SnapKit

class SearchHistoryViewController: UIViewController {
    
    let tableView = UITableView()
    
    var searchHistory = [LocationRequest]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTV()
        view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: "SearchHistoryCell")
        self.tableView.rowHeight = 100
        self.searchHistory = PersistanceService.manager.getPreviousSearches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if searchHistory.isEmpty {
            self.tableView.isHidden = true
        }
        else {
            self.tableView.isHidden = false
        }
    }
    
    private func setUpTV() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { tv in
            tv.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    

}


extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Clicked cell segues to Violation View Controller
        let violationVC = UINavigationController(rootViewController: MainTableViewController())
        present(violationVC, animated: true, completion: nil)
    }
}

extension SearchHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationRequest = searchHistory[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryCell", for: indexPath) as! SearchHistoryTableViewCell
        cell.configureCell(location: locationRequest)
        return cell
    }
    
}


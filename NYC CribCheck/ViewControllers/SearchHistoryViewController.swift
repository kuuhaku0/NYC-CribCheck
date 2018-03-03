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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTV()
    }
    
    func setUpTV() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { tv in
            tv.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

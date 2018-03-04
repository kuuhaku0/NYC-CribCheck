//
//  ViewController.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class BoroughSelectViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundView?.contentMode = .scaleAspectFill
            tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        }
    }
    
    let boroughs = [("Manhattan", #imageLiteral(resourceName: "Lower-Manhattan")), ("Brooklyn", #imageLiteral(resourceName: "downtown-brooklyn-aerial-hires")), ("Queens", #imageLiteral(resourceName: "Queens")), ("Bronx", #imageLiteral(resourceName: "Yankee_Stadium_001")), ("Staten Island", #imageLiteral(resourceName: "Staten Island"))]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension BoroughSelectViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.size.height / 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoroughCell", for: indexPath) as! BoroughTableViewCell
        let borough = boroughs[indexPath.row]
        cell.configureCell(with: borough.0, image: borough.1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boroughs.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FormViewController {
            //TODO
            
        }
    }
}





//
//  ViewController2.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import SnapKit
import MaterialComponents.MaterialCollections


let reusableIdentifierItem = "Cell"
class SearchHistoryViewControlle: MDCCollectionViewController {
    
    var searchHistory = [LocationRequest]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    var currentViolationArr = [Violation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styler.cellStyle = .card
//        self.collectionView = CustomCollectionView(frame: (self.collectionView?.frame)!,
//                                                   collectionViewLayout: (self.collectionViewLayout))
        self.collectionView?.register(MDCCollectionViewTextCell.self,
                                      forCellWithReuseIdentifier: reusableIdentifierItem)
        self.searchHistory = Cache.manager.getSearches()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.searchHistory = Cache.manager.getSearches()
        if searchHistory.isEmpty {
            self.collectionView?.isHidden = true
        }
        else {
            self.collectionView?.isHidden = false
        }
    }
    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return searchHistory.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellHeightAt indexPath: IndexPath) -> CGFloat {
        return MDCCellDefaultTwoLineHeight
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let location = searchHistory[indexPath.item]
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifierItem, for: indexPath)
        if let cell = cell as? MDCCollectionViewTextCell {
//            cell.heightPreset = MDCCellDefaultTwoLineHeight
            cell.textLabel?.text = "\(location.houseNumber) \(location.streetName) \(location.apartment ?? "" )"
            cell.detailTextLabel?.text = "\(location.borough), New York \(location.zipCode)"
        }
        
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationRequest = searchHistory[indexPath.row]
        let location = LocationRequest(borough: locationRequest.borough, houseNumber: locationRequest.houseNumber, streetName: locationRequest.streetName, apartment: locationRequest.apartment, zipCode: locationRequest.zipCode)
        
        HousingAPIClient.manager.getViolations(usingLocation: location) { result in
            switch result {
            case .success(let onlineViolations):
                if onlineViolations.isEmpty {
                    self.showAlert(title: "No violations", message: "This address contains no violations. Please check the address or try a different one.")
                }
                    
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let violationVC = storyboard.instantiateViewController(withIdentifier: "MainTableViewController") as! MainTableViewController
                    self.currentViolationArr = onlineViolations
                    violationVC.allViolations = onlineViolations
                    violationVC.locationRequest = location
                    self.present(violationVC, animated: true, completion: nil)
                }
                
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription )
            }
        }
        
    }
    
}




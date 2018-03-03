//
//  SearchHistoryTableViewCell.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import SnapKit

class SearchHistoryTableViewCell: UITableViewCell {

    lazy var streetAddressLabel: UILabel = {
        let lab = UILabel()
        lab.text = "37 West 6th Street 3C"
        lab.numberOfLines = 0
        lab.adjustsFontForContentSizeCategory = true
        return lab
    }()
    
    lazy var cityStateZipLabel: UILabel = {
        let lab = UILabel()
        lab.text = "New York, NY 10232"
        lab.numberOfLines = 0
        lab.adjustsFontForContentSizeCategory = true
        return lab
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "SearchHistoryCell")
        setUpLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLabels()
    }
    
    public func configureCell(location: LocationRequest) {
        self.streetAddressLabel.text = "\(location.streetName) \(location.streetName) \(location.apartment ?? "" )"
        self.cityStateZipLabel.text = "\(location.borough), New York \(location.zipCode)"
    }
    
    private func setUpLabels() {
        self.addSubview(streetAddressLabel)
        self.addSubview(cityStateZipLabel)
        
        streetAddressLabel.snp.makeConstraints { lab in
            lab.centerX.equalTo(self.snp.centerX)
            lab.width.equalTo(self.snp.width).multipliedBy(0.8)
            lab.height.equalTo(self.snp.height).multipliedBy(0.2)
            lab.top.equalTo(self.snp.top).offset(5)
        }
        
        cityStateZipLabel.snp.makeConstraints { (lab) in
            lab.centerX.equalTo(self.snp.centerX)
            lab.width.equalTo(self.snp.width).multipliedBy(0.8)
            lab.height.equalTo(self.snp.height).multipliedBy(0.2)
            lab.top.equalTo(streetAddressLabel.snp.bottom).offset(1)
        }
    }

    
}

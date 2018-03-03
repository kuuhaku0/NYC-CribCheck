//
//  SearchHistoryTableViewCell.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    lazy var streetAddressLabel: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var cityStateZipLabel: UILabel = {
        let lab = UILabel()
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
    
    public func configureCell() {
        
    }
    
    private func setUpLabels() {
        self.addSubview(streetAddressLabel)
        self.addSubview(cityStateZipLabel)
        
        streetAddressLabel.snp.makeConstraints { lab in
            lab.centerX.equalTo(self.snp.centerX)
            lab.width.equalTo(self.snp.width).offset(10)
            lab.height.equalTo(self.snp.height).multipliedBy(0.5)
            lab.top.equalTo(self.snp.top).offset(5)
        }
        
        cityStateZipLabel.snp.makeConstraints { (lab) in
            lab.centerX.equalTo(self.snp.centerX)
            lab.width.equalTo(self.snp.width).offset(10)
            lab.height.equalTo(self.snp.height).multipliedBy(0.5)
            lab.bottom.equalTo(self.snp.bottom).offset(5)
        }
    }

    
}

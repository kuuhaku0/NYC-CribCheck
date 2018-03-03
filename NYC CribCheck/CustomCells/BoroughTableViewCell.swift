//
//  BoroughTableViewCell.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class BoroughTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var boroughLabel: UILabel!
    @IBOutlet weak var boroughImage: UIImageView! {
        didSet {
            boroughImage.layer.cornerRadius = 15
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //need model
    public func configureCell(with boroughs: String) {
        
    }

}

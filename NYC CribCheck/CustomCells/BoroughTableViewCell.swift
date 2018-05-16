//
//  BoroughTableViewCell.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import MaterialComponents

class BoroughTableViewCell: UITableViewCell {

    @IBOutlet weak var opaqueView: UIView! {
        didSet {
            opaqueView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var boroughLabel: UILabel!
    @IBOutlet weak var boroughImage: UIImageView! {
        didSet {
            boroughImage.layer.cornerRadius = 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //need model
    public func configureCell(with boroughs: String, image: UIImage) {
        boroughLabel.text = boroughs
        boroughImage.image = image
    }

}

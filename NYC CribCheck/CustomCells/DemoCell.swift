//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit

class DemoCell: FoldingCell {
    //CLOSED
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var severityClassLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    //OPEN
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var topContaier: UIView!
    @IBOutlet weak var violationID: UILabel!
    @IBOutlet weak var severityLabelUnfolded: UILabel!
    @IBOutlet weak var statusLabelUnfolded: UILabel!
    @IBOutlet weak var boroughLabel: UIButton!
    @IBOutlet weak var DescriptionLabelUnfolded: UILabel!
    @IBOutlet weak var insectionDate: UILabel!
    @IBOutlet weak var issueDate: UILabel!
    @IBOutlet weak var approvedDate: UILabel!
    @IBOutlet weak var noticeType: UILabel!
    
    var number: Int = 0 {
        didSet {
            
        }
    }

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    public func configCell(with violation: Violation, borough: String) {
        
        //Formatting Date
//        let currentStatusDate = DateFormatHelper.formatter.formateDate(from: violation.currentStatusDate,
//                                                                       inputDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ",
//                                                                       outputDateFormat: "MMM d, yyyy")
//        let inspectionDate = DateFormatHelper.formatter.formateDate(from: violation.inspectionDate,
//                                                                    inputDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ",
//                                                                    outputDateFormat: "MMM d, yyyy")
//        let formattedApprovedDate = DateFormatHelper.formatter.formateDate(from: violation.approvedDate ?? "" ,
//                                                                  inputDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ",
//                                                                  outputDateFormat: "MMM d, yyyy")
//        let formattedIssueDate = DateFormatHelper.formatter.formateDate(from: violation.issueDate ?? "Present",
//                                                               inputDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ",
//                                                               outputDateFormat: "MMM d, yyyy")
        
        boroughLabel.isEnabled = false
        switch violation.violationStatus {
        case "Open":
            leftView.backgroundColor = UIColor.red
            bar.backgroundColor = UIColor.red
            topContaier.backgroundColor = UIColor.red
            statusLabel.text = violation.violationStatus.uppercased()
        case "Close":
            leftView.backgroundColor = UIColor(displayP3Red: 12 / 255, green: 150 / 255, blue: 67 / 255, alpha: 1)
            bar.backgroundColor = UIColor(displayP3Red: 12 / 255, green: 150 / 255, blue: 67 / 255, alpha: 1)
            topContaier.backgroundColor = UIColor(displayP3Red: 12 / 255, green: 150 / 255, blue: 67 / 255, alpha: 1)
            statusLabel.text = violation.violationStatus.uppercased() + "D"
        default:
            //WHITE
            leftView.backgroundColor = UIColor.white
            bar.backgroundColor = UIColor.white
            topContaier.backgroundColor = UIColor.white
        }
        violationID.text = violation.violationID
        DescriptionLabel.text = violation.description
        DescriptionLabelUnfolded.text = violation.description
        boroughLabel.setTitle(borough, for: .normal)
        severityClassLabel.text = violation.`class`
        severityLabelUnfolded.text = "Severity: \(violation.`class`)".uppercased()
        insectionDate.text = violation.inspectionDate
        issueDate.text = violation.issueDate
        approvedDate.text = violation.approvedDate
        noticeType.text = violation.noticeType
        lastUpdatedLabel.text = "Last Updated: \(violation.currentStatusDate)"
    }
}

// MARK: - Actions ⚡️

extension DemoCell {

    //HANDLE ACTIONS HERE
    
}

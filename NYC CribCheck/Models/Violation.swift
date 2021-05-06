//
//  Model2.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation

struct Violation: Codable {
    let description: String
    let violationStatus: String
    let approvedDate: String
    let issueDate: String?
    let inspectionDate: String
    let `class`: String
    let currentStatus: String
    let currentStatusDate: String
    let noticeType: String?
    let violationID: String
    let latitude: String?
    let longitude: String?
    
    static let dummyViolation = Violation.init(description: "SECTION 27-2013 ADM CODE  PAINT WITH LIGHT COLORED PAINT TO THE SATISFACTION OF THIS DEPARTMENT  ALL PEELING PAINT SURFACES IN  THE 4th ROOM  FROM EAST AT SOUTH,  THE 2nd ROOM  FROM EAST AT NORTH  LOCATED AT APT 2R, 2nd STORY, 1st APARTMENT FROM NORTH AT EAST", violationStatus: "Open", approvedDate: "2015-10-27T00:00:00.000", issueDate: "2015-10-28T00:00:00.000", inspectionDate: "2015-10-26T00:00:00.000", class: "A", currentStatus: "NOV SENT OUT", currentStatusDate: "2015-10-28T00:00:00.000", noticeType: "Original", violationID: "10980603", latitude: "40.653217", longitude: "-73.932480")
    
    enum CodingKeys: String, CodingKey {
        case description = "novdescription"
        case violationStatus = "violationstatus"
        case approvedDate = "approveddate"
        case issueDate = "novissueddate"
        case inspectionDate = "inspectiondate"
        case `class` = "class"
        case currentStatus = "currentstatus"
        case currentStatusDate = "currentstatusdate"
        case noticeType = "novtype"
        case violationID = "violationid"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

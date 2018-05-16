//
//  model.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation


// Borough, house number, street name, optional apartment number and zip code as Strings
struct LocationRequest: Codable, Equatable {
    static func ==(lhs: LocationRequest, rhs: LocationRequest) -> Bool {
        return lhs.borough == rhs.borough &&
            lhs.houseNumber == rhs.houseNumber &&
            lhs.streetName == rhs.streetName &&
            lhs.apartment == rhs.apartment &&
            lhs.zipCode == rhs.zipCode
    }
    
    let borough: String
    let houseNumber: String
    let streetName: String
    let apartment: String?
    let zipCode: String
    
    static let dummyLR = LocationRequest.init(borough: "brooklyn", houseNumber: "355", streetName: "east 48 street" ,apartment: "2R", zipCode: "11203")
}

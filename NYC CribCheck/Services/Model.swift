//
//  Model.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation
import Alamofire

enum Result {
    case success([Violation])
    case failure(Error)
}

enum AppError: Error {
    case urlError(String)
}

class HousingAPIClient {
    private init(){}
    static let manager = HousingAPIClient()
    
    
    // helper -- make url from LocationRequest
    private func urlString(from locationRequest: LocationRequest) -> String {
        let apartment = locationRequest.apartment?.uppercased()
        let borough = locationRequest.borough.uppercased()
        let houseNumber = locationRequest.houseNumber.uppercased()
        let streetName = locationRequest.streetName.uppercased()
        let zipCode = locationRequest.zipCode.uppercased()
        var url = "https://data.cityofnewyork.us/resource/b2iz-pps8.json?"
        if let apartment = apartment {
            url += "apartment=\(apartment)&"
        }
        url += "boro=\(borough)&"
        url += "housenumber=\(houseNumber)&"
        url += "streetname=\(streetName)&"
        url += "zip=\(zipCode)"
        return url
    }
    
    // public -- for use in getting data for viewcontrollers
    public let dummyRequest = "https://data.cityofnewyork.us/resource/b2iz-pps8.json?streetname=EAST 48 STREET&housenumber=355"
    public func getViolations(usingLocation locationRequest: LocationRequest, completion: @escaping (Result) -> Void) {
//        let _ = urlString(from: locationRequest).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlStr = urlString(from: locationRequest).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(Result.failure(AppError.urlError(urlString(from: locationRequest))))
            return
        }
        print(urlStr)
//        let urlStr = urlString(from: locationRequest)
        guard let url = URL(string: urlStr) else { completion(Result.failure(AppError.urlError(urlStr))); return }
        // TODO: - add caching call here
        // only call alamofire when cache call fails
        
        Alamofire.request(url).responseData { (response) in
            if let error = response.error {
                completion(Result.failure(error))
            } else if let data = response.data {
                do {
                    let violations = try JSONDecoder().decode([Violation].self, from: data)
                    completion(Result.success(violations))
                } catch {
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    
}



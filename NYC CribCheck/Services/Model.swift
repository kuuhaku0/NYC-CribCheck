//
//  Model.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation
import Alamofire

enum HousingResult {
    case success([Violation])
    case failure(HousingError)
}

enum HousingError: Error {
    case networkError(rawError: Error)
    case noResults
    case badUrl(String)
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
    public func getViolations(usingLocation locationRequest: LocationRequest, completion: @escaping (HousingResult) -> Void) {
        guard let urlStr = urlString(from: locationRequest).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.badUrl(urlString(from: locationRequest))))
            return
        }
        if let violations = Cache.manager.getViolations(fromURL: urlStr) {
            completion(HousingResult.success(violations))
            return
        }
        // only continue if getting violations from cache fails
        guard let url = URL(string: urlStr) else {
            completion(.failure(.badUrl(urlStr)))
            return
        }
        
        Alamofire.request(url).responseData { (response) in
            if let error = response.error {
                completion(.failure(.networkError(rawError: error)))
            } else if let data = response.data {
                do {
                    let violations = try JSONDecoder().decode([Violation].self, from: data)
                    if violations.isEmpty {
                        completion(.failure(.noResults))
                    } else {
                        completion(.success(violations))
                        // TODO: add image to cache and persistence model?
                        
                    }
                } catch {
                    completion(.failure(.networkError(rawError: error)))
                }
            }
        }
    }
    
    
}



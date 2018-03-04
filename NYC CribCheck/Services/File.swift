//
//  File.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit
import Alamofire



enum StreetImageResult {
    case success(UIImage)
    case failure(StreetImageError)
}

enum StreetImageError: Error {
    case noImage
    case badData
    case networkError(rawError: Error)
}

class StreetImageAPIClient {
    private init(){}
    static let manager = StreetImageAPIClient()
    
    private let apiKey = "AIzaSyARPaGAS3g4oaHzIpdHDk6iCn2FFgp1nP8"
    // helper -- make url from Violation
    private func urlString(from violation: Violation) -> String {
        let lat = violation.latitude
        let lon = violation.longitude
        let url = "https://maps.googleapis.com/maps/api/streetview?size=640x640&location=\(lat),\(lon)&key=\(self.apiKey)"
        return url
    }
    
    
    // public -- for use in getting data for viewcontrollers
    
    public func getStreetImage(from violation: Violation, completion: @escaping (StreetImageResult) -> Void) {
        let urlStr = urlString(from: violation)
        if let image = Cache.manager.getImage(fromURL: urlStr) {
            completion(.success(image))
            return
        }
        // only continue if getting image from cache fails
        Alamofire.request(urlStr).responseData { (response) in
            if let error = response.error {
                completion(.failure(.networkError(rawError: error)))
            } else if let data = response.data {
                if let image = UIImage.init(data: data) {
                    completion(.success(image))
                    // TODO: add image to cache and persistence model?
                } else {
                    completion(.failure(.badData))
                }
            }
        }
    }
}

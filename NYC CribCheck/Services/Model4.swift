//
//  Model2.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class Cache {
    private init(){}
    static let manager = Cache()
    
    private var violations: [String: [Violation]] = [:]
    private var images: [String: UIImage] = [:]
    private var searches: [LocationRequest] = []
    
    public func getViolations(fromURL urlStr: String) -> [Violation]? {
        if let violations = self.violations[urlStr] {
            if violations.isEmpty {
                return nil
            }
            return violations
        }
        return nil
    }
    
    public func getImage(fromURL urlStr: String) -> UIImage? {
        if let image = images[urlStr] {
            return image
        }
        return nil
    }
    
    public func getSearches() -> [LocationRequest] {
        return searches
    }
    // will load previous searches into cache
    public func configureSearches() {
        
    }
}

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
    
    public func add(violations: [Violation], withUrlStr urlStr: String) {
        self.violations[urlStr] = violations
    }
    public func add(image: UIImage, withUrlStr urlStr: String) {
        self.images[urlStr] = image
    }
    public func add(search: LocationRequest) {
        // TODO: linear runtime, fix it
        guard !searches.contains(search) else {
            return
        }
        self.searches.insert(search, at: 0)
        // same
        PersistanceService.manager.addToPreviousSearches(search: search)
    }
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
        searches = PersistanceService.manager.getPreviousSearches()
    }
}

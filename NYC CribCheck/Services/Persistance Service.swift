//
//  Persistance Service.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation


class PersistanceService {
    private init() {}
    static let searchHistoryPath = "SearchHistory.plist"
    static let manager = PersistanceService()
    
    private var locationRequests = [LocationRequest]() {
        didSet {
            saveSearchedAddress()
        }
    }
    
    public func getPreviousSearches() -> [LocationRequest] {
        return self.locationRequests
    }
    
    public func addToPreviousSearches(search: LocationRequest) {
        // TODO: linear runtime, fix it
        locationRequests.insert(search, at: 0)
    }
    private func saveSearchedAddress() {

        let propertyEncoder = PropertyListEncoder()
        let path = dataFilePath(withPathName: PersistanceService.searchHistoryPath)
        do {
            let encodedUsers = try propertyEncoder.encode(locationRequests)
            try encodedUsers.write(to: path, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func loadData() {
        let propertyDecoder = PropertyListDecoder()
        let path = dataFilePath(withPathName: PersistanceService.searchHistoryPath)
        do {
            let data = try Data(contentsOf: path)
            let locationsRequested = try propertyDecoder.decode([LocationRequest].self, from: data)
            self.locationRequests = locationsRequested
        }
        catch {
            print(error)
        }
    }
    
    private func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    private func dataFilePath(withPathName path: String) -> URL {
        return PersistanceService.manager.documentDirectory().appendingPathComponent(path)
    }
    
    // just loads things into manager
    public func configure(){}
    
}

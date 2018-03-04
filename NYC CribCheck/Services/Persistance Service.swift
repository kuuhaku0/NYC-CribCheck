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
    
  func getPreviousSearches() -> [LocationRequest] {
        return self.locationRequests
    }
    
    private func addToPreviousSearches(search: LocationRequest) {
        locationRequests.append(search)
    }
    
    private func saveSearchedAddress() {

        let propertyEncoder = PropertyListEncoder()
        let path = dataFilePath(withPathName: PersistanceService.searchHistoryPath)
        do {
            let encodedUsers = try propertyEncoder.encode(locationRequests)
            try encodedUsers.write(to: path, options: .atomic)
            
            print()
        }
            
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadData() {
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
    
    
    
}

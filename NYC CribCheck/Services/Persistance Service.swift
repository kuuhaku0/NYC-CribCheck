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
    
    private var locationRequests = [String]()
    
    private func getPreviousSearches() -> [String] {
        return self.locationRequests
    }
    
    private func addToPreviousSearches(search: String) {
        locationRequests.append(search)
    }
    
    private func saveSearchedAddress() {
        //Make an encoder
        let propertyEncoder = PropertyListEncoder()
        //Make the string of the path into a url to use
        let path = dataFilePath(withPathName: PersistanceService.searchHistoryPath)
        do {
            //encode what you want encoded
            let encodedUsers = try propertyEncoder.encode(locationRequests)
            //write it to the path.
            try encodedUsers.write(to: path, options: .atomic)
            
            print()
        }
            
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadData() {
        //Make a decoder to retrieve the users. You can just code in the do block but this is just to show when you are decoding/encoding.
        let propertyDecoder = PropertyListDecoder()
        //Get the url where the users are stored
        let path = dataFilePath(withPathName: PersistanceService.searchHistoryPath)
        do {
            let data = try Data(contentsOf: path)
            let locationsRequested = try propertyDecoder.decode([String].self, from: data)
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

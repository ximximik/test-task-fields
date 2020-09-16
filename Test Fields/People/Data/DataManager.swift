//
//  DataManager.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import Foundation

public protocol PeopleDataManager: class {
    func delete(at index: Int)
    func update(at index: Int, item: PeopleData)
    func list() -> [PeopleData]
}

public class DataManagerInfoPlist: PeopleDataManager {
    private var data: [PeopleData]
    
    public init(data: [PeopleData]) {
        self.data = data
    }
    
    public func delete(at index: Int) {
        data.remove(at: index)
    }
    
    public func list() -> [PeopleData] {
        return data
    }
    
    public func update(at index: Int, item: PeopleData) {
        data[index] = item
    }
}

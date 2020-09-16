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
    func people(at index: Int) -> PeopleData?
}

public class PeopleDataManagerDefault: PeopleDataManager {
    private var data: [PeopleData]
    
    public init(data: [PeopleData]) {
        self.data = data
    }
    
    public func delete(at index: Int) {
        data.remove(at: index)
    }
    
    public func update(at index: Int, item: PeopleData) {
        data[index] = item
    }
    
    public func list() -> [PeopleData] {
        return data
    }
    
    public func people(at index: Int) -> PeopleData? {
        return data[safe: index]
    }
}

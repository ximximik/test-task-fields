//
//  PeopleListViewModel.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//



public class PeopleListViewModel {
    private let scheme: [FieldScheme]
    private let dataManager: PeopleDataManager
    
    private var peoples: [PeopleListCellViewModel] = []
    public var dataDidUpdated: (([PeopleListCellViewModel])->())? = nil
    
    public init(scheme: [FieldScheme], dataManager: PeopleDataManager) {
        self.scheme = scheme
        self.dataManager = dataManager
    }
    
    public func updateData() {
        peoples = dataManager.list()
            .map { .init(scheme: scheme, fields: $0) }
        dataDidUpdated?(peoples)
    }
    
    public func deletePeople(at index: Int) {
        dataManager.delete(at: index)
        updateData()
    }
}

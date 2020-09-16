//
//  PeopleViewModel.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import Foundation

public class PeopleViewModel {
    private let scheme: [FieldScheme]
    private let dataManager: PeopleDataManager
    
    private var fields: [PeopleListCellViewModel] = []
    private var peopleIndex: Int = 0
    private var peopleData: PeopleData = [:]
    public var dataDidUpdated: (([FieldCellViewModel])->())? = nil
    
    public init(scheme: [FieldScheme], dataManager: PeopleDataManager) {
        self.scheme = scheme
        self.dataManager = dataManager
    }
    
    public func configure(peopleIndex: Int) {
        self.peopleIndex = peopleIndex
        set(peopleData: dataManager.people(at: peopleIndex) ?? [:])
    }
    
    public func updateData() {
        set(peopleData: dataManager.people(at: peopleIndex) ?? [:])
    }
    
    public func set(peopleData: PeopleData, invalidatedFieldIds: [String] = []) {
        self.peopleData = peopleData
        let viewModels = peopleData
            .sorted(by: \.key, preferredOrder: scheme.map { $0.id })
            .compactMap { key, value -> FieldCellViewModel? in
                if let fieldScheme = scheme.first(where: { $0.id == key }) {
                    return FieldCellViewModel(fieldScheme: fieldScheme,
                                              value: value,
                                              isInvalidate: invalidatedFieldIds.contains(key))
                }
                return nil
        }
        dataDidUpdated?(viewModels)
    }
    
    public func validateAndSave() {
        var invalidatedFieldIds: [String] = []
        peopleData.forEach { key, value in
            guard let fieldScheme = scheme.first(where: { $0.id == key }) else { return }
            
            var isValid = true
            switch fieldScheme.type {
            case .date:
                break
            case .number:
                isValid = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value))
            case .string:
                break
            }
            
            if fieldScheme.required, value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                isValid = false
            }
            if !isValid {
                invalidatedFieldIds.append(key)
            }
        }
        if invalidatedFieldIds.isEmpty {
            dataManager.update(at: peopleIndex, item: peopleData)
        } else {
            set(peopleData: peopleData, invalidatedFieldIds: invalidatedFieldIds)
        }
    }
    
    public func updateField(at index: Int, value: String) {
        guard let fieldId = scheme[safe: index]?.id else { return }
        peopleData[fieldId] = value
    }
}

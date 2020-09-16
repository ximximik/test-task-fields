//
//  PeopleListCellViewModel.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//


public class PeopleListCellViewModel {
    public let fields: [(String, String)]
    
    public init(scheme: [FieldScheme], fields: PeopleData) {
        self.fields = fields
            .sorted(by: \.key, preferredOrder: scheme.map { $0.id })
            .compactMap { key, value -> (String, String)? in
            if let field = scheme.first(where: { $0.id == key }) {
                return (field.title, value)
            }
            return nil
        }
    }
}

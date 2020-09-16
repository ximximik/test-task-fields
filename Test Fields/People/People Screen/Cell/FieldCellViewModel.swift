//
//  FieldCellViewModel.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

public class FieldCellViewModel {
    public let type: FieldType
    public let title: String
    public let value: String
    public let isInvalidate: Bool
    
    public init(fieldScheme: FieldScheme, value: String, isInvalidate: Bool) {
        self.type = fieldScheme.type
        self.title = fieldScheme.title
        self.value = value
        self.isInvalidate = isInvalidate
    }
}

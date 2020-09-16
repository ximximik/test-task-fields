//
//  Data.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//



public enum FieldType: String, Codable {
    case string, date, number
}

public struct FieldScheme: Codable {
    public let id: String
    public let type: FieldType
    public let title: String
    public let required: Bool
}

public typealias PeopleData = [String: String]

public struct InitData: Codable {
    public let scheme: [FieldScheme]
    public let data: [PeopleData]
    
    public let dateFormat = "d.MM.y"
}

//
//  Date.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import Foundation

extension String {
    public func date(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = initData.dateFormat
        return dateFormatter.date(from: self)
    }
}

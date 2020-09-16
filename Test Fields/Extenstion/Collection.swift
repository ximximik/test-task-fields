//
//  Collection.swift
//  Test Fields
//
//  Created by Danil Pestov on 16.09.2020.
//  Copyright © 2020 Danil Pestov. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Sequence {
  func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, preferredOrder: [T]) -> [Element] {
    return sorted { a, b in
      guard let first = preferredOrder.firstIndex(of: a[keyPath: keyPath]) else {
          return false
      }

      guard let second = preferredOrder.firstIndex(of: b[keyPath: keyPath]) else {
          return true
      }

      return first < second
    }
  }
}

extension Sequence where Element: Comparable {
    func reorder(by preferredOrder: [Element]) -> [Element] {

        return self.sorted { (a, b) -> Bool in
            guard let first = preferredOrder.firstIndex(of: a) else {
                return false
            }

            guard let second = preferredOrder.firstIndex(of: b) else {
                return true
            }

            return first < second
        }
    }
}

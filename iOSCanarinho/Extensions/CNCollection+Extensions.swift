//
//  CNCollection+Extensions.swift
//  iOSCanarinho
//
//  Created by Yeltsin Suares Lobato Gama on 31/10/20.
//  Copyright © 2020 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

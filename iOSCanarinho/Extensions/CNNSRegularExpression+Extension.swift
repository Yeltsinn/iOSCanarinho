//
//  NSRegularExpression+Extension.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 29/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

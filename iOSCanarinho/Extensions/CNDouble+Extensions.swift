//
//  CNDouble+Extensions.swift
//  CartoesCAIXA
//
//  Created by cedesbrdf on 30/06/20.
//  Copyright © 2020 Caixa. All rights reserved.
//

import Foundation

extension Double {
    func cnToPercent(countOfDecimalPlaces: Int) -> String {
        String(format: "%.\(countOfDecimalPlaces)f%%", self)
    }
}



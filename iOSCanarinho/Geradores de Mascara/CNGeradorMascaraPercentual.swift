//
//  CNGeradorMascaraPercentual.swift
//  CartoesCAIXA
//
//  Created by Yeltsin Suares Lobato Gama on 30/06/20.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

class CNGeradorMascaraPercentual: GeradorMascaraNumerico {
    
    var tipoMascara: TipoMascara
    
    required init(tipoMascara: TipoMascara, mascaraCustomizada: String? = nil) {
        self.tipoMascara = tipoMascara
    }
    
    convenience init() { self.init(tipoMascara: .percentual) }
    
    func retornaMascara(textoSemMascara: String) -> String {
        guard let valorNumerico = Double(textoSemMascara.filtrarNumeros()) else { return textoSemMascara }
        return valorNumerico.cnToPercent(countOfDecimalPlaces: 0)
    }
}

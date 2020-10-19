//
//  CNGeradorMascaraBoleto.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 08/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

let digitoInicialBoletoConvenio: Character = "8"

enum TipoBoleto {
    case convenio, boleto
}

extension TipoBoleto {
    
    init(codigo: String) {
        switch codigo.first {
        case digitoInicialBoletoConvenio: self = .convenio
        default: self = .boleto
        }
    }
}

class CNGeradorMascaraBoleto: GeradorMascaraNumerico {
    
    var tipoMascara: TipoMascara
    
    required init(tipoMascara: TipoMascara, mascaraCustomizada: String?) {
        self.tipoMascara = tipoMascara
    }
    
    func retornaMascara(textoSemMascara: String) -> String {
        return capturaMascaraBaseadaTipoBoleto(TipoBoleto(codigo: textoSemMascara.filtrarNumeros()))
    }
    
    private func capturaMascaraBaseadaTipoBoleto(_ tipoBoleto: TipoBoleto) -> String {
        switch tipoBoleto {
        case .boleto:
            return CNCodigoDeBarrasUtil.mascaraLinhaDigitavelBoleto
        default:
            return CNCodigoDeBarrasUtil.mascaraLinhaDigitavelConvenio
        }
    }
}


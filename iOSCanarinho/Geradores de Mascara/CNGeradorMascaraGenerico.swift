//
//  CNGeradorMascaraGenerico.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 08/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

public enum CNMascara: String {
    case mascaraCPF  = "###.###.###-##"
    case mascaraCNPJ = "##.###.###/####-##"
    case mascaraCEP  = "#####-###"
    case mascaraRG   = "#.###.###"
}

class CNGeradorMascaraGenerico: GeradorMascaraNumerico {
    
    var tipoMascara: TipoMascara
    var mascaraCustomizada: String?
    
    required init(tipoMascara: TipoMascara, mascaraCustomizada: String?) {
        self.tipoMascara = tipoMascara
        self.mascaraCustomizada = mascaraCustomizada
    }
    
    func retornaMascara(textoSemMascara: String) -> String {
        switch tipoMascara {
        case .cnpj:
            return CNMascara.mascaraCNPJ.rawValue
        case .rg:
            return CNMascara.mascaraRG.rawValue
        case .cpf:
            return CNMascara.mascaraCPF.rawValue
        case .cep:
            return CNMascara.mascaraCEP.rawValue
        case .customizada:
            return mascaraCustomizada ?? ""
        default:
            return ""
        }
    }
}


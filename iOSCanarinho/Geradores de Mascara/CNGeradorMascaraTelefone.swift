//
//  CNGeradorMascaraTelefone.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 08/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

class CNGeradorMascaraTelefone: GeradorMascaraNumerico {
    
    static let mascaraTelefone1 = "###-####"
    static let mascaraTelefone2 = "####-####"
    static let mascaraTelefone3 = "#####-####"
    static let mascaraTelefone4 = "(##) ####-####"
    static let mascaraTelefone5 = "(##) #####-####"
    static let mascaraTelefone6 = "+## (##) #####-####"
    
    var tipoMascara: TipoMascara
    
    required init(tipoMascara: TipoMascara, mascaraCustomizada: String? = nil) {
        self.tipoMascara = tipoMascara
    }
    
    convenience init() { self.init(tipoMascara: .telefone) }
    
    func retornaMascara(textoSemMascara: String) -> String {
        return capturaMascaraTelefoneBaseadoQuantidadeNumeros(textoSemMascara.filtrarNumeros().count)
    }
    
    func capturaMascaraTelefoneBaseadoQuantidadeNumeros(_ count: Int) -> String {
        switch count {
        case 0..<8 : return CNGeradorMascaraTelefone.mascaraTelefone1
        case 8     : return CNGeradorMascaraTelefone.mascaraTelefone2
        case 9     : return CNGeradorMascaraTelefone.mascaraTelefone3
        case 10    : return CNGeradorMascaraTelefone.mascaraTelefone4
        case 11    : return CNGeradorMascaraTelefone.mascaraTelefone5
        default    : return CNGeradorMascaraTelefone.mascaraTelefone6
        }
    }
    
    func telefoneFormatado(_ telefone: String, comSeguranca: Bool = false) -> String {
        let telefoneFormatado = telefone.aplicaMascara(mascara: retornaMascara(textoSemMascara: telefone.filtrarNumeros()))
        guard comSeguranca else { return telefoneFormatado }
        return aplicaMascaraSeguranca(telefoneFormatado)
    }
    
     private func aplicaMascaraSeguranca(_ telefone: String) -> String {
        guard telefone.count >= 10 else { return telefone }
        let startIndex = telefone.index(telefone.endIndex, offsetBy: -10)
        let endIndex = telefone.index(telefone.endIndex, offsetBy: -6)
        return telefone.replacingCharacters(in: startIndex...endIndex, with: "*****").replacingOccurrences(of: "-", with: " ")
    }
}


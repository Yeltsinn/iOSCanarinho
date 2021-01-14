//
//  CNFormatadorNumericoDelegate.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 08/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import UIKit

public protocol CNFormatador {
    var entradaComMascara: String { get set }
    var entradaSemMascara: String { get }
}

public enum TipoMascara {
    case boleto, telefone, cpf, rg, cnpj, cep, customizada, percentual, cartaoDeCredito
}

protocol GeradorMascaraNumerico {
    var tipoMascara: TipoMascara { get set }
    init(tipoMascara: TipoMascara, mascaraCustomizada: String?)
    func retornaMascara(textoSemMascara: String) -> String
}

/**
 Gerencia a aplicação de mascaras do tipo numéricas em um objeto UITextField através de métodos do protocolo UITextFieldDelegate.
 
 Este formatador tem como objetivo gerenciar mascaras númericas em geral. Ele pode ser inicializado a partir de um enum 'TipoMascara' ou através de uma String representando uma máscara customizada.
 
 
 ```
 // Inicialização a partir de um enum 'TipoMascara':
 let formatador = FormatadorNumericoDelegate(tipoMascara: .telefone)
 
 // Inicialização a partir de uma máscara customizada:
 let formatador = FormatadorNumericoDelegate(mascaraCustomizada: "###.##.#")
 
 ```
 
 ## Mascaras nativas (TipoMascara)
 
 - cpf
 - cnpj
 - cep
 - boleto
 - telefone
 - rg
 */
public class CNFormatadorNumerico: NSObject, UITextFieldDelegate, CNFormatador {
    
    private var tipoMascara : TipoMascara
    private var geradorMascaraNumerico : GeradorMascaraNumerico
    var delegate: UITextFieldDelegate?
    
    /** Retorna a string de texto com a aplicação da máscara processada. */
    public var entradaComMascara: String = ""
    
    /** Retorna a string de texto sem a aplicação da máscara. */
    public var entradaSemMascara: String { return entradaComMascara.filtrarNumeros() }
    
    private var mascaraCustomizada: String?
    
    public init(tipoMascara: TipoMascara) {
        self.tipoMascara = tipoMascara
        self.geradorMascaraNumerico = CNFormatadorNumerico.criaGeradorMascaraNumerico(tipoMascara: tipoMascara)
    }
    
    public init(mascaraCustomizada: String) {
        self.tipoMascara = .customizada
        self.geradorMascaraNumerico = CNFormatadorNumerico.criaGeradorMascaraNumerico(tipoMascara: self.tipoMascara, mascaraCustomizada: mascaraCustomizada)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let bool = formata(textField, shouldChangeCharactersIn: range, replacementString: string)
        return bool
    }
    
    private func formata(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textoNormal = textField.text else { return false }
        let novoTexto = (textoNormal as NSString).replacingCharacters(in: range, with: string)
        
        let mascaraEntradaTexto = geradorMascaraNumerico.retornaMascara(textoSemMascara: novoTexto)
        entradaComMascara = novoTexto.filtrarNumeros().aplicaMascara(mascara: mascaraEntradaTexto)
        
        guard novoTexto != entradaComMascara else { return true }
        textField.text = entradaComMascara
        guard string != "" else { return false }
        
        let posicaoCursor = textField.position(from   : textField.beginningOfDocument,
                                               offset : range.location + entradaComMascara.count - 1)
        
        if let posicaoCursor = posicaoCursor {
            let textRange = textField.textRange(from: posicaoCursor, to: posicaoCursor)
            textField.selectedTextRange = textRange
        }
        return false
    }
    
    private static func criaGeradorMascaraNumerico(tipoMascara: TipoMascara, mascaraCustomizada: String? = nil) -> GeradorMascaraNumerico {
        switch tipoMascara {
        case .boleto:
            return CNGeradorMascaraBoleto(tipoMascara: tipoMascara, mascaraCustomizada: mascaraCustomizada)
        case .cnpj, .cpf, .rg, .cep, .customizada, .cartaoDeCredito:
            return CNGeradorMascaraGenerico(tipoMascara: tipoMascara, mascaraCustomizada: mascaraCustomizada)
        case .telefone:
            return CNGeradorMascaraTelefone(tipoMascara: tipoMascara, mascaraCustomizada: mascaraCustomizada)
        case .percentual:
            return CNGeradorMascaraPercentual(tipoMascara: tipoMascara, mascaraCustomizada: mascaraCustomizada)
        }
    }
}



//
//  CNFormatadorMoedaDelegate.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 08/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import UIKit

/**
 Gerencia a aplicação de mascaras do tipo monetárias em um objeto UITextField através de métodos do protocolo UITextFieldDelegate.
 
 Este formatador tem como objetivo gerenciar mascaras do tipo moeda.
 
 Ele é inicializado a partir de um objeto do tipo 'Locale', utilizado para definir qual tipo de moeda será utilizada na mascará.
 
 Você pode utilizar a classe 'LocalidadesMoeda' para retornar algum dos tipos de 'Locale' pré inicializados para moedas como
 
 - real
 - dollar
 - euro
 
 ```
 /* Inicialização a partir de um objeto 'Locale'
 utilizando a classe 'LocalidadesMoeda' */
let formatador = FormatadorMoeda(localidadeMoeda: LocalidadesMoeda.real)
 */
public class CNFormatadorMoeda: NSObject, UITextFieldDelegate, CNFormatador {
    
    var limiteDeCaracteres = 30
    var delegate: UITextFieldDelegate?
    
    /** Retorna a string de texto com a aplicação da máscara processada. */
    public var entradaComMascara: String = ""
    
    /** Retorna a string de texto sem a aplicação da máscara. */
    public var entradaSemMascara: String = ""
    
    let formatadorMoeda = NumberFormatter()
    
    public init(localidadeMoeda: Locale = LocalidadesMoeda.real, limiteDeCaracteres: Int = 30, simboloMoenda: String = "R$") {
        super.init()
        self.limiteDeCaracteres = limiteDeCaracteres
        configuraFormatadorMoeda(localidadeMoeda: localidadeMoeda, simboloMoenda: simboloMoenda)
    }
    
    private func configuraFormatadorMoeda(localidadeMoeda: Locale, simboloMoenda: String = "R$") {
        formatadorMoeda.locale = localidadeMoeda
        formatadorMoeda.numberStyle = .currency
        formatadorMoeda.currencySymbol = simboloMoenda
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let bool = formata(textField, shouldChangeCharactersIn: range, replacementString: string)
        return bool
    }
    
    private func formata(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textoNormal = textField.text else { return false }
        var novoTexto = (textoNormal as NSString).replacingCharacters(in: range, with: string)
        
        if novoTexto.count >= limiteDeCaracteres {
            novoTexto = String(novoTexto.prefix(textoNormal.count - 1))
        } else {
            guard let valorNumerico = Double(novoTexto.filtrarNumeros()) else { return true }
            novoTexto = formatadorMoeda.string(from: NSNumber(value: valorNumerico/100)) ?? ""
        }
        
        textField.text = novoTexto
        
        var posicaoUltimoDigitoValido = novoTexto.count - 1
        for index in (0...(novoTexto.count - 1)).reversed() {
            let digito = novoTexto[index]
            guard let _ = Int(String(digito)) else { continue }
            posicaoUltimoDigitoValido = index
            break
        }
        
        let posicaoCursor = textField.position(from   : textField.beginningOfDocument,
                                               offset : posicaoUltimoDigitoValido)
        
        if let posicaoCursor = posicaoCursor {
            let textRange = textField.textRange(from: posicaoCursor, to: posicaoCursor)
            textField.selectedTextRange = textRange
        }
    
        entradaSemMascara = String(formatadorMoeda.number(from: textField.text ?? "")?.doubleValue ?? 0)
        entradaComMascara = textField.text ?? ""
        return false
    }
    
    public func capturaValorFormatado(from text: String) -> Double {
        formatadorMoeda.number(from: text.filter("01234567890,".contains))?.doubleValue ?? 0
    }
}




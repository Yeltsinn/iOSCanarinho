//
//  CNPessoaFisicaJuridicaUtil.swift
//  Canarinho-iOS
//
//  Created by Yeltsin Suares Lobato Gama on 29/09/19.
//  Copyright © 2019 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

enum CNValidadorError: Error {
    case QuantidadeDeDigitosInvalida
    case DigitosVerificadoresInvalidos
    case CaracteresNaoPodemSerTodosIguais
}

class CNPessoaFisicaJuridicaUtil {
    
    private let quantidadeDigitosCPF = 11
    private let pesoLimiteCPF = 11
    
    private let quantidadeDigitosCNPJ = 14
    private let pesoLimiteCNPJ = 9
    
    private let valorDoModulo = 11
    private let pesoInicial = 2
    
    func regexDigitosRepetidos(_ quantidadeCaracteres: Int) -> String {
        return "^(?=([0-9]))\\1{\(String(quantidadeCaracteres))}"
    }
    
    func validaCNPJ(_ cnpj: String) throws -> Bool {
        
        do { return try validaValor(valor                            : cnpj,
                                    quantidadeDigitos                : quantidadeDigitosCNPJ,
                                    pesoLimite                       : pesoLimiteCNPJ,
                                    posicaoPrimeiroDigitoVerificador : 12)
        } catch let error { throw error }
    }
    
    func validaCPF(_ cpf: String) throws -> Bool {
        
        do { return try validaValor(valor                            : cpf,
                                    quantidadeDigitos                : quantidadeDigitosCPF,
                                    pesoLimite                       : pesoLimiteCPF,
                                    posicaoPrimeiroDigitoVerificador : 9)
        } catch let error { throw error }
    }
    
    private func validaValor(valor: String, quantidadeDigitos: Int, pesoLimite: Int, posicaoPrimeiroDigitoVerificador: Int) throws -> Bool {
        
        let stringNumeros = valor.filter("01234567890".contains)
        
        guard stringNumeros.count == quantidadeDigitos else { throw CNValidadorError.QuantidadeDeDigitosInvalida }
        
        if let regex = try? NSRegularExpression(pattern: regexDigitosRepetidos(quantidadeDigitos)) {
            if regex.matches(stringNumeros) { throw CNValidadorError.CaracteresNaoPodemSerTodosIguais }
        }
        
        let digitosVerificadores = stringNumeros.substring(posicaoPrimeiroDigitoVerificador, quantidadeDigitos)
        let valorSemDigitosVerificadores = stringNumeros.substring(0, posicaoPrimeiroDigitoVerificador)
        
        guard let dv1 = calculaDigitoVerificador(valorSemDigitosVerificadores, pesoLimite: pesoLimite) else {
            throw CNValidadorError.DigitosVerificadoresInvalidos
        }
        guard let dv2 = calculaDigitoVerificador(valorSemDigitosVerificadores + "\(dv1)", pesoLimite: pesoLimite) else {
            throw CNValidadorError.DigitosVerificadoresInvalidos
        }
        
        guard ("\(dv1)\(dv2)" == digitosVerificadores) else { throw CNValidadorError.DigitosVerificadoresInvalidos }
        return true
    }
    
    private func calculaDigitoVerificador(_ stringNumeros: String, pesoLimite: Int) -> Int? {
        
        var somaParcial = 0
        var peso = pesoInicial
        for digitoStr in String(stringNumeros.reversed()) {
            guard let digito = Int(String(digitoStr)) else { return nil }
            somaParcial += digito * peso
            peso = (peso == pesoLimite) ? pesoInicial : (peso + 1)
        }
        
        let resultadoModulo = somaParcial % valorDoModulo
        let digitoVerificador = resultadoModulo < 2 ? 0 : (valorDoModulo - resultadoModulo)
        
        return digitoVerificador
    }
}

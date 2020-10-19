//
//  CodigoDeBarrasUtil.swift
//  CaixaTem
//
//  Created by cedesbr050 on 17/08/19.
//

import Foundation

enum MascaraCodigoBarrasError: Error {
    case quantidadeDeDigitosInvalida
    case stringOrigemEBoletoNaoLinhaDigitavel
}

public typealias CNCodigoBarras = (codigo: String, codigoComMascara: String)

public class CNCodigoDeBarrasUtil {
    
    private static let digitoInicialBoletoConvenio: Character = "8"
    
    private static let MOEDA_REAL_10 = 6
    private static let MOEDA_REFERENCIA_10 = 7
    private static let MOEDA_REAL_11 = 8
    private static let MOEDA_REFERENCIA_11 = 9
    private static let POSICAO_MOEDA = 2
    
    static let mascaraLinhaDigitavelConvenio = "###########-# ###########-# ###########-# ###########-#"
    static let mascaraLinhaDigitavelBoleto =  "#####.##### #####.###### #####.###### # ##############"
    
     /* MARK: Métodos responsáveis pela conversão de código de barras em linha digitável */
    
    public static func converteCodigoBarrasParaLinhaDigitavelConvenio(_ codigoBarras: String) -> CNCodigoBarras? {
        let valorBruto = converteCodigoBarrasParaLinhaDigitavelConvenio(codigoBarras: codigoBarras)
        let valorBrutoComMascara = mascaraCodigoBarrasParaLinhaDigitavelConvenio(codigoBarras: codigoBarras)
        guard let linhaDigitavel = valorBruto, let linhaDigitavelComMascara = valorBrutoComMascara else { return nil }
        return CNCodigoBarras(linhaDigitavel, linhaDigitavelComMascara)
    }
    
    public static func converteCodigoBarrasParaLinhaDigitavelBoleto(_ codigoBarras: String) -> CNCodigoBarras? {
        let valorBruto = converteCodigoBarrasParaLinhaDigitavelBoleto(codigoBarras: codigoBarras)
        let valorBrutoComMascara = mascaraCodigoBarrasParaLinhaDigitavelBoleto(codigoBarras: codigoBarras)
        guard let linhaDigitavel = valorBruto, let linhaDigitavelComMascara = valorBrutoComMascara else { return nil }
        return CNCodigoBarras(linhaDigitavel, linhaDigitavelComMascara)
    }
    
    private static func converteCodigoBarrasParaLinhaDigitavelConvenio(codigoBarras: String) -> String? {
        
        guard codigoBarras.count >= 44 else { return nil }
        
        var campo1 = codigoBarras.substring(0, 11)
        var campo2 = codigoBarras.substring(11, 22)
        var campo3 = codigoBarras.substring(22, 33)
        var campo4 = codigoBarras.substring(33, 44)
        
        let tipoMoeda = campo1.substring(POSICAO_MOEDA, POSICAO_MOEDA + 1)
        
        campo1 = campo1 + String(calculaDVConvenio(campo1 + "0", Int(tipoMoeda) ?? 0))
        campo2 = campo2 + String(calculaDVConvenio(campo2 + "0", Int(tipoMoeda) ?? 0))
        campo3 = campo3 + String(calculaDVConvenio(campo3 + "0", Int(tipoMoeda) ?? 0))
        campo4 = campo4 + String(calculaDVConvenio(campo4 + "0", Int(tipoMoeda) ?? 0))
        
        return campo1 + campo2 + campo3 + campo4
    }
    
    private static func converteCodigoBarrasParaLinhaDigitavelBoleto(codigoBarras: String) -> String? {
        
        guard codigoBarras.count >= 44 else { return nil }
        
        let dv = codigoBarras.substring(4, 5)
        
        var campo1 = codigoBarras.substring(0, 4)
        
        campo1 = campo1 + codigoBarras.substring(19, 24)
        
        var campo2 = codigoBarras.substring(24, 34);
        var campo3 = codigoBarras.substring(34, 44);
        var campo4 = codigoBarras.substring(5, 19);
        
        var campo5 = ""
        
        campo1 = campo1 + String(calculaDAC10(campo1 + "0"))
        campo2 = campo2 + String(calculaDAC10(campo2 + "0"))
        campo3 = campo3 + String(calculaDAC10(campo3 + "0"))
        campo5 = campo4
        campo4 = dv
        
        return campo1 + campo2 + campo3 + campo4 + campo5
    }
    
     /* MARK: Métodos responsáveis pelo cálculo dos dígitos verificadores dos boletos */
    
    private static func calculaDAC10(_ campoCodigo: String) -> Int {
        
        let campoCodigoSemDV = campoCodigo.substring(0, campoCodigo.count - 1)
        let index = campoCodigoSemDV.count
        
        var currentVal = 0
        var fator = 2

        /* Começa com 2 */
        var total = 0
        var parcial = 0
        
        for index in (0..<index).reversed() {
            currentVal = Int(String(campoCodigoSemDV[index])) ?? 0
            parcial = currentVal * fator
            
            var parcialRounded = Double(parcial / 10)
            parcialRounded.round(FloatingPointRoundingRule.towardZero)
            total += (parcial % 10) + Int(parcialRounded)
            fator = 3 - fator
        }
        
        let dvCalculado = ((10 - (total % 10)) % 10);
        return dvCalculado
    }
    
    private static func calculaDAC11(_ campoCodigo: String) -> Int {
        
        let campoCodigoSemDV = campoCodigo.substring(0, campoCodigo.count - 1)
        let index = campoCodigoSemDV.count
        
        let fatorInicial = 2
        let fatorFinal = 9
        var fator = fatorInicial
        var total = 0
        
        var currentVal = 0
        for index in (0..<index).reversed() {
            currentVal = Int(String(campoCodigoSemDV[index])) ?? 0
            total += (currentVal * fator)
            
            fator = fator + 1
            
            if (fator > fatorFinal) { fator = fatorInicial }
        }
        var dvCalculado = total % 11
        if (dvCalculado < 2) {
            return 0;
        }
        dvCalculado = (11 - dvCalculado);
        return dvCalculado
    }
    
    private static func calculaDVConvenio(_ campoCodigoCompleto: String, _ tipoMoeda: Int) -> Int {
        
        var dvCalculado: Int = 0
        
        if ((tipoMoeda == MOEDA_REAL_10) || (tipoMoeda == MOEDA_REFERENCIA_10)) {
            print("DAC10")
            dvCalculado = calculaDAC10(campoCodigoCompleto)
        }
        
        if ((tipoMoeda == MOEDA_REAL_11) || (tipoMoeda == MOEDA_REFERENCIA_11)) {
            print("DAC11")
            dvCalculado = calculaDAC11(campoCodigoCompleto)
        }
        
        return dvCalculado
    }
    
    /* MARK: Métodos geradores de mascara dos boletos */
    
    public static func mascaraLinhaDigitavel(_ linhaDigitavel: String) -> String? {
        if linhaDigitavel.first == CNCodigoDeBarrasUtil.digitoInicialBoletoConvenio {
            return aplicaMascaraLinhaDigitavelConvenio(linhaDigitavel)
        } else {
            return aplicaMascaraLinhaDigitavelBoleto(linhaDigitavel)
        }
    }
    
    public static func mascaraCodigoBarrasParaLinhaDigitavel(_ codigoBarras: String) -> String? {
        
        if codigoBarras.first == CNCodigoDeBarrasUtil.digitoInicialBoletoConvenio {
            return mascaraCodigoBarrasParaLinhaDigitavelConvenio(codigoBarras: codigoBarras)
        } else {
            return mascaraCodigoBarrasParaLinhaDigitavelBoleto(codigoBarras: codigoBarras)
        }
    }
    
    private static func mascaraCodigoBarrasParaLinhaDigitavelConvenio(codigoBarras: String) -> String? {
        
        if codigoBarras.count == 44 {
            guard let codigoBarrasConvertido = converteCodigoBarrasParaLinhaDigitavelConvenio(codigoBarras: codigoBarras) else { return nil }
            return aplicaMascaraLinhaDigitavelConvenio(codigoBarrasConvertido)
        }
        return nil
    }
    
    private static func aplicaMascaraLinhaDigitavelConvenio(_ linhaDigitavelConvenio: String) -> String?  {
        
        guard linhaDigitavelConvenio.count == 48 else { return nil }
        
        let campo1 = linhaDigitavelConvenio.substring(0, 11) + "-" + linhaDigitavelConvenio.substring(11, 12)
        let campo2 = linhaDigitavelConvenio.substring(12, 23) + "-" + linhaDigitavelConvenio.substring(23, 24)
        let campo3 = linhaDigitavelConvenio.substring(24, 35) + "-" + linhaDigitavelConvenio.substring(35, 36)
        let campo4 = linhaDigitavelConvenio.substring(36, 47) + "-" + linhaDigitavelConvenio.substring(47, 48)
        
        return campo1 + " " + campo2 + " " + campo3 + " " + campo4
    }
    
    private static func mascaraCodigoBarrasParaLinhaDigitavelBoleto(codigoBarras: String) -> String? {
        
        if codigoBarras.count == 44 {
            guard let codigoBarrasConvertido = converteCodigoBarrasParaLinhaDigitavelBoleto(codigoBarras: codigoBarras) else { return nil }
            return aplicaMascaraLinhaDigitavelBoleto(codigoBarrasConvertido)
        }
        return nil
    }
    
    private static func aplicaMascaraLinhaDigitavelBoleto(_ linhaDigitavelBoleto: String) -> String? {
        
        guard linhaDigitavelBoleto.count == 47 else { return nil }
        
        let campo1 = linhaDigitavelBoleto.substring(0, 5) + "." + linhaDigitavelBoleto.substring(5, 10)
        let campo2 = linhaDigitavelBoleto.substring(10, 15) + "." + linhaDigitavelBoleto.substring(15, 21)
        let campo3 = linhaDigitavelBoleto.substring(21, 26) + "." + linhaDigitavelBoleto.substring(26, 32)
        let campo4 = linhaDigitavelBoleto.substring(32, 33)
        let campo5 = linhaDigitavelBoleto.substring(33, 47)
        
        return campo1 + " " + campo2 + " " + campo3 + " " + campo4 + " " + campo5;
    }
}

//
//  TestesAplicacaoDeMascaraEmStrings.swift
//  iOSCanarinhoTests
//
//  Created by Yeltsin Suares Lobato Gama on 12/01/21.
//  Copyright © 2021 Yeltsin Suares Lobato Gama. All rights reserved.
//

import XCTest
import iOSCanarinho

class TestesAplicacaoDeMascaraEmStrings: XCTestCase {
    
    var telefone: String?
    var numeroCartao: String?
    var numeroRG: String?
    var numeroCPF: String?
    var numeroBoletoConvenio: String?
    var numeroLinhaDigitavelBoleto: String?

    override func setUpWithError() throws {
        telefone = "99999999999"
        numeroCartao = "1234567890123456"
        numeroRG = "1111111"
        numeroCPF = "00000000000"
        numeroBoletoConvenio = "84670000001435900240200240500024384221010811"
        numeroLinhaDigitavelBoleto = "34191790010104351004791020150008484260026000"
    }

    override func tearDownWithError() throws {
        telefone = nil
        numeroCartao = nil
        numeroRG = nil
        numeroCPF = nil
        numeroBoletoConvenio = nil
        numeroLinhaDigitavelBoleto = nil
    }

    func testaAplicacaoDeMascarasEmString() throws {
        
        let telefoneComMascara = telefone?.aplicaMascara(.telefone)
        let numeroCartaoComMascara = numeroCartao?.aplicaMascara(.cartaoDeCredito)
        let numeroRGComMascara = numeroRG?.aplicaMascara(.mascaraRG)
        let numeroCPFComMascara = numeroCPF?.aplicaMascara(.mascaraCPF)
        let numeroBoletoConvenioComMascara = numeroBoletoConvenio?.aplicaMascara(.mascaraLinhaDigitavelConvenio)
        let numeroLinhaDigitavelBoletoComMascara = numeroLinhaDigitavelBoleto?.aplicaMascara(.mascaraLinhaDigitavelBoleto)
        
        XCTAssertEqual(telefoneComMascara, "(99) 99999-9999")
        XCTAssertEqual(numeroCartaoComMascara, "1234 5678 9012 3456")
        XCTAssertEqual(numeroRGComMascara, "1.111.111")
        XCTAssertEqual(numeroCPFComMascara, "000.000.000-00")
        XCTAssertEqual(numeroBoletoConvenioComMascara, "84670000001-4 35900240200-2 40500024384-2 21010811")
        XCTAssertEqual(numeroLinhaDigitavelBoletoComMascara, "34191.79001 01043.510047 91020.150008 4 84260026000")
    }
    
    func testaAplicacaoDeMascarasEmStringComOcultacaoDeCaracteres() throws {
        
        let telefoneComMascara = telefone?.aplicaMascara(.telefone,
                                                        esconderPosicoes: [0, 1],
                                                        caractereDeOcultacao: "*")
        
        let numeroCartaoComMascara = numeroCartao?.aplicaMascara(.cartaoDeCredito,
                                                                esconderPosicoes: [12, 13, 14, 15],
                                                                caractereDeOcultacao: "#")
        
        let numeroRGComMascara = numeroRG?.aplicaMascara(.mascaraRG,
                                                        esconderPosicoes: [2],
                                                        caractereDeOcultacao: "-")
       
        let numeroCPFComMascara = numeroCPF?.aplicaMascara(.mascaraCPF,
                                                          esconderPosicoes: [],
                                                          caractereDeOcultacao: "*")
        
        let numeroBoletoConvenioComMascara = numeroBoletoConvenio?.aplicaMascara(.mascaraLinhaDigitavelConvenio,
                                                                                esconderPosicoes: [1, 3],
                                                                                caractereDeOcultacao: "*")
       
        let numeroLinhaDigitavelBoletoComMascara = numeroLinhaDigitavelBoleto? .aplicaMascara(.mascaraLinhaDigitavelBoleto,
                                                                                             esconderPosicoes: [0, 5],
                                                                                             caractereDeOcultacao: "*")
        
        XCTAssertEqual(telefoneComMascara, "(**) 99999-9999")
        XCTAssertEqual(numeroCartaoComMascara, "1234 5678 9012 ####")
        XCTAssertEqual(numeroRGComMascara, "1.1-1.111")
        XCTAssertEqual(numeroCPFComMascara, "000.000.000-00")
        XCTAssertEqual(numeroBoletoConvenioComMascara, "8*6*0000001-4 35900240200-2 40500024384-2 21010811")
        XCTAssertEqual(numeroLinhaDigitavelBoletoComMascara, "*4191.*9001 01043.510047 91020.150008 4 84260026000")
    }
}

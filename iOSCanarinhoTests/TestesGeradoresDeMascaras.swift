//
//  TestesGeradoresDeMascaras.swift
//  iOSCanarinhoTests
//
//  Created by Yeltsin Suares Lobato Gama on 15/01/21.
//  Copyright © 2021 Yeltsin Suares Lobato Gama. All rights reserved.
//

import XCTest
@testable import iOSCanarinho

class TestesGeradoresDeMascaras: XCTestCase {
    
    var geradorDeMascarasBoleto: CNGeradorMascaraBoleto?
    var geradorDeMascarasTelefone: CNGeradorMascaraTelefone?
    var geradorMascaraGenerico: CNGeradorMascaraGenerico?
    
    var numeroBoletoConvenio = "84670000001435900240200240500024384221010811"
    var numeroLinhaDigitavelBoleto = "34191790010104351004791020150008484260026000"

    override func setUpWithError() throws {
        geradorDeMascarasBoleto = CNGeradorMascaraBoleto(tipoMascara: .boleto, mascaraCustomizada: nil)
        geradorDeMascarasTelefone = CNGeradorMascaraTelefone(tipoMascara: .telefone, mascaraCustomizada: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testeGeradorMascaraBoletoConvenio() throws {
        let mascara = geradorDeMascarasBoleto?.retornaMascara(textoSemMascara: numeroBoletoConvenio)
        XCTAssertEqual(mascara, CNMascara.mascaraLinhaDigitavelConvenio.rawValue)
    }
    
    func testeGeradorMascaraBoleto() throws {
        let mascara = geradorDeMascarasBoleto?.retornaMascara(textoSemMascara: numeroLinhaDigitavelBoleto)
        XCTAssertEqual(mascara, CNMascara.mascaraLinhaDigitavelBoleto.rawValue)
    }
    
    func testeGeradorMascaraTelefone() throws {
        let mascaraTelefone1 = geradorDeMascarasTelefone?.retornaMascara(textoSemMascara: "9999999")
        XCTAssertEqual(mascaraTelefone1, CNGeradorMascaraTelefone.mascaraTelefone1)
        
        let mascaraTelefone2 = geradorDeMascarasTelefone?.retornaMascara(textoSemMascara: "99999999")
        XCTAssertEqual(mascaraTelefone2, CNGeradorMascaraTelefone.mascaraTelefone2)
        
        let mascaraTelefone3 = geradorDeMascarasTelefone?.retornaMascara(textoSemMascara: "999999999")
        XCTAssertEqual(mascaraTelefone3, CNGeradorMascaraTelefone.mascaraTelefone3)
        
        let mascaraTelefone4 = geradorDeMascarasTelefone?.retornaMascara(textoSemMascara: "9999999999")
        XCTAssertEqual(mascaraTelefone4, CNGeradorMascaraTelefone.mascaraTelefone4)
        
        let mascaraTelefone5 = geradorDeMascarasTelefone?.retornaMascara(textoSemMascara: "99999999999")
        XCTAssertEqual(mascaraTelefone5, CNGeradorMascaraTelefone.mascaraTelefone5)
        
        let mascaraTelefone6 = geradorDeMascarasTelefone?.retornaMascara(textoSemMascara: "999999999999")
        XCTAssertEqual(mascaraTelefone6, CNGeradorMascaraTelefone.mascaraTelefone6)
    }
    
    func testeGeradorMascaraGenerico() throws {
        geradorMascaraGenerico = CNGeradorMascaraGenerico(tipoMascara: .cep, mascaraCustomizada: nil)
        XCTAssertEqual(CNMascara.mascaraCEP.rawValue, geradorMascaraGenerico?.retornaMascara(textoSemMascara: "11111111"))
        
        geradorMascaraGenerico = CNGeradorMascaraGenerico(tipoMascara: .cpf, mascaraCustomizada: nil)
        XCTAssertEqual(CNMascara.mascaraCPF.rawValue, geradorMascaraGenerico?.retornaMascara(textoSemMascara: "11111111111"))
        
        geradorMascaraGenerico = CNGeradorMascaraGenerico(tipoMascara: .cnpj, mascaraCustomizada: nil)
        XCTAssertEqual(CNMascara.mascaraCNPJ.rawValue, geradorMascaraGenerico?.retornaMascara(textoSemMascara: "11111111111111"))
        
        geradorMascaraGenerico = CNGeradorMascaraGenerico(tipoMascara: .cartaoDeCredito, mascaraCustomizada: nil)
        XCTAssertEqual(CNMascara.cartaoDeCredito.rawValue, geradorMascaraGenerico?.retornaMascara(textoSemMascara: "1111111111111111"))
        
        geradorMascaraGenerico = CNGeradorMascaraGenerico(tipoMascara: .customizada, mascaraCustomizada: "### ##.#")
        XCTAssertEqual("### ##.#", geradorMascaraGenerico?.retornaMascara(textoSemMascara: "111111"))
    }
}

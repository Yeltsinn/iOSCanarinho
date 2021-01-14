//
//  TestesAplicacaoDeMascaraEmUITextFields.swift
//  iOSCanarinhoTests
//
//  Created by Yeltsin Suares Lobato Gama on 13/01/21.
//  Copyright © 2021 Yeltsin Suares Lobato Gama. All rights reserved.
//

import XCTest
import iOSCanarinho

class TestesAplicacaoDeMascaraEmUITextFields: XCTestCase {
    
    var formatadorCpf: CNFormatadorNumerico?
    var formatadorCnpj: CNFormatadorNumerico?
    var formatadorTelefone: CNFormatadorNumerico?
    var formatadorBoleto: CNFormatadorNumerico?
    var formatadorCartaoDeCredito: CNFormatadorNumerico?
    
    var textFieldCPF = UITextField()
    var textFieldCNPJ = UITextField()
    var textFieldTelefone = UITextField()
    var textFieldBoleto = UITextField()
    var textFieldCartaoDeCredito = UITextField()
    
    var telefone = "99999999999"
    var numeroCPF = "00000000000"
    var numeroCNPJ = "00000000000000"
    var numeroBoletoConvenio = "84670000001435900240200240500024384221010811"
    var numeroLinhaDigitavelBoleto = "34191790010104351004791020150008484260026000"
    var numeroCartaoDeCredito = "1111111111111111"
    
    let quantidadeDigitosCPF = 11
    let quantidadeDigitosCNPJ = 14
    let quantidadeDigitosTelefoneComDDD = 10
    let quantidadeDigitosCodigoDeBarras = 44
    let quantidadeDigitosCartaoDeCredito = 16
    
    override func setUpWithError() throws {
        formatadorCpf = CNFormatadorNumerico(tipoMascara: .cpf)
        formatadorCnpj = CNFormatadorNumerico(tipoMascara: .cnpj)
        formatadorTelefone = CNFormatadorNumerico(tipoMascara: .telefone)
        formatadorBoleto = CNFormatadorNumerico(tipoMascara: .boleto)
        formatadorCartaoDeCredito = CNFormatadorNumerico(tipoMascara: .cartaoDeCredito)
        
        textFieldCPF.delegate = formatadorCpf
        textFieldTelefone.delegate = formatadorTelefone
        textFieldBoleto.delegate = formatadorBoleto
        textFieldCartaoDeCredito.delegate = formatadorCartaoDeCredito
    }
    
    override func tearDownWithError() throws {
        formatadorCpf = nil
        formatadorCnpj = nil
        formatadorTelefone = nil
        formatadorBoleto = nil
        formatadorCartaoDeCredito = nil
        
        textFieldCPF.delegate = nil
        textFieldTelefone.delegate = nil
        textFieldBoleto.delegate = nil
        textFieldCartaoDeCredito.delegate = nil
    }
    
    func testaAplicacaoDeMascaraCPF() throws {
        textFieldCPF.text = "------------"
        let _ = formatadorCpf?.textField(textFieldCPF,
                                         shouldChangeCharactersIn: NSMakeRange(0, quantidadeDigitosCPF),
                                         replacementString: numeroCPF)
        
        XCTAssertEqual(formatadorCpf?.entradaComMascara, "000.000.000-00")
        XCTAssertEqual(formatadorCpf?.entradaSemMascara, numeroCPF)
    }
    
    func testaAplicacaoDeMascaraCNPJ() throws {
        textFieldCNPJ.text = "---------------"
        let _ = formatadorCnpj?.textField(textFieldCNPJ,
                                          shouldChangeCharactersIn: NSMakeRange(0, quantidadeDigitosCNPJ),
                                          replacementString: numeroCNPJ)
        
        XCTAssertEqual(formatadorCnpj?.entradaComMascara, "00.000.000/0000-00")
        XCTAssertEqual(formatadorCnpj?.entradaSemMascara, numeroCNPJ)
    }
    
    func testaAplicacaoDeMascaraTelefone() throws {
        textFieldTelefone.text = "-----------"
        let _ = formatadorTelefone?.textField(textFieldTelefone,
                                              shouldChangeCharactersIn: NSMakeRange(0, quantidadeDigitosTelefoneComDDD),
                                              replacementString: telefone)
        
        XCTAssertEqual(formatadorTelefone?.entradaComMascara, "(99) 99999-9999")
        XCTAssertEqual(formatadorTelefone?.entradaSemMascara, telefone)
    }
    
    func testaAplicacaoDeMascaraBoletoConvenio() throws {
        textFieldBoleto.text = "--------------------------------------------"
        let _ = formatadorBoleto?.textField(textFieldBoleto,
                                            shouldChangeCharactersIn: NSMakeRange(0, quantidadeDigitosCodigoDeBarras),
                                            replacementString: numeroBoletoConvenio)
        
        XCTAssertEqual(formatadorBoleto?.entradaComMascara, "84670000001-4 35900240200-2 40500024384-2 21010811")
        XCTAssertEqual(formatadorBoleto?.entradaSemMascara, numeroBoletoConvenio)
    }
    
    func testaAplicacaoDeMascaraLinhaDigitavelBoleto() throws {
        textFieldBoleto.text = "--------------------------------------------"
        let _ = formatadorBoleto?.textField(textFieldBoleto,
                                            shouldChangeCharactersIn: NSMakeRange(0, quantidadeDigitosCodigoDeBarras),
                                            replacementString: numeroLinhaDigitavelBoleto)
        
        XCTAssertEqual(formatadorBoleto?.entradaComMascara, "34191.79001 01043.510047 91020.150008 4 84260026000")
        XCTAssertEqual(formatadorBoleto?.entradaSemMascara, numeroLinhaDigitavelBoleto)
    }
    
    func testaAplicacaoDeMascaraCartaoDeCredito() throws {
        textFieldCartaoDeCredito.text = "----------------"
        let _ = formatadorCartaoDeCredito?.textField(textFieldCartaoDeCredito,
                                                     shouldChangeCharactersIn: NSMakeRange(0, quantidadeDigitosCartaoDeCredito),
                                                     replacementString: numeroCartaoDeCredito)
        
        XCTAssertEqual(formatadorCartaoDeCredito?.entradaComMascara, "1111 1111 1111 1111")
        XCTAssertEqual(formatadorCartaoDeCredito?.entradaSemMascara, numeroCartaoDeCredito)
    }
}

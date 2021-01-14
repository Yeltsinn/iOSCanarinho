//
//  ViewController.swift
//  iOSCanarinhoExemploDeUso
//
//  Created by Yeltsin Suares Lobato Gama on 22/09/20.
//  Copyright © 2020 Yeltsin Suares Lobato Gama. All rights reserved.
//

import iOSCanarinho
import UIKit

class ViewController: UIViewController {
    
    let formatadorCpf = CNFormatadorNumerico(tipoMascara: .cpf)
    let formatadorTelefone = CNFormatadorNumerico(tipoMascara: .telefone)
    let formatadorBoleto = CNFormatadorNumerico(tipoMascara: .boleto)
    
    @IBOutlet weak var textFieldCPF: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldBoleto: UITextField!

    @IBOutlet weak var labelTelefone: UILabel!
    @IBOutlet weak var labelCPF: UILabel!
    @IBOutlet weak var labelRG: UILabel!
    @IBOutlet weak var labelLinhaDigitavelBoleto: UILabel!
    @IBOutlet weak var labelBoletoConvenio: UILabel!
    @IBOutlet weak var labelCartaoDeCredito: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraComponentesDaTela()
        configuraFormatadoresParaTextField()
        aplicaMascaraNasLabels()
    }
    
    func configuraComponentesDaTela() {
        labelBoletoConvenio.minimumScaleFactor = 0.5
        labelBoletoConvenio.adjustsFontSizeToFitWidth = true
        
        labelLinhaDigitavelBoleto.minimumScaleFactor = 0.5
        labelLinhaDigitavelBoleto.adjustsFontSizeToFitWidth = true
    }
    
    func aplicaMascaraNasLabels() {
        labelTelefone.text = "99999999999".aplicaMascara(.telefone)
        labelRG.text = "1111111".aplicaMascara(.mascaraRG)
        labelCPF.text = "11111111111".aplicaMascara(.mascaraCPF, esconderPosicoes: [9, 10], caractereDeOcultacao: "*")
        labelBoletoConvenio.text = "84670000001435900240200240500024384221010811".aplicaMascara(.mascaraLinhaDigitavelConvenio)
        labelLinhaDigitavelBoleto.text = "34191790010104351004791020150008484260026000".aplicaMascara(.mascaraLinhaDigitavelBoleto)
        labelCartaoDeCredito.text = "1111111111111111".aplicaMascara(.cartaoDeCredito)
    }
    
    func configuraFormatadoresParaTextField() {
        textFieldCPF.delegate = formatadorCpf
        textFieldTelefone.delegate = formatadorTelefone
        textFieldBoleto.delegate = formatadorBoleto
    }
    
    @IBAction func mostrarInputsSemMascara(_ sender: Any) {
        print("CPF sem Mascara: \(formatadorCpf.entradaSemMascara)")
        print("Telefone sem Mascara: \(formatadorTelefone.entradaSemMascara)")
        print("Boleto sem Mascara: \(formatadorBoleto.entradaSemMascara)\n")
    }
    
    @IBAction func mostrarInputsComMascara(_ sender: Any) {
        print("CPF com Mascara: \(formatadorCpf.entradaComMascara)")
        print("Telefone com Mascara: \(formatadorTelefone.entradaComMascara)")
        print("Boleto com Mascara: \(formatadorBoleto.entradaComMascara)\n")
    }
}


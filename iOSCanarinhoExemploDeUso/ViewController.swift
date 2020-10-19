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

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraFormatadoresParaTextField()
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


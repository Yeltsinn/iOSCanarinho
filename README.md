# iOSCanarinho

<img src="https://img.shields.io/cocoapods/p/iOSCanarinho?label=platform"> <img src="https://img.shields.io/static/v1?label=pod&message=v0.0.1&color=blue&style=flat">



> Biblioteca inspirada no projeto Canarinho para Android https://github.com/concretesolutions/canarinho

iOSCanarinho é uma biblioteca **swift** para trabalhar com padrões brasileiros de documentos tais como: CPF, CNPJ, RG, boleto cobrança, boleto convênio, etc. 
Além de dar suporte para o trabalho com máscaras, formatadores e validadores para objetos UITextField e String.

## Máscaras

* CPF
* CNPJ
* Monetária
* Boleto Convênio
* Boleto Cobrança 
* Telefone
* Telefone com máscara de segurança
* CEP

## Validadores

* CPF
* CNPJ
* Boleto Convênio
* Boleto Cobrança 

## Instalação 

Você pode adicionar a biblioteca **iOSCanarinho** no seu projeto através do CocoaPods, basta adicionar as informações abaixo em seu arquivo Podfile:

```ruby
  platform :ios, '10.0'

  target '<Target do Projeto>' do
      use_frameworks!
  
      pod 'iOSCanarinho', '~> 0.0.1'
  end
```

Em seguida execute o seguinte comando no seu terminal:

```shell
$ pod install
```

## Utilização

### Máscaras para UITextField

```swift
class ViewController: UIViewController {
    
    let formatadorCpf = CNFormatadorNumerico(tipoMascara: .cpf)
    let formatadorTelefone = CNFormatadorNumerico(tipoMascara: .telefone)
    let formatadorBoleto = CNFormatadorNumerico(tipoMascara: .boleto)
    
    @IBOutlet weak var textFieldCPF: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldBoleto: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldCPF.delegate = formatadorCpf
        textFieldTelefone.delegate = formatadorTelefone
        textFieldBoleto.delegate = formatadorBoleto
    } 
}
```


> Recuperar texto de um objeto UITextField através dos formatadores

```swift
    let cpfSemMascara = formatadorCpf.entradaSemMascara
    let telefoneSemMascara = formatadorTelefone.entradaSemMascara
    let boletoSemMascara = formatadorBoleto.entradaSemMascara
    
    let cpfComMascara = formatadorCpf.entradaComMascara
    let telefoneComMascara = formatadorTelefone.entradaComMascara
    let boletoComMascara = formatadorBoleto.entradaComMascara
```

### Máscaras para String

```swift
  class ViewController: UIViewController {

    @IBOutlet weak var labelTelefone: UILabel!
    @IBOutlet weak var labelCPF: UILabel!
    @IBOutlet weak var labelRG: UILabel!
    @IBOutlet weak var labelLinhaDigitavelBoleto: UILabel!
    @IBOutlet weak var labelBoletoConvenio: UILabel!
    
    func aplicaMascaraNasLabels() {
        /* Retorno: (99) 99999-9999 */
        labelTelefone.text = "99999999999".aplicaMascara(.telefone) 

        /* Retorno:  1.111.111 */
        labelRG.text = "1111111".aplicaMascara(.mascaraRG) 

        /* Retorno:  111.111.111-11 */
        labelCPF.text = "11111111111".aplicaMascara(.mascaraCPF) 

        /* Retorno: 84670000001-4 35900240200-2 40500024384-2 21010811 */
        labelBoletoConvenio.text = "84670000001435900240200240500024384221010811".aplicaMascara(.mascaraLinhaDigitavelConvenio) 

        /* Retorno: 34191.79001 01043.510047 91020.150008 4 84260026000 */
        labelLinhaDigitavelBoleto.text = "34191790010104351004791020150008484260026000".aplicaMascara(.mascaraLinhaDigitavelBoleto)
    }
}
```

> Aplicação de máscara ocultando posições específicas 

```swift

  /* 1. As posições informadas consideram o texto antes da aplicação da máscara) */
  /* 2. Caso a posição informada exceda o tamanho da String a posição em questão é ignorada */

  func aplicaMascaraNasLabels() {
        /* Retorno: (**) 99999-9999") */
        labelTelefone.text = "99999999999".aplicaMascara(.telefone, esconderPosicoes: [0, 1], caractereDeOcultacao: "*")

        /* Retorno: 111.111.111-** */
        labelCPF.text = "11111111111".aplicaMascara(.mascaraCPF, esconderPosicoes: [9, 10], caractereDeOcultacao: "*")
   }
```

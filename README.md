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

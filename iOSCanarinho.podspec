
Pod::Spec.new do |spec|

  spec.name         = "iOSCanarinho"
  spec.version      = "0.0.1"
  spec.summary      = "Biblioteca swift para aplicação de máscaras."

  spec.description  = <<-DESC
    Biblioteca para aplicação de máscaras de padrões brasileiros, tais como linha digitável boleto, linha digitável convênio, CPF, RG, CNPJ, etc.
                   DESC

  spec.homepage     = "https://github.com/Yeltsinn/iOSCanarinho"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Yeltsin Lobato" => "yeltsin.lobato@gmail.com" }

  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/Yeltsinn/iOSCanarinho.git", :tag => "#{spec.version}" }
  spec.source_files  = "iOSCanarinho/**/*.{h,m,swift}"

end

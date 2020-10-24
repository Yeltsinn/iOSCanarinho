//
//  CNString+Extensions.swift
//  CanarinhoSampleProject
//
//  Created by Yeltsin Suares Lobato Gama on 22/09/20.
//  Copyright © 2020 Yeltsin Suares Lobato Gama. All rights reserved.
//

import Foundation

extension String {
    
   subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }
    
    func filtrarNumeros() -> String {
        return filter("01234567890".contains)
    }
    
    func filterDoubleCharacters() -> String {
        return filter("01234567890.".contains)
    }
    
    func substring(_ start: Int, _ end: Int) -> String {
        
        let string = self
        
        let start = string.index(string.startIndex, offsetBy: start)
        let end = string.index(string.startIndex, offsetBy: end)
        let range = start..<end
        
        return String(string[range])
    }
    
    public func aplicaMascara(_ mascara: CNMascara) -> String {
        return aplicaMascara(mascara: mascara.rawValue)
    }
    
    public func aplicaMascara(mascara: String) -> String {
        
        var stringResultante = String()
        
        let caracteres = self
        let caracteresMascara = mascara
        
        var indexStringOriginal = caracteres.startIndex
        var indexStringMascara = mascara.startIndex
        
        while indexStringOriginal < caracteres.endIndex && indexStringMascara < caracteresMascara.endIndex {
            
            if (caracteresMascara[indexStringMascara] == "#") {
                stringResultante.append(caracteres[indexStringOriginal])
                indexStringOriginal = caracteres.index(after: indexStringOriginal)
            } else {
                stringResultante.append(caracteresMascara[indexStringMascara])
            }
            indexStringMascara = caracteresMascara.index(after: indexStringMascara)
        }
        
        return stringResultante
    }
}



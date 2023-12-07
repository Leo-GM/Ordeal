//
//  LastFeedback.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 04/12/23.
//

import Foundation
import SwiftUI


// Classe para gerenciar os dados

class LastFeedback: ObservableObject {
    @Published var imagem: String
    @Published var instruction: String
    
    init(imagem: String, instruction: String) {
        self.imagem = imagem
        self.instruction = instruction
    }
    
    func updateValues(image: String, instruction:String){
        self.imagem = image
        self.instruction = instruction
    }
}



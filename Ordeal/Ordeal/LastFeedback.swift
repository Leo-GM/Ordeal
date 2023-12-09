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
    @Published var especie: String
    @Published var nomePlanta: String
    @Published var humidityReceived: Int

    
    init(imagem: String, instruction: String, especie: String, nomePlanta: String, humidityReceived: Int) {
        self.imagem = imagem
        self.instruction = instruction
        self.especie = especie
        self.nomePlanta = nomePlanta
        self.humidityReceived = humidityReceived
    }
    
    func updateValues(image: String, instruction:String, especie: String, nomePlanta: String, humidityReceived: Int){
        self.imagem = image
        self.instruction = instruction
        self.especie = especie
        self.nomePlanta = nomePlanta
        self.humidityReceived = humidityReceived
        
    }
}



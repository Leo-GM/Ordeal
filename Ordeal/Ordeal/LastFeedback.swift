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
   // @Publ var feedbackManager: FeedbackManager
    @EnvironmentObject var bluetoothViewModel: BluetoothModel

    @Published var especie: String = ""
    @Published var nome: String = ""
    @Published var idealHumidity: Int = 0
    @Published var humidityReceived: Int = 0
    
    @Published var flag: Int = 0
    
    @Published var imagem: String = ""
    @Published var instruction: String = ""
    

    init(feedbackManager: FeedbackManager, bluetoothViewModel: BluetoothModel) {
        self.feedbackManager = feedbackManager
            
        especie = feedbackManager.especieFeedback
        nome = feedbackManager.nomeFeedback
        idealHumidity = feedbackManager.idealHumiditySpecie
        humidityReceived = feedbackManager.humidityReceived
        flag = bluetoothViewModel.flag
        
        let humidityStatus = bluetoothViewModel.checkHumidityPlantState(specieHumidity: idealHumidity, humidityReceived: humidityReceived)
        let nutrientsStatus = bluetoothViewModel.checkNPKPlantState(nitrogenReceived: 0, phosphorReceived: 0, potassiumReceived: 0)
        let overallStatus = bluetoothViewModel.checkOveralStatus(humidyStatus: humidityStatus, nutrientsStatus: nutrientsStatus)
        
        if flag == 0 { // está recebendo atualização para feedback
            // Você pode acessar as propriedades e fazer o que precisa aqui
            imagem = humidityStatus.image()
            instruction = overallStatus.instruction()
        }
    }
}



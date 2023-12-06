//
//  LastFeedback.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 04/12/23.
//

import Foundation


// Classe para gerenciar os dados

class LastFeedback: ObservableObject {
    @Published var feedbackManager: FeedbackManager

    init(feedbackManager: FeedbackManager) {
        self.feedbackManager = feedbackManager
    }

    func acessarVariaveis() {
        let especie = feedbackManager.especieFeedback
        let nome = feedbackManager.nomeFeedback
        let idealHumidity = feedbackManager.idealHumiditySpecie
        let humidityReceived = feedbackManager.humidityReceived
        

        var image = BluetoothModel.GeneralPlantState.image
        var instruction = BluetoothModel.GeneralPlantState.instruction
       // var flag = BluetoothModel.fl
        
       // if flag == 0 {
        //    Text("O texto está sendo exibido.")
          //         }
        //else {
            //           Text("O texto está oculto.")
              //     }
       // while( nao estiver atualizando)
        // guard feedback = ultima atual
           //  image e istrucao
              // mandar para o card
        // guard feedback = atuliza atual
            // image e istrucao
                // mandar para o card
        // ... acesse outras variáveis conforme necessário ...
    }
}


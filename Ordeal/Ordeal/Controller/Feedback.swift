//
//  Feedback.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 13/11/23.
//

import Foundation
import SwiftUI

func checkPlantStateHumidity (umidadeEspecie: Int, umidadeRecebida: Int) -> String{
    
    if (umidadeRecebida >= umidadeEspecie-10 && umidadeRecebida <= umidadeEspecie+10) {
        return "checkmark.circle"
    }else{
        return "exclamationmark.triangle"
    }
}

func checkPlantStateHumidityColor (umidadeEspecie: Int, umidadeRecebida: Int) -> String{
    
    if (umidadeRecebida >= umidadeEspecie-10 && umidadeRecebida <= umidadeEspecie+10) {
        return "principalColor"
    }else{
        return "secondaryColor"
    }
}


func checkPlantStateNPK (nitrogenioRecebido: Int, fosforoRecebido: Int, potassioRecebido: Int) -> String{
    
    if (nitrogenioRecebido >= 10 && nitrogenioRecebido <= 50 && fosforoRecebido >= 1 && fosforoRecebido <= 10 && potassioRecebido >= 10 && potassioRecebido <= 35) {
        return "checkmark.circle"
    }else if (nitrogenioRecebido >= 10 && nitrogenioRecebido <= 50 && fosforoRecebido >= 1 && fosforoRecebido <= 10) {
        return "checkmark.circle"
    }else if (nitrogenioRecebido >= 10 && nitrogenioRecebido <= 50 && potassioRecebido >= 10 && potassioRecebido <= 35) {
        return "checkmark.circle"
    }else{
        return "exclamationmark.triangle"
    }
}

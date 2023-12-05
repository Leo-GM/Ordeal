//
//  PlantaIndividualView.swift
//  Ordeal
//
//  Created by Caio Lopes on 30/11/23.
//

import SwiftUI

struct PlantaIndividualView: View {
    var planta: IdentifiablePlantas
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Nome: \(planta.nome)")
            Text("Espécie: \(planta.especie)")
        }
        .navigationTitle(planta.nome)
    }
}

//#Preview {
//    @State var planta = IdentifiablePlantas(nome: "Sarambaia", especie: "Não lembro")
//    
//    PlantaIndividualView(planta: planta)
//}

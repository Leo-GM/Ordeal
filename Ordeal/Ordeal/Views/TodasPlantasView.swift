//
//  TodasPlantasView.swift
//  Ordeal
//
//  Created by Caio Lopes on 30/11/23.
//

import SwiftUI

struct TodasPlantasView: View {
    
    @State private var termoPesquisa = ""
    @ObservedObject var plantaData = Plantas()
    @State var selection: UUID?
    
    var body: some View {
            List{
                VStack(spacing: 16){
                    
                    //TextField
                    Section{
                        HStack{
                            Image(systemName: "magnifyingglass")
                            TextField("Digite o nome da planta", text: $termoPesquisa)
                        }//.HStack
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }//.Section
                    
                    //Lista de Plantas existentes
                    Section{
                        ForEach(plantaData.filtrarPlantas(por: termoPesquisa)) { planta in
                            ZStack {
                                PlantaCard(title: planta.nome, especie: planta.especie)
                                NavigationLink(destination: PlantaIndividualView(planta: planta), tag: planta.id, selection: $selection) {
                                    EmptyView()
                                }
                            }
//                            NavigationLink(destination: PlantaIndividualView(planta: planta),
//                                           tag: planta.id, selection: $selection) {
//                                Text(planta.nome)
//                                // Exiba as informações da planta
//                                //PlantaCard(title: planta.nome, especie: planta.especie)
                            //}//.NavigationLink
                            .listRowSeparator(.visible, edges: .bottom)
                        }
                        .onDelete(perform: plantaData.apagarPlanta)
                    }//.Section
                
                }//.VStack
            }//.List
            .listStyle(.plain)
            .navigationTitle("Todas as Plantas")
        
    }
}


#Preview {
    TodasPlantasView()
}

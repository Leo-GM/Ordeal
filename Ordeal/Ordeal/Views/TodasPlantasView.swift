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
    @EnvironmentObject var router: Router
    
    @State private var selectedPlanta: IdentifiablePlantas? = nil
    
    
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

                            PlantaCard(title: planta.nome, especie: planta.especie)
                                .onTapGesture {
                                    selectedPlanta = planta
                                }
                            
                            //                            NavigationLink(
//                                destination: PlantaCard(title: planta.nome, especie: planta.especie),
//                                label: {
//                                    PlantaCard(title: planta.nome, especie: planta.especie)
//                                }
//                            )//.NavigationLink
                            
                            
                            .listRowSeparator(.visible, edges: .bottom)
                        }

                        .onDelete(perform: plantaData.apagarPlanta)
                    }//.Section
                    
                }//.VStack
            }//.List
            .listStyle(.plain)
            .navigationTitle("Todas as Plantas")

            .background(
                NavigationLink(
                    destination: PlantaCard(title: selectedPlanta?.nome ?? "", especie: selectedPlanta?.especie ?? ""),
                    isActive: Binding(
                        get: { selectedPlanta != nil },
                        set: { isActive in
                            if !isActive {
                                selectedPlanta = nil
                            }
                        }
                    ),
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
                )
        
//            .navigationDestination(for: IdentifiablePlantas.self){ planta in
//                    PlantaCard(title: planta.nome, especie: planta.especie)
//            }
          
        
    }
    
}


#Preview {
    TodasPlantasView()
}

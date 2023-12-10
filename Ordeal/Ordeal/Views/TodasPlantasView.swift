//
//  TodasPlantasView.swift
//  Ordeal
//
//  Created by Caio Lopes on 30/11/23.
//

import SwiftUI

struct TodasPlantasView: View {
    
    @State private var termoPesquisa = ""
    @EnvironmentObject var router: Router
    @ObservedObject var plantaData: Plantas
    
    
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
                            NavigationLink(destination: PlantaIndividualView(planta: planta)) {
                                // Exiba as informações da planta
                                PlantaCard(title: planta.nome, especie: planta.especie)
                            }//.NavigationLink
                            
                        }
                        .onDelete(perform: plantaData.apagarPlanta)
                    }//.Section
                    
                }//.VStack
            }//.List
            .navigationTitle("Todas as Plantas")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                        Button(action: {
                router.reset()
                        }) {
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                }
            )
            
        
    }
    
}

//
//#Preview {
//    TodasPlantasView()
//}

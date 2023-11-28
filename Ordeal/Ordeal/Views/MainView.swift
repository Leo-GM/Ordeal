//
//  MainView.swift
//  Ordeal
//
//  Created by Caio Lopes on 13/11/23.
//

import SwiftUI

struct MainView: View {

    @State private var showingSheet = false
    var especies = ["Não sei", "Orégano", "Samambaia", "Cacto"]
    @State private var especie = "Não sei"
    @State private var navigaterToNext = false
    
    var body: some View {
        NavigationView{
                VStack(alignment: .leading, spacing: 16){
                    
                    NavigationLink(destination: Text("Tela de todas as plantas"), label: {
                        LastMeasurementCard(title: "Todas as plantas", illustration: "todasPlantas")
                            .shadow(radius: 2.5)
                            .background(Color(red: 255, green: 255, blue: 255))
                    })
                    
                    NavigationLink(destination: Text("Tela de última medicao"), label: {
                        LastMeasurementCard(title: "Ultima medição", illustration: "ultimaMedicao")
                            .shadow(radius: 2.5)
                            .background(Color(red: 255, green: 255, blue: 255))
                    })
                    
                    HStack(alignment: .top){
                        

                        Button(action: {
                            showingSheet.toggle()
                                }) {
                                    Card(title: "Nova medição", illustration: "novaMedicao")
                                        .shadow(radius: 2.5)
                                } .sheet(isPresented: $showingSheet) {
                                    responderSheet                                }
                        
                        
                        NavigationLink(destination: CarregamentoView(), isActive: $navigaterToNext) {
                            
                        }
                        Spacer()
                        
                        NavigationLink(destination: Text("Tela para cadastrar plantas"), label: {
                            Card(title: "Cadastrar planta", illustration: "cadastrarPlanta")
                                .shadow(radius: 2.5)
                                .background(Color(red: 255, green: 255, blue: 255))
                        })
                        
                    }
                    Spacer()
                    
                }
                .padding(16)
                .padding(.top, 16)
                .navigationBarTitle("Meu Jardim")
                .background(Color(red: 242, green: 242, blue: 247))
        }

        
    }
    var responderSheet: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                   
                    showingSheet = false
                            
                }) {
                    Text("Cancel")
                        .padding(.top, 10)
                        .foregroundColor(.blue)
                }
               
                Spacer()
                    
                Text("Selecione a espécie")
                    .padding(.top, 10)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    navigaterToNext = true
                    showingSheet = false
                            
                }) {
                    Text("Medir")
                        .padding(.top, 10)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
            Spacer()
            }
            

            Spacer()

            VStack {
                List{
                    HStack{
                        
                        Spacer()
                        
                        Picker("Espécie", selection: $especie) {
                            ForEach(especies, id: \.self) {
                                Text($0)
                            }
                        }.presentationDetents([.height(UIScreen.main.bounds.height / 4)])
                        Spacer()
                    }
                }
                
            }
        
            Spacer()
        }
    }
}


#Preview {
    MainView()
}

//
//  MainView.swift
//  Ordeal
//
//  Created by Caio Lopes on 13/11/23.
//

import SwiftUI

//enum AppViews: String {
//    case
//}

struct MainView: View {
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    @EnvironmentObject var router: Router
    @ObservedObject var plantaData = Plantas()
    
    var especies = ["Não sei", "Orégano", "Samambaia", "Cacto"]
    @State var especie = "Não sei"
    @State private var navigaterToNext = false
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @State var nome = "Joaquim"
    @EnvironmentObject var lastFeedback: LastFeedback
    
    
    
    var body: some View {
        NavigationStack(path: $router.path){
            
            VStack(alignment: .leading, spacing: 16){
                
                NavigationLink(value: "TodasPlantas"){
                    GardenCard(title: "Todas as plantas", illustration: "garden")
                }
                
                
                NavigationLink(value: "UltimaMedicao"){
                    LastMeasurementCard(title: "Ultima medição", illustration: "ultimaMedicao")
                }
                
                HStack(alignment: .top){
                    Button(action: {
                        if !bluetoothViewModel.isHC08Connected {
                            showingAlert = true
                        }else{
                            showingSheet.toggle()
                        }
                        
                        
                        
                    }) {
                        Card(title: "Nova medição", illustration: "novaMedicao")
                        
                    } .sheet(isPresented: $showingSheet) {
                        responderSheet
                    }
                    
                    
                    Spacer()
                    
                    NavigationLink(value: "CadastrarPlantas"){
                        Card(title: "Cadastrar planta", illustration: "cadastrarPlanta")
                    }
                    
                    
                }
                Spacer()
                
            }
            .padding(16)
            .padding(.top, 16)
            .navigationBarTitle("Meu Jardim")
            .background(Color(UIColor.systemGray6))
            
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Alerta"),
                    message: Text("O Bluetooth não está conectado ao dispositivo HC-08."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            .navigationDestination(for: String.self){ value in
                switch value{
                case "TodasPlantas":
                    TodasPlantasView(plantaData: plantaData)
                case "UltimaMedicao":
                    LastFeedbackView(especieFeedback: lastFeedback.especie, nomeFeedback: lastFeedback.nomePlanta, humidityReceived: lastFeedback.humidityReceived)
                case "CadastrarPlantas":
                    Text("Tela para cadastrar plantas")
                case "Carregamento":
                    CarregamentoView(especieCarregamento: especie, nomeCarregamento: nome)
                case "Feedback":
                    FeedbackView(especieFeedback: especie,nomeFeedback: nome)
                default:
                    Text("ERRO")
                }
            }
        }            .navigationBarBackButtonHidden(true)
            .onAppear{
                bluetoothViewModel.flag = 1
            }
        
        
        
        
        
        
    }

    var responderSheet: some View {
        
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    
                    showingSheet = false
                    
                }) {
                    Text("Cancelar")
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
                    router.navigateTo("Carregamento")
                    
                    
                    bluetoothViewModel.flag = 0
                    
                    
                    
                    
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


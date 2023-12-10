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
    @State private var showingSheetRegister = false
    @State private var showingAlert = false
    @EnvironmentObject var router: Router
    @EnvironmentObject var plantaData: Plantas
    @State private var nomePlantaCadastro: String = ""

    
    var especies = ["Espécie desconhecida", "Orégano", "Samambaia", "Cacto"]
    @State var especie = "Espécie desconhecida"
    @State private var navigaterToNext = false
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @State var nome = "Plantinha sem nome"
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
                    
                    Button(action: {
                            showingSheetRegister.toggle()
     
                    }) {
                        Card(title: "Cadastrar planta", illustration: "cadastrarPlanta")
                    } .sheet(isPresented: $showingSheetRegister) {
                        responderSheetRegister
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
                    TodasPlantasView()
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
                        .foregroundColor(Color("principalColor"))
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
                        .foregroundColor(Color("principalColor"))
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
        }            .background(Color(UIColor.systemGray6))

    }
    
    var responderSheetRegister: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    
                    showingSheetRegister = false
                    
                }) {
                    Text("Cancelar")
                        .padding(.top, 10)
                        .foregroundColor(Color("principalColor"))
                }
                
                Spacer()
                
                Text("Selecione a espécie")
                    .padding(.top, 10)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    showingSheetRegister = false
                    plantaData.adicionarPlanta(nome: nomePlantaCadastro, especie: especie)
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    nomePlantaCadastro = ""
   
                }) {
                    Text("Cadastrar")
                        .padding(.top, 10)
                        .foregroundColor(Color("principalColor"))
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
                    HStack{
                        Spacer()
                        TextField("Digite o nome da planta aqui...", text: $nomePlantaCadastro)
                            .onTapGesture {
                                hideKeyboard()
                            }
                            .onSubmit {
                                hideKeyboard()
                            }
                        Spacer()
                    }
                }
                Spacer()
            }
            
            Spacer()
        }            .background(Color(UIColor.systemGray6))

    }
    func hideKeyboard() {
           // Código para esconder o teclado
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }
   
}


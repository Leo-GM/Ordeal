//
//  MainView.swift
//  Ordeal
//
//  Created by Caio Lopes on 13/11/23.
//

import SwiftUI


struct MainView: View {
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    
    var especies = ["Não sei", "Orégano", "Samambaia", "Cacto"]
    @State var especie = "Não sei"
    @State private var navigaterToNext = false
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @State var nome = "Joaquim"
    
    
    
    
    
    var body: some View {
        NavigationView{
                VStack(alignment: .leading, spacing: 16){
                    
                    NavigationLink(destination: TodasPlantasView(), label: {
                        GardenCard(title: "Todas as plantas", illustration: "garden")
                            .shadow(radius: 2.5)
                    })
                    
                    NavigationLink(destination: Text("Tela de última medicao"), label: {
                        LastMeasurementCard(title: "Ultima medição", illustration: "ultimaMedicao")
                            .shadow(radius: 2.5)
                        
                    })
                
                HStack(alignment: .top){
                    
                    
                    Button(action: {
                        if !bluetoothViewModel.isHC08Connected {
                            showingAlert = true
                        }else{
                            showingSheet.toggle()
                        }

                        
                        
                    }) {
                        Card(title: "Nova medição", illustration: "novaMedicao")
                            .shadow(radius: 2.5)
                            
                    } .sheet(isPresented: $showingSheet) {
                        responderSheet                        
                    }
                    
                    
                    NavigationLink(destination: CarregamentoView(especieCarregamento: especie, nomeCarregamento: nome), isActive: $navigaterToNext) {
                        
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
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Alerta"),
                    message: Text("O Bluetooth não está conectado ao dispositivo HC-08."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }            .navigationBarBackButtonHidden(true)

        
        
        
        
        
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


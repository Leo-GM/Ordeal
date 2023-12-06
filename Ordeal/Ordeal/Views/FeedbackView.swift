//
//  FeedbackView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 09/11/23.
//

import Foundation

class FeedbackManager: ObservableObject {
    @Published var idealHumiditySpecie = 50
    @Published var especieFeedback: String = ""
    @Published var nomeFeedback: String = ""
    
    // Propriedades para status geral
    @Published var overallStatusImage: String = ""
    @Published var overallStatusInstruction: String = ""
        
    /* Propriedades para status de umidade
    @Published var humidityStatusImage: String = ""
    @Published var humidityStatusColor: String = ""
        
    // Propriedades para status de nutrientes
    @Published var nutrientsStatusImage: String = ""
    @Published var nutrientsStatusColor: String = ""
        
    // Propriedades específicas para cada nutriente
    @Published var nitrogenStatus: String = ""
    @Published var phosphorusStatus: String = ""
    @Published var potassiumStatus: String = ""
     */
    // Propriedades específicas para cada nutriente
    
    @Published var nitrogenReceived: Int = 0
    @Published var phosphorusReceived: Int = 0
    @Published var potassiumReceived: Int = 0
    @Published var humidityReceived: Int = 0
     
    func adicionarFeedback(_ feedback: String) {
        // implemente conforme necessário
    }
}

import SwiftUI

struct FeedbackView: View {
    @StateObject var feedbackManager = FeedbackManager() // Criando a instância do FeedbackManager
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    
    @State var idealHumiditySpecie = 50 //we are going to receive this value from the view before this one
    @State var especieFeedback:String
    @State var nomeFeedback:String
    
    var nitrogenReceived = 0 //we are going to receive this value from the view before this one
    var phosphoroReceived = 0 //we are going to receive this value from the view before this one
    var potassiumReceived = 0 //we are going to receive this value from the view before this one
    
    
    var body: some View {
        
        lazy var humidityReceived = bluetoothViewModel.IntValueReceived
        
        
        VStack {
            NavigationLink(destination: MainView()) {
                HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .offset(y: -25) // Ajusta a posição verticalmente

                            .frame(width: 22, height: 22) // Define um tamanho fixo, opcional
                        
                        Text("Tela Principal")
                            .offset(y: -25) // Ajusta a posição verticalmente
                            .padding(.leading, -5) // Ajusta o espaçamento à esquerda
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Alinha à esquerda
                    .padding(.leading, 16) // Adiciona um espaçamento à esquerda
            }
        }
        List {
            
            let humidityStatus = bluetoothViewModel.checkHumidityPlantState(specieHumidity: idealHumiditySpecie, humidityReceived: humidityReceived)
            let nutrientsStatus = bluetoothViewModel.checkNPKPlantState(nitrogenReceived: nitrogenReceived, phosphorReceived: phosphoroReceived, potassiumReceived: potassiumReceived)
            let overallStatus = bluetoothViewModel.checkOveralStatus(humidyStatus: humidityStatus, nutrientsStatus: nutrientsStatus)
            let nitrogenStatus = bluetoothViewModel.checkNitrogenPlantState(nitrogenReceived: nitrogenReceived)
            let phosphoroStatus = bluetoothViewModel.checkPhosphoroPlantState(phosphoroReceived: phosphoroReceived)
            let potassiumStatus = bluetoothViewModel.checkPotassiumPlantState(potassiumReceived: potassiumReceived)
            
            
            Section (){
                HStack{
                    VStack(alignment: .leading){
                        Text("\(nomeFeedback)") //we are going to receive this value from the view before this one
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("principalColor"))
                            .padding(.top, 8)
                            .fontDesign(.rounded)
                        
                        Text("\(especieFeedback)") //we are going to receive this value from the view before this one
                            .font(.caption)
                            .foregroundColor(Color("BodyColor"))
                            .padding(.bottom, 24)
                        
                        HStack{
                            Text("Umidade")
                                .font(.system(size: 17))
                                .fontDesign(.rounded)
                                .foregroundColor(Color("BodyColor"))
                                .padding(.trailing, 30)
                            
                            Spacer()
                            
                            Image(systemName: humidityStatus.image())
                                .padding(.trailing, 15)
                                .foregroundColor(Color(humidityStatus.color()) )
                            
                        }.padding(.bottom, 2)
                           
                        
                        Spacer()
                        
                        HStack{
                            Text("Nutrientes")
                                .font(.body)
                                .fontDesign(.rounded)
                                .foregroundColor(Color("BodyColor"))
                                .padding(.trailing, 30)
                            
                            Spacer()
                            
                            
                            Image(systemName: nutrientsStatus.image())
                                .padding(.trailing, 15)
                                .foregroundColor(Color(nutrientsStatus.color()) )
                            
                        }
                        Spacer()
                    }
                    Spacer()
                    
                    VStack{
                        
                        
                        ZStack{
                            Image("feedbackFundoCard")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 135, height: 120)
                            
                            Image(overallStatus.image())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 59, height: 105)
                        }
                    }
                }
            }
            
            Section(header:
                        Text("Instrução")
                .fontDesign(.rounded)
            ){
                
                Text(overallStatus.instruction())
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color("BodyColor"))
                    .fontDesign(.rounded)
                
                
            }
            
            Section(header:
                        Text("Valores da medição")
                .fontDesign(.rounded)
            ){
                
                Grid (alignment: .center, horizontalSpacing: 0, verticalSpacing: 16){
                    
                    GridRow {
                        Text("")
                        
                        Text("")
                        Spacer()
                        
                        Text("Ideal")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(Color("BodyColor"))
                            .fontDesign(.rounded)
                        
                        Spacer()
                        
                        Text("Atual")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(Color("BodyColor"))
                            .fontDesign(.rounded)
                        
                    }
                    
                    // Humidity Line
                    GridRow {
                        
                        LineTableFeedback(icon: humidityStatus.downimage(), iconColor: humidityStatus.color(), idealValue: idealHumiditySpecie, valueReceived: humidityReceived, lineTitle: "Umidade\n     (%)")
                    }
                    
                    // Nitrogen Line
                    GridRow {
                        LineTableFeedback(icon: nitrogenStatus.image(), iconColor: nitrogenStatus.color(), idealValue: 30, valueReceived: nitrogenReceived, lineTitle: "Nitrogênio\n(mmg/kg)")
                        
                    }
                    
                    // Phosphoro Line
                    GridRow {
                        LineTableFeedback(icon: phosphoroStatus.image(), iconColor: phosphoroStatus.color(), idealValue: 5, valueReceived: phosphoroReceived, lineTitle: "Fósforo\n(mmg/kg)")
                        
                        
                    }
                    
                    // Potassium Line
                    GridRow {
                        LineTableFeedback(icon: potassiumStatus.image(), iconColor: potassiumStatus.color(), idealValue: 25, valueReceived: potassiumReceived, lineTitle: "Potássio\n(mmg/kg)")
                        
                    }
                    
                    
                }
            }
            .padding(.top, 8)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Resultado")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                }
            }
        }.onAppear{
            // Configurando o FeedbackManager
            feedbackManager.especieFeedback = especieFeedback
            feedbackManager.nomeFeedback = nomeFeedback
            feedbackManager.humidityReceived = humidityReceived
            if especieFeedback == "Samambaia" {
                idealHumiditySpecie = 60
            } else if especieFeedback == "Cacto" {
                idealHumiditySpecie = 30
            } else {
                idealHumiditySpecie = 50
            }

            feedbackManager.idealHumiditySpecie = idealHumiditySpecie // Pega a umidade de acordo com a especie
        }
        .environmentObject(feedbackManager) // Tornando a instância do FeedbackManager acessível globalmente
    }
    
}


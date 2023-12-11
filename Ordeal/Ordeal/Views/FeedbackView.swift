//
//  FeedbackView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 09/11/23.
//

import Foundation

import SwiftUI

struct FeedbackView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @EnvironmentObject var lastfeedback: LastFeedback
    
    @State var idealHumiditySpecie = 50 //we are going to receive this value from the view before this one
    @State var especieFeedback:String
    @State var nomeFeedback:String
    @EnvironmentObject var router: Router
    
    var nitrogenReceived = 0 //we are going to receive this value from the view before this one
    var phosphoroReceived = 0 //we are going to receive this value from the view before this one
    var potassiumReceived = 0 //we are going to receive this value from the view before this one
    
    
    var body: some View {
        
        lazy var humidityReceived = bluetoothViewModel.IntValueReceived
        
        List {
            
            let humidityStatus = bluetoothViewModel.checkHumidityPlantState(specieHumidity: idealHumiditySpecie, humidityReceived: humidityReceived)
            let nutrientsStatus = bluetoothViewModel.checkNPKPlantState(nitrogenReceived: nitrogenReceived, phosphorReceived: phosphoroReceived, potassiumReceived: potassiumReceived)
            let overallStatus = bluetoothViewModel.checkOveralStatus(humidyStatus: humidityStatus, nutrientsStatus: nutrientsStatus)
            let nitrogenStatus = bluetoothViewModel.checkNitrogenPlantState(nitrogenReceived: nitrogenReceived)
            let phosphoroStatus = bluetoothViewModel.checkPhosphoroPlantState(phosphoroReceived: phosphoroReceived)
            let potassiumStatus = bluetoothViewModel.checkPotassiumPlantState(potassiumReceived: potassiumReceived)
            
            
            Section(){
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
                                .font(.body)
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
                        Text("Valores da Medição")
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
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Resultado")
                        .fontWeight(.semibold)
                        .font(.body)
                }
            }
            
            
        }.onAppear{
            if especieFeedback == "Samambaia" {
                idealHumiditySpecie = 60
            } else if especieFeedback == "Cacto" {
                idealHumiditySpecie = 30
            } else {
                idealHumiditySpecie = 50
            }
                        
            lastfeedback.updateValues(image: bluetoothViewModel.checkHumidityPlantState(specieHumidity: idealHumiditySpecie, humidityReceived: idealHumiditySpecie).image(), instruction: bluetoothViewModel.checkHumidityPlantState(specieHumidity: idealHumiditySpecie, humidityReceived: humidityReceived).instruction(), especie: especieFeedback, nomePlanta: nomeFeedback, humidityReceived: humidityReceived )
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                    Button(action: {
            router.reset()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.body)
                        Text("Meu Jardim")
                            .font(.body)
            }
        )
    }
}

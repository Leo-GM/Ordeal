//
//  LastFeedback.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 07/12/23.
//

import SwiftUI


import SwiftUI

struct LastFeedbackView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @EnvironmentObject var lastfeedback: LastFeedback
    
    @State var idealHumiditySpecie = 50 //we are going to receive this value from the view before this one
    @State var especieFeedback:String
    @State var nomeFeedback:String
    @State var humidityReceived: Int
    
    var nitrogenReceived = 0 //we are going to receive this value from the view before this one
    var phosphoroReceived = 0 //we are going to receive this value from the view before this one
    var potassiumReceived = 0 //we are going to receive this value from the view before this one
    
    
    var body: some View {
        
        if(humidityReceived == 653){
            VStack{
                Spacer()
                Section(){
                    VStack{
                        HStack{
                            Spacer()
                            Text("Ausência de medições")
                                .font(.title2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        Divider()
                            .padding(.horizontal, 8)
                        Text("Adorariamos ajudar você a cuidar da suas plantinhas, faça sua primeira medição na tela 'Meu jardim' em 'Nova medição'")
                            .font(.body)
                            .foregroundColor(Color("BodyColor"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(uiColor: .white))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }.padding(.horizontal, 16)
                Spacer()
            }.background(Color(UIColor.systemGray6))
        }else{
            List {
                
                let humidityStatus = bluetoothViewModel.checkHumidityPlantState(specieHumidity: idealHumiditySpecie, humidityReceived: humidityReceived)
                let nutrientsStatus = bluetoothViewModel.checkNPKPlantState(nitrogenReceived: nitrogenReceived, phosphorReceived: phosphoroReceived, potassiumReceived: potassiumReceived)
                let overallStatus = bluetoothViewModel.checkOveralStatus(humidyStatus: humidityStatus, nutrientsStatus: nutrientsStatus)
                let nitrogenStatus = bluetoothViewModel.checkNitrogenPlantState(nitrogenReceived: nitrogenReceived)
                let phosphoroStatus = bluetoothViewModel.checkPhosphoroPlantState(phosphoroReceived: phosphoroReceived)
                let potassiumStatus = bluetoothViewModel.checkPotassiumPlantState(potassiumReceived: potassiumReceived)
                
                
                //            instructionCardLastFeedback = overallStatus.instruction()
                //            imageCardLastFeedback = humidityStatus.image()
                
                
                
                
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
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Text("Resultado")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
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
                
                
                
                
            }
        }
    }
    
}

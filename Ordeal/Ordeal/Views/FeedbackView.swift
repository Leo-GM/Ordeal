//
//  FeedbackView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 09/11/23.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothModel()
    var umidadeIdealEspecie = 50 //we are going to receive this value from the view before this one
    
    var body: some View {
        NavigationView{
            List {
                
                let humidityStatus = bluetoothViewModel.checkHumidityPlantState(specieHumidity: 50, humidityReceived: 50)
                let nutrientsStatus = bluetoothViewModel.checkNPKPlantState(nitrogenReceived: 0, phosphorReceived: 1, potassiumReceived: 30)
                
                Section (){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Nome da Planta") //we are going to receive this value from the view before this one
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("principalColor"))
                                .padding(.top, 8)
                                .fontDesign(.rounded)
                            
                            Text("Espécie da Planta") //we are going to receive this value from the view before this one
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .padding(.bottom, 24)
                            
                            //Spacer()
                            
                            HStack{
                                Text("Umidade")
                                    .font(.system(size: 17))
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color.black)
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
                                    .foregroundColor(Color.black)
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
                            
                            
                            let overallStatus = bluetoothViewModel.checkOveralStatus(humidyStatus: humidityStatus, nutrientsStatus: nutrientsStatus)
                            
                            ZStack{
                                Image("feedbackFundoCard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 135, height: 120)
                                    .shadow(radius: 2)
                                
                                Image(overallStatus.image())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 59, height: 105)
                                    .shadow(radius: 2)
                            }
                        }
                    }
                }
                
                Section(){
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text("Instrução")
                                .font(.headline)
                                .foregroundColor(Color("principalColor"))
                                .padding(.bottom, 8)

                            
                            Text("Sua planta está seca e com baixa concentração de nutriente, considere regar sua planta mais frequentemente e adicionar fertilizantes baseados em Nitrogênio, Potássio e Fósforo (NPK).")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .fontDesign(.rounded)
                            
                            Divider()
                            
                            Grid (alignment: .center, horizontalSpacing: 0, verticalSpacing: 24){
                                GridRow {
                                    Text("")
                                    
                                    Text("")
                                    Spacer()
                                    
                                    Text("Ideal")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                    
                                    Spacer()
                                    
                                    Text("Atual")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                    
                                }

                                GridRow {
                                    Image(systemName: nutrientsStatus.image())
                                        .foregroundColor(Color(nutrientsStatus.color()) )
                                        .font(.body)
                                       
                                    
                                    Text("Umidade (%)")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                    
                                    Spacer()
                                    
                                    Text("40")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                    
                                    Spacer()
                                    
                                    Text("43")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                    
                                }

                                GridRow {
                                    
                                    Image(systemName: nutrientsStatus.image())
                                        .foregroundColor(Color(nutrientsStatus.color()) )
                                        .font(.body)
                                    
                                    
                                    Text("NPK (mmg/kg)")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                        .padding(.leading, 14)

                                    
                                    Spacer()
                                    
                                    Text("230")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                    
                                    Spacer()
                                    
                                    Text("231")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                }
                            }.padding(.top, 16)
                            
                            
                        }
                        
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Text("Resultado")
                            .fontWeight(.bold)
                            .font(.system(size: 17))
                            .fontDesign(.rounded)
                            .foregroundStyle(Color("principalColor"))
                    }
                }
                
            }
        }
    }
}

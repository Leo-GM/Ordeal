//
//  FeedbackView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 09/11/23.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothModel()
    var umidadeIdealEspecie = 50 //vamos receber esse valor da view responsável por selecionar a espécie para medição
    
    var body: some View {
        NavigationView{
            List {
                
                let humidityStatus = bluetoothViewModel.checkHumidityPlantState(specieHumidity: 50, humidityReceived: 50)
                let nutrientsStatus = bluetoothViewModel.checkNPKPlantState(nitrogenReceived: 0, phosphorReceived: 1, potassiumReceived: 30)
                
                Section{
                    HStack{
                        VStack(alignment: .leading
                               
                        ){
                            Text("Nome da Planta") //Nome da planta será recebido da view anterior que me fornecerá esse valor
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color("principalColor"))
                                .padding(.top, 8)
                                .fontDesign(.rounded)
                            
                            Text("Espécie da Planta") //Especie será recebido da view anterior que me fornecerá esse valor
                                .font(.system(size: 12))
                                .foregroundColor(Color.black)
                            
                            
                            Spacer()
                            HStack{
                                Text("Umidade")
                                    .font(.system(size: 17))
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 30)
                                
                                Spacer()
                                
                                Image(systemName: humidityStatus.image())
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color(humidityStatus.color()) )//Esses valores serão recebidos do arduino
    
                            }
                            
                            Spacer()
                            
                            HStack{
                                Text("Nutrientes")
                                    .font(.system(size: 17))
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 30)
                                
                                Spacer()
                                
                                
                                Image(systemName: nutrientsStatus.image())
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color(nutrientsStatus.color()) )//Esses valores serão recebidos do arduino
                                
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

#Preview {
    FeedbackView()
}

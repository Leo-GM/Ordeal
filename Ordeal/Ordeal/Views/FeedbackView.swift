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
    var umidadebom = 0
    var npkbom = 1
    
    var body: some View {
        NavigationView{
            List {
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
                                
                                Image(systemName: bluetoothViewModel.checkPlantStateHumidity(specieHumidity: umidadeIdealEspecie, humidityReceived: 59)) //This values are going to be received from arduino
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color(bluetoothViewModel.checkPlantStateHumidityColor(specieHumidity: umidadeIdealEspecie, humidityReceived: 61))) //This values are going to be received from arduino
                                
                            }
                            
                            Spacer()
                            
                            HStack{
                                Text("Nutrientes")
                                    .font(.system(size: 17))
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 30)
                                
                                Spacer()
                                
                                Image(systemName: bluetoothViewModel.checkPlantStateNPK(nitrogenReceived: 0, phosphorReceived: 1, potassiumReceived: 10)) //Esses valores serão recebidos do arduino
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color(bluetoothViewModel.checkPlantStateNPKColor(nitrogenReceived: 0, phosphorReceived: 1, potassiumReceived: 10))) //Esses valores serão recebidos do arduino
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
                                    .shadow(radius: 2)
                                
                                Image("")
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

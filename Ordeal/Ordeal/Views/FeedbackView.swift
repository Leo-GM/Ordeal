//
//  FeedbackView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 09/11/23.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject private var bluetoothViewModel = ViewController()
    var umidadeIdealEspecie = 50
    
    var body: some View {
        NavigationView{
            List {
                
                Section{
                    HStack{
                        VStack(alignment: .leading
                               
                        ){
                            Text("Nome da Planta")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color("principalColor"))
                                .padding(.top, 8)
                                .fontDesign(.rounded)
                            
                            Text("Espécie da Planta")
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
                                
                                Image(systemName: checkPlantStateHumidity(umidadeEspecie: umidadeIdealEspecie, umidadeRecebida: 61))
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color(checkPlantStateHumidityColor(umidadeEspecie: umidadeIdealEspecie, umidadeRecebida: 61)))
                                
                            }
                            
                            
                            
                            
                            Spacer()
                            
                            HStack{
                                Text("Nutrientes")
                                    .font(.system(size: 17))
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 30)
                                
                                Spacer()
                                Image(systemName: checkPlantStateNPK(nitrogenioRecebido: <#T##Int#>, fosforoRecebido: <#T##Int#>, potassioRecebido: <#T##Int#>))
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color("principalColor"))
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
                                
                                Image("feedbackPlantaFelizCard")
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

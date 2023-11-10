//
//  HomeView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 09/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            List {
                
                Section{
                    HStack{
                        VStack(alignment: .leading
                               
                        ){
                            Text("Nome da Planta")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.top, 8)
                            
                            
                            Text("Espécie da Planta")
                                .font(.system(size: 10))
                                .foregroundColor(Color.black)
                            
                            
                            Spacer()
                            HStack{
                                Text("Umidade")
                                    .font(.system(size: 11))
                                
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 30)
                                
                                Spacer()
                                Image(systemName: "checkmark.seal")
                                    .padding(.trailing, 15)
                            }
                            
                            
                            
                            
                            Spacer()
                            
                            HStack{
                                Text("Nutrientes")
                                    .font(.system(size: 11))
                                
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 30)
                                
                                Spacer()
                                Image(systemName: "checkmark.seal")
                                    .padding(.trailing, 15)
                            }
                            
                            Spacer()
                        }
                        Spacer()
                        VStack{
                            
                            Image("plantaViva")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 134, height: 120)
                                .shadow(radius: 2)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Resultado")
                        .fontWeight(.bold)
                }
            }

        }
    }
}

#Preview {
    HomeView()
}

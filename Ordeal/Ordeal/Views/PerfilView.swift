//
//  PerfilView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 10/11/23.
//

import SwiftUI

struct PerfilView: View {
    @EnvironmentObject var routerProfile: Router
    
    var body: some View {
        NavigationStack(path: $routerProfile.path){
            VStack{
                Button(action: {
                    
                }) {
                    HStack{
            
                        ZStack{
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.accentColor)
                                .opacity(0.6)
                                
                        }
                        
                        VStack(alignment: .leading){
                            Text("Leonardo G")
                                .font(.title2)
                                .foregroundColor(Color("BodyColor"))
                                .fontWeight(.regular)
                                .fontDesign(.rounded)
                            Text("leonardoguimares@icloud.com")
                                .font(.footnote)
                                .foregroundColor(Color("BodyColor"))
                            
                        }.padding(.vertical, 16)
                        
                        Spacer()
                        
                    }.padding(.leading, 16)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                
                    
                
                HStack{
                    Text("Dados pessoais")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, 16)
                    Spacer()
                }.padding(.top, 40)
                
                Section(){
                    VStack{
                        Button(action: {
                            
                        }) {
                            HStack{
                                Text("Meus dados")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding(.leading, 16)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding(.trailing, 16)
                                    .foregroundColor(Color(UIColor.systemGray2))
                            }.padding(.top, 12)
                                .padding(.bottom, 8)
                        }
                            
                        
                       Divider()
                            .padding(.leading, 16)
                        Button(action: {
                            
                        }) {
                            HStack{
                                Text("Alterar senha")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding(.leading, 16)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding(.trailing, 16)
                                    .foregroundColor(Color(UIColor.systemGray2))
                            }.padding(.vertical, 8)
                        }
                            
                        
                       Divider()
                            .padding(.leading, 16)

                        Button(action: {
                            
                        }) {
                            HStack{
                                Text("Configurações")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding(.leading, 16)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding(.trailing, 16)
                                    .foregroundColor(Color(UIColor.systemGray2))
                            }.padding(.top, 8)
                                .padding(.bottom, 16)
                        }
                        }
                            
                        
                        
                    
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                  
                ZStack{
                    Section(){
                        HStack{
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Text("Finalizar Sessão")
                                    .font(.body)
                                    .foregroundColor(Color("FinalizarSessao"))
                                    .padding(12)
                            }
                            
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 16)
                }.padding(.top, 40)
                Spacer()
                
                
                
            }.navigationDestination(for: String.self){ value in
                switch value{
                case "Perfil":
                    Text("Tela para editar perfil")
                case "meusDados":
                    Text("Tela para ver meus dados")
                case "alterarSenha":
                    Text("Tela para alterar senha")
                case "configuracao":
                    Text("Tela para configuracao")
                default:
                    Text("ERRO")
                }
            }
            .navigationTitle("Perfil")
            .background(Color(UIColor.systemGray6))

        }
    }
}



 #Preview {
 PerfilView()
 }
 

//
//  MainView.swift
//  Ordeal
//
//  Created by Caio Lopes on 13/11/23.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        NavigationView{
                VStack(alignment: .leading, spacing: 16){
                    
                    NavigationLink(destination: Text("Tela de todas as plantas"), label: {
                        BigCard(title: "Todas as plantas", background: "", illustration: "todasPlantas")
                            .shadow(radius: 2.5)
                    })
                    
                    NavigationLink(destination: Text("Tela de última medicao"), label: {
                        BigCard(title: "Ultima medição", background: "", illustration: "ultimaMedicao")
                            .shadow(radius: 2.5)
                    })
                    
                    HStack(alignment: .top){
                        
                        NavigationLink(destination: FeedbackView(), label: {
                            Card(title: "Nova medição", background: "", illustration: "novaMedicao")
                                .shadow(radius: 2.5)
                        })
                        
                        Spacer()
                        
                        NavigationLink(destination: Text("Tela para cadastrar plantas"), label: {
                            Card(title: "Cadastrar planta", background: "", illustration: "cadastrarPlanta")
                                .shadow(radius: 2.5)
                        })
                        
                    }
                    Spacer()
                    
                }
                .padding(16)
                .padding(.top, 16)
                .navigationBarTitle("Meu Jardim")
        }
        
    }
}

#Preview {
    MainView()
}

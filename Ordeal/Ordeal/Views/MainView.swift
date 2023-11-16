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
                    
                    NavigationLink(destination: FeedbackView(), label: {
                        BigCard(title: "Todas as plantas", background: "", illustration: "")
                            .shadow(radius: 2.5)
                    })
                    
                    NavigationLink(destination: FeedbackView(), label: {
                        BigCard(title: "Ultima medição", background: "", illustration: "")
                            .shadow(radius: 2.5)
                    })
                    
                    HStack(alignment: .top){
                        
                        NavigationLink(destination: FeedbackView(), label: {
                            Card(title: "Nova medição", background: "BlueBackground", illustration: "PlantaComSensor")
                                .shadow(radius: 2.5)
                        })
                        
                        Spacer()
                        
                        NavigationLink(destination: FeedbackView(), label: {
                            Card(title: "Cadastrar planta", background: "", illustration: "")
                                .shadow(radius: 2.5)
                        })
                        
                    }
                    Spacer()
                    
                }
                .padding()
                .navigationBarTitle("Meu Jardim")
        }
        
    }
}

#Preview {
    MainView()
}

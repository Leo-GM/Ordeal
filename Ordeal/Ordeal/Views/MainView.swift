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
                VStack(alignment: .leading, spacing: 10){
                    HStack(alignment: .top){
                        NavigationLink(destination: FeedbackView(), label: {
                            Card(title: "Nova medição")
                                .shadow(radius: 8)
                        })
                        .accentColor(Color("principalColor"))
                        Spacer()
                    }
                    Spacer()
                }//.VStack
                .padding()
                .navigationBarTitle("Meu Jardim")
        }//.NavigationView
        
    }
}

#Preview {
    MainView()
}

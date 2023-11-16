//
//  Card.swift
//  Ordeal
//
//  Created by Caio Lopes on 14/11/23.
//

import SwiftUI

struct Card: View {
    @State var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .center){
                Image("BlueBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 175, height: 125)
                
                Image("PlantaComSensor")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
            cardText
                .padding(.horizontal, 8)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        
    }
    
    
    var cardText: some View {
        VStack{
            Text(title)
                .font(.headline)
                .fontDesign(.rounded)

            .padding(.bottom, 16)
            .padding(.leading, 8)
        }
    }
}

#Preview {
    Card(title: "Nova medição")
}

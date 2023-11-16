//
//  Card.swift
//  Ordeal
//
//  Created by Caio Lopes on 14/11/23.
//

import SwiftUI

struct Card: View {
    @State var title: String
    @State var background: String
    @State var illustration: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .center){
                Image(background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 173.5, height: 125)
                
                Image(illustration)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
            cardText
                .padding(.horizontal, 8)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
    
    
    var cardText: some View {
        VStack{
            Text(title)
                .font(.body)
                .foregroundColor(.black)
                .fontDesign(.rounded)

            .padding(.bottom, 16)
            .padding(.leading, 8)
        }
    }
}

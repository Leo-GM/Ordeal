//
//  GardenCard.swift
//  Ordeal
//
//  Created by Caio Zavarezzi balieiro on 27/11/23.
//

import SwiftUI

struct GardenCard: View {
    @State var title: String
    @State var illustration: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            VStack{
                Text("")
                    .font(.body)
                    .foregroundColor(Color("BodyColor"))
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
               
                HStack{
                    Spacer()
                    
                    Text("Você possui 5 plantas cadastradas")
                        .font(.body)
                        .foregroundColor(Color("BodyColor"))
                        .fontWeight(.regular)
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    Image(illustration)
                        .resizable()
                        .fixedSize()
                        
                    
                    Spacer()
                }
            }
            Divider()
            //.frame(width: 157.5)
                .padding(.trailing, 16)
                .padding(.leading, 16)
            cardText
                .padding(.horizontal, 16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
        
    }
    
    
    var cardText: some View {
        VStack{
            HStack{
                Spacer()
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                
                    .padding(.bottom, 16)
                Spacer()
            }
        }
    }
}


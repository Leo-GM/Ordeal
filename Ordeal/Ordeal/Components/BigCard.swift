//
//  BigCard.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 16/11/23.
//

import SwiftUI

struct BigCard: View {
    @State var title: String
    @State var illustration: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Image(illustration)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
            
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



//
//  Card.swift
//  Ordeal
//
//  Created by Caio Lopes on 14/11/23.
//

import SwiftUI

struct Card: View {
    @State var title: String
    @State var illustration: String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {

            Image(illustration)
                .resizable()
                .fixedSize()
                .frame(width: 175, height: 125)
 
            Divider()
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

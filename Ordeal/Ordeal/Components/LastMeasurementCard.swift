//
//  LastMeasurementCard.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 24/11/23.
//

import SwiftUI

struct LastMeasurementCard: View {
    @State var title: String
    @State var illustration: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            VStack{
                
                Text("Orquidea")
                    .font(.body)
                    .foregroundColor(Color("BodyColor"))
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
               
                HStack{
                    Spacer()
                    
                    Text("A planta está seca e com poucos nutrientes 􀇾")
                        .font(.body)
                        .foregroundColor(Color("BodyColor"))
                        .fontWeight(.regular)
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(illustration)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
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


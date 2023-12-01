//
//  PlantaCard.swift
//  Ordeal
//
//  Created by Caio Lopes on 30/11/23.
//

import SwiftUI

struct PlantaCard: View {
    @State var title: String
    @State var especie: String
    
    var body: some View {
        HStack{
            Image("feedbackFundoCard")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .scaledToFit()
            
            VStack(alignment:.leading){
                Text(title)
                    .font(.title2)
                Text(especie)
                    .font(.caption)
                    .italic()
            }
            Spacer()
            
            
//
//            Image(systemName: "chevron.right")
        }
        
    }
}

#Preview {
    PlantaCard(title: "Sarambaia", especie: "Nephrolepis exaltata")
    
}

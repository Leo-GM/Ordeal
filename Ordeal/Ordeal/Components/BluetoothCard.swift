//
//  BluetoothCard.swift
//  Ordeal
//
//  Created by Caio Lopes on 14/11/23.
//

import SwiftUI

struct BluetoothCard: View {
    var body: some View {
        HStack(spacing:10){
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color("principalColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("Bluetooth")
            Spacer()
            
        }
    }
}

#Preview {
    List{
        Section{
            BluetoothCard()
        }
    }
}

//
//  ProdutoView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 10/11/23.
//

import SwiftUI

struct ProdutoView: View {
    var body: some View {
        NavigationView{
                List{
                    Section{
                        NavigationLink(destination: ConnectBluetoothView()) {
                            BluetoothCard()
                        }
                    }
                }
        .navigationBarTitle("Produto")
        }
        
    }
}

#Preview {
    ProdutoView()
}

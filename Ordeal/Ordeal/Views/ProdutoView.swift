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
//            ScrollView(.vertical){
                List{
                    Section{
                        NavigationLink(destination: Text("sim")) {
                            BluetoothCard()
                        }
                    }//.Section
                }//.List
//            }//.ScrollView
        .navigationBarTitle("Produto")
        }//.NavigationView
        
    }
}

#Preview {
    ProdutoView()
}

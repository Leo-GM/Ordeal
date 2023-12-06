//
//  TabView.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 06/12/23.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var router = Router()
    @StateObject private var routerProfile = Router()
    @StateObject var bluetoothViewModel = BluetoothModel()
    
    var body: some View {
        TabView{
            MainView()
                .tabItem {Label("Jardim", systemImage: "leaf.circle") }
                .environmentObject(router)
            ProdutoView()
                .tabItem {Label("Produto", systemImage: "sensor") }
            PerfilView()
                .tabItem {Label("Perfil", systemImage: "person.circle") }
                .environmentObject(routerProfile)
//                TodasPlantasView()
//                    .tabItem {Label("Teste", systemImage: "bolt.heart") }
            
        }
        .accentColor(Color("principalColor"))
        .environmentObject(bluetoothViewModel)
    }
}

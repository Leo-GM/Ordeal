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
    @StateObject var lastFeedback = LastFeedback(imagem: "", instruction: "Nenhuma medicao realizada", especie: "", nomePlanta: "", humidityReceived: 653)

    
    var body: some View {
        TabView{
            MainView()
                .tabItem {Label("Jardim", systemImage: "leaf.circle") }
                .environmentObject(router)
                .environmentObject(lastFeedback)
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

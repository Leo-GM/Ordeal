//
//  OrdealApp.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 25/10/23.
//

import SwiftUI

@main
struct OrdealApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            TabView{
                FeedbackView()
                    .tabItem {Label("Jardim", systemImage: "leaf.circle") }
                ProdutoView()
                    .tabItem {Label("Produto", systemImage: "sensor") }
                PerfilView()
                    .tabItem {Label("Perfil", systemImage: "person.circle") }
                
            }
        }
    }
}

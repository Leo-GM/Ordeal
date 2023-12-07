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
    
//    init() {
//            //Use this if NavigationBarTitle is with Large Font
//            UINavigationBar.appearance().largeTitleTextAttributes = [
//                .foregroundColor: UIColor(named: "principalColor")
////                ,
////                .font: UIFont(name: "SFProRounded-Bold", size: 34.0) ?? UIFont.systemFont(ofSize: 34.0, weight: .bold)
//            ]
//
//            //Use this if NavigationBarTitle is with displayMode = .inline
//            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "principalColor")]
//        }
    
    init() {
            var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle) /// the default large title font
            titleFont = UIFont(
                descriptor:
                    titleFont.fontDescriptor
                    .withDesign(.rounded)? /// make rounded
                    .withSymbolicTraits(.traitBold) /// make bold
                    
                    ??
                    titleFont.fontDescriptor, /// return the normal title if customization failed
                size: titleFont.pointSize
            )
            
            /// set the rounded font and color
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont, .foregroundColor: UIColor(named: "principalColor")]
        }

    var body: some Scene {
        WindowGroup {
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            @StateObject var bluetoothViewModel = BluetoothModel()
            @StateObject var lastFeedback = LastFeedback()

            TabView{
                MainView()
                    .tabItem {Label("Jardim", systemImage: "leaf.circle") }
                ProdutoView()
                    .tabItem {Label("Produto", systemImage: "sensor") }
                PerfilView()
                    .tabItem {Label("Perfil", systemImage: "person.circle") }
//                TodasPlantasView()
//                    .tabItem {Label("Teste", systemImage: "bolt.heart") }
                
            }
            .accentColor(Color("principalColor"))
            .environmentObject(bluetoothViewModel)



        }
        
    }
}

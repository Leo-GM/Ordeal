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
            ConnectBluetoothView()
        }
    }
}

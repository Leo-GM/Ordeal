//
//  ConnectBluetoothView.swift
//  Ordeal
//
//  Created by Caio Gomes Piteli on 16/11/23.
//

import SwiftUI

struct ConnectBluetoothView: View {
    @ObservedObject private var bluetoothViewModel = ViewController()
    
    var body: some View {
        List {
            Section(header: Text("Outros produtos"), footer: Text("Estes são todos os nossos produtos disponíveis perto de você.")){
                
                ForEach(bluetoothViewModel.discoveredPeripherals, id: \.self) { elemento in
                    Button("\(elemento.name!)") {
                        bluetoothViewModel.connect(peripheral: elemento)
                    }
                }
            }
        }
    }
}

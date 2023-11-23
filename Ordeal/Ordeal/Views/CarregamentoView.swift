//
//  CarregamentoView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 17/11/23.
//

import SwiftUI

struct CarregamentoView: View {
    @State private var progress = 0.8
    var body: some View {
        VStack{
            Image("plantona")
            ProgressView(value: progress) {
                            Text("Label")
                        } currentValueLabel: {
                            Text("Recebendo dados do solo, aguarde 15 segundos")
                        }

        }
    }
}

#Preview {
    CarregamentoView()
}

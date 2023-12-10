//
//  CarregamentoView.swift
//  Ordeal
//
//  Created by Leonardo Guimaraes on 28/11/23.
//

import SwiftUI

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    @State private var progress = 0.0
    @State private var currentImageIndex = 0
    @State private var continueTimer = true
    @State var timer:Timer?
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 250, height: 10)
                .overlay(Color("carregamento2")).cornerRadius(14)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 10)
                .foregroundColor(Color("carregamento1"))
            
        }
        .padding()
        
            
        
    }
}



struct CarregamentoView: View {
    
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @State private var progress = 0.0
    @State private var currentImageIndex = 0
    @State private var continueTimer = true
    @State private var isFeedbackViewActive = false
    @State var especieCarregamento:String
    @State var nomeCarregamento:String
    @State private var textoIndex = 0
    @EnvironmentObject var router: Router



    
    
    @State var timer:Timer?
    @State var timerTexto:Timer?
        
    let images = ["plantona1", "plantona2", "plantona3"]
    let textos = ["Verificando conexão...", "Conexão confirmada...", "Coletando dados...", "Interpretando dados...git "]
    
    
    var body: some View {
       
            VStack{
                
                Image(images[currentImageIndex])
                
                
                
                ProgressView(value: progress) {
                    
                }
                .progressViewStyle(RoundedRectProgressViewStyle())
                
                Text(textos[textoIndex])
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding()
                    .tint(.purple)
                
                
                
                
            }
            .navigationBarBackButtonHidden(true)
            
            .onAppear{
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: continueTimer) { timer in
                    // Mudando para a próxima imagem
                    self.currentImageIndex = (self.currentImageIndex + 1) % self.images.count
                    
                }
                timerTexto = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: continueTimer) { timer in
                    // Mudando para a próxima imagem
                    self.textoIndex = (self.textoIndex + 1) % self.textos.count
                    
                }
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                    
                    // self.progress += 0.0008
                    self.progress += 0.00085
                    
                    if self.progress > 1.0 {
                        self.progress = 1.0
                        self.continueTimer = false
                        self.timer?.invalidate()
                        timer.invalidate()
                        self.isFeedbackViewActive = true
                        bluetoothViewModel.flag = 1
                        router.navigateTo("Feedback")
                        
                    }
                }
            }
        }
    
    
    
}

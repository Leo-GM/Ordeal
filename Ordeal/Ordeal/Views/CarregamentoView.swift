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
    
    @State private var progress = 0.0
    @State private var currentImageIndex = 0
    @State private var continueTimer = true
    
    
    @State var timer:Timer?
        
    let images = ["plantona1", "plantona2", "plantona3"]
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                Image(images[currentImageIndex])
                
                
                
                ProgressView(value: progress) {
                    
                }
                .progressViewStyle(RoundedRectProgressViewStyle())
                
                Text("Coletando os Dados")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding()
                    .tint(.purple)
                
                
                
                
            }
            
            .onAppear{
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: continueTimer) { timer in
                    // Mudando para a próxima imagem
                    self.currentImageIndex = (self.currentImageIndex + 1) % self.images.count
                    
                }
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                    
                    // self.progress += 0.0008
                    self.progress += 0.00085
                    
                    if self.progress > 1.0 {
                        self.progress = 1.0
                        self.continueTimer = false
                        self.timer?.invalidate()
                        timer.invalidate()
                    }
                }
            }
            
        }
    }
    
    
}

#Preview {
    CarregamentoView()
}

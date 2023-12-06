import SwiftUI

struct ConnectBluetoothView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothModel
    @State private var isConnected: Bool = false
    @State private var isConnecting: Bool = false

    var body: some View {
        List {
            Section(header: Text("Outros produtos"), footer: Text("Estes são todos os nossos produtos disponíveis perto de você.")) {
                
                ForEach(bluetoothViewModel.discoveredPeripherals, id: \.self) { elemento in
                    Button {
                        if isConnected {
                            // Desconectar se já estiver conectado
                            isConnected = false
                        } else {
                            // Conectar se não estiver conectado
                            isConnecting = true
                            bluetoothViewModel.connect(peripheral: elemento)
                                // Callback chamado quando a conexão for estabelecida
                                isConnecting = false
                                isConnected = true
                            
                        }
                    } label: {
                        HStack {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                //.background(Color(isConnected ? "connectedColor" : "principalColor"))
                                .background(Color("principalColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                .onChange(of: isConnected) { _ in
//                                    // Este bloco será executado sempre que isConnected mudar
//                                    // Certifique-se de que a interface do usuário é atualizada corretamente
//                                }
                            
                            Text("\(elemento.name!)") // Nome do Bluetooth à direita
                                .foregroundColor(.black)
                            
                            Spacer() // Adiciona um espaçador para empurrar o conteúdo para a direita
                            
                            Text(isConnected ? "Conectado" : isConnecting ? "Conectando..." : "Não conectado")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity) // Garante que o conteúdo ocupe toda a largura do botão
                    }
                }
            }
        }

    }
}

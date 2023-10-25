import SwiftUI
import CoreBluetooth
class BluetoothViewModel : NSObject, ObservableObject {
    private var centralManager : CBCentralManager?
    fileprivate var peripherals : [CBPeripheral] = []
    private var connectedPeripheral: CBPeripheral?
    
    @Published var peripheralNames: [String] = []
    @Published var isConnecting: Bool = false
    @Published var isConnected: Bool = false
    
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func connect(name: CBPeripheral) {
        isConnecting = true
        centralManager?.connect(name)
    }
    
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
                       self.peripherals.append(peripheral)
                       if let name = peripheral.name {
                           if name.hasPrefix("RC") {
                               self.centralManager?.stopScan() // Stop scanning when "RC" prefix is found.
                           }
                           self.peripheralNames.append(name)
                       }
                   }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnecting = false
        isConnected = true
        connectedPeripheral = peripheral
        print("Nome do dispositivo conectado: \(peripheral.name)") //printando nome do peripheral conectado
        print("Identificador do dispositivo conectado: \(peripheral.identifier)") //printando ID do peripheral conectado
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnecting = false
        isConnected = false
        connectedPeripheral = nil
    }
}



struct ConnectBluetoothView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            List(bluetoothViewModel.peripheralNames, id: \.self) {peripheral in Text(peripheral)
                    .onTapGesture {
                        if let peripheral = bluetoothViewModel.peripherals.first(where: { $0.name == peripheral }) {
                            bluetoothViewModel.connect(name: peripheral)
                        }
                    }
            }.navigationTitle("Peripherals")
        }
    }
}

struct ConnectBluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectBluetoothView()
    }
}

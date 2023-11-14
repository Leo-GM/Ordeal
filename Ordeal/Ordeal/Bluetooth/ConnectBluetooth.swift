import SwiftUI
import UIKit
import CoreBluetooth

class BluetoothModel: NSObject, ObservableObject, CBPeripheralDelegate {
    private var centralManager: CBCentralManager!
    var discoveredPeripherals = [CBPeripheral]()
    @Published var connectedPeripheral: CBPeripheral?
    @Published var ValueReceived: String?

    enum GeneralPlantState {
        case ok
        case notOk
        
        func image() -> String {
            switch self {
            case .ok:
                return "feedbackPlantaFelizCard"
            case .notOk:
                return "feedbackPlantaTristeCard"
            }
        }
    }

    
    enum HumidityPlantState {
        case lack
        case ideal
        case excess
        
        func image() -> String {
            switch self {
            case .lack:
                return "exclamationmark.triangle"
            case .ideal:
                return "checkmark.circle"
            case .excess:
                return "exclamationmark.triangle"
            }
        }
        
        func color() -> String {
            switch self {
            case .lack:
                return "secondaryColor"
            case .ideal:
                return "principalColor"
            case .excess:
                return "secondaryColor"
            }
        }
    }
    
    enum NPKPlantState {
        case lack
        case ideal
        case excess
        
        func image() -> String {
            switch self {
            case .lack:
                return "exclamationmark.triangle"
            case .ideal:
                return "checkmark.circle"
            case .excess:
                return "exclamationmark.triangle"
            }
        }
        
        func color() -> String {
            switch self {
            case .lack:
                return "secondaryColor"
            case .ideal:
                return "principalColor"
            case .excess:
                return "secondaryColor"
            }
        }
    }
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManagerDidUpdateState(centralManager)
        
    }
    
    func checkHumidityPlantState (specieHumidity: Int, humidityReceived:Int) -> HumidityPlantState {
        if (humidityReceived <= specieHumidity-10) {
            return .lack
        }else if (humidityReceived >= specieHumidity-10 && humidityReceived <= specieHumidity+10){
            return .ideal
        }else{
            return .excess
        }
    }
    
    func checkNPKPlantState(nitrogenReceived: Int, phosphorReceived: Int, potassiumReceived: Int) -> NPKPlantState {
        let nitrogenInRange = (10...50).contains(nitrogenReceived)
        let phosphorInRange = (1...10).contains(phosphorReceived)
        let potassiumInRange = (10...35).contains(potassiumReceived)
        
        if nitrogenInRange && phosphorInRange && potassiumInRange {
                return .ideal
            } else if nitrogenInRange && phosphorInRange {
                return .ideal
            } else if nitrogenInRange && potassiumInRange {
                return .ideal
            } else if phosphorInRange && potassiumInRange {
                return .ideal
            } else if (nitrogenReceived > 50) && (phosphorReceived > 10) && (potassiumReceived > 35) {
                return .excess
            } else if (nitrogenReceived > 50) && (phosphorReceived > 10) {
                return .excess
            } else if (phosphorReceived > 10) && (potassiumReceived > 35) {
                return .excess
            } else if (nitrogenReceived > 50) && (potassiumReceived > 35) {
                return .excess
            } else {
                return .lack
            }
        
    }
    
    
    func checkOveralStatus(humidyStatus: HumidityPlantState,
                           nutrientsStatus: NPKPlantState) -> GeneralPlantState {
        
        if humidyStatus == .ideal && nutrientsStatus == .ideal {
            return .ok
        } else {
            return .notOk
        }
        
    }
    
    
}

extension BluetoothModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("---Bluetooth ligado---")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            print("Conectado em \(connectedPeripheral?.name)")
            
            print("Procurando dispositivos...")
        case .poweredOff:
            print("Bluetooth ta desligado")
        case .resetting:
            // Wait for next state update and consider logging interruption of Bluetooth service
            print("Bluetooth ta resseting")
        case .unauthorized:
            // Alert user to enable Bluetooth permission in app Settings
            print("Bluetooth ta desautorizado")
        case .unsupported:
            // Alert user their device does not support Bluetooth and app will not work as expected
            print("Celular não suporta bluetooth")
        case .unknown:
            // Wait for next state update
            print("Estado desconhecido, aguarde...\n")
        @unknown default:
            print("Vai saber o que aconteceu aqui")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.discoveredPeripherals.append(peripheral)
        
        if peripheral.name == "HC-08"{ //Connecting to the peripherral without asking
            connect(peripheral: peripheral)
        }
    }
    
    func connect(peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Successfully connected. Store reference to peripheral if not already done.
        self.connectedPeripheral = peripheral
        peripheral.delegate = self
        print("Bluetooth conectado em: \(peripheral.name)\n")
        
        print("Procurando seus servicos...")
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Handle error
        print("WARNING: Conexão falhou")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            return
        }
        print("Servicos encontrados: \(services)\n\n")
        
        print("Procurando caracteristicas do serviço...")
        discoverCharacteristics(peripheral: peripheral)
        
    }
    
    func discoverCharacteristics(peripheral: CBPeripheral) {
        guard let services = peripheral.services else {
            return
        }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        if characteristics[0].properties.contains(.notify) {
            peripheral.setNotifyValue(true, for: characteristics[0])
        } // in case the data modify, it notifys me
        
        print("Caracteristicas encontradas: \(characteristics)\n\n")
        
        self.connectedPeripheral?.readValue(for: characteristics[0])
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard let value = characteristic.value else {
            return
        }
        print("Valor recebido: \(value)")
        
        if let value = characteristic.value {
            // Making the data received be a string
            if let stringValue = String(data: value, encoding: .utf8) {
                print("Valor recebido: \(stringValue)")
                ValueReceived = stringValue
            }
        }
    }
    
}


// -----VIEW USADA PARA TESTES----- //
/* struct ConnectBluetoothView: View {
 @ObservedObject private var bluetoothViewModel = ViewController()
 
 var body: some View {
 Text("Dado recebido pelo sensor arduino: \(bluetoothViewModel.StringRecebida ?? "NADA RECEBIDO")")
 
 if bluetoothViewModel.connectedPeripheral?.name == "HC-08"{
 Circle() // Cria um círculo
 .fill(Color.green)
 .frame(width: 100, height: 100)
 .padding()
 }else{
 Circle() // Cria um círculo
 .fill(Color.red)
 .frame(width: 100, height: 100)
 .padding()
 }
 }
 }
 
 struct ConnectBluetoothView_Previews: PreviewProvider {
 static var previews: some View {
 ConnectBluetoothView()
 }
 } */

import SwiftUI
import UIKit
import CoreBluetooth

class BluetoothModel: NSObject, ObservableObject, CBPeripheralDelegate {
    private var centralManager: CBCentralManager!
    
    @Published var discoveredPeripherals = [CBPeripheral]()
    @Published var connectedPeripheral: CBPeripheral?
    @Published var ValueReceived: String?
    @Published var IntValueReceived: Int = 101
    @Published var isHC08Connected = false

    
    enum GeneralPlantState {
        case idealParameters
        case lackHumidityLackNPK
        case lackHumidityIdealNPK
        case lackHumidityExcessNPK
        case idealHumidityLackNPK
        case idealHumidityExcessNPK
        case excessHumidityLackNPK
        case excessHumidityIdealNPK
        case excessHumidityExcessNPK
        
        
        func image() -> String {
            switch self {
            case .idealParameters:
                return "feedbackPlantaFelizCard"
            case .lackHumidityLackNPK:
                return "feedbackPlantaTristeCard"
            case .lackHumidityIdealNPK:
                return "feedbackPlantaTristeCard"
            case .lackHumidityExcessNPK:
                return "feedbackPlantaTristeCard"
            case .idealHumidityLackNPK:
                return "feedbackPlantaTristeCard"
            case .idealHumidityExcessNPK:
                return "feedbackPlantaTristeCard"
            case .excessHumidityLackNPK:
                return "feedbackPlantaTristeCard"
            case .excessHumidityIdealNPK:
                return "feedbackPlantaTristeCard"
            case .excessHumidityExcessNPK:
                return "feedbackPlantaTristeCard"
            }
        }
        
        func instruction() -> String{
            switch self {
            case .idealParameters:
                return "Tanto a umidade quanto as concentrações de NPK estão ideais. Continue com a manutenção adequada para garantir o crescimento saudável das plantas."
            case .lackHumidityLackNPK:
                return "Sua planta está seca e com baixa concentração de nutriente, considere regar sua planta mais frequentemente e adicionar fertilizantes baseados em Nitrogênio, Potássio e Fósforo (NPK)"
            case .lackHumidityIdealNPK:
                return "Seu solo está seco, mas as concentrações de Nitrogênio, Potássio e Fósforo (NPK) estão na faixa ideal. Recomendo regar para manter a umidade adequada."
            case .lackHumidityExcessNPK:
                return "O solo está seco, e as concentrações de NPK são altas. Recomendo ajustar a irrigação para corrigir a secura e reduzir a aplicação de fertilizantes para evitar excessos."
            case .idealHumidityLackNPK:
                return "A umidade do solo está adequada, mas as concentrações de NPK estão baixas. Recomendo aplicar fertilizantes ricos em Nitrogênio, Potássio e Fósforo para melhorar a nutrição das plantas."
            case .idealHumidityExcessNPK:
                return "A umidade está adequada, mas as concentrações de NPK estão elevadas. Recomendo monitorar de perto e ajustar a fertilização para evitar excessos."
            case .excessHumidityLackNPK:
                return "Água em excesso, e concentrações de NPK baixas. Recomendo reduzir a irrigação e aplicar fertilizantes para melhorar a nutrição das plantas."
            case .excessHumidityIdealNPK:
                return "O solo está muito úmido, mas as concentrações de NPK estão ideais. Recomendo ajustar a irrigação para evitar problemas de drenagem."
            case .excessHumidityExcessNPK:
                return "O solo está excessivamente úmido, e as concentrações de NPK são altas. Recomendo reduzir a irrigação e a aplicação de fertilizantes para evitar danos às plantas."
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
        
        func downimage() -> String{
            switch self {
            case .lack:
                return "arrow.down"
            case .ideal:
                return "checkmark"
            case .excess:
                return "arrow.up"
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
        
        func downimage() -> String{
            switch self {
            case .lack:
                return "arrow.down"
            case .ideal:
                return "checkmark"
            case .excess:
                return "arrow.up"
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
            return .idealParameters
        } else if humidyStatus == .lack && nutrientsStatus == .lack{
            return .lackHumidityLackNPK
            
        }else if humidyStatus == .lack && nutrientsStatus == .ideal{
            return .lackHumidityIdealNPK
            
        }else if humidyStatus == .lack && nutrientsStatus == .excess{
            return .lackHumidityExcessNPK
            
        }else if humidyStatus == .ideal && nutrientsStatus == .lack{
            return .idealHumidityLackNPK
            
        }else if humidyStatus == .ideal && nutrientsStatus == .excess{
            return .idealHumidityExcessNPK
            
        }else if humidyStatus == .excess && nutrientsStatus == .lack{
            return .excessHumidityLackNPK
            
        }else if humidyStatus == .excess && nutrientsStatus == .ideal{
            return .excessHumidityIdealNPK
            
        }else{
            return .excessHumidityExcessNPK
        }
        
    }
    
    // MARK: - Check Nitrogen State
    
    enum NitrogenState {
        case lack
        case ideal
        case excess
        

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
        
        func image() -> String{
            switch self {
            case .lack:
                return "arrow.down"
            case .ideal:
                return "checkmark"
            case .excess:
                return "arrow.up"
            }
        }
    }
    
    func checkNitrogenPlantState(nitrogenReceived: Int) -> NitrogenState{
        let nitrogenInrange = (10...50).contains(nitrogenReceived)
        
        if nitrogenInrange{
            return .ideal
        }else if nitrogenReceived > 50{
            return .excess
        }else {
            return .lack
        }
    }
    
    // MARK: - Check Phosphoro State
    
    enum PhosphoroState {
        case lack
        case ideal
        case excess
        

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
        
        func image() -> String{
            switch self {
            case .lack:
                return "arrow.down"
            case .ideal:
                return "checkmark"
            case .excess:
                return "arrow.up"
            }
        }
    }
    
    func checkPhosphoroPlantState(phosphoroReceived: Int) -> PhosphoroState{
        let phosphoroInrange = (1...10).contains(phosphoroReceived)
        
        if phosphoroInrange{
            return .ideal
        }else if phosphoroReceived > 50{
            return .excess
        }else {
            return .lack
        }
    }
   
    // MARK: - Check potassium State
    
    enum PotassiumState {
        case lack
        case ideal
        case excess
        

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
        
        func image() -> String{
            switch self {
            case .lack:
                return "arrow.down"
            case .ideal:
                return "checkmark"
            case .excess:
                return "arrow.up"
            }
        }
    }
    
    func checkPotassiumPlantState(potassiumReceived: Int) -> PotassiumState{
        let potassiumInrange = (10...35).contains(potassiumReceived)
        
        if potassiumInrange{
            return .ideal
        }else if potassiumReceived > 50{
            return .excess
        }else {
            return .lack
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
        
        
        if peripheral.name == "HC-08"{
            self.discoveredPeripherals.append(peripheral)
            centralManager.stopScan()
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
        
        if peripheral.name == "HC-08" {
                self.isHC08Connected = true
            }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Handle error
        print("WARNING: Conexão falhou")
        if peripheral.name == "HC-08" {
                self.isHC08Connected = false
            }
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
        print("Valor recebido Data: \(value)")
        
        if let value = characteristic.value {
            
        // Making the data received be a string
        if let stringValue = String(data: value, encoding: .utf8) {
            ValueReceived = stringValue
            print("Valor recebido String: \(ValueReceived)")
        }
            
        // Making the data received be a int
            if let intValue = Int(ValueReceived ?? "1234") {
                IntValueReceived = intValue
                print("Valor recebido inteiro esse aqui: \(IntValueReceived)")
                
            }
            
        }
    }
    
}


import SwiftUI
import CoreBluetooth
class BluetoothViewModel : NSObject, ObservableObject {
  private var centralManager : CBCentralManager?
  private var peripherals : [CBPeripheral] = []
  @Published var peripheralNames: [String] = []
  override init() {
    super.init()
    self.centralManager = CBCentralManager(delegate: self, queue: .main)
  }
  func conectando(name: CBPeripheral) {
     
      
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
                } else {
                    self.peripheralNames.append("unnamed device")
                }
            }
        }
}
struct ConnectBluetoothView: View {
  @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
  var body: some View {
    NavigationView {
      List(bluetoothViewModel.peripheralNames, id: \.self) {peripheral in Text(peripheral)
          
          .onTapGesture {
            //bluetoothViewModel.conectando()
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

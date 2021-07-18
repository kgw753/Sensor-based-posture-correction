import CoreBluetooth
import UIKit

class BluetoothTableViewController: UITableViewController {
  
  var mainViewController: MainViewController?
  
  @IBOutlet var bluetoothTableView: UITableView!
  
  var bluetoothDeviceList: [CBPeripheral] = []
  
  var centralManager: CBCentralManager!
  
  var connectedDevice: CBPeripheral? {
    
    didSet{
      
      if connectedDevice != nil {
        //if connected
        mainViewController?.isDeviceConnected = true
        return
      }
      
      mainViewController?.isDeviceConnected = false
    }
  }
  
  var updateTimer: Timer!

    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.navigationController?.isNavigationBarHidden = false
      centralManager = CBCentralManager(delegate: self, queue: nil)
      
      updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        self.updateTableView()
      }
    }
  
  override func viewWillAppear(_ animated: Bool) {
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    updateTimer.invalidate()
  }

    // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
    return bluetoothDeviceList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "deviceName", for: indexPath)
    
    cell.textLabel?.text = self.bluetoothDeviceList[indexPath.row].name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    centralManager.connect(bluetoothDeviceList[indexPath.row])
  }
  
  // Asynchronously update tadle view according to discoverable bluetooth devices
  func updateTableView() {
    DispatchQueue.global(qos: .background).async {

        // Background Thread

        DispatchQueue.main.async {
          self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
}

extension BluetoothTableViewController: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unknown:
      break
    case .resetting:
      break
    case .unsupported:
      break
    case .unauthorized:
      break
    case .poweredOff:
      break
    case .poweredOn:
      centralManager.scanForPeripherals(withServices: nil)
    @unknown default:
      break
    }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
    
    print(peripheral)
  
  // Return if name is 'nil'
  guard peripheral.name != nil else {
    return
  }
  
  for (index, device) in bluetoothDeviceList.enumerated() {
    if device.name == peripheral.name {
      
      bluetoothDeviceList[index] = peripheral
      
      bluetoothDeviceList.sort { (lhs, rhs) -> Bool in
        guard let lname = lhs.name, let rname = rhs.name else {
          return false
        }
        
        return lname > rname
      }
      
      return
    }
  }
    
    bluetoothDeviceList.append(peripheral)
    bluetoothDeviceList.sort { (lhs, rhs) -> Bool in
      guard let lname = lhs.name, let rname = rhs.name else {
        return false
      }
      
      return lname > rname
    }
    
    return
}
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    
    connectedDevice = peripheral
    
    // Forced Uwrapping is avaliable with peripheral.name
    // peripheral.name is always not nil by centralManager(didDiscover:)
    
    let successAlertView = UIAlertController(title:"Connection Success", message: "Your phone succefully connected to \(peripheral.name!)", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
      self.dismiss(animated: true, completion: nil)
    }
    
    successAlertView.addAction(okAction)
    
    self.present(successAlertView, animated: true, completion:nil)
    
  }
  
  func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    return
  }

}

import UIKit
import CocoaMQTT

class ConnectRpiViewController: UIViewController {
  
  @IBOutlet weak var ipAdressTextField: UITextField!
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var disconnectButton: UIButton!
  
  private var serverIPAdrees: String?
  private var mqttClient: CocoaMQTT?
  
  var mainViewController: MainViewController?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    connectButton.isEnabled = mainViewController!.isDeviceConnected
    connectButton.isEnabled = !mainViewController!.isDeviceConnected
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    if ipAdressTextField.canBecomeFirstResponder {
      ipAdressTextField.becomeFirstResponder()
    }
    
    guard let mqttClient = mqttClient else {
      return
    }
    
    if mqttClient.connState == .connected {
      connectButton.isEnabled = false
      disconnectButton.isEnabled = true
    } else {
      connectButton.isEnabled = true
      disconnectButton.isEnabled = false
    }
  }
  
  @IBAction func connectServer(_ sender: Any) {
    
    guard let _ = ipAdressTextField.text else {
      
      fatalError("cannot be nil: ipAdressTextField.text")
    }
    
    mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.30.1.7", port: 1883)
    
    let _ = mqttClient?.connect()
    connectButton.isEnabled = false
    disconnectButton.isEnabled = true
    
    mainViewController?.isDeviceConnected = true
  }
  
  @IBAction func disconnectServer(_ sender: Any) {
    
    mqttClient?.disconnect()
    connectButton.isEnabled = true
    disconnectButton.isEnabled = false
    
    mainViewController?.isDeviceConnected = false
  }
  
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }

}

extension ConnectRpiViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}


import UIKit

class RealtimeMeasuringViewController: UIViewController {
  
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var faceImage: UIImageView!
  @IBOutlet weak var feedBackLabel: UILabel!
  
  @IBOutlet weak var correctRateLabel: UILabel!
  @IBOutlet weak var badRateLabel: UILabel!
  @IBOutlet weak var backgroundImage: UIImageView!
  
  // Timer for timerLabel
  var timer: Timer?
  var sec: Int = 0
  
  // Timer for Update FaceImage by ratio
  var updateFaceTimer: Timer?
  // Interval that RaspberryPi sending data
  var raspberryInterval: Double = 1.0
  

  
  private var resultList: [Result] = [] {
    
    //Called when new element added
    didSet {
      correctRateLabel.text = "\(correctRate) %"
      badRateLabel.text = "\(badRate) %"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    faceImage.image = UIImage(imageLiteralResourceName: "blank-face")
    self.view.sendSubviewToBack(backgroundImage)
    
    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      
      if self.sec < Result.testResultList.count {
        self.resultList.append(Result.testResultList[self.sec])
        
        //debugging
        print(self.resultList[self.resultList.count-1].postureType)
      }
      
      self.sec += 1
      self.timerLabel.text = self.timeFomatter(self.sec)
    }
    
    self.updateFaceTimer = Timer.scheduledTimer(withTimeInterval: raspberryInterval, repeats: true, block: { (_) in
      self.changeInfoByRatio()
      
      self.correctRateLabel.text = String(format: "%.1f", self.correctRate) + "%"
      self.badRateLabel.text = String(format: "%.1f", self.badRate) + "%"
    })
  }
  
  override func viewWillAppear(_ animated: Bool) {
    resultList.removeAll()
    self.view.sendSubviewToBack(self.backgroundImage)
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.timer?.invalidate()
    self.updateFaceTimer?.invalidate()
  }
}

// About Timer
extension RealtimeMeasuringViewController {
  
  func timeFomatter(_ timeCount: Int) -> String {
    
    let hour = timeCount / 3600
    let min = (timeCount % 3600) / 60
    let sec = (timeCount % 3600) % 60
    
    let hourStr =  hour < 10 ? "0\(hour)" : String(hour)
    let minStr = min < 10 ? "0\(min)" : String(min)
    let secStr = sec < 10 ? "0\(sec)" : String(sec)
    
    return "\(hourStr):\(minStr):\(secStr)"
  }
}

extension RealtimeMeasuringViewController {
  
  public var correctRate: Double {
    get {
      if resultList.count == 0 {
        return 0
      }
      
      let correctCount = Double(resultList.filter{$0.postureType == Result.PostureType.Correct}.count)
      
      return correctCount / Double(resultList.count) * 100
    }
  }
  
  public var badRate: Double {
    get {
      if resultList.count == 0 {
        return 0
      }
      
      return 100 - correctRate
    }
  }
  
  private func changeInfoByRatio(){
    
    if correctRate > 66 {
      
      self.faceImage.image = UIImage(imageLiteralResourceName: "happy-face")
      self.feedBackLabel.text = "Keep Going!?"
      
    } else if correctRate > 32 {
      
      self.faceImage.image = UIImage(imageLiteralResourceName: "blank-face")
      self.feedBackLabel.text = "Not bad...??"
      
    } else if correctRate >= 0 {
      
      self.faceImage.image = UIImage(imageLiteralResourceName: "sad-face")
      self.feedBackLabel.text = "Inappropriate?"
      
    } else {
      
      fatalError("Nan error: Correct & Bad Rate")
    }
  }
}

//
//  NothingController.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//
import Combine
import Foundation


// Define a custom error type
private enum DeviceError: Error {
    case responseError(String)
    case timeoutError(String)
}

// Define a structure to represent a request
private struct Request {
    let command: Commands
    let completion: (Result<Void, Error>) -> Void
    let requestTimeout: TimeInterval
    let responseTimeout: TimeInterval
}

class NothingServiceImpl : NothingService {
    
    func ringBuds() {
        setRingBuds(right: true, left: true, doRing: true)
    }
    
    func stopRingingBuds() {
        setRingBuds(right: true, left: true, doRing: false)
    }
    
    func switchANC(mode: ANC) {
        // Initialize the byte array
        var byteArray: [UInt8] = [0x01, 0x01, 0x00]
        
        byteArray[1] = mode.rawValue
        
        
        // Print the byte array
        print(byteArray)
        
        // Call the send function with the specified parameters
        send(command: Commands.SET_ANC.rawValue, payload: byteArray)
        
        addRequest(command: Commands.GET_ANC, requestTimeout: 1000, responseTimeout: 1000) {
            result in
            switch result {
            case .success:
                print("Successfully fetched eq settings")
            case .failure(let error):
                print("Failed to fetch eq: \(error.localizedDescription)")
                
            }
        }
    }
    
    func switchEQ(mode: EQProfiles) {
        var byteArray: [UInt8] = [0x00, 0x00]
        
        byteArray[0] = mode.rawValue
        
        send(command: Commands.SET_EQ.rawValue, payload: byteArray)
        
        addRequest(command: Commands.GET_EQ, requestTimeout: 1000, responseTimeout: 1000) {
            result in
            switch result {
            case .success:
                print("Successfully fetched eq settings")
            case .failure(let error):
                print("Failed to fetch eq: \(error.localizedDescription)")
                
            }
        }
    }
    
    func connectToNothing(device: NothingDevice) {
        
    }
    
    
    
    
    private var operationID = 0
    private var cancellables = Set<AnyCancellable>()
    private let bluetoothManager = BluetoothManager.shared
    
    private let classOfNothing:UInt32 = 2360324
    
    // A queue to hold requests
    private var requestQueue: [Request] = []
    
    // A semaphore to control access to the queue
    private let queueSemaphore = DispatchSemaphore(value: 1)
    
    // A flag to indicate if a request is currently being processed
    private var isProcessing = false

    
    private var nothingDevice: FrameworkNothingDevice? = nil
         
    
    init() {
        
        #warning("On device discovery should return a list of currently connected paired earbuds + discovered - saved in the app")
        #warning("Handle list processing in here, then send the list to the service")
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.CONNECTED.rawValue), object: nil, queue: .main) { notification in
            // Handle the notification here
            if let userInfo = notification.userInfo, let data = userInfo["data"] as? BluetoothDevice {
                if let userInfo = notification.userInfo, let data = userInfo["data"] as? BluetoothDevice {
                    
                    self.nothingDevice = FrameworkNothingDevice(bluetoothDetails: data)
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.DATA_RECEIVED.rawValue), object: nil, queue: .main) { notification in
            // Handle the notification here
            if let userInfo = notification.userInfo, let data = userInfo["data"] as? [UInt8] {
                if let userInfo = notification.userInfo, let data = userInfo["data"] as? [UInt8] {
                    print("Data received in Nothing Controller: \(data)")
                    
                    self.onDataReceived(rawData: data)
                }
            }
        }
        
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let deviceFramework = notification.object as? FrameworkNothingDevice {
                print("Class has been updated in repository")
                
                let nothingDevice = FrameworkNothingDevice.fromNothingDeviceFramework(deviceFramework)
                
                NotificationCenter.default.post(name: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nothingDevice, userInfo: nil)
            }
        }
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.FOUND.rawValue), object: nil, queue: .main) { notification in
            
           print("found device")
            
            if let bluetoothDevice = notification.object as? BluetoothDevice {
                
                
                
                
                
            }
        }
        
        
    }
    
    func getPairedNothing() -> [(address: String, name: String, isConnected: Bool)] {
        return bluetoothManager.getPaired(withClass: Int(classOfNothing))
    }
    
    func discoverNothing() {
        bluetoothManager.startDeviceInquiry(withClass: classOfNothing)
    }
    
    func isNothingConnected() -> Bool {
        return bluetoothManager.isDeviceConnected()
    }
    
    func connectToNothing(address: String) {
        bluetoothManager.connectToDevice(address: address, channelID: 15)
    }
    
    func fetchData() {
        //there is a change that device gets disconnected during transfer
        //but it is low since it takes less than a second to fetch the data
        //will fix it in the future
        if isNothingConnected() && nothingDevice != nil {
            
            
            addRequest(command: Commands.GET_SERIAL_NUMBER, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched serial number.")
                case .failure(let error):
                    print("Failed to fetch serial number: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_FIRMWARE, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched firmware number.")
                case .failure(let error):
                    print("Failed to fetch firmware number: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_BATTERY, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched battery settings.")
                case .failure(let error):
                    print("Failed to fetch battery settings: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_ANC, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched ANC settings.")
                case .failure(let error):
                    print("Failed to fetch ANC settings: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_EQ, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched eq settings")
                case .failure(let error):
                    print("Failed to fetch eq: \(error.localizedDescription)")
                    
                }
            }
            
        }
        
    }

    
    //low latency mode
    
    func send(command: UInt16, payload: [UInt8] = []) {
        var header: [UInt8] = [0x55, 0x60, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00]
        
        operationID += 1
        header[7] = UInt8(operationID)
        
        // Convert command to bytes
        let commandBytes = withUnsafeBytes(of: command.bigEndian) { Array($0) }
        header[3] = commandBytes[0]
        header[4] = commandBytes[1]
        
        let payloadLength = UInt8(payload.count)
        header[5] = payloadLength
        
        // Append payload to header
        header.append(contentsOf: payload)
        
        // Calculate CRC
        let crc = CRC16.crc16(buffer: header)
        header.append(UInt8(crc & 0xFF)) // Append low byte
        header.append(UInt8((crc >> 8) & 0xFF))
        
        // Log the byte array in hex format
        let hexString = header.map { String(format: "%02x", $0) }.joined()
        print("sending \(hexString)")
        
        // Send the data
     
        bluetoothManager.send(data: &header, length: UInt16(header.count))
   
    }

    
    // Function to get the current request being processed
    private func getCurrentRequest() -> Request? {
        queueSemaphore.wait()
        defer { queueSemaphore.signal() }
        return requestQueue.first // Return the first request in the queue
    }
    
    // Function to process requests in the queue
    private func processNextRequest() {
        queueSemaphore.wait()
        
        // Check if there are requests in the queue
        guard !requestQueue.isEmpty else {
            isProcessing = false
            queueSemaphore.signal()
            return
        }
        
        // Get the next request from the queue
        let request = requestQueue.removeFirst()
        isProcessing = true
        queueSemaphore.signal()
        
        // Set a timeout for the request
        let requestTimeout = DispatchTime.now() + request.requestTimeout
        DispatchQueue.global().asyncAfter(deadline: requestTimeout) {
            if self.isProcessing {
                print("Request timed out, attempting to repeat")
                // Re-add the request to the queue
                self.queueSemaphore.wait()
                self.requestQueue.append(request) // Re-add the request
                self.queueSemaphore.signal()
                
                // Call the completion handler with a timeout error
                request.completion(.failure(DeviceError.timeoutError("Request timed out.")))
                self.isProcessing = false
                
                // Process the next request
                self.processNextRequest()
            }
        }
        
        // Send the command and handle the response
        send(command: request.command.rawValue, payload: [])
    }
    
    // Function to add a request to the queue
    func addRequest(command: Commands, requestTimeout: TimeInterval, responseTimeout: TimeInterval, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let requestTimeoutInSeconds = TimeInterval(requestTimeout) / 1000.0
        let responseTimeoutInSeconds = TimeInterval(responseTimeout) / 1000.0
        
        let request = Request(command: command, completion: completion, requestTimeout: requestTimeoutInSeconds, responseTimeout: responseTimeoutInSeconds)
        
        queueSemaphore.wait()
        requestQueue.append(request) // Append the request to the queue
        queueSemaphore.signal()
        
        // Start processing if not already processing
        if !isProcessing {
            processNextRequest()
        }
    }

    
    
    
    private func readBattery(hexString: [UInt8]) {
        
        var connectedDevices = 0
        
        let BATTERY_MASK: UInt8 = 127
        let RECHARGING_MASK: UInt8 = 128
        
        // Read the number of connected devices
        connectedDevices = Int(hexString[8])
        
        nothingDevice?.isCaseConnected = false
        nothingDevice?.isLeftConnected = false
        nothingDevice?.isRightConnected = false
        
        // Process each connected device
        for i in 0..<connectedDevices {
            let deviceId = hexString[9 + (i * 2)]
            let batteryData = hexString[10 + (i * 2)]
            let batteryLevel = Int(batteryData & BATTERY_MASK)
            let isCharging = (batteryData & RECHARGING_MASK) == RECHARGING_MASK
            
            switch deviceId {
            case 0x02: // Left device
                nothingDevice?.leftBattery = batteryLevel
                nothingDevice?.isLeftCharging = isCharging
                nothingDevice?.isLeftConnected = true
            case 0x03: // Right device
                nothingDevice?.rightBattery = batteryLevel
                nothingDevice?.isRightCharging = isCharging
                nothingDevice?.isRightConnected = true
            case 0x04: // Case device
                nothingDevice?.caseBattery = batteryLevel
                nothingDevice?.isCaseCharging = isCharging
                nothingDevice?.isCaseConnected = true
            default:
                // Handle unknown device ID if necessary
                break
            }
        }
        
        // Print battery levels (optional)
        print("Battery Left: \(nothingDevice?.leftBattery), Charging: \(nothingDevice?.isLeftCharging)")
        print("Battery Right: \(nothingDevice?.rightBattery), Charging: \(nothingDevice?.isRightCharging)")
        print("Battery Case: \(nothingDevice?.caseBattery), Charging: \(nothingDevice?.isCaseCharging)")
    }
    
    private func readANC(hexArray: [UInt8]) {
        
        let ancStatus = hexArray[9]
        let level = ANC(rawValue: ancStatus)
        guard let unwrappedLevel = level else {
            return
        }
        nothingDevice?.anc = unwrappedLevel
  
        
        print("level \(unwrappedLevel)")
        
        nothingDevice?.printValues()
        
    }
    
    private func readEQ(hexArray: [UInt8]) -> EQProfiles {
        

        let eqMode: UInt8 = hexArray[8]
        print("eqMode \(eqMode)")
        
        return EQProfiles(rawValue: eqMode) ?? EQProfiles.BALANCED
        
    }
    
    private func readSerial(hexPayload: [UInt8]) -> String {
        
        
        var configurations: [(device: Int, type: Int, value: String)] = []
        
        // Decode the remaining payload and split by new lines
        let linesData = hexPayload[7...] // Subarray from index 7 to the end
        let lines = String(decoding: linesData, as: UTF8.self).split(separator: "\n")
        
        // Process each line
        for line in lines {
            let parts = line.split(separator: ",").map { String($0) }
            if parts.count == 3,
               let device = Int(parts[0]),
               let type = Int(parts[1]),
               let value = parts[2].nonEmpty {
                configurations.append((device: device, type: type, value: value))
            }
        }
        
        // Filter configurations to find the serial number
        let serialConfigs = configurations.filter { $0.type == 4 && !$0.value.isEmpty }
        
        print("Configurations:")
        for config in configurations {
            print("Device: \(config.device), Type: \(config.type), Value: \(config.value)")
        }
        // Return the serial number if found, otherwise return empty string
        let serialValue = serialConfigs.first?.value ?? "12345678901234567"
        print("Serial: \(serialValue)")
        return serialValue
    }
    
   
    
    private func readFirmware(hexArray: [UInt8]) -> String {
        
        // Initialize an empty string for the firmware version
        var firmwareVersion = ""
        
        // Ensure that the hexArray has enough elements
        guard hexArray.count > 8 else {
            print("Error: hexArray does not contain enough elements.")
            return firmwareVersion // Return empty string if not enough data
        }
        
        // Get the size from the hexArray
        let size = hexArray[5]
        
        // Extract the firmware version based on the size
        for i in 0..<size {
            let index = 8 + Int(i)
            if index < hexArray.count {
                firmwareVersion += String(UnicodeScalar(hexArray[index]))
            } else {
                print("Warning: Index \(index) is out of bounds for hexArray.")
                break
            }
        }
        
        nothingDevice?.firmware = firmwareVersion
        print(firmwareVersion)
        
        return firmwareVersion
    }
    
    
    
    func setRingBuds(right: Bool, left: Bool, doRing: Bool) {
        
        var byteArray: [UInt8] = [0x00] // Initialize the byte array with a single element

        // Assuming modelBase is a global variable or passed as a parameter
        let modelBase = Codenames.ONE // Replace this with the actual modelBase value as needed

        if modelBase == Codenames.ONE {
            // Set the first byte based on the isRing parameter
            byteArray[0] = doRing ? 0x01 : 0x00
            send(command: 0x02F0, payload: byteArray)
        } else {
            // If modelBase is not "B181", initialize a larger byte array
            byteArray = [0x00, 0x00]
            // Set the first byte based on the isLeft parameter
            byteArray[0] = left ? 0x02 : 0x03
            // Set the second byte based on the isRing parameter
            byteArray[1] = right ? 0x01 : 0x00
            send(command: 0x02F0, payload: byteArray)
        }
        
    }
    

    
    
    private func onDataReceived(rawData: [UInt8]) {
        
        
        // Print hex string of the received data
        var hexString = ""
        for byte in rawData {
            hexString += String(format: "%02x", byte) // Format each byte as a two-digit hex
        }
        print("Hex string: \(hexString)")
        
        // Check if the first byte is 0x55 and if the length is at least 10
        guard rawData.count >= 8, rawData[0] == 0x55 else {
            print("Invalid data: first byte is not 0x55 or data length is less than 10")
            return
        }
        
        // Extract the header (first 6 bytes)
        let header = Array(rawData[0..<6])
        
        // Get the command from the header
        let command = getCommand(header: header)
        
        
        
        switch command {
            
        case Commands.READ_FIRMWARE.rawValue:
       
            let firmware = readFirmware(hexArray: rawData)
            nothingDevice?.firmware = firmware
            if (nothingDevice?.sku == SKU.UNKNOWN) {
                nothingDevice?.sku = skuFromFirmware(firmware: firmware)
                guard let sku = nothingDevice?.sku else {
                    return
                }
                nothingDevice?.codename = codenameFromSKU(sku: sku)
            }
            
        case Commands.READ_SERIAL_NUMBER.rawValue:
            
            
            let serial = readSerial(hexPayload: rawData)
            if (!serial.isEmpty) {
                nothingDevice?.serial = serial
                nothingDevice?.sku = skuFromSerial(serial: serial)
        
            }
            
        case Commands.READ_ANC_ONE.rawValue:
            
            readANC(hexArray: rawData)
            
        case Commands.READ_ANC_TWO.rawValue:
            
            readANC(hexArray: rawData)
            
        case Commands.READ_EQ_ONE.rawValue:
            
            let mode = readEQ(hexArray: rawData)
            nothingDevice?.listeningMode = mode
            
        case Commands.READ_EQ_TWO.rawValue:
            
            let mode = readEQ(hexArray: rawData)
            nothingDevice?.listeningMode = mode
            
        case Commands.READ_BATTERY_ONE.rawValue:
            
            readBattery(hexString: rawData)

            
        case Commands.READ_BATTERY_TWO.rawValue:
            
            readBattery(hexString: rawData)
            
            
        case Commands.READ_BATTERY_THREE.rawValue:
            
            readBattery(hexString: rawData)
  
            
        default:
            print("Unhandled command \(command)")
            
        }
        
        if let currentRequest = self.getCurrentRequest() {
            currentRequest.completion(.success(()))
        }
        processNextRequest()
        
    }
    
    private func getCommand(header: [UInt8]) -> UInt16 {
        // Print the header for debugging
        print("header: \(header)")
        
        // Extract command bytes from the header (bytes 3 and 4)
        let commandBytes = Array(header[3..<5])
        print("commandBytes: \(commandBytes)")
        
        // Convert command bytes to a UInt16
        let commandInt = (UInt16(commandBytes[0]) | (UInt16(commandBytes[1]) << 8))
        print("commandInt: \(commandInt)")
        
        return commandInt
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}


extension String {
    var nonEmpty: String? {
        return isEmpty ? nil : self
    }
}

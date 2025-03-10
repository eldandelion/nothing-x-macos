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
    let operationID: UInt8
    let payload: [UInt8]
    let completion: (Result<Void, Error>) -> Void
    let requestTimeout: TimeInterval
    let responseTimeout: TimeInterval
    var retryCount: Int = 0 // Track the number of retries
}

class NothingServiceImpl : NothingService {
    
    static let shared = NothingServiceImpl()
    
    private var cancellables = Set<AnyCancellable>()
    private let bluetoothManager = BluetoothManager.shared
    private var currentRequest: Request? = nil
    
    private let classOfNothing:UInt32 = 2360324
    // A queue to hold requests
    private var requestQueue: [Request] = []
    // A semaphore to control access to the queue
    private let queueSemaphore = DispatchSemaphore(value: 1)
    private let maxRetries = 3
    // A flag to indicate if a request is currently being processed
    private var isProcessing = false

    private var nothingDevice: NothingDeviceFDTO? = nil
    
    private init() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.CONNECTED.rawValue), object: nil, queue: .main) { notification in
            // Handle the notification here
            if let device = notification.object as? BluetoothDeviceEntity {
                
                    
                    self.nothingDevice = NothingDeviceFDTO(bluetoothDetails: device)
                    print("Nothing Device object has been created \(self.nothingDevice?.name)")
                    
                    NotificationCenter.default.post(name: Notification.Name(DataNotifications.CONNECTED.rawValue), object: self.nothingDevice)
                
            }
        }
     

        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.DATA_RECEIVED.rawValue), object: nil, queue: .main) { notification in
            // Handle the notification here
            if let userInfo = notification.userInfo, let data = userInfo["data"] as? [UInt8] {
                if let userInfo = notification.userInfo, let data = userInfo["data"] as? [UInt8] {
                    print("Data received in Nothing Service: \(data)")
                    
                    self.onDataReceived(rawData: data)
                }
            }
        }
        
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let deviceFramework = notification.object as? NothingDeviceFDTO {
                print("Class has been updated in repository")
                
                let nothingDevice = NothingDeviceFDTO.toEntity(deviceFramework)
                
                NotificationCenter.default.post(name: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nothingDevice, userInfo: nil)
            }
        }
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.FOUND.rawValue), object: nil, queue: .main) { notification in
            
           print("Found device")
            if let bluetoothDevice = notification.object as? BluetoothDeviceEntity {
                
                NotificationCenter.default.post(name: Notification.Name(DataNotifications.FOUND.rawValue), object: bluetoothDevice, userInfo: nil)
                
            }
        }
        
    }
    

    func switchGesture(device: DeviceType, gesture: GestureType, action: UInt8) {
        let payload: [UInt8] = [0x01, device.rawValue, 0x01, gesture.rawValue, action]
        
        addRequest(command: Commands.SET_GESTURE, operationID: Commands.SET_GESTURE.firstEightBits, requestTimeout: 1000, responseTimeout: 1000, payload: payload) {
            
            result in
            switch result {
            case .success:
                print("Successfully switched gesture settings")
                self.updateGestureInNothing(deviceType: device, gestureType: gesture, action: action)
                
            case .failure(let error):
                print("Failed to switch gesture settings: \(error.localizedDescription)")
                
            }
        }
    }
    
    func stopNothingDiscovery() {
        bluetoothManager.stopDeviceInquiry()
    }
    
    func switchLowLatency(mode: Bool) {
        
        var array: [UInt8] = [0x02, 0x00]
        if (mode) {
            array[0] = 0x01
        }
        
        addRequest(command: Commands.SET_LATENCY, operationID: Commands.SET_LATENCY.firstEightBits, requestTimeout: 1000, responseTimeout: 1000, payload: array) {
            result in
            switch result {
            case .success:
                print("Successfully changed latency settings")
                self.nothingDevice?.isLowLatencyOn = mode
            case .failure(let error):
                print("Failed to change latency settings: \(error.localizedDescription)")
                
            }
        }
        
    }
    
    func switchInEarDetection(mode: Bool) {
        var array: [UInt8] = [0x01, 0x01, 0x00]
        
        if (mode) {
            array[2] = 0x01
        }
        
        addRequest(command: Commands.SET_IN_EAR_STATUS, operationID: Commands.SET_IN_EAR_STATUS.firstEightBits, requestTimeout: 1000, responseTimeout: 1000, payload: array) {
            result in
            switch result {
            case .success:
                print("Successfully switched in ear detection")
                self.nothingDevice?.isInEarDetectionOn = mode
            case .failure(let error):
                print("Failed to fetch eq: \(error.localizedDescription)")
                
            }
        }
    }
    
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
        
        
        addRequest(command: Commands.SET_ANC, operationID: Commands.SET_ANC.firstEightBits, requestTimeout: 1000, responseTimeout: 1000, payload: byteArray) {
            result in
            switch result {
            case .success:
                print("Successfully changed ANC settings")
                self.nothingDevice?.anc = mode
            case .failure(let error):
                print("Failed to change ANC settings: \(error.localizedDescription)")
                
            }
        }
        
        
    }
    
    func switchEQ(mode: EQProfiles) {
        var byteArray: [UInt8] = [0x00, 0x00]
        
        byteArray[0] = mode.rawValue
        if (nothingDevice == nil) {
            print("The nothing device is nil")
        }
        
        
        addRequest(command: Commands.SET_EQ, operationID: Commands.SET_EQ.firstEightBits, requestTimeout: 1000, responseTimeout: 1000, payload: byteArray) { result in  // Capture self weakly
                
                switch result {
                case .success:
                    print("Successfully switched in ear detection")
                    self.nothingDevice?.listeningMode = mode
                case .failure(let error):
                    print("Failed to fetch eq: \(error.localizedDescription)")
                }
            }
        
    }
    
    func connectToNothing(device: BluetoothDeviceEntity) {
        bluetoothManager.connectToDevice(address: device.mac, channelID: device.channelId)
    }
    
    func disconnect() {
        bluetoothManager.disconnectDevice()
        self.nothingDevice = nil
    }
        
    func discoverNothing() {
        
        let pairedDevices = bluetoothManager.getPaired(withClass: Int(classOfNothing))
        
        let connectedPaired = pairedDevices.filter({ $0.isConnected })
        
        for c in connectedPaired {
            NotificationCenter.default.post(name: Notification.Name(DataNotifications.FOUND.rawValue), object: c, userInfo: nil)
        }
        
        bluetoothManager.startDeviceInquiry(withClass: classOfNothing)
        
    }
    
    func isNothingConnected() -> BluetoothDeviceEntity? {
        return nothingDevice?.bluetoothDetails
    }
    
    func isNothingConnected() -> Bool {
        return bluetoothManager.isDeviceConnected()
    }
    
    func connectToNothing(address: String) {
        bluetoothManager.connectToDevice(address: address, channelID: 15)
    }
    
    func fetchData() {
        
        print("fetching data")
 
        #warning("there is a change that device gets disconnected during transfer but it is low since it takes less than a second to fetch the data will fix it in the future")
        print("Nothing is connected \(isNothingConnected())")
        print("Nothing device \(nothingDevice != nil)")
        
        if isNothingConnected() && nothingDevice != nil {
            
            print("adding request")
            
            
            addRequest(command: Commands.GET_SERIAL_NUMBER, operationID: Commands.GET_SERIAL_NUMBER.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched serial number.")
                case .failure(let error):
                    print("Failed to fetch serial number: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_FIRMWARE, operationID: Commands.GET_FIRMWARE.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched firmware number.")
                case .failure(let error):
                    print("Failed to fetch firmware number: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_BATTERY, operationID: Commands.GET_BATTERY.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched battery settings.")
                case .failure(let error):
                    print("Failed to fetch battery settings: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_ANC, operationID: Commands.GET_ANC.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched ANC settings.")
                case .failure(let error):
                    print("Failed to fetch ANC settings: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_EQ, operationID: Commands.GET_EQ.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched eq settings")
                case .failure(let error):
                    print("Failed to fetch eq: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_LATENCY, operationID: Commands.GET_LATENCY.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched latency settings")
                case .failure(let error):
                    print("Failed to fetch eq: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_IN_EAR_STATUS, operationID: Commands.GET_IN_EAR_STATUS.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched in ear status")
                case .failure(let error):
                    print("Failed to fetch eq: \(error.localizedDescription)")
                    
                }
            }
            
            addRequest(command: Commands.GET_GESTURES, operationID: Commands.GET_GESTURES.firstEightBits, requestTimeout: 1000, responseTimeout: 1000) {
                result in
                switch result {
                case .success:
                    print("Successfully fetched gestures")
                case .failure(let error):
                    print("Failed to gestures: \(error.localizedDescription)")
                    
                }
            }

            
        }
        
    }

    
    #warning("low latency mode switch is not implemented")
    
    private func send(command: UInt16, operationID: UInt8, payload: [UInt8] = []) {
        var header: [UInt8] = [0x55, 0x60, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00]
        
        header[7] = UInt8(operationID)
        print("OPERATION \(operationID)")
        
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
        print("Log queue: processing next request")
        queueSemaphore.wait()
        
        // Check if there are requests in the queue
        guard !requestQueue.isEmpty else {
            print("Log queue: queue is empty")
            isProcessing = false
            queueSemaphore.signal()
            return
        }
        
        // Get the next request from the queue
        var request = requestQueue.removeFirst()
        currentRequest = request
        print("Log queue: first request in queue is \(request.operationID)")
        isProcessing = true
        queueSemaphore.signal()
        
        // Set a timeout for the request
        let requestTimeout = DispatchTime.now() + request.requestTimeout
        DispatchQueue.global().asyncAfter(deadline: requestTimeout) {
            if self.isProcessing {
                print("Request timed out, attempting to repeat")
                // Increment the retry count
                request.retryCount += 1
                
                // Check if the retry count exceeds the maximum allowed
                if request.retryCount <= self.maxRetries {
                    // Re-add the request to the queue
                    self.queueSemaphore.wait()
                    self.requestQueue.append(request) // Re-add the request
                    self.queueSemaphore.signal()
                    
                    // Call the completion handler with a timeout error
                    request.completion(.failure(DeviceError.timeoutError("Request timed out.")))
                    self.isProcessing = false
                    
                    // Process the next request
                    self.processNextRequest()
                } else {
                    // Handle the case where the maximum retries have been reached
                    print("Maximum retries reached for request. Not re-adding to queue.")
                    request.completion(.failure(DeviceError.timeoutError("Maximum retries reached.")))
                    self.isProcessing = false
                    
                    // Process the next request
                    self.processNextRequest()
                }
            }
        }
        
        // Send the command and handle the response
        send(command: request.command.rawValue, operationID: request.operationID, payload: request.payload)
    }
    
    // Function to add a request to the queue
    private func addRequest(command: Commands, operationID: UInt8, requestTimeout: TimeInterval, responseTimeout: TimeInterval, payload: [UInt8] = [], completion: @escaping (Result<Void, Error>) -> Void) {
        
        let requestTimeoutInSeconds = TimeInterval(requestTimeout) / 1000.0
        let responseTimeoutInSeconds = TimeInterval(responseTimeout) / 1000.0
        
        let request = Request(command: command, operationID: operationID, payload: payload, completion: completion, requestTimeout: requestTimeoutInSeconds, responseTimeout: responseTimeoutInSeconds)
        
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
    
    private func readGestures(hexArray: [UInt8]) -> [(deviceType: DeviceType, gestureType: GestureType, action: UInt8)] {
        let gestureCount: UInt8 = hexArray[8]
        
        var array: [(deviceType: DeviceType, gestureType: GestureType, action: UInt8)] = []
        
        for i in 0..<gestureCount { // Loop from 0 to gestureCount - 1
            
            let device = DeviceType(rawValue: hexArray[9 + Int(i) * 4]) // Assign values from hexString to the dictionary
            
            let common = hexArray[10 + Int(i) * 4]
            let gesture = GestureType(rawValue: hexArray[11 + Int(i) * 4])
            
            if let device = device, let gesture = gesture {
                array.append((deviceType: device, gestureType: gesture, action: hexArray[12 + Int(i) * 4]))
            }
            
        }
        
        for a in array {
            print("device \(a.0) " + "gesture \(a.1) " + "action \(a.2)")
        }
        
        return array
        
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
    
    private func readLatencyMode(hexArray: [UInt8]) -> Bool {
        print("readLatency called")
        return (hexArray[8] != 0)
    }
    
    private func readInEarDetection(hexArray: [UInt8]) -> Bool {
        print("readInEar called")
        return (hexArray[10] != 0)
    }

    
    private func setRingBuds(right: Bool, left: Bool, doRing: Bool) {
        
        var byteArray: [UInt8] = [0x00] // Initialize the byte array with a single element

        // Assuming modelBase is a global variable or passed as a parameter
        let modelBase = Codenames.ONE // Replace this with the actual modelBase value as needed

        if modelBase == Codenames.ONE {
            // Set the first byte based on the isRing parameter
            byteArray[0] = doRing ? 0x01 : 0x00
            send(command: Commands.SET_RING_BUDS.rawValue, operationID: Commands.SET_RING_BUDS.firstEightBits, payload: byteArray)
        } else {
            // If modelBase is not "B181", initialize a larger byte array
            byteArray = [0x00, 0x00]
            // Set the first byte based on the isLeft parameter
            byteArray[0] = left ? 0x02 : 0x03
            // Set the second byte based on the isRing parameter
            byteArray[1] = right ? 0x01 : 0x00
            send(command: Commands.SET_RING_BUDS.rawValue, operationID: Commands.SET_RING_BUDS.firstEightBits, payload: byteArray)
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
        
        
        let executedOperationID = rawData[7]
        
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
            
        case Commands.READ_LATENCY.rawValue:
            
            let latency = readLatencyMode(hexArray: rawData)
            print("LATENCY \(latency)")
            nothingDevice?.isLowLatencyOn = latency
            
        case Commands.READ_IN_EAR_MODE.rawValue:
            
            let inEarMode = readInEarDetection(hexArray: rawData)
            print("IN EAR MODE \(inEarMode)")
            nothingDevice?.isInEarDetectionOn = inEarMode
            
        case Commands.READ_GESTURES.rawValue:
            let result = readGestures(hexArray: rawData)
            for device in result {
                updateGestureInNothing(deviceType: device.0, gestureType: device.1, action: device.2)
            }
            
        default:
            print("Unhandled command \(command)")
            
        }
        
        print(self.getCurrentRequest()?.command ?? "current request is nil")
        if let currentRequest = currentRequest {
            
            print("Current request is \(currentRequest.operationID)")
            print("Executed request is \(executedOperationID)")
            if currentRequest.operationID == executedOperationID as UInt8 {
                currentRequest.completion(.success(()))
            }
        }
        processNextRequest()
        
    }
    
    private func updateGestureInNothing(deviceType: DeviceType, gestureType: GestureType, action: UInt8) {
        if deviceType == .LEFT {
            if gestureType == .TAP_AND_HOLD {
                nothingDevice?.tapAndHoldGestureActionLeft = TapAndHoldGestureActions(rawValue: action) ?? TapAndHoldGestureActions.NO_EXTRA_ACTION
            }
            if gestureType == .TRIPLE_TAP {
                nothingDevice?.tripleTapGestureActionLeft = TripleTapGestureActions(rawValue: action) ?? TripleTapGestureActions.NO_EXTRA_ACTION
            }
        } else if deviceType == .RIGHT {
            if gestureType == .TAP_AND_HOLD {
                nothingDevice?.tapAndHoldGestureActionRight = TapAndHoldGestureActions(rawValue: action) ?? TapAndHoldGestureActions.NO_EXTRA_ACTION
            }
            if gestureType == .TRIPLE_TAP {
                nothingDevice?.tripleTapGestureActionRight = TripleTapGestureActions(rawValue: action) ?? TripleTapGestureActions.NO_EXTRA_ACTION
            }
        }
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

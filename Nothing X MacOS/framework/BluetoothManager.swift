//
//  BluetoothManager.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//

import Foundation
import IOBluetooth
import CoreBluetooth


class BluetoothManager: NSObject, IOBluetoothDeviceInquiryDelegate, IOBluetoothRFCOMMChannelDelegate, CBCentralManagerDelegate {

    static let shared = BluetoothManager()

    private var device: IOBluetoothDevice?
    private var channel: IOBluetoothRFCOMMChannel?
    private var deviceInquiry: IOBluetoothDeviceInquiry?
    private var connectedDevice: IOBluetoothDevice?
    private var rfcommChannel: IOBluetoothRFCOMMChannel?
    private var centralManager: CBCentralManager!
    private var deviceClass: UInt32? = nil
    private var bluetoothState: BluetoothStates = .OFF
    

    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            bluetoothState = .ON
            print("Bluetooth is ON")
            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.BLUETOOTH_ON.rawValue), object: nil)
            
        case .poweredOff:
            bluetoothState = .OFF
            print("Bluetooth is OFF")
            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.BLUETOOTH_OFF.rawValue), object: nil)
        case .resetting:
            print("Bluetooth is resetting")
        case .unauthorized:
            print("Bluetooth is unauthorized")
        case .unsupported:
            print("Bluetooth is unsupported")
        case .unknown:
            print("Bluetooth state is unknown")
        @unknown default:
            print("A previously unknown state occurred")
        }
    }
    
    func isBluetoothEnabled() -> Bool {
        return centralManager.state == .poweredOn
    }
    
    func isDeviceConnected() -> Bool {
        
        return device?.isConnected() ?? false
    }

    func getPaired(withClass: Int) -> [BluetoothDeviceEntity] {
        return IOBluetoothDevice.pairedDevices()
            .compactMap { $0 as? IOBluetoothDevice } // Safely unwrap and cast to IOBluetoothDevice
            .filter { $0.classOfDevice == withClass } // Filter by the specified device class
            .map { device in
                // Create an instance of BluetoothDevice
                BluetoothDeviceEntity(
                    name: device.name ?? "Unknown",
                    mac: device.addressString,
                    channelId: 15, // Set channelId as needed; using 0 as a placeholder
                    isPaired: true, // Assuming these devices are paired
                    isConnected: device.isConnected()
                )
            }
    }

        
    func startDeviceInquiry(withClass: UInt32) {
        if deviceInquiry == nil {
            
            deviceInquiry = IOBluetoothDeviceInquiry(delegate: self)
            deviceInquiry?.start()
            deviceClass = withClass
            print("Looking for devices")
            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.SEARCHING.rawValue), object: nil)
        }
    }
    
    
    func deviceInquiryComplete(_ sender: IOBluetoothDeviceInquiry!, error: IOReturn, aborted: Bool) {
        deviceInquiry = nil
        print("Device inquiry complete.")
        deviceClass = nil
        NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.SEARCHING_COMPLETE.rawValue), object: nil)
    }
    
    func deviceInquiryDeviceFound(_ sender: IOBluetoothDeviceInquiry!, device: IOBluetoothDevice!) {
        
        print("inquiry called")
    
        if (device.classOfDevice == deviceClass) {
            
            let bluetoothDevice = BluetoothDeviceEntity(name: device.name, mac: device.addressString, channelId: 15, isPaired: false, isConnected: false)
           
            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.FOUND.rawValue), object: bluetoothDevice)
        }
        
    }
    
    
    
    func connectToDevice(address: String, channelID: UInt8) {
        
        
        stopDeviceInquiry()
        
        DispatchQueue.global(qos: .userInitiated).async {
                // Check if the device is already connected
                print("Connecting to device \(address)")
                if !(self.device?.isConnected() ?? false) {
                    self.device = IOBluetoothDevice(addressString: address)
                    
                    // Open a connection to the device
                    let resultConnection = self.device?.openConnection()
                    if resultConnection == kIOReturnSuccess {
                        print("Connected to device")
                        let bluetoothDevice = BluetoothDeviceEntity(name: self.device!.name, mac: address, channelId: channelID, isPaired: true, isConnected: true)
                        
                        // Notify on the main thread
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.CONNECTED.rawValue), object: bluetoothDevice)
                            
                        }
                    } else {
                        print("Failed to connect to device")
                        DispatchQueue.main.async {
                            self.device = nil
                            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.FAILED_TO_CONNECT.rawValue), object: nil)
                            
                        }
                        return
                    }
                    
                    // Open an RFCOMM channel to the device
                    
                    let resultRFCOMM = self.device?.openRFCOMMChannelAsync(&self.channel, withChannelID: channelID, delegate: self)
                    
                    if resultRFCOMM == kIOReturnSuccess {
                        print("Opened RFCOMM channel")
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil)
                        }
                    } else {
                        print("Failed to open RFCOMM channel")
                        self.device = nil
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.FAILED_RFCOMM_CHANNEL.rawValue), object: nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil)
                        
                    }
                }
            }
        
    }
    
    func send(data: UnsafeMutableRawPointer!, length: UInt16) {
        channel?.writeSync(data, length: length)
    }
    
    func rfcommChannelData(_ rfcommChannel: IOBluetoothRFCOMMChannel!, data dataPointer: UnsafeMutableRawPointer!, length dataLength: Int) {
        
        // Create Data object from the received bytes
        let data = Data(bytes: dataPointer, count: dataLength)
        
        // Convert Data to [UInt8] (byte array)
        let rawData = [UInt8](data)
        
        NotificationCenter.default.post(name: Notification.Name(DataNotifications.DATA_RECEIVED.rawValue), object: nil, userInfo: ["data": rawData])
        
    }
    
    
    func rfcommChannelClosed(_ channel: IOBluetoothRFCOMMChannel) {
        print("RFCOMM channel closed.")
        self.device = nil
        self.channel = nil
        NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.CLOSED_RFCOMM_CHANNEL.rawValue), object: nil)
    }

    func disconnectDevice() {
        if let channel = self.channel {
            channel.close() // This should trigger rfcommChannelClosed delegate method
            self.channel = nil // Ensure it's set to nil immediately
        }
        
        // 2. Close the Connection to the Device
        if let device = self.device, device.isConnected() {
            device.closeConnection()
        }
        self.device = nil // Ensure it's set to nil immediately
        
        // 3. Stop Device Inquiry (if running) - important to prevent further connections
        if let inquiry = self.deviceInquiry {
            inquiry.stop()
            self.deviceInquiry = nil
        }
        
        // 4. Clear any stored device information
        connectedDevice = nil
        rfcommChannel = nil
        
        // 5. Post a Notification (optional, but good practice)
        NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.DISCONNECTED.rawValue), object: nil)
        
        print("Disconnected from device.")
    }
    
    func stopDeviceInquiry() {
        deviceInquiry?.stop()
    }

   
}

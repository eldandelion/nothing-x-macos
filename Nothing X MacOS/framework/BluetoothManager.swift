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
    

    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is ON")
            NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.BLUETOOTH_ON.rawValue), object: nil)
            
        case .poweredOff:
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

    
    func getPairedByClass(deviceClass: Int) -> [(address: String, name: String)] {
        return IOBluetoothDevice.pairedDevices()
            .compactMap { $0 as? IOBluetoothDevice } // Safely unwrap and cast to IOBluetoothDevice
            .filter { $0.classOfDevice == deviceClass } // Filter by the specified device class
            .map { (address: $0.addressString, name: $0.name ?? "Unknown") } // Create tuples of (address, name)
    }

        
    func startDeviceInquiry() {
        deviceInquiry = IOBluetoothDeviceInquiry(delegate: self)
        deviceInquiry?.start()
        print("Looking for devices")
    }
    
    func deviceInquiryComplete(_ sender: IOBluetoothDeviceInquiry) {
        print("Device inquiry complete.")
    }
    
    func deviceInquiry(_ sender: IOBluetoothDeviceInquiry, deviceFound device: IOBluetoothDevice) {
        print("Found device: \(device.name ?? "Unknown")")
        if device.name == "Your Earbuds Name" { // Replace with your earbuds' name
            connectedDevice = device
            deviceInquiry?.stop()
            //connectToDevice(device)
        }
    }
    
    func connectToDevice(address: String, channelID: UInt8) {
        
        if !(device?.isConnected() ?? false) {
            device = IOBluetoothDevice(addressString: address)
            
            // Open a connection to the device
            let resultConnection = device?.openConnection()
            if resultConnection == kIOReturnSuccess {
                print("Connected to device")
                NotificationCenter.default.post(name: Notification.Name(DataNotifications.CONNECTED.rawValue), object: nil, userInfo: ["data": address])
                
            } else {
                print("Failed to connect to device")
                NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.FAILED_TO_CONNECT.rawValue), object: nil)
                return
            }
            
            // Open an RFCOMM channel to the device
            let resultRFCOMM = device?.openRFCOMMChannelAsync(&channel, withChannelID: channelID, delegate: self)
            
            
            if resultRFCOMM == kIOReturnSuccess {
                print("Opened RFCOMM channel")
                NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.OPENNED_RFCOMM_CHANNEL.rawValue), object: nil)
                
            } else {
                print("Failed to open RFCOMM channel")
                NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.FAILED_RFCOMM_CHANNEL.rawValue), object: nil)
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
        NotificationCenter.default.post(name: Notification.Name(BluetoothNotifications.CLOSED_RFCOMM_CHANNEL.rawValue), object: nil)
    }
    


}

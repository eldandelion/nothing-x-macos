//
//  MainViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/19.
//

import Foundation

class MainViewViewModel : ObservableObject {
    
    
    
    private let bluetoothService: BluetoothService
    private let nothingService: NothingService = NothingServiceImpl()
    
    private let jsonEncoder: JsonEncoder = JsonEncoder(fileName: "configurations")
    private let nothingRepository: NothingRepository
    
    @Published var rightBattery: Double? = nil
    @Published var leftBattery: Double? = nil
    
    @Published var currentDestination: Destination? // Published property for destination
    @Published var nothingDevice: NothingDeviceEntity?
    
    init(bluetoothService: BluetoothService, nothingRepository: NothingRepository) {
        
        self.bluetoothService = bluetoothService
        self.nothingRepository = nothingRepository
        
 
        
//        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.FOUND.rawValue), object: nil, queue: .main) { notification in
//            
//            if let bluetoothDevice = notification.object as? BluetoothDeviceEntity {
//                
//                print("discovered device")
//                print("address: \(bluetoothDevice.mac)")
//                self.nothingService.connectToNothing(device: bluetoothDevice)
//                
//                
//            }
//        }
        
//        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) { notification in
//        
//                self.nothingService.fetchData()
//
//        }
        
        
        
//        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
//            
//            if let nothingDevice = notification.object as? NothingDeviceEntity {
//                
//                self.jsonEncoder.addOrUpdateDevice(nothingDevice.toDTO())
//                
//            }
//        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.CLOSED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
            self.currentDestination = .connect
            self.leftBattery = nil
            self.rightBattery = nil
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
            self.nothingService.fetchData()
            
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if self.currentDestination == .connect {
                self.currentDestination = .home
            }
            if let device = notification.object as? NothingDeviceEntity {
                self.nothingDevice = device
                
                self.rightBattery = Double(device.rightBattery)
                self.leftBattery = Double(device.leftBattery)
            }
        }
        
    
        
        
        // Check Bluetooth status and set the destination accordingly
        if !bluetoothService.isBluetoothOn() || !bluetoothService.isDeviceConnected() {
            let devices = nothingRepository.getSaved()
            if (!devices.isEmpty) {
                currentDestination = .connect
            } else {
                // go to discover
            }
            
        } else {
            currentDestination = .home // Default destination
        }
        
        
    }
    
    
}

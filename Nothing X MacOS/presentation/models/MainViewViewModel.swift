//
//  MainViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/19.
//

import Foundation

class MainViewViewModel : ObservableObject {
    
    
    
    private let bluetoothService: BluetoothService
    
    private let fetchDataUseCase: FetchDataUseCaseProtocol
    
    private let jsonEncoder: JsonEncoder = JsonEncoder(fileName: "configurations")
    private let nothingRepository: NothingRepository
    
    @Published var rightBattery: Double? = nil
    @Published var leftBattery: Double? = nil
    
    @Published var currentDestination: Destination? // Published property for destination
    @Published var nothingDevice: NothingDeviceEntity?
    
    init(bluetoothService: BluetoothService, nothingRepository: NothingRepository, nothingService: NothingService) {
        
        self.bluetoothService = bluetoothService
        self.nothingRepository = nothingRepository
        self.fetchDataUseCase = FetchDataUseCase(service: nothingService)
 
        

        
//        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) { notification in
//        
//                self.nothingService.fetchData()
//
//        }
        
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.CLOSED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
            self.currentDestination = .connect
            self.leftBattery = nil
            self.rightBattery = nil
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
            self.fetchDataUseCase.fetchData()
            
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
#warning("if there is a device currently connected and you are trying to connect or discover another device at some point it might just snap to home screen")
            if self.currentDestination == .connect || self.currentDestination == .discover {
                self.currentDestination = .home
            }
            if let device = notification.object as? NothingDeviceEntity {
                self.nothingDevice = device
                self.jsonEncoder.addOrUpdateDevice(device.toDTO())
                
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
                currentDestination = .discover
            }
            
        } else {
            currentDestination = .home // Default destination
        }
        
        
    }
    
    
}

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
    
    @Published var nothingDevice: NothingDeviceEntity?
    @Published var isDeviceNotConnected: Bool = true
    @Published var areDevicesNotSaved: Bool = false
    @Published var eqProfiles: EQProfiles = .BALANCED
    
    init(bluetoothService: BluetoothService, nothingRepository: NothingRepository, nothingService: NothingService) {
        
        self.bluetoothService = bluetoothService
        self.nothingRepository = nothingRepository
        self.fetchDataUseCase = FetchDataUseCase(service: nothingService)
 
    
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.CLOSED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
//            self.currentDestination = .connect
            
            self.leftBattery = nil
            self.rightBattery = nil
            self.isDeviceNotConnected = true
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
            self.fetchDataUseCase.fetchData()
            self.isDeviceNotConnected = false
            self.areDevicesNotSaved = false
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.FAILED_TO_CONNECT.rawValue), object: nil, queue: .main) {
            notification in
            
            
//            self.isDeviceNotConnected = false
//            self.areDevicesNotSaved = false
            //show that it failed to connect
            
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
#warning("if there is a device currently connected and you are trying to connect or discover another device at some point it might just snap to home screen")
//            if self.currentDestination == .connect || self.currentDestination == .discover {
//                self.currentDestination = .home
//            }
            if let device = notification.object as? NothingDeviceEntity {
                self.nothingDevice = device
                self.eqProfiles = device.listeningMode
                
                self.jsonEncoder.addOrUpdateDevice(device.toDTO())
                
                self.rightBattery = Double(device.rightBattery)
                self.leftBattery = Double(device.leftBattery)
            }
        }
        
    
        
        
        // Check Bluetooth status and set the destination accordingly
        if !bluetoothService.isBluetoothOn() || !bluetoothService.isDeviceConnected() {
            let devices = nothingRepository.getSaved()
            if (devices.isEmpty) {
                areDevicesNotSaved = true
            }
        }
        
        
    }
    
    
}

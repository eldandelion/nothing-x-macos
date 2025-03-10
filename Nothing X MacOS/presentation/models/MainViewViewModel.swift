//
//  MainViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/19.
//

import Foundation
import SwiftUI

class MainViewViewModel : ObservableObject {
    
    
    private let bluetoothService: BluetoothService
    
    private let fetchDataUseCase: FetchDataUseCaseProtocol
    private let disconnectDeviceUseCase: DisconnectDeviceUseCaseProtocol
    private let getSavedDevicesUseCase: GetSavedDevicesUseCaseProtocol
    
    private let jsonEncoder: JsonEncoder = JsonEncoder.shared
    private let nothingRepository: NothingRepository
    
    @Published var rightBattery: Double? = nil
    @Published var leftBattery: Double? = nil
    
    @Published var nothingDevice: NothingDeviceEntity?

    @Published var eqProfiles: EQProfiles = .BALANCED
    @Published var navigationPath = NavigationPath()
    
    @Published var leftTripleTapAction: TripleTapGestureActions = .NO_EXTRA_ACTION
    @Published var rightTripleTapAction: TripleTapGestureActions = .SKIP_BACK
    @Published var leftTapAndHoldAction: TapAndHoldGestureActions = .NO_EXTRA_ACTION
    @Published var rightTapAndHoldAction: TapAndHoldGestureActions = .NOISE_CONTROL
    
    
    
    init(bluetoothService: BluetoothService, nothingRepository: NothingRepository, nothingService: NothingService) {
        
        self.bluetoothService = bluetoothService
        self.nothingRepository = nothingRepository
        self.fetchDataUseCase = FetchDataUseCase(service: nothingService)
        self.disconnectDeviceUseCase = DisconnectDeviceUseCase(nothingService: nothingService)
        self.getSavedDevicesUseCase = GetSavedDevicesUseCase(nothingRepository: nothingRepository)
 
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.CLOSED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
                        
            self.leftBattery = nil
            self.rightBattery = nil
            
            withAnimation {
                if self.getSavedDevicesUseCase.getSaved().isEmpty {
                    self.navigationPath.append(Destination.discover)
                } else {
                    self.navigationPath.append(Destination.connect)
                }
            }
  
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
            self.fetchDataUseCase.fetchData()
            self.navigationPath.append(Destination.home)
        }
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(RepositoryNotifications.CONFIGURATION_DELETED.rawValue), object: nil, queue: .main) {
            notification in
            
            self.disconnectDeviceUseCase.disconnectDevice()
            
            self.navigationPath.append(Destination.discover)
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
#warning("if there is a device currently connected and you are trying to connect or discover another device at some point it might just snap to home screen")
//            if self.currentDestination == .connect || self.currentDestination == .discover {
//                self.currentDestination = .home
//            }
            if let device = notification.object as? NothingDeviceEntity {
                self.nothingDevice = device
                withAnimation {
                    self.eqProfiles = device.listeningMode
                    self.rightTripleTapAction = device.tripleTapGestureActionRight
                    self.leftTripleTapAction = device.tripleTapGestureActionLeft
                    self.rightTapAndHoldAction = device.tapAndHoldGestureActionRight
                    self.leftTapAndHoldAction = device.tapAndHoldGestureActionLeft
                }
                
                self.jsonEncoder.addOrUpdateDevice(device.toDTO())
                
                self.rightBattery = Double(device.rightBattery)
                self.leftBattery = Double(device.leftBattery)
            }
        }
        
    
        // Check Bluetooth status and set the destination accordingly
        if !bluetoothService.isBluetoothOn() || !bluetoothService.isDeviceConnected() {
            let devices = nothingRepository.getSaved()
            if (devices.isEmpty) {
                navigationPath.append(Destination.discover)
            } else {
                navigationPath.append(Destination.connect)
            }
        }
        
        
    }
    
    func navigateToBluetoothIsOff() {
        navigationPath.append(Destination.bluetooth_off)
    }
    
    
}

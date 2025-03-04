//
//  DiscoverViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/28.
//

import Foundation

class DiscoverViewViewModel : ObservableObject {
    
    
    private let discoverNothingUseCase: DiscoverNothingUseCaseProtocol
    private let connectToNothingUseCase: ConnectToNothingUseCaseProtocol
    private let isNothingConnectedUseCase: IsNothingConnectedUseCaseProtocol
    
    
    
    @Published var viewState: DiscoverStates = .not_discovering
    @Published var deviceName: String = ""
    
    private var discoveredDevice: BluetoothDeviceEntity? = nil
    
    init(nothingService: NothingService) {
        self.discoverNothingUseCase = DiscoverNothingUseCase(nothingService: nothingService)
        self.connectToNothingUseCase = ConnectToNothingUseCase(nothingService: nothingService)
        self.isNothingConnectedUseCase = IsNothingConnectedUseCase(nothingService: nothingService)
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.FOUND.rawValue), object: nil, queue: .main) { notification in
            
            if let bluetoothDevice = notification.object as? BluetoothDeviceEntity {
                
                
                
                self.discoveredDevice = bluetoothDevice
                self.deviceName = bluetoothDevice.name
                self.viewState = .found
                
                
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.SEARCHING_COMPLETE.rawValue), object: nil, queue: .main) {
            notification in
            
            if (self.discoveredDevice == nil) {
                self.viewState = .not_found
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.FAILED_TO_CONNECT.rawValue), object: nil, queue: .main) {
            notification in
            
            
                self.viewState = .failed_to_connect
            
            
            
        }

        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.OPENED_RFCOMM_CHANNEL.rawValue), object: nil, queue: .main) {
            notification in
            
//            self.viewState = .not_discovering
            #warning("might still be showing discovering after reopen")
            
        
        }

    }
    
    
    
    func startDiscovery() {
        
        viewState = .discovering
        discoverNothingUseCase.discoverNothing()
        
    }
    
    func connectToDevice() {
        
        viewState = .connecting
        
        let connectedDevice: BluetoothDeviceEntity? = isNothingConnectedUseCase.isNothingConnected()
        
        
        if let discoveredDevice = discoveredDevice {
            if let connectedDevice = connectedDevice {
                if (connectedDevice.mac == discoveredDevice.mac) {
                    //fetch data and navigate to home screen
                    return
                }
            }
            connectToNothingUseCase.connectToNothing(device: discoveredDevice)
        }
        
        
    }
    
}

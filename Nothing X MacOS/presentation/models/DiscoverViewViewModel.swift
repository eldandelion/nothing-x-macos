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
    private let isBluetoothOnUseCase: IsBluetoothOnUseCaseProtocol
    @Published var destination: Destination = .discover_started
    
    
    private var discoveredDevice: BluetoothDeviceEntity? = nil
    
    init(nothingService: NothingService, bluetoothService: BluetoothService) {
        self.discoverNothingUseCase = DiscoverNothingUseCase(nothingService: nothingService)
        self.connectToNothingUseCase = ConnectToNothingUseCase(nothingService: nothingService)
        self.isNothingConnectedUseCase = IsNothingConnectedUseCase(nothingService: nothingService)
        self.isBluetoothOnUseCase = IsBluetoothOnUseCase(bluetoothService: bluetoothService)
   
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.BLUETOOTH_ON.rawValue), object: nil, queue: .main) {
            notification in
            
            self.destination = .discover_started
        }
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.BLUETOOTH_OFF.rawValue), object: nil, queue: .main) {
            notification in
            
            self.destination = .bluetooth_off
        }
    }
    
    func checkBluetoothStatus() {
        
        if isBluetoothOnUseCase.isBluetoothOn() {
            destination = .discover_started
        } else {
            destination = .bluetooth_off
        }
    }
    
    
}

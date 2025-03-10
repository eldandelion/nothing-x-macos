//
//  ConnectViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/27.
//
import SwiftUI
import Foundation

class ConnectViewViewModel : ObservableObject {
    
    
    private let nothingRepository: NothingRepository
    private let nothingService: NothingService
    
    @Published var isLoading = false
    @Published var isFailedToConnectPresented = false
    @Published var retry = false
    
    private let isBluetoothOnUseCase: IsBluetoothOnUseCaseProtocol
    @Published var isBluetoothOn = false
    
    
    init(nothingRepository: NothingRepository, nothingService: NothingService, bluetoothService: BluetoothService) {
        
        self.nothingRepository = nothingRepository
        self.nothingService = nothingService
        self.isBluetoothOnUseCase = IsBluetoothOnUseCase(bluetoothService: bluetoothService)
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            self.isLoading = false
            
        }
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.FAILED_TO_CONNECT.rawValue), object: nil, queue: .main) {
            notification in
            
            
            withAnimation {
                self.isFailedToConnectPresented = true
                self.isLoading = false
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(Notifications.REQUEST_RETRY.rawValue), object: nil, queue: .main) {
            notification in
            
            self.connect()
            withAnimation {
                self.isFailedToConnectPresented = false
            }
            
        }
        
    }
    
    func checkBluetoothStatus() {
        isBluetoothOn = isBluetoothOnUseCase.isBluetoothOn()
    }
    
    func connect() {
        isLoading = true
        let devices = nothingRepository.getSaved()
        
        nothingService.connectToNothing(device: devices[0].bluetoothDetails)
    }
    
    
    func retryConnect() {
        connect()
        retry = false
        withAnimation {
            isFailedToConnectPresented = false
        }
        
    }
    
}

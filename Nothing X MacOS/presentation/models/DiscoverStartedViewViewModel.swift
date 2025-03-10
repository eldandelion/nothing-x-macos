//
//  DiscoverStartedViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/9.
//

import Foundation
import SwiftUI
class DiscoverStartedViewViewModel : ObservableObject {
    
    
    private let discoverNothingUseCase: DiscoverNothingUseCaseProtocol
    private let connectToNothingUseCase: ConnectToNothingUseCaseProtocol
    private let isNothingConnectedUseCase: IsNothingConnectedUseCaseProtocol
    private let stopNothingDiscoveryUseCase: StopNothingDiscoveryUseCaseProtocol
    
    private var discoveredDevice: BluetoothDeviceEntity? = nil
    
    @Published var viewState: DiscoverStates = .not_discovering
    
    @Published var deviceName: String = ""
    @Published var discoveryCirclesOffset: CGFloat = 0 //-60 when found
    @Published var shouldShowDevice = false
    @Published var shouldShowDiscoveryCircles = true
    @Published var shouldShowDiscoveryMessage = true
    @Published var shouldShowBudsBackground = false
    @Published var shouldShowDeviceName = false 
    @Published var budsScale = 0.7
    @Published var budsOffsetY: CGFloat = 0 //32 when done
    @Published var budsOffsetX: CGFloat = 170 // 0 when done
    @Published var budsBackgroundsOffsetY: CGFloat = 0 //28 when done
    @Published var budsBackgroundOffsetX: CGFloat = 170 // 0 when done
    @Published var deviceNameOffsetX: CGFloat = 80
    @Published var deviceNameOffsetY: CGFloat = 30
    @Published var deviceNameFontSize: CGFloat = 12
    @Published var showSetUpButton = false
    
    
    @Published var title: String? = "Can't find your device?"
    @Published var text: String? = "Make sure device is on and in discovery mode."
    @Published var topButtonText: String? = "Retry"
    @Published var bottomButtonText: String? = "Cancel"
    @Published var shouldPresentModalSheet = false
    
    
    
    init(nothingService: NothingService) {
        self.discoverNothingUseCase = DiscoverNothingUseCase(nothingService: nothingService)
        self.connectToNothingUseCase = ConnectToNothingUseCase(nothingService: nothingService)
        self.isNothingConnectedUseCase = IsNothingConnectedUseCase(nothingService: nothingService)
        self.stopNothingDiscoveryUseCase = StopNothingDiscoveryUseCase(nothingService: nothingService)
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.FOUND.rawValue), object: nil, queue: .main) { notification in
            
            if let bluetoothDevice = notification.object as? BluetoothDeviceEntity {
                
                
                print("Found device")
                if self.viewState != .found {
                    
                    self.viewState = .found
                    self.discoveredDevice = bluetoothDevice
                    var deviceName = bluetoothDevice.name
                    let components = deviceName.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
                    
                    // Check if there are components after the first space
                    if components.count > 1 {
                        // Join the components after the first one
                        deviceName = components[1...].joined(separator: " ")
                    }
                    
                    self.deviceName = deviceName
          
                    self.objectWillChange.send()
                    withAnimation(.easeInOut(duration: 0.6)) {
                        
                        if self.discoveryCirclesOffset != -60 {
                            self.discoveryCirclesOffset = -60
                        }
                        if self.shouldShowBudsBackground != true {
                            self.shouldShowBudsBackground = true
                        }
                        if self.shouldShowDevice != true {
                            self.shouldShowDevice = true
                        }
                        
                        if self.shouldShowDeviceName != true {
                            self.shouldShowDeviceName = true
                        }
                    }
                    
                    withAnimation(.smooth(duration: 0.6)) {
                        self.budsOffsetX = 0
                        self.budsOffsetY = 32
                        self.budsBackgroundOffsetX = 0
                        self.budsBackgroundsOffsetY = 28
                    }
                }
                
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.SEARCHING_COMPLETE.rawValue), object: nil, queue: .main) {
            notification in
            
            if (self.discoveredDevice == nil) {

                withAnimation {
                    self.viewState = .not_found
                    self.shouldPresentModalSheet = true
                }
                    
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(BluetoothNotifications.FAILED_TO_CONNECT.rawValue), object: nil, queue: .main) {
            notification in
            
            self.viewState = .failed_to_connect
        }

    
        #warning("should handle a state where bluetooth turns off")

    }
    
    
    
    func startDiscovery() {
        
        viewState = .discovering
        shouldPresentModalSheet = false
        discoverNothingUseCase.discoverNothing()
        
    }
    
    func onDeviceSelectClick() {
        
        withAnimation() {
            shouldShowBudsBackground = false
            shouldShowDiscoveryMessage = false
            shouldShowDiscoveryCircles = false
            shouldShowDeviceName = false
        
        }
        
        withAnimation(.smooth(duration: 0.5)) {
            budsOffsetY = -30
            budsScale = 1.0
        }
        
        
        deviceNameOffsetX = 0
        deviceNameOffsetY = 48
        deviceNameFontSize = 16
        withAnimation(.smooth(duration: 0.6)) {
            shouldShowDeviceName = true
            showSetUpButton = true
        }
        
    }
    
    func connectToDevice() {
        
        withAnimation {
            viewState = .connecting
        }
      
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
    
    func stopDeviceDiscovery() {
        stopNothingDiscoveryUseCase.stopNothingDiscovery()
    }
    
    
    
}

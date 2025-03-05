//
//  SettingsViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/3.
//

import Foundation

class SettingsViewViewModel : ObservableObject {
    
    private let switchLatencyUseCase: SwitchLatencyUseCaseProtocol
    private let switchInEarDetectionUseCase: SwitchInEarDetectionUseCaseProtocol
    private let deleteSavedDeviceUseCase: DeleteSavedUseCaseProtocol
    private let getSavedDevicesUseCase: GetSavedDevicesUseCaseProtocol
    private let isNothingConnectedUseCase: IsNothingConnectedUseCaseProtocol
    
    @Published var shouldShowForgetDialog = false
    @Published var latencySwitch = false
    @Published var inEarSwitch = false
    
    @Published var name: String = ""
    @Published var mac: String = ""
    @Published var serial: String = ""
    @Published var firmware: String = ""
    @Published var isNothingDeviceAccessible = false
    
    
    @Published var nothingDevice: NothingDeviceEntity?
    
    
    init(nothingService: NothingService, nothingRepository: NothingRepository) {
        self.switchLatencyUseCase = SwitchLatencyUseCase(nothingService: nothingService)
        self.switchInEarDetectionUseCase = SwitchInEarDetectionUseCase(nothingService: nothingService)
        self.deleteSavedDeviceUseCase = DeleteSavedDeviceUseCase(nothingRepository: nothingRepository)
        self.getSavedDevicesUseCase = GetSavedDevicesUseCase(nothingRepository: nothingRepository)
        self.isNothingConnectedUseCase = IsNothingConnectedUseCase(nothingService: nothingService)
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            

            if let device = notification.object as? NothingDeviceEntity {
                
                print("Settings View latency \(device.isLowLatencyOn)")
                print("Settings View in ear \(device.isInEarDetectionOn)")
                self.latencySwitch = device.isLowLatencyOn
                self.inEarSwitch = device.isInEarDetectionOn
                self.nothingDevice = device
                
                self.name = device.bluetoothDetails.name
                self.mac = device.bluetoothDetails.mac
                self.serial = device.serial
                self.firmware = device.firmware
            }
        }
        
        isNothingDeviceAccessible = isNothingConnectedUseCase.isNothingConnected()
        
        
        let devices = getSavedDevicesUseCase.getSaved()
        if (!devices.isEmpty) {
            name = devices[0].bluetoothDetails.name
            mac = devices[0].bluetoothDetails.mac
            serial = devices[0].serial
            firmware = devices[0].firmware
        }

    }
    
    func switchLatency(mode: Bool) {
        switchLatencyUseCase.switchLatency(mode: mode)
    }
    
    func switchInEarDetection(mode: Bool) {
        switchInEarDetectionUseCase.switchInEarDetection(mode: mode)
    }
    
    func forgetDevice() {
        let devices = getSavedDevicesUseCase.getSaved()
        deleteSavedDeviceUseCase.delete(device: devices[0])
    }
    
    
}

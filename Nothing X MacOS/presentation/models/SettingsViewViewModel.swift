//
//  SettingsViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/3.
//

import Foundation

class SettingsViewViewModel : ObservableObject {
    
    private let switchLatencyUseCase: SwitchLatencyUseCaseProtocol
    private let switchInEarDetectionUseCase: SwitchInEarDetectionUseCase
    private let deleteSavedDeviceUseCase: DeleteSavedUseCaseProtocol
    
    @Published var shouldShowForgetDialog = false
    @Published var latencySwitch = false
    @Published var inEarSwitch = false
    
    private var nothingDevice: NothingDeviceEntity?
    
    init(nothingService: NothingService, nothingRepository: NothingRepository) {
        self.switchLatencyUseCase = SwitchLatencyUseCase(nothingService: nothingService)
        self.switchInEarDetectionUseCase = SwitchInEarDetectionUseCase(nothingService: nothingService)
        self.deleteSavedDeviceUseCase = DeleteSavedDeviceUseCase(nothingRepository: nothingRepository)
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            

            if let device = notification.object as? NothingDeviceEntity {
                print("Settings View latency \(device.isLowLatencyOn)")
                print("Settings View in ear \(device.isInEarDetectionOn)")
                self.latencySwitch = device.isLowLatencyOn
                self.inEarSwitch = device.isInEarDetectionOn
                self.nothingDevice = device
            }
        }

    }
    
    func switchLatency(mode: Bool) {
        switchLatencyUseCase.switchLatency(mode: mode)
    }
    
    func switchInEarDetection(mode: Bool) {
        switchInEarDetectionUseCase.switchInEarDetection(mode: mode)
    }
    
    func forgetDevice() {
        if let nothingDevice = nothingDevice {
            deleteSavedDeviceUseCase.delete(device: nothingDevice)
        }
    }
    
    
}

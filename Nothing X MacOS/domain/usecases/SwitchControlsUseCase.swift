//
//  SwitchControlsUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/8.
//

import Foundation
class SwitchControlsUseCase : SwitchControlsUseCaseProtocol {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func switchGesture(device: DeviceType, gesture: GestureType, action: UInt8) {
        nothingService.switchGesture(device: device, gesture: gesture, action: action)
    }
    
}

//
//  DisconnectDeviceUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation
class DisconnectDeviceUseCase : DisconnectDeviceUseCaseProtocol {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func disconnectDevice() {
        nothingService.disconnect()
    }
}

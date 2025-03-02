//
//  ConnectToNothingUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/28.
//

import Foundation

class ConnectToNothingUseCase : ConnectToNothingUseCaseProtocol {
    
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func connectToNothing(device: BluetoothDeviceEntity) {
        nothingService.connectToNothing(device: device)
    }
    
}

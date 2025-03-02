//
//  IsNothingConnectedUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/28.
//

import Foundation

class IsNothingConnectedUseCase : IsNothingConnectedUseCaseProtocol {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func isNothingConnected() -> Bool {
        return nothingService.isNothingConnected()
    }
    
    func isNothingConnected() -> BluetoothDeviceEntity? {
        return nothingService.isNothingConnected()
    }
}

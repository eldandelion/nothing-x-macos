//
//  IsBluetoothOnUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/10.
//

import Foundation

class IsBluetoothOnUseCase : IsBluetoothOnUseCaseProtocol {
    
    private let bluetoothService: BluetoothService
    
    init(bluetoothService: BluetoothService) {
        self.bluetoothService = bluetoothService
    }
    
    func isBluetoothOn() -> Bool {
        return bluetoothService.isBluetoothOn()
    }
    
}

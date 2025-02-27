//
//  BluetoothServiceImpl.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/19.
//

import Foundation


class BluetoothServiceImpl : BluetoothService {
    
    private let bluetoothManager = BluetoothManager.shared
    
    
    func isBluetoothOn() -> Bool {
        bluetoothManager.isBluetoothEnabled()
    }
    
    func isDeviceConnected() -> Bool {
        bluetoothManager.isDeviceConnected()
    }
    
    
    
}

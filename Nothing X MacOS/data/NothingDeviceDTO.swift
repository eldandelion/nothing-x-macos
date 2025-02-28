//
//  NothingDeviceDTO.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/27.
//

import Foundation

class NothingDeviceDTO : Codable {
    
    
    let name: String
    let serial: String
    let codename: Codenames
    let sku: SKU
    let bluetoothDetails: BluetoothDeviceDTO
    
    init(name: String, serial: String, codename: Codenames, sku: SKU, bluetoothDetails: BluetoothDeviceDTO) {
        self.name = name
        self.serial = serial
        self.codename = codename
        self.sku = sku
        self.bluetoothDetails = bluetoothDetails
    }
    
    
}

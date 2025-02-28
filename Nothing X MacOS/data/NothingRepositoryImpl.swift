//
//  NothingRepositoryImpl.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/25.
//

import Foundation

class NothingRepositoryImpl : NothingRepository {
    
    private let encoder = JsonEncoder(fileName: "configurations")
    
    func getSaved() -> [NothingDeviceEntity] {
        encoder.getAllDevices().toEntities()
    }
    
    func save(device: NothingDeviceEntity) {
        encoder.addOrUpdateDevice(device.toDTO())
    }
    
    func delete(device: NothingDeviceEntity) {
        encoder.deleteDevice(mac: device.bluetoothDetails.mac)
    }
    
    func contains(mac: String) -> Bool {
        #warning("contains is not implemented")
        return true
    }
    
}

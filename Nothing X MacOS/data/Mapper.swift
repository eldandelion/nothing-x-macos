//
//  Mapper.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/27.
//

import Foundation

extension NothingDeviceDTO {
    func toEntity() -> NothingDeviceEntity {
        
        return NothingDeviceEntity(
            name: self.name,
            serial: self.serial,
            codename: self.codename,
            firmware: "nil",
            sku: self.sku,
            leftBattery: 0,
            rightBattery: 0,
            caseBattery: 0,
            isLeftCharging: false,
            isRightCharging: false,
            isCaseCharging: false,
            isLeftConnected: false,
            isRightConnected: false,
            isCaseConnected: false,
            anc: .OFF,
            listeningMode: .BALANCED,
            isLowLatencyOn: false,
            isInEarDetectionOn: false,
            bluetoothDetails: self.bluetoothDetails.toEntity() // Assuming a similar mapping exists for BluetoothDeviceDTO
        )
    }
}

extension NothingDeviceEntity {
    func toDTO() -> NothingDeviceDTO {
        return NothingDeviceDTO(
            name: self.name,
            serial: self.serial,
            codename: self.codename,
            sku: self.sku,
            bluetoothDetails: self.bluetoothDetails.toDTO() // Assuming a similar mapping exists for BluetoothDeviceEntity
        )
    }
}

extension BluetoothDeviceDTO {
    func toEntity() -> BluetoothDeviceEntity {
        return BluetoothDeviceEntity(
            name: self.name,
            mac: self.mac,
            channelId: self.channelId,
            isPaired: self.isPaired,
            isConnected: self.isConnected
        )
    }
}

extension BluetoothDeviceEntity {
    func toDTO() -> BluetoothDeviceDTO {
        return BluetoothDeviceDTO(
            name: self.name,
            mac: self.mac,
            channelId: self.channelId,
            isPaired: self.isPaired,
            isConnected: self.isConnected
        )
    }
}


// Extension for mapping lists of NothingDeviceDTO to NothingDeviceEntity
extension Array where Element == NothingDeviceDTO {
    func toEntities() -> [NothingDeviceEntity] {
        return self.map { $0.toEntity() }
    }
}

// Extension for mapping lists of NothingDeviceEntity to NothingDeviceDTO
extension Array where Element == NothingDeviceEntity {
    func toDTOs() -> [NothingDeviceDTO] {
        return self.map { $0.toDTO() }
    }
}

// Extension for mapping lists of BluetoothDeviceDTO to BluetoothDeviceEntity
extension Array where Element == BluetoothDeviceDTO {
    func toEntities() -> [BluetoothDeviceEntity] {
        return self.map { $0.toEntity() }
    }
}

// Extension for mapping lists of BluetoothDeviceEntity to BluetoothDeviceDTO
extension Array where Element == BluetoothDeviceEntity {
    func toDTOs() -> [BluetoothDeviceDTO] {
        return self.map { $0.toDTO() }
    }
}

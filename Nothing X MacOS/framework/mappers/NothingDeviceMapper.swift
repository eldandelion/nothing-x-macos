//
//  NothingDeviceMapper.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/18.
//

import Foundation


extension NothingDeviceFDTO {
    // Static method to convert NothingDeviceFramework to NothingDevice
    static func toEntity(_ framework: NothingDeviceFDTO) -> NothingDeviceEntity {
        return NothingDeviceEntity(
            name: framework.name,
            serial: framework.serial,
            codename: framework.codename,
            firmware: framework.firmware,
            sku: framework.sku,
            leftBattery: framework.leftBattery,
            rightBattery: framework.rightBattery,
            caseBattery: framework.caseBattery,
            isLeftCharging: framework.isLeftCharging,
            isRightCharging: framework.isRightCharging,
            isCaseCharging: framework.isCaseCharging,
            isLeftConnected: framework.isLeftConnected,
            isRightConnected: framework.isRightConnected,
            isCaseConnected: framework.isCaseConnected,
            anc: framework.anc,
            listeningMode: framework.listeningMode,
            isLowLatencyOn: framework.isLowLatencyOn,
            isInEarDetectionOn: framework.isInEarDetectionOn,
            bluetoothDetails: framework.bluetoothDetails,
            tripleTapGestureActionLeft: framework.tripleTapGestureActionLeft,
            tripleTapGestureActionRight: framework.tripleTapGestureActionRight,
            tapAndHoldGestureActionLeft: framework.tapAndHoldGestureActionLeft,
            tapAndHoldGestureActionRight: framework.tapAndHoldGestureActionRight
            
        )
    }
}

extension NothingDeviceEntity {
    // Static method to convert NothingDevice to NothingDeviceFramework
    static func toFDTO(_ device: NothingDeviceEntity) -> NothingDeviceFDTO {
        let framework = NothingDeviceFDTO(bluetoothDetails: device.bluetoothDetails)
        framework.name = device.name
        framework.serial = device.serial
        framework.codename = device.codename
        framework.firmware = device.firmware
        framework.sku = device.sku
        framework.leftBattery = device.leftBattery
        framework.rightBattery = device.rightBattery
        framework.caseBattery = device.caseBattery
        framework.isLeftCharging = device.isLeftCharging
        framework.isRightCharging = device.isRightCharging
        framework.isCaseCharging = device.isCaseCharging
        framework.isLeftConnected = device.isLeftConnected
        framework.isRightConnected = device.isRightConnected
        framework.isCaseConnected = device.isCaseConnected
        framework.anc = device.anc
        framework.listeningMode = device.listeningMode
        framework.isLowLatencyOn = device.isLowLatencyOn
        framework.isInEarDetectionOn = device.isInEarDetectionOn
        return framework
    }
}

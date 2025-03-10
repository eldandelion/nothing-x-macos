//
//  NothingDevice.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//
import Foundation

class NothingDeviceEntity : Codable, ObservableObject {
    
    let name: String
    let serial: String
    let codename: Codenames
    let firmware: String
    let sku: SKU
    let bluetoothDetails: BluetoothDeviceEntity
    
    var leftBattery: Int
    var rightBattery: Int
    var caseBattery: Int
    
    var isLeftCharging: Bool
    var isRightCharging: Bool
    var isCaseCharging: Bool
    
    var isLeftConnected: Bool
    var isRightConnected: Bool
    var isCaseConnected: Bool
    
    var anc: ANC
    var listeningMode: EQProfiles
    
    var isLowLatencyOn: Bool
    var isInEarDetectionOn: Bool
    
    var tripleTapGestureActionLeft: TripleTapGestureActions
    var tripleTapGestureActionRight: TripleTapGestureActions
    
    var tapAndHoldGestureActionLeft: TapAndHoldGestureActions
    var tapAndHoldGestureActionRight: TapAndHoldGestureActions
    
    init(name: String, serial: String, codename: Codenames, firmware: String, sku: SKU, leftBattery: Int, rightBattery: Int, caseBattery: Int, isLeftCharging: Bool, isRightCharging: Bool, isCaseCharging: Bool, isLeftConnected: Bool, isRightConnected: Bool, isCaseConnected: Bool, anc: ANC, listeningMode: EQProfiles, isLowLatencyOn: Bool, isInEarDetectionOn: Bool, bluetoothDetails: BluetoothDeviceEntity, tripleTapGestureActionLeft: TripleTapGestureActions, tripleTapGestureActionRight: TripleTapGestureActions, tapAndHoldGestureActionLeft: TapAndHoldGestureActions, tapAndHoldGestureActionRight: TapAndHoldGestureActions) {
        self.name = name
        self.serial = serial
        self.codename = codename
        self.firmware = firmware
        self.sku = sku
        self.leftBattery = leftBattery
        self.rightBattery = rightBattery
        self.caseBattery = caseBattery
        self.isLeftCharging = isLeftCharging
        self.isRightCharging = isRightCharging
        self.isCaseCharging = isCaseCharging
        self.isLeftConnected = isLeftConnected
        self.isRightConnected = isRightConnected
        self.isCaseConnected = isCaseConnected
        self.anc = anc
        self.listeningMode = listeningMode
        self.isLowLatencyOn = isLowLatencyOn
        self.isInEarDetectionOn = isInEarDetectionOn
        self.bluetoothDetails = bluetoothDetails
        self.tripleTapGestureActionLeft = tripleTapGestureActionLeft
        self.tripleTapGestureActionRight = tripleTapGestureActionRight
        self.tapAndHoldGestureActionLeft = tapAndHoldGestureActionLeft
        self.tapAndHoldGestureActionRight = tapAndHoldGestureActionRight
    }
    
    
    
}

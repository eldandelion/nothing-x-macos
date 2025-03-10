//
//  NothingDeviceFramework.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//
import Combine
import Foundation

class NothingDeviceFDTO: ObservableObject {
    
    
    @Published var name: String = "" {
        didSet { notifyDataUpdated() }
    }
    @Published var serial: String = "" {
        didSet { notifyDataUpdated() }
    }
    @Published var codename: Codenames = .UNKNOWN {
        didSet { notifyDataUpdated() }
    }
    @Published var firmware: String = "" {
        didSet { notifyDataUpdated() }
    }
    @Published var sku: SKU = .UNKNOWN {
        didSet { notifyDataUpdated() }
    }
    
    @Published var bluetoothDetails: BluetoothDeviceEntity {
        didSet { notifyDataUpdated() }
    }
    
    @Published var leftBattery: Int = 0 {
        didSet { notifyDataUpdated() }
    }
    @Published var rightBattery: Int = 0 {
        didSet { notifyDataUpdated() }
    }
    @Published var caseBattery: Int = 0 {
        didSet { notifyDataUpdated() }
    }
    
    @Published var isLeftCharging: Bool = false {
        didSet { notifyDataUpdated() }
    }
    @Published var isRightCharging: Bool = false {
        didSet { notifyDataUpdated() }
    }
    @Published var isCaseCharging: Bool = false {
        didSet { notifyDataUpdated() }
    }
    
    @Published var isLeftConnected: Bool = false {
        didSet { notifyDataUpdated() }
    }
    @Published var isRightConnected: Bool = false {
        didSet { notifyDataUpdated() }
    }
    @Published var isCaseConnected: Bool = false {
        didSet { notifyDataUpdated() }
    }
    
    @Published var anc: ANC = .OFF {
        didSet { notifyDataUpdated() }
    }
    @Published var listeningMode: EQProfiles = .BALANCED {
        didSet { notifyDataUpdated() }
    }
    
    @Published var isLowLatencyOn: Bool = false {
        didSet { notifyDataUpdated() }
    }
    @Published var isInEarDetectionOn: Bool = false {
        didSet { notifyDataUpdated() }
    }
    
    @Published var tripleTapGestureActionLeft: TripleTapGestureActions = .NO_EXTRA_ACTION {
        didSet { notifyDataUpdated() }
    }
    
    @Published var tripleTapGestureActionRight: TripleTapGestureActions = .NO_EXTRA_ACTION {
        didSet { notifyDataUpdated() }
    }
    
    @Published var tapAndHoldGestureActionLeft: TapAndHoldGestureActions = .NO_EXTRA_ACTION {
        didSet { notifyDataUpdated() }
    }
    @Published var tapAndHoldGestureActionRight: TapAndHoldGestureActions = .NO_EXTRA_ACTION {
        didSet { notifyDataUpdated() }
    }
     
    init(bluetoothDetails: BluetoothDeviceEntity) {
        self.bluetoothDetails = bluetoothDetails
    }
    
    private func notifyDataUpdated() {
        NotificationCenter.default.post(name: Notification.Name(DataNotifications.DATA_UPDATED.rawValue), object: self, userInfo: nil)
    }
    
    func printValues() {
            print("Device Name: \(name)")
            print("Serial Number: \(serial)")
            print("Codename: \(codename)")
            print("Firmware Version: \(firmware)")
            print("SKU: \(sku)")
            print("Left Battery: \(leftBattery)%")
            print("Right Battery: \(rightBattery)%")
            print("Case Battery: \(caseBattery)%")
            print("Is Left Charging: \(isLeftCharging)")
            print("Is Right Charging: \(isRightCharging)")
            print("Is Case Charging: \(isCaseCharging)")
            print("Is Left Connected: \(isLeftConnected)")
            print("Is Right Connected: \(isRightConnected)")
            print("Is Case Connected: \(isCaseConnected)")
            print("ANC Status: \(anc)")
            print("Listening Mode: \(listeningMode)")
            print("Is Low Latency On: \(isLowLatencyOn)")
            print("Is In-Ear Detection On: \(isInEarDetectionOn)")
    }
}

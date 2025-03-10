//
//  Repository.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//

import Foundation

protocol NothingService {
    
    func ringBuds()
    
    func stopRingingBuds()
    
    func switchANC(mode: ANC)
    
    func switchEQ(mode: EQProfiles)
    
    func fetchData()
    
    func discoverNothing()
    
    func stopNothingDiscovery()
    
    func connectToNothing(device: BluetoothDeviceEntity)
    
    func isNothingConnected() -> BluetoothDeviceEntity?
    
    func isNothingConnected() -> Bool
    
    func switchLowLatency(mode: Bool)
    
    func switchInEarDetection(mode: Bool)
    
    func switchGesture(device: DeviceType, gesture: GestureType, action: UInt8)
    
    func disconnect()
    
}

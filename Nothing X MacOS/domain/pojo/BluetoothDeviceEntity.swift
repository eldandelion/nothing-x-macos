//
//  BluetoothDevice.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/21.
//

import Foundation

class BluetoothDeviceEntity : Codable {
    
    var name: String
    let mac: String
    let channelId: UInt8
    var isPaired: Bool
    var isConnected: Bool
    
    init(name: String, mac: String, channelId: UInt8, isPaired: Bool, isConnected: Bool) {
        self.name = name
        self.mac = mac
        self.channelId = channelId
        self.isPaired = isPaired
        self.isConnected = isConnected
    }

}

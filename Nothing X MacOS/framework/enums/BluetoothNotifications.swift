//
//  BluetoothNotifications.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/19.
//

import Foundation


enum BluetoothNotifications : String {
    
    case CONNECTED = "CONNECTED"
    case FAILED_TO_CONNECT = "FAILED_TO_CONNECT"
    case OPENED_RFCOMM_CHANNEL = "OPENED_RFCOMM_CHANNEL"
    case FAILED_RFCOMM_CHANNEL = "FAILED_RFCOMM_CHANNEL"
    case CLOSED_RFCOMM_CHANNEL = "CLOSED_RFCOMM_CHANNEL"
    case SEARCHING = "SEARCHING"
    case SEARCHING_COMPLETE = "SEARCHING_COMPLETE"
    case FOUND = "FOUND_NOTHING_DEVICE"
    case CONNECTING = "CONNECTING"
    case BLUETOOTH_OFF = "BLUETOOTH OFF"
    case BLUETOOTH_ON = "BLUETOOTH_ON"
    case DISCONNECTED = "DISCONNECTED"
    
}

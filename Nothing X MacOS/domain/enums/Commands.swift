//
//  Commands.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//

enum Commands : UInt16 {
    
    case GET_BATTERY = 0x07C0
    case GET_SERIAL_NUMBER = 0x06C0
    case GET_FIRMWARE = 0x42C0
    case GET_ANC = 0x1EC0
    case GET_EQ = 0x1FC0
    case GET_LISTENING_MODE = 0x50C0
    
    case SET_ANC = 0x0FF0
    case SET_EQ = 0x10F0
    
    case READ_BATTERY_ONE = 57345
    case READ_BATTERY_THREE = 57346
    case READ_BATTERY_TWO = 16391
    case READ_SERIAL_NUMBER = 16390
    case READ_ANC_ONE = 57347
    case READ_ANC_TWO = 16414

    case READ_EQ_ONE = 16415
    case READ_EQ_TWO = 16464
    
    case UNHANDLED_ONE = 28687
    case UNHANDLED = 28688
    
    case READ_FIRMWARE = 16450
    
    
    
}

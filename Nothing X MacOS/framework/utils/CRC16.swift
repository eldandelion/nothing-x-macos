//
//  CRC16.swift
//  BluetoothTest
//
//  Created by Daniel on 2025/2/13.
//

//checksum
class CRC16 {
    
    static func crc16(buffer: [UInt8]) -> UInt16 {
        var crc: UInt16 = 0xFFFF // Initialize CRC to 0xFFFF
        
        for byte in buffer {
            crc ^= UInt16(byte) // XOR byte into the CRC
            for _ in 0..<8 { // Process each bit
                if (crc & 0x0001) != 0 { // Check if the least significant bit is set
                    crc = (crc >> 1) ^ 0xA001 // Shift right and XOR with polynomial
                } else {
                    crc >>= 1 // Just shift right
                }
            }
        }
        
        return crc // Return the final CRC value
    }
    
}

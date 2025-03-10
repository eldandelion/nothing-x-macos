//
//  SwitchControlsUseCaseProtocol.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/8.
//

import Foundation

protocol SwitchControlsUseCaseProtocol {
    
    func switchGesture(device: DeviceType, gesture: GestureType, action: UInt8)
    
}

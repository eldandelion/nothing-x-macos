//
//  DeleteSavedUseCaseProtocol.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation


protocol DeleteSavedUseCaseProtocol {
    
    func delete(device: NothingDeviceEntity)
    
    func delete(mac: String)
}

//
//  GetSavedDevicesUseCaseProtocol.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation

protocol GetSavedDevicesUseCaseProtocol {
    
    func getSaved() -> [NothingDeviceEntity]
}

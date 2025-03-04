//
//  DeleteSavedDeviceUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation

class DeleteSavedDeviceUseCase : DeleteSavedUseCaseProtocol {
    
    private let nothingRepository: NothingRepository
    
    init(nothingRepository: NothingRepository) {
        self.nothingRepository = nothingRepository
    }
    
    func delete(mac: String) {
        nothingRepository.delete(mac: mac)
    }
    
    func delete(device: NothingDeviceEntity) {
        nothingRepository.delete(device: device)
    }
}

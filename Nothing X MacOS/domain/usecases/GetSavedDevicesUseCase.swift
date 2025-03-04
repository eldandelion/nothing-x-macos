//
//  GetSavedDevicesUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation

class GetSavedDevicesUseCase : GetSavedDevicesUseCaseProtocol {
    
    private let nothingRepository: NothingRepository
    
    init(nothingRepository: NothingRepository) {
        self.nothingRepository = nothingRepository
    }
    
    func getSaved() -> [NothingDeviceEntity] {
        return nothingRepository.getSaved()
    }
}

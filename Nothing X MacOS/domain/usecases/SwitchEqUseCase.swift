//
//  SwitchEqUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/28.
//

import Foundation

class SwitchEqUseCase : SwitchEqUseCaseProtocol {
    
    private let service: NothingService
    
    init(service: NothingService) {
        self.service = service
    }
    
    func switchEQ(mode: EQProfiles) {
        service.switchEQ(mode: mode)
    }
    
}
